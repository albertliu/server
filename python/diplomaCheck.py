import asyncio
import base64
import os
import sys
import time
import pymssql
import ddddocr
import nodriver as uc
from PIL import Image
from io import BytesIO

# ---------- 数据库连接 ----------
env_dist = os.environ
conn = pymssql.connect(
    server=env_dist.get('NODE_ENV_DB'),
    port="14333",
    user="sqlrw",
    password=env_dist.get('NODE_ENV_DB_PASSWD'),
    database="elearning",
    autocommit=True
)
py_path = env_dist.get('NODE_ENV_PYTHON')
register = "操作员"
result = {"count_s": 0, "count_e": 0, "err": 0, "errMsg": "", "msg": ""}

# ---------- 辅助函数 ----------
def img_to_code(imgpath):
    ocr = ddddocr.DdddOcr()
    with open(imgpath, 'rb') as f:
        return ocr.classification(f.read())

def base64_to_photo(file_data):
    # 防御性检查：如果是 RemoteObject，提取 value
    if hasattr(file_data, 'value'):
        file_data = file_data.value
    if not file_data or not isinstance(file_data, str):
        print(f"base64_to_photo 收到非字符串类型: {type(file_data)}")
        return None
    try:
        if ';base64,' in file_data:
            b64_data = file_data.split(';base64,')[1]
        else:
            b64_data = file_data
        data = base64.b64decode(b64_data)
        img_dir = os.path.join(py_path, "temp")
        os.makedirs(img_dir, exist_ok=True)
        imgpath = os.path.join(img_dir, "code.png")
        with open(imgpath, "wb") as f:
            f.write(data)
        return imgpath
    except Exception as e:
        print(f"base64_to_photo 错误: {e}")
        return None

def extract_value(obj):
    if hasattr(obj, 'value'):
        return obj.value
    return obj

def execSQL(text: str):
    curs = conn.cursor()
    curs.execute(text)
    curs.close()

async def set_input_value_by_xpath(tab, xpath, value):
    # 转义 value 中的单引号
    safe_value = str(value).replace("'", "\\'")
    js = f"""
    (function() {{
        var el = document.evaluate("{xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        if (el) {{
            el.value = '';
            el.value = '{safe_value}';
            el.dispatchEvent(new Event('input', {{bubbles: true}}));
        }}
    }})();
    """
    await tab.evaluate(js)


# ---------- 通用等待函数（支持 CSS 和 XPath）----------
async def wait_for_element(tab, selector, timeout=10, selector_type='css'):
    """
    轮询等待元素出现，返回第一个找到的元素，超时返回 None
    selector_type: 'css' 或 'xpath'
    """
    start = asyncio.get_event_loop().time()
    while True:
        try:
            if selector_type == 'xpath':
                elements = await tab.find_all(selector)  # find_all 支持 XPath
                if elements:
                    return elements[0]
            else:
                elem = await tab.find(selector)
                if elem is not None:
                    return elem
        except Exception:
            pass
        if asyncio.get_event_loop().time() - start > timeout:
            return None
        await asyncio.sleep(0.3)

# ---------- 核心异步函数 ----------
async def enter_by_list0(elist, kindID, refID):
    cursor = conn.cursor()
    sql = f"exec getStudentListByList '{elist}', {kindID}, {refID}"
    cursor.execute(sql)
    rows = cursor.fetchall()
    cursor.close()

    browser = await uc.start(headless=False)
    tab = await browser.get('https://cx.mem.gov.cn/wxcx/pages/certificateQuery/inquirySpecialCertificate?personTypeCode=03')

    safy = 0
    d = ["应复审日期", "有效期结束日期"]

    for row in rows:
        try:
            if row[5] in ("C16", "C17"):
                url = 'https://cx.mem.gov.cn/wxcx/pages/certificateQuery/safetyManagement?personTypeCode=02'
                safy = 1
            else:
                url = 'https://cx.mem.gov.cn/wxcx/pages/certificateQuery/inquirySpecialCertificate?personTypeCode=03'
                safy = 0

            # 导航到目标URL
            await tab.get(url)
            await asyncio.sleep(2)  # 初始渲染等待

            # 等待验证码图片出现（保持不变）
            img_elem = await wait_for_element(tab, 'img.code_img', timeout=10, selector_type='css')
            if not img_elem:
                print("验证码图片未出现，跳过")
                continue

            # 处理证件类型选择（如果有）
            try:
                type_label = await wait_for_element(tab, "//div[contains(text(), '请选择证件类型')]", timeout=2, selector_type='xpath')
                if type_label:
                    # 点击证件类型选择框（父容器）
                    await tab.evaluate("""
                        var el = document.evaluate("//div[contains(text(), '请选择证件类型')]/ancestor::uni-view[contains(@class, 'u-form-item__body__right__content__slot')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
                        if (el) el.click();
                    """)
                    await asyncio.sleep(0.5)
                    # 点击身份证选项
                    await tab.evaluate("""
                        var opt = document.evaluate("//uni-text[@class='u-action-sheet__item-wrap__item__name']/span[contains(text(),'身份证')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
                        if (opt) opt.click();
                    """)
            except Exception as e:
                print(f"证件类型选择处理失败: {e}")
                pass

            # ---- 输入证件号码 ----
            try:
                xpath_id = "//div[contains(text(), '请输入证件号码')]/following-sibling::input"
                await set_input_value_by_xpath(tab, xpath_id, row[2])
            except Exception as e:
                print(f"操作证件号码输入框失败: {e}")
                continue

            # ---- 输入姓名 ----
            try:
                xpath_name = "//div[contains(text(), '请输入姓名')]/following-sibling::input[@class='uni-input-input']"
                await set_input_value_by_xpath(tab, xpath_name, row[1])
            except Exception as e:
                print(f"操作姓名输入框失败: {e}")
                continue
            
            # 识别验证码
# ---------- 验证码循环 ----------
            while True:
                # 1. 获取验证码图片的 src（安全提取字符串）
                src_raw = await tab.evaluate("""
                    (function() {
                        try {
                            var img = document.querySelector('img.code_img');
                            return img ? img.src : '';
                        } catch(e) {
                            return '';
                        }
                    })();
                """)
                if hasattr(src_raw, 'value'):
                    src = src_raw.value
                else:
                    src = src_raw
                if not isinstance(src, str):
                    src = str(src)

                if not src:
                    print("验证码图片未加载或获取失败，刷新页面")
                    await tab.reload()
                    await asyncio.sleep(1)
                    continue

                # 2. 保存并识别验证码
                imgpath = base64_to_photo(src)
                if not imgpath:
                    print("验证码图片保存失败，刷新验证码")
                    await tab.evaluate("document.querySelector('img.code_img')?.click()")
                    continue

                code_text = img_to_code(imgpath)
                if not code_text:
                    print("验证码识别为空，刷新验证码")
                    await tab.evaluate("document.querySelector('img.code_img')?.click()")
                    continue

                # 3. 输入验证码（使用纯 JS 方式，不传递 Element）
                xpath_code = "//div[contains(text(), '请输入验证码')]/following-sibling::input[@class='uni-input-input']"
                await set_input_value_by_xpath(tab, xpath_code, code_text)

                # 4. 点击查询
                query_btn = await wait_for_element(tab, "//uni-button/uni-text/span[contains(text(), '查询')]/../..", timeout=5, selector_type='xpath')
                if query_btn is None:
                    print("查询按钮未找到，刷新页面")
                    await tab.reload()
                    continue
                await query_btn.click()

                await asyncio.sleep(1.5)
                # 检查是否出现“查询结果”
                result_elem = await wait_for_element(tab, "//*[contains(text(), '查询结果')]", timeout=3, selector_type='xpath')
                if result_elem is not None:
                    break  # 成功进入结果页
                else:
                    # 刷新验证码继续
                    await tab.evaluate("document.querySelector('img.code_img')?.click()")
                    continue

            # 查找作业项目（改进版）
            project_name = str(row[3]).replace("'", "\\'")
            xpath_expr = f"//td[contains(., '{project_name}')]"
            count_js = f"""
                (function() {{
                    var xpath = "{xpath_expr}";
                    var result = document.evaluate(xpath, document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
                    return result.snapshotLength;
                }})();
            """
            count_raw = await tab.evaluate(count_js)
            count = extract_value(count_raw)  # 使用您之前定义的 extract_value 函数

            print(f"DEBUG: 作业项目 '{row[3]}' 匹配数量: {count}")  # 调试输出

            if count > 0:
                # 获取日期（同样使用 contains(., ...)）
                date_xpath = f"//td[contains(., '{project_name}')]/../../tr/td[contains(., '{d[safy]}')]/following-sibling::td"
                date_js = f"""
                    (function() {{
                        var xpath = "{date_xpath}";
                        var result = document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null);
                        var node = result.singleNodeValue;
                        return node ? node.textContent : null;
                    }})();
                """
                check_date_raw = await tab.evaluate(date_js)
                check_date = extract_value(check_date_raw)
                if check_date:
                    check_date = check_date.replace(" ", "")
                    sql = f"exec setDiplomaCheckDate {row[4]}, '{check_date}', '{register}'"
                    execSQL(sql)
                    result["count_s"] += 1
                else:
                    result["count_e"] += 1
            else:
                result["count_e"] += 1

        except Exception as e:
            print(f"Error processing row {row}: {e}")
            continue

    conn.close()
    return result


# ---------- 入口 ----------
if __name__ == '__main__':
    # 测试代码（可注释掉）
    # username = "13817866150"
    # password = "123456Asdf"
    # register = "desk."
    # asyncio.run(enter_by_list0('310113198006251414', 2, 4283))

    kind = sys.argv[2]
    register = sys.argv[4]
    if kind != '3':
        asyncio.run(enter_by_list0(sys.argv[1], sys.argv[2], sys.argv[3]))
    # else:
    #     asyncio.run(enter_by_list1(sys.argv[1], sys.argv[3], sys.argv[4]))
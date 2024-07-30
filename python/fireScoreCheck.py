from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import os
import sys
from selenium.webdriver.common.keys import Keys
import base64
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from PIL import Image   # pip install Pillow
from io import BytesIO
import ddddocr
import pymssql
# wd = webdriver.Chrome()
# wd.implicitly_wait(3)
# wd.get('ks.51safe.com.cn/aksManage/login')
# wd.maximize_window()
# 13601947578/Znxf123456
# 13651648767/P200516@
# from selenium.webdriver.chrome.service import Service
# pip install -i https://mirrors.aliyun.com/pypi/simple/ opencv_python  # this is cv2's package
env_dist = os.environ
options = webdriver.ChromeOptions()
options.add_argument('ignore-certificate-errors')
# 指定为无界面模式
# options.add_argument('headless')
driver = webdriver.Chrome(options=options)
# driver = webdriver.Chrome()
# wait = WebDriverWait(driver, 5)
# 创建连接字符串  （sqlserver默认端口为1433）
img_path = env_dist.get('NODE_ENV_IMG')
py_path = env_dist.get('NODE_ENV_PYTHON')
password1 = env_dist.get('NODE_ENV_DB_PASSWD')
conn = pymssql.connect(
    server=env_dist.get('NODE_ENV_DB'),  # 本地服务器
    port="14333",  # TCP端口
    user="sqlrw",
    password=env_dist.get('NODE_ENV_DB_PASSWD'),
    database="elearning",
    autocommit=True   # 自动提交
    )
result = {"count_s": 0, "count_e": 0, "err": 0, "errMsg": "", "msg": ""}
host = ""
register = "操作员"
username = ""
password = ""


def enter_by_list0(elist, kindID, refID):
    # 根据指定名单（kindID:0 applyID  1 enterID)查询消防考试成绩和考试日期。
    # 获取名单完整信息
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "exec getStudentListByList '" + elist + "', " + str(kindID) + ", " + str(refID)  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句
    rs = cursor.fetchall()
    url = r'https://xfhyjd.119.gov.cn/#/cjcx'

    # 打开网址
    driver.get(url)
    wait = WebDriverWait(driver, 5)
    # 浏览器全屏，可有可无
    driver.maximize_window()

    for row in rs:
        c = 0
        try:
            # driver.execute_script("window.open('" + url + "','_self');")
            # 查找验证码的元素
            driver.refresh()
            wait.until(EC.presence_of_element_located((By.XPATH, "//img[@class='code']")))
            # 输入证件号码
            name_input = driver.find_elements(By.XPATH, "//table[@class='score-box-table']/tr/td/following-sibling::td//input")[0]
            clean_send(name_input, row[2])
            # 输入姓名
            name_input = driver.find_elements(By.XPATH, "//td[contains(text(), '姓名')]/following-sibling::td//input")[0]
            clean_send(name_input, row[1])

            # 循环获取验证码，知道输入的验证码正确
            while True:
                # 验证码截取、保存
                img = driver.find_elements(By.XPATH, "//img[@class='code']")[0].get_attribute("src")  # 要截图的元素
                imgpath = base64_to_photo(img)
                # imgpath = img_save(img, driver)  # 将验证码的部分使用图片保存
                res = img_to_code(imgpath)  # 将图片解析为验证码，每次验证码不一定正确，所以代码逻辑使用循环处理，直到拿到正确的验证码
                # 输入验证码
                name_input = driver.find_elements(By.XPATH, "//table[@class='score-box-table']/tr/following-sibling::tr/td/following-sibling::td//input")[0]
                # name_input.send_keys(Keys.CONTROL, 'a')     # 模拟全选然后清空内容
                clean_send(name_input, res)
                time.sleep(1)

                driver.find_elements(By.XPATH, "//button/span[contains(text(), '查询')]/..")[0].click()  # 点击【查询】
                time.sleep(1)

                # 验证码获取失败，再重新获取
                # 我的网页的情况是当在登录页面时，url里带有login，如果登录成功，则没有login字符串，所以这里采用这样条件来判断是否登录成功
                # if "queryResults" in driver.current_url:  # 根据自己的实际网页情况，编写不同的判断条件
                try:
                    # if wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(),'成绩单')]"))):
                    if driver.find_elements(By.XPATH, "//div[contains(text(),'成绩单')]"):
                        break   # 登录成功，则跳出循环，不再获取验证码
                    if driver.find_elements(By.XPATH, "//div[contains(text(),'成绩合格电子凭证')]"):
                        break   # 登录成功，则跳出循环，不再获取验证码
                    # if wait.until(EC.presence_of_element_located((By.XPATH, "//p[contains(text(),'查无成绩')]"))):
                    if driver.find_elements(By.XPATH, "//p[contains(text(),'查无成绩')]"):
                        c = 1
                        break   # 登录成功，则跳出循环，不再获取验证码
                    if driver.find_elements(By.XPATH, "//div[@class='el-notification__content']/p[contains(text(),'验证码错误')]"):
                        # 刷新验证码
                        driver.find_elements(By.XPATH, "//img[@class='code']")[0].click()
                        continue  # 如果验证码校验失败，则重新获取验证码
                except Exception as e:
                    # print(e)
                    c = 1
                    break

            if c == 1:
                continue
            if driver.find_elements(By.XPATH, "//div[contains(text(),'成绩单')]") or driver.find_elements(By.XPATH, "//div[contains(text(),'成绩合格电子凭证')]"):
                score1 = ""
                score2 = ""
                score2a = ""
                examDate = ""
                if driver.find_elements(By.XPATH, "//td[contains(text(), '理论成绩')]/following-sibling::td"):
                    score1 = driver.find_elements(By.XPATH, "//td[contains(text(), '理论成绩')]/following-sibling::td")[0].get_attribute('innerText')
                if driver.find_elements(By.XPATH, "//td[contains(text(), '技能成绩')]/following-sibling::td/span"):
                    score2a = driver.find_elements(By.XPATH, "//td[contains(text(), '技能成绩')]/following-sibling::td/span")[0].get_attribute('innerText')
                    ln = score2a.find('(')
                    if ln > -1:
                        score2 = score2a[:ln]
                    else:
                        score2 = score2a
                if driver.find_elements(By.XPATH, "//td[contains(text(), '理论考试时间')]/following-sibling::td"):
                    examDate = driver.find_elements(By.XPATH, "//td[contains(text(), '理论考试时间')]/following-sibling::td")[0].get_attribute('innerText')
                elif driver.find_elements(By.XPATH, "//td[contains(text(), '评定时间')]/following-sibling::td"):
                    examDate = driver.find_elements(By.XPATH, "//td[contains(text(), '评定时间')]/following-sibling::td")[0].get_attribute('innerText')
                # 保存结果
                result["count_s"] += 1
                # @enterID int, @date varchar(50), @registerID varchar(50)  删除字符串首尾的空格
                sql = "exec setFireScoreCheck " + str(row[4]) + ",'" + score1 + "','" + score2 + "', '" + examDate.strip() + "', 'system'"
                # print(sql)
                execSQL(sql)
                time.sleep(1)
            else:
                pass

        except Exception as e:
            # print(e)
            # result["err"] = 1
            # result["errMsg"] = "action failed"
            pass

    # 关闭数据库
    cursor.close()
    conn.close()
    # print("window:", driver.window_handles)
    driver.quit()
    return result


def base64_to_photo(file_data):
    imgpath = py_path + "/temp/code.png"
    if file_data:
        b64_data = file_data.split(';base64,')[1]
        data = base64.b64decode(b64_data)
        with open(imgpath, "wb") as f:
            f.write(data)
        return imgpath


# 截取验证码，保存
def img_save(img, driver):
    x, y = img.location.values()  # 元素 坐标数据
    h, w = img.size.values()  # 元素高宽
    # 将截图以二进制的形式返回
    img_data = driver.get_screenshot_as_png()
    # 以新图片的形式打开返回的数据
    sreenshots = Image.open(BytesIO(img_data))
    # 对截图进行剪切
    result = sreenshots.crop((x, y, x + w, y + h))  # 元素大小放缩
    # 存储
    imgpath = py_path + "/temp/code.png"
    result.save(imgpath)
    return imgpath


# 将图片转换为验证码
def img_to_code(imgpath):
    # 创建对象
    ocr = ddddocr.DdddOcr()
    res = ""
    # 使用二进制的方式读取图片
    with open(imgpath, 'rb') as f:
        img_tytes = f.read()
        # 调用识别方法
        res = ocr.classification(img_tytes)
        # print(f'验证码为：{res}')
        return res


def clean_send(element, text: str):
    """
    清空输入框并且输入内容
    :param element: 需要操作的元素
    :param text: 输入的内容
    """
    element.clear()
    element.send_keys(text)


def execSQL(text: str):
    """
    执行SQL语句, 无返回结果
    """
    curs = conn.cursor()  # 使用cursor()方法获取操作游标
    curs.execute(text)  # 执行sql语句
    curs.close()


if __name__ == '__main__':
    # 以下是测试代码
    # register = "test"
    # enter_by_list0('320321197402284830,130281199411220016', 2, 210)
    # 以上是测试代码
    enter_by_list0(sys.argv[1], sys.argv[2], sys.argv[3])   # argv[2]:0 applyID  1 enterID  2 username  argv[3]:classInfo.ID
    print(result)

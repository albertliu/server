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
    database="etraining",
    autocommit=True   # 自动提交
    )
result = {"count_s": 0, "count_e": 0, "err": 0, "errMsg": "", "msg": ""}
host = ""
register = "操作员"
username = ""
password = ""


def enter_by_list0(elist, kindID):
    # 根据指定开班编号及名单（kindID:0 applyID  1 enterID)查询应复训日期。
    # 获取名单完整信息
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "exec getStudentListByList '" + elist + "', " + str(kindID)  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句
    rs = cursor.fetchall()
    url = r'https://cx.mem.gov.cn/wxcx/pages/certificateQuery/inquirySpecialCertificate?personTypeCode=03'

    # 打开网址
    driver.get(url)

    # 浏览器全屏，可有可无
    driver.maximize_window()

    for row in rs:
        try:
            driver.execute_script("window.open('" + url + "','_self');")
            # 查找验证码的元素
            wait = WebDriverWait(driver, 5)
            wait.until(EC.presence_of_element_located((By.XPATH, "//img[@class='code_img']")))

            if wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(), '请选择证件类型')]"))):
                # 选择证件类型
                name_input = driver.find_elements(By.XPATH, "//div[contains(text(), '请选择证件类型')]/following-sibling::input[@class='uni-input-input']")[0].click()
                time.sleep(1)
                # 点击符合要求的项目
                name_input = driver.find_elements(By.XPATH, "//uni-text[@class='u-action-sheet__item-wrap__item__name']/span[contains(text(),'身份证')]")[0].click()
                # time.sleep(1)
                # 输入证件号码
                # name_input = wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(), '请输入证件号码')]/following-sibling::input")))
                name_input = driver.find_elements(By.XPATH, "//div[contains(text(), '请输入证件号码')]/following-sibling::input")[0]
                name_input.send_keys(row[2])
                # 输入姓名
                name_input = driver.find_elements(By.XPATH, "//div[contains(text(), '请输入姓名')]/following-sibling::input[@class='uni-input-input']")[0]
                name_input.send_keys(row[1])

            # 循环获取验证码，知道输入的验证码正确
            while True:
                # 验证码截取、保存
                img = driver.find_elements(By.XPATH, "//img[@class='code_img']")[0].get_attribute("src")  # 要截图的元素
                imgpath = base64_to_photo(img)
                # imgpath = img_save(img, driver)  # 将验证码的部分使用图片保存
                res = img_to_code(imgpath)  # 将图片解析为验证码，每次验证码不一定正确，所以代码逻辑使用循环处理，直到拿到正确的验证码
                # 输入验证码
                name_input = driver.find_elements(By.XPATH, "//div[contains(text(), '请输入验证码')]/following-sibling::input[@class='uni-input-input']")[0]
                # name_input.send_keys(Keys.CONTROL, 'a')     # 模拟全选然后清空内容
                # time.sleep(1)
                # name_input.clear()
                # name_input.send_keys(res)
                clean_send(name_input, res)
                time.sleep(1)

                driver.find_elements(By.XPATH, "//uni-button/uni-text/span[contains(text(), '查询')]/../..")[0].click()  # 点击【查询】
                time.sleep(1)

                # 验证码获取失败，再重新获取
                # 我的网页的情况是当在登录页面时，url里带有login，如果登录成功，则没有login字符串，所以这里采用这样条件来判断是否登录成功
                if "queryResults" in driver.current_url:  # 根据自己的实际网页情况，编写不同的判断条件
                    break   # 登录成功，则跳出循环，不再获取验证码
                else:
                    # 刷新验证码
                    driver.find_elements(By.XPATH, "//img[@class='code_img']")[0].click()
                    continue  # 如果验证码校验失败，则重新获取验证码

            wait.until(EC.presence_of_element_located((By.XPATH, "//uni-text/span[contains(text(), '特种作业操作证查询结果')]")))
            # 查找作业项目
            name_input = driver.find_elements(By.XPATH, "//td[contains(text(), '" + row[3] + "')]")
            if len(name_input) > 0:
                checkDate = driver.find_elements(By.XPATH, "//td[contains(text(), '" + row[3] + "')]/../../tr/td[contains(text(), '应复审日期')]/following-sibling::td")[0].text
                # 保存结果
                result["count_s"] += 1
                # @enterID int, @date varchar(50), @registerID varchar(50)
                sql = "exec setDiplomaCheckDate " + str(row[4]) + ", '" + checkDate.replace(" ", "") + "', 'system'"
                # print(sql)
                execSQL(sql)
                time.sleep(1)
            else:
                result["count_e"] += 1

        except Exception as e:
            print(e)
            # result["err"] = 1
            # result["errMsg"] = "action failed"
            pass

    # 关闭数据库
    cursor.close()
    conn.close()
    # print("window:", driver.window_handles)
    driver.quit()
    return result


def enter_by_list1(username, name, courseName):
    # 根据指定身份证，查询应复训日期。
    # 获取名单完整信息
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    url = r'https://cx.mem.gov.cn/wxcx/pages/certificateQuery/inquirySpecialCertificate?personTypeCode=03'

    # 打开网址
    driver.get(url)

    # 浏览器全屏，可有可无
    driver.maximize_window()

    try:
        driver.execute_script("window.open('" + url + "','_self');")
        # 查找验证码的元素
        wait = WebDriverWait(driver, 5)
        wait.until(EC.presence_of_element_located((By.XPATH, "//img[@class='code_img']")))

        if wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(), '请选择证件类型')]"))):
            # 选择证件类型
            name_input = driver.find_elements(By.XPATH, "//div[contains(text(), '请选择证件类型')]/following-sibling::input[@class='uni-input-input']")[0].click()
            time.sleep(1)
            # 点击符合要求的项目
            name_input = driver.find_elements(By.XPATH, "//uni-text[@class='u-action-sheet__item-wrap__item__name']/span[contains(text(),'身份证')]")[0].click()
            # time.sleep(1)
            # 输入证件号码
            # name_input = wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(), '请输入证件号码')]/following-sibling::input")))
            name_input = driver.find_elements(By.XPATH, "//div[contains(text(), '请输入证件号码')]/following-sibling::input")[0]
            name_input.send_keys(username)
            # 输入姓名
            name_input = driver.find_elements(By.XPATH, "//div[contains(text(), '请输入姓名')]/following-sibling::input[@class='uni-input-input']")[0]
            name_input.send_keys(name)

        # 循环获取验证码，知道输入的验证码正确
        while True:
            # 验证码截取、保存
            img = driver.find_elements(By.XPATH, "//img[@class='code_img']")[0].get_attribute("src")  # 要截图的元素
            imgpath = base64_to_photo(img)
            # imgpath = img_save(img, driver)  # 将验证码的部分使用图片保存
            res = img_to_code(imgpath)  # 将图片解析为验证码，每次验证码不一定正确，所以代码逻辑使用循环处理，直到拿到正确的验证码
            # 输入验证码
            name_input = driver.find_elements(By.XPATH, "//div[contains(text(), '请输入验证码')]/following-sibling::input[@class='uni-input-input']")[0]
            # name_input.send_keys(Keys.CONTROL, 'a')     # 模拟全选然后清空内容
            # time.sleep(1)
            # name_input.clear()
            # name_input.send_keys(res)
            clean_send(name_input, res)
            time.sleep(1)

            driver.find_elements(By.XPATH, "//uni-button/uni-text/span[contains(text(), '查询')]/../..")[0].click()  # 点击【查询】
            time.sleep(1)

            # 验证码获取失败，再重新获取
            # 我的网页的情况是当在登录页面时，url里带有login，如果登录成功，则没有login字符串，所以这里采用这样条件来判断是否登录成功
            if "queryResults" in driver.current_url:  # 根据自己的实际网页情况，编写不同的判断条件
                break   # 登录成功，则跳出循环，不再获取验证码
            else:
                # 刷新验证码
                driver.find_elements(By.XPATH, "//img[@class='code_img']")[0].click()
                continue  # 如果验证码校验失败，则重新获取验证码

        wait.until(EC.presence_of_element_located((By.XPATH, "//uni-text/span[contains(text(), '特种作业操作证查询结果')]")))
        # 查找作业项目
        name_input = driver.find_elements(By.XPATH, "//td[contains(text(), '" + courseName + "')]")
        if len(name_input) > 0:
            checkDate = driver.find_elements(By.XPATH, "//td[contains(text(), '" + courseName + "')]/../../tr/td[contains(text(), '应复审日期')]/following-sibling::td")[0].text
            # 保存结果
            result["msg"] = checkDate
        else:
            result["count_e"] += 1

    except Exception as e:
        print(e)
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
    # username = "13817866150"
    # password = "123456Asdf"
    # register = "test"
    # # enter_by_list0('4923,4924', 0)
    # enter_by_list1('321281198711034057', '高正友', '低压电工作业')
    # 以上是测试代码
    kind = sys.argv[2]     # 0 applyID  1 enterID  2 username  
    host = sys.argv[3]
    # print(kind, sys.argv[3], sys.argv[4])
    username = "13817866150" if host == "feng" else "15900646360"
    password = "123456Asdf" if host == "feng" else "123456Asdf"
    if kind == '0' or kind == '1':
        enter_by_list0(sys.argv[1], sys.argv[2])   # argv[2]:0 applyID  1 enterID
    if kind == '2':
        enter_by_list1(sys.argv[1], sys.argv[3], sys.argv[4])   # argv[2]:0 applyID  1 enterID
    print(result)

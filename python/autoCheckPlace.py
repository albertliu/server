from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import numpy as np
import base64
import cv2  # pip install opencv-python
import os
import sys
import tempfile
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver import ActionChains
from selenium.webdriver.common.keys import Keys
from selenium.common.exceptions import TimeoutException
import pymssql
from datetime import date

new_temp_path = tempfile.gettempdir()
os.makedirs(new_temp_path + "\\2", exist_ok=True)  # 确保目录存在

env_dist = os.environ
options = webdriver.ChromeOptions()
options.add_argument('ignore-certificate-errors')
# 指定为无界面模式
# options.add_argument('headless')
driver = webdriver.Chrome(options=options)
# 设置最大等待时间10秒
wait = WebDriverWait(driver, 30)
# 创建连接字符串  （sqlserver默认端口为1433）
img_path = env_dist.get('NODE_ENV_IMG')
py_path = env_dist.get('NODE_ENV_PYTHON')
conn = pymssql.connect(
    server=env_dist.get('NODE_ENV_DB'),  # 本地服务器
    port="14333",  # TCP端口
    user="sqlrw",
    password=env_dist.get('NODE_ENV_DB_PASSWD'),
    database="elearning",
    autocommit=True,   # 自动提交
    tds_version="7.0"
    )
result = {"count_s": 0, "count_e": 0, "err": 0, "errMsg": ""}
host = ""
register = "操作员"
username = ""
password = ""


def login_fr():
    # 在指定网页上进行登录：输入用户名、密码、登录，拉动滑块进行验证。
    # 定义目标URL信息, , 
    aim_url = {
        'login_url':
        r'https://zwdtuser.sh.gov.cn/uc/login/login.jsp?redirect_uri=https%3a%2f%2fks.51safe.com.cn%2faks_platform%2fauth%2fgetToken%3f',
        'username': username,   # 13918051550
        'password': password,   # Yan@sun0707
        'homepage': 'studentList?pid=3'
    }
    # 打开链接
    try:
        driver.get(aim_url['login_url'])

        # 浏览器全屏，可有可无
        driver.maximize_window()

        # 找到输入框，这里需要自行在F12的Elements中找输入框的位置，然后在这里写入
        user_input = wait.until(EC.presence_of_element_located((By.ID, "userNameFack")))  # 用户名
        pw_input = driver.find_element(by=By.ID, value="password")  # 密码
        login_btn = driver.find_element(by=By.ID, value="login-btn")  # 提交按钮

        # 输入用户名和密码，点击登录
        user_input.send_keys(aim_url['username'])
        pw_input.send_keys(aim_url['password'])
        login_btn.click()
        time.sleep(1)

        n = 0   # 尝试登录，5次失败后退出
        while 1:
            n += 1
            # 获取主图以及需要拖动的图片
            # 主图
            target_link = driver.find_element(By.ID,
                                            "scream").get_attribute('src').replace(
                                                "data:image/png;base64,", "")
            # print("target_link:", target_link, end="\n")
            # 需要拖动的图片
            template_link = driver.find_element(By.ID,
                                                "puzzleShadow").get_attribute('style')
            # print("template_link:", template_link, end="\n")
            # 取background-image数据起始位置
            str_url = 'url("'
            url_start = template_link.find(str_url)
            if url_start > -1:
                url_start += len(str_url)
            # 取background-image数据结束位置
            str_url = '") no-repeat;'
            url_end = template_link.find(str_url)
            if url_end > -1:
                url_end += 0  # 取到结尾
            # print("start:", url_start, url_end, end="\n")
            template_link = template_link[url_start:url_end].replace(
                "data:image/png;base64,", "")
            # print("target:", target_link, end="\n")
            # print("template:", template_link, end="\n")
            target_data = base64.b64decode(target_link)
            with open(py_path + '/temp/target.jpg', 'wb') as f:
                f.write(target_data)
            template_data = base64.b64decode(template_link)
            with open(py_path + '/temp/template.png', 'wb') as f:
                f.write(template_data)

            # 计算滑块移动距离
            distance = match(py_path + '/temp/target.jpg', py_path + '/temp/template.png')
            distance = distance / 400 * 398 + 4  # 这个距离自己慢慢试一下试出来的
            # print(distance)

            # 移动滑块
            slider = wait.until(
                EC.element_to_be_clickable((By.CLASS_NAME, 'slider-btn')))
            ActionChains(driver).click_and_hold(slider).perform()
            ActionChains(driver).move_by_offset(xoffset=distance, yoffset=0).perform()
            time.sleep(1)
            ActionChains(driver).release().perform()
            try:
                if wait.until(EC.presence_of_element_located((By.XPATH, "//p[contains(text(), '考生管理系统')]"))):
                    # 进入主页面
                    driver.execute_script("window.open('studentList?pid=3','_self');")
                    time.sleep(3)
                    return 0
            except Exception:
                if n > 4:
                    raise Exception("login_fail")
    except Exception:
        result["err"] = 1
        result["errMsg"] = "login failed"
        return 1


def autoCheckPlace(courseName):
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    # 考试管理菜单
    driver.find_elements(By.XPATH, "//span[contains(text(),'考试管理')]")[0].click()  # 点击考试管理菜单
    time.sleep(1)
    driver.find_elements(By.XPATH, "//li[contains(text(),'实操考试预约')]")[0].click()  # 点击实操考试预约菜单
    time.sleep(1)
    # 选择课程
    # 点击下拉框
    driver.find_elements(By.XPATH, "//div[@class='el-select']//input[@placeholder='请选择工种']")[0].click()
    time.sleep(1)
    # 点击符合要求的项目
    driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//ul/li/span[contains(text(),'" + courseName + "')]")[0].click()
    time.sleep(1)

    data = driver.find_elements(By.XPATH, "//div[@class='main-app']//div[@class='el-table__body-wrapper is-scrolling-none']//tbody/tr")
    if len(data) > 0:
        data[0].find_elements(By.XPATH, ".//td/div/label//span[@class='el-checkbox__inner']")[0].click()  # 勾选第一条数据
        try:
            # 点击选择考点与时间
            driver.find_element(By.XPATH, "//div//button/span[contains(text(),'选择考点与时间')]/..").click()
            # 请选择考点
            driver.find_elements(By.XPATH, "//div[@class='el-select']//input[@placeholder='请选择考点']")[0].click()
            time.sleep(1)
            # 点击符合要求的项目
            driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//ul/li/span[contains(text(),'上海城建职业学院考试点')]")[0].click()
            time.sleep(1)

            while True:
                # 每隔1分钟执行一次查询任务
                # 点击查询
                driver.find_element(By.XPATH, "//div[@class='el-dialog__body']//button/span[contains(text(),'查询')]/..").click()

                place = driver.find_elements(By.XPATH, "//div[@class='el-dialog__body']//div[@class='el-table__body-wrapper is-scrolling-none']//tbody/tr")

                if len(place) > 0:
                    for tr in place:
                        # 处理每一行数据
                        tds = tr.find_elements(By.TAG_NAME, "td")
                        if len(tds) >= 3:
                            r_name = tds[0].find_elements(By.TAG_NAME, "div")[0].text
                            r_examDate = tds[1].find_elements(By.TAG_NAME, "div")[0].text
                            r_all = tds[2].find_elements(By.TAG_NAME, "div")[0].text
                            r_now = tds[3].find_elements(By.TAG_NAME, "div")[0].text
                            sql = "exec autoCheckPlace '" + r_name + "', '" + r_examDate + "', '" + r_all + "', '" + r_now + "'"
                            execSQL(sql)
                        pass
                time.sleep(1 * 60)

        except Exception as e:
            # result["err"] = 1
            # result["errMsg"] = "action failed"
            print("error:", e)
            pass
    # 关闭数据库
    cursor.close()
    return result


def add_alpha_channel(img):
    """ 为jpg图像添加alpha通道 """

    r_channel, g_channel, b_channel = cv2.split(img)  # 剥离jpg图像通道
    alpha_channel = np.ones(b_channel.shape,
                            dtype=b_channel.dtype) * 255  # 创建Alpha通道

    img_new = cv2.merge(
        (r_channel, g_channel, b_channel, alpha_channel))  # 融合通道
    return img_new


def handel_img(img):
    # 背景图片中的残缺块位置和原始残缺图的亮度有所差异，直接对比两张图片相似的地方，往往得不到令人满意的结果，
    # 在此要对两张图片进行一定的处理，为了避免这种亮度的干扰，笔者这里将两张图片先进行灰度处理，再对图像进行高斯处理，最后进行边缘检测。
    imgGray = cv2.cvtColor(img, cv2.COLOR_RGBA2GRAY)  # 转灰度图
    imgBlur = cv2.GaussianBlur(imgGray, (5, 5), 1)  # 高斯模糊
    imgCanny = cv2.Canny(imgBlur, 60, 60)  # Canny算子边缘检测
    return imgCanny


def match(img_jpg_path, img_png_path):
    # 读取图像
    img_jpg = cv2.imread(img_jpg_path, cv2.IMREAD_UNCHANGED)
    img_png = cv2.imread(img_png_path, cv2.IMREAD_UNCHANGED)
    # 判断jpg图像是否已经为4通道
    if img_jpg.shape[2] == 3:
        img_jpg = add_alpha_channel(img_jpg)
    img = handel_img(img_jpg)
    small_img = handel_img(img_png)
    res_TM_CCOEFF_NORMED = cv2.matchTemplate(img, small_img, 3)
    value = cv2.minMaxLoc(res_TM_CCOEFF_NORMED)
    value = value[3][0]  # 获取到移动距离
    return value


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
    username = "13918051550"
    password = "Yan@sun0707"
    register = "desk."
    courseName = "低压电工作业"  # 课程名称
    if login_fr() == 0:
        autoCheckPlace(courseName)
        # conn.close()
        # driver.quit()
    # 以上是测试代码
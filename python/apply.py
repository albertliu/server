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
# wd = webdriver.Chrome()
# wd.implicitly_wait(3)
# wd.get('ks.51safe.com.cn/aksManage/login')
# wd.maximize_window()
# 13601947578/Znxf123456
# 13651648767/P200516@
# from selenium.webdriver.chrome.service import Service
# pip install -i https://mirrors.aliyun.com/pypi/simple/ opencv_python  # this is cv2's package
# 如果临时文件目录不存在，则创建该目录
new_temp_path = tempfile.gettempdir()
# print(new_temp_path)
os.makedirs(new_temp_path + "\\2", exist_ok=True)  # 确保目录存在

env_dist = os.environ
options = webdriver.ChromeOptions()
options.add_argument('ignore-certificate-errors')
# 指定为无界面模式
# options.add_argument('headless')
driver = webdriver.Chrome(options=options)
# 设置最大等待时间10秒
wait = WebDriverWait(driver, 10)
# 创建连接字符串  （sqlserver默认端口为1433）
img_path = env_dist.get('NODE_ENV_IMG')
py_path = env_dist.get('NODE_ENV_PYTHON')
conn = pymssql.connect(
    server=env_dist.get('NODE_ENV_DB'),  # 本地服务器
    port="14333",  # TCP端口
    user="sqlrw",
    password=env_dist.get('NODE_ENV_DB_PASSWD'),
    database="elearning",
    autocommit=True   # 自动提交
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
        'username': username,   # 13651648767
        'password': password,   # Pqf1823797198
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


def enter_by_list0(elist, kind):
    # 根据指定名单（enterID list)去报名。初训  kind: "特种作业（默认）/安全干部"
    # 获取名单完整信息
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "exec getApplyListByList '" + ','.join(elist) + "'"  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句

    # 初训菜单
    if len(driver.find_elements(By.XPATH, "//li[contains(text(),'初训报名')]")) == 0:
        driver.find_elements(By.XPATH, "//span[contains(text(),'报名管理')]")[0].click()  # 点击报名管理菜单
        time.sleep(1)
    else:
        driver.find_elements(By.XPATH, "//li[contains(text(),'初训报名')]")[0].click()  # 点击初训报名菜单
        time.sleep(1)
    # 选择类型
    if kind == "安全干部":
        # 点击下拉框
        # name_input = driver.find_elements(By.XPATH, "//label[contains(text(),'类型:')]/following-sibling::div//input[contains(@placeholder, '选择类型')]")[0].click()
        name_input = driver.find_elements(By.XPATH, "//input[contains(@placeholder, '选择类型')]")[0].click()
        time.sleep(1)
        # 点击符合要求的项目
        name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + kind + "')]")[0].click()

    rs = cursor.fetchall()
    # print(len(rs))
    for row in rs:
        try:
            if row[2] == "":    # if no education item, pass
                sql = "exec setApplyMemo " + str(row[13]) + ", '报名失败', '报名信息：缺少学历信息'"
                execSQL(sql)
                d_list.remove(str(row[13]))     # 从列表中删除失败数据
                continue
            # 非18位长度的，选择其他证件
            if len(row[3]) != 18:
                name_input = driver.find_elements(By.XPATH, "//input[contains(@placeholder, '选择证件种类')]")[0].click()
                time.sleep(1)
                # 点击符合要求的项目
                name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'其他')]")[0].click()
            
            # 查找身份证
            # 身份证输入框
            username_input = wait.until(EC.presence_of_element_located((By.XPATH, "//input[contains(@placeholder, '请输入证件号码')]")))  
            clean_send(username_input, row[3])
            # time.sleep(1)
            # 查找按钮
            search_btn = driver.find_elements(By.XPATH, "//button//span[contains(text(), '查询')]")[0] 
            search_btn.click()
            time.sleep(1)
            # 弹出确定按钮
            # confirm_btn = driver.find_elements(By.XPATH, "//span[@class='dialog-footer']//button[contains(@class, 'el-button--primary')]")[0] 
            # time.sleep(1)
            confirm_btn = wait.until(EC.element_to_be_clickable((By.XPATH, "//span[@class='dialog-footer']//button[contains(@class, 'el-button el-button--primary')]")))
            confirm_btn.click()
            # 姓名输入
            # name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//p[contains(text(),'人员初证报名')]/following-sibling::div//label[contains(text(),'姓名')]/following-sibling::div//input")  # 姓名输入框
            name_input = wait.until(EC.presence_of_element_located((By.XPATH, "//label[contains(text(),'姓名')]/following-sibling::div//input")))  # 姓名输入框
            s1 = ""
            if name_input.is_enabled():
                # 如果是可用的就填入姓名（以前没有报过名）
                name_input.send_keys(row[0])
            else:
                # 如果以前有姓名资料，比较是否与当前系统一致
                tt = name_input.get_attribute('value')
                if tt != row[0]:
                    s1 = '<p style="color:red;"> 姓名与原登记不符：' + tt + '</p>'
            # 选择文化程度
            # 点击下拉框
            name_input = driver.find_elements(By.XPATH, "//label[contains(text(),'文化程度')]/following-sibling::div//input")[0].click()
            # time.sleep(1)
            wait.until(EC.presence_of_element_located((By.XPATH, "//div[@class='el-select-dropdown el-popper']/div/div/ul[@class='el-scrollbar__view el-select-dropdown__list']/li/span[contains(text(),'" + row[2][:2] + "')]")))
            # 点击符合要求的学历选项（与给定值前两位相符的）
            name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']/div/div/ul[@class='el-scrollbar__view el-select-dropdown__list']/li/span[contains(text(),'" + row[2][:2] + "')]")[0].click()
            # 联系手机
            name_input = driver.find_elements(By.XPATH, "//label[contains(text(),'联系手机')]/following-sibling::div//input")[0]
            clean_send(name_input, row[4])
            # 单位/街道名称
            # name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//p[contains(text(),'人员初证报名')]/following-sibling::div//label[contains(text(),'单位/街道名称')]/following-sibling::div//input")[0]
            # clean_send(name_input, row[5])
            if kind == "安全干部":
                # 职务
                name_input = driver.find_elements(By.XPATH, "//label[@for='position']/following-sibling::div//input")[0]
                clean_send(name_input, row[6])
                # 职称
                # 点击下拉框
                name_input = driver.find_elements(By.XPATH, "//label[@for='jobTitle']/following-sibling::div//input")[0].click()
                time.sleep(1)
                # wait.until(EC.presence_of_element_located((By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'无')]")))
                # 点击符合要求的选项
                name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'无')]")[0].click()
            # 单位/街道地址
            # name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//p[contains(text(),'人员初证报名')]/following-sibling::div//label[contains(text(),'单位/街道地址')]/following-sibling::div//input")[0]
            # clean_send(name_input, row[7])
            # 清空邮编
            # name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//p[contains(text(),'人员初证报名')]/following-sibling::div//label[contains(text(),'邮编')]/following-sibling::div//input")[0]
            # clean_send(name_input, '000000')
            # 判断是否本地户籍
            area = driver.find_elements(By.XPATH, "//span[contains(text(),'非本地户籍')]/preceding-sibling::span")[0]
            if area.get_attribute("class") == "el-radio__input is-checked":
                # 非本地户籍需要上传证明材料
                # 选择相应的证明种类：工作证明、居住证、社保证明
                name_input = driver.find_elements(By.XPATH, "//span[contains(text(),'" + row[15] + "')]/preceding-sibling::span//span[@class='el-radio__inner']")[0].click()
                # 上传文件
                if row[16] > '':
                    name_input = driver.find_elements(By.XPATH, "//div[@class='upload-demo']//input[@type='file']")[0]
                    name_input.send_keys(img_path + row[16])
                    name_input = wait.until(EC.visibility_of_element_located((By.XPATH, "//li[@class='el-upload-list__item is-success']//span[contains(text(),'删除')]")))
                else:
                    result["count_e"] += 1
                    sql = "exec setApplyMemo " + str(row[13]) + ", '报名失败', '缺少证明材料:" + row[15] + "'"
                    execSQL(sql)
                    d_list.remove(str(row[13]))     # 从列表中删除失败数据
                    time.sleep(1)
                    continue
                    
            # 填写单位名称
            name_input = driver.find_elements(By.XPATH, "//label[contains(text(),'单位名称')]/following-sibling::div//input")[0]
            if name_input.is_displayed():
                clean_send(name_input, row[5])
            # 填写单位地址
            name_input = driver.find_elements(By.XPATH, "//label[@for='unitAddress']/following-sibling::div//input")[0]
            if name_input.is_displayed():
                clean_send(name_input, row[7])
            # 填写统一社会信用代码
            name_input = driver.find_elements(By.XPATH, "//label[@for='creditCode']/following-sibling::div//input")[0]
            if name_input.is_displayed():
                clean_send(name_input, row[17])
            # 勾选承诺
            name_input = driver.find_elements(By.XPATH, "//p[@class='information']/label")[0].click()
            # 下一步按钮
            name_input = driver.find_elements(By.XPATH, "//div[@class='button']/button[@type='button']")[0].click()
            time.sleep(1)
            # 检查错误信息
            err_msg = driver.find_elements(By.XPATH, "//div[@class='el-form-item__error']")
            if err_msg and err_msg[0].is_displayed():
                result["count_e"] += 1
                sql = "exec setApplyMemo " + str(row[13]) + ", '报名失败', '" + err_msg[0].text + "'"
                execSQL(sql)
                d_list.remove(str(row[13]))     # 从列表中删除失败数据
                time.sleep(1)
                continue
            # 选择课程
            # 点击下拉框
            name_input = driver.find_elements(By.XPATH, "//div[@class='con-left fl']//label[contains(text(),'资格类型:')]/following-sibling::div//input")[0].click()
            time.sleep(1)
            # 点击符合要求的项目
            name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']/div/div/ul[@class='el-scrollbar__view el-select-dropdown__list']/li/span[contains(text(),'" + row[11] + "')]")[0].click()
            # 填写人
            name_input = driver.find_elements(By.XPATH, "//div[@class='con-left fl']//label[contains(text(),'填写人')]/following-sibling::div//input")[0]
            clean_send(name_input, register)
            # 上传照片
            if row[10] > "":
                name_input = driver.find_elements(By.XPATH, "//div[@class='con-right fl']//input[@type='file']")[0].send_keys(img_path + row[10])
            else:
                s1 += "缺少照片"
            # 保存按钮
            name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//form[@class='el-form']/div[@class='button']//span[contains(text(),'保存')]/..")))
            name_input.click()
            # driver.implicitly_wait(2)
            time.sleep(1)
            name_input = wait.until(EC.invisibility_of_element_located((By.XPATH, "//form[@class='el-form']/div[@class='button']//span[contains(text(),'保存')]/..")))

            # 判断保存结果
            try:
                # 成功
                wait.until(EC.visibility_of_element_located((By.XPATH, "//p[contains(text(),'该学员报名成功')]")))
                result["count_s"] += 1
                sql = "exec setApplyMemo " + str(row[13]) + ", '已报名', '报名成功" + s1 + "'"
                execSQL(sql)
                d_list.remove(str(row[13]))     # 从列表中删除已成功数据
                # 提交成功，确定按钮
                name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-message-box__btns']/button/span[contains(text(),'确定')]/..")))
                name_input.click()
                time.sleep(3)
            except TimeoutException:
                # 失败
                result["count_e"] += 1
                # 提交失败 保存错误信息
                # name_input = driver.find_elements(By.XPATH, "//div[@role='dialog']//div[@class='el-message-box__message']/p")[0]
                name_input = wait.until(EC.presence_of_element_located((By.XPATH, "//div[@role='dialog']//div[@class='el-message-box__message']/p")))
                sql = "exec setApplyMemo " + str(row[13]) + ", '报名失败', '报名信息：" + name_input.text + "'"
                execSQL(sql)
                d_list.remove(str(row[13]))     # 从列表中删除失败数据

                # 关闭按钮
                name_input = driver.find_element(By.XPATH, "//div[@role='dialog']//button/span[contains(text(),'确定')]/..")
                if not name_input.is_displayed():
                    name_input = driver.find_element(By.XPATH, "//div[@role='dialog']//button/span[contains(text(),'关闭')]/..")
                name_input.click()
                time.sleep(1)

        except Exception as e:
            # result["err"] = 1
            # result["errMsg"] = "action failed"
            # print("error:", e)
            pass
    # 关闭数据库
    cursor.close()
    # conn.close()
    # print("window:", driver.window_handles)
    # driver.quit()
    return result


def enter_by_list1(elist):
    # 根据指定名单（enterID list)去报名。复训
    # 获取名单完整信息
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "exec getApplyListByList '" + ','.join(elist) + "'"  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句

    # 复训菜单
    if len(driver.find_elements(By.XPATH, "//li[contains(text(),'复训报名')]")) == 0:
        driver.find_elements(By.XPATH, "//span[contains(text(),'报名管理')]")[0].click()  # 点击报名管理菜单
        time.sleep(1)
    else:
        driver.find_elements(By.XPATH, "//li[contains(text(),'复训报名')]")[0].click()  # 点击复训报名菜单
        time.sleep(1)
    rs = cursor.fetchall()
    # print(len(rs))
    for row in rs:
        try:
            if row[2] == "":    # if no education item, pass
                sql = "exec setApplyMemo " + str(row[13]) + ", '报名失败', '报名信息：缺少学历信息'"
                execSQL(sql)
                d_list.remove(str(row[13]))     # 从列表中删除失败数据
                continue
            # 姓名输入框
            username_input = wait.until(EC.presence_of_element_located((By.XPATH, "//input[contains(@placeholder, '请输入姓名')]")))
            clean_send(username_input, row[0])
            # 身份证输入框
            username_input = driver.find_elements(By.XPATH, "//input[contains(@placeholder, '请输入证件号码')]")[0]
            clean_send(username_input, row[3])
            # 操作证号码输入框
            diploma_input = driver.find_elements(By.XPATH, "//input[contains(@placeholder, '请输入操作证号码')]")[0]
            clean_send(diploma_input, row[3])
            # 选择课程
            # 点击下拉框
            name_input = driver.find_elements(By.XPATH, "//label[contains(text(),'资格类型')]/following-sibling::div//input")[0].click()
            time.sleep(1)
            # 点击符合要求的项目
            name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + row[11] + "')]")[0].click()
            # 查找按钮
            search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '查询')]")[0]
            search_btn.click()
            time.sleep(1)
            # 弹出确定按钮
            try:
                confirm_btn = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-message-box__btns']/button[contains(@class, 'el-button--primary')]")))
                # 获取操作证提示信息
                name_input = driver.find_elements(By.XPATH, "//div[@class='el-message-box__content']//div[@class='el-message-box__message']/p")[0].text
                # 操作证号码输入框
                i = name_input.find('最新操作证号报名:')
                if i >= 0:
                    s = name_input[i + 9:].replace('。', '').replace(' ', '')
                    confirm_btn.click()
                    clean_send(diploma_input, s)
                    # 第二次按查找按钮
                    search_btn.click()
                    driver.implicitly_wait(2)
            except Exception:
                i = 0
                pass

            # 判断是否有错误弹窗
            f = 0
            s1 = ""
            if driver.find_elements(By.XPATH, "//div[@class='el-message-box__message']/p[contains(text(),'该证件只能在')]"):
                # 提交失败 保存错误信息
                f = 1
                msg_input = driver.find_elements(By.XPATH, "//div[@class='el-message-box__message']/p[contains(text(),'该证件只能在')]")[0]
                s1 = msg_input.text
                s2 = s1.replace('该证件只能在', '')[0:10]
                today = date.today().strftime("%Y-%m-%d")
                # 确定按钮
                name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-message-box__btns']/button/span[contains(text(),'确定')]/..")))
                name_input.click()
                driver.implicitly_wait(2)
                if s2 < today:  # 如果显示的日期小于今天，说明需要更换操作证号再试一次
                    # 再次尝试更换新的操作证号码
                    # 操作证号码输入框
                    clean_send(diploma_input, 'T' + row[3])
                    # 第二次按查找按钮
                    search_btn.click()
                    driver.implicitly_wait(2)
                    # 判断是否有错误弹窗
                    if driver.find_elements(By.XPATH, "//div[@class='el-message-box__message']/p[contains(text(),'该证件只能在')]"):
                        # 提交失败 保存错误信息
                        msg_input = driver.find_elements(By.XPATH, "//div[@class='el-message-box__message']/p[contains(text(),'该证件只能在')]")[0]
                        s1 = msg_input.text
                        if s1 > "":     # 新的信息，否则为原来的控件残留
                            # 确定按钮
                            name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-message-box__btns']/button/span[contains(text(),'确定')]/..")))
                            name_input.click()
                        else:
                            f = 0
                    else:
                        f = 0
                else:
                    f = 1
                if f == 1:
                    result["count_e"] += 1
                    sql = "exec setApplyMemo " + str(row[13]) + ", '报名失败', '报名信息：" + s1 + "'"
                    execSQL(sql)
                    d_list.remove(str(row[13]))     # 从列表中删除失败数据
                    time.sleep(1)
                    continue
            # 第二页
            # 姓名check
            # name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//p[contains(text(),'人员初证报名')]/following-sibling::div//label[contains(text(),'姓名')]/following-sibling::div//input")  # 姓名输入框
            name_input = wait.until(EC.presence_of_element_located((By.XPATH, "//form[@class='el-form']//label[contains(text(),'姓名')]/following-sibling::div//input")))  # 姓名输入框
            s1 = ""
            # 以前有姓名资料，比较是否与当前系统一致
            tt = name_input.get_attribute('value')
            if tt != row[0]:
                s1 = '<p style="color:red;"> 姓名与原登记不符：' + tt + '</p>'
            # 选择文化程度
            # 点击下拉框
            name_input = driver.find_elements(By.XPATH, "//label[contains(text(),'文化程度')]/following-sibling::div//input")[0].click()
            # time.sleep(1)
            wait.until(EC.presence_of_element_located((By.XPATH, "//div[@class='el-select-dropdown el-popper']/div/div/ul[@class='el-scrollbar__view el-select-dropdown__list']/li/span[contains(text(),'" + row[2][:2] + "')]")))
            # 点击符合要求的学历选项（与给定值前两位相符的）
            name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']/div/div/ul[@class='el-scrollbar__view el-select-dropdown__list']/li/span[contains(text(),'" + row[2][:2] + "')]")[0].click()
            # 联系手机
            name_input = driver.find_elements(By.XPATH, "//label[contains(text(),'联系手机')]/following-sibling::div//input")[0]
            clean_send(name_input, row[4])
            # 判断是否本地户籍
            area = driver.find_elements(By.XPATH, "//span[contains(text(),'非本地户籍')]/preceding-sibling::span")[0]
            if area.get_attribute("class") == "el-radio__input is-checked":
                # 非本地户籍需要上传证明材料
                # 选择相应的证明种类：工作证明、居住证、社保证明
                name_input = driver.find_elements(By.XPATH, "//span[contains(text(),'" + row[15] + "')]/preceding-sibling::span//span[@class='el-radio__inner']")[0].click()
                # 上传文件
                if row[16] > '':
                    name_input = driver.find_elements(By.XPATH, "//div[@class='upload-demo']//input[@type='file']")[0]
                    name_input.send_keys(img_path + row[16])
                    name_input = wait.until(EC.visibility_of_element_located((By.XPATH, "//li[@class='el-upload-list__item is-success']//span[contains(text(),'删除')]")))
                else:
                    result["count_e"] += 1
                    sql = "exec setApplyMemo " + str(row[13]) + ", '报名失败', '缺少证明材料:" + row[15] + "'"
                    execSQL(sql)
                    d_list.remove(str(row[13]))     # 从列表中删除失败数据
                    time.sleep(1)
                    continue
                    
            # 填写单位名称
            name_input = driver.find_elements(By.XPATH, "//label[contains(text(),'单位名称')]/following-sibling::div//input")[0]
            if name_input.is_displayed():
                clean_send(name_input, row[5])
            # 填写单位地址
            name_input = driver.find_elements(By.XPATH, "//label[@for='unitAddress']/following-sibling::div//input")[0]
            if name_input.is_displayed():
                clean_send(name_input, row[7])
            # 填写统一社会信用代码
            name_input = driver.find_elements(By.XPATH, "//label[@for='creditCode']/following-sibling::div//input")[0]
            if name_input.is_displayed():
                clean_send(name_input, row[17])
            # 勾选承诺
            name_input = driver.find_elements(By.XPATH, "//p[@class='information']/label")[0].click()
            # 下一步按钮
            name_input = driver.find_elements(By.XPATH, "//div[@class='button']/button[@type='button']")[0].click()
            time.sleep(1)
            # 填写人
            name_input = driver.find_elements(By.XPATH, "//div[@class='el-row']/div/label[contains(text(),'填写人')]/following-sibling::div//input")[0]
            clean_send(name_input, register)
            # 保存按钮
            name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//button[contains(@class, 'el-button')]/span[contains(text(),'保存')]/..")))
            name_input.click()
            time.sleep(3)
            # 判断保存结果
            try:
                # 成功
                wait.until(EC.visibility_of_element_located((By.XPATH, "//p[contains(text(),'该学员报名成功')]")))
                result["count_s"] += 1
                sql = "exec setApplyMemo " + str(row[13]) + ", '已报名', '报名成功" + s1 + "'"
                execSQL(sql)
                d_list.remove(str(row[13]))     # 从列表中删除已成功数据
                # 提交成功，确定按钮
                name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-message-box__btns']/button/span[contains(text(),'确定')]/..")))
                name_input.click()
                time.sleep(1)
            except TimeoutException:
                # 失败
                result["count_e"] += 1
                # 提交失败 保存错误信息
                name_input = driver.find_elements(By.XPATH, "//div[@role='dialog']//div[@class='el-message-box__message']/p")[0]
                sql = "exec setApplyMemo " + str(row[13]) + ", '报名失败', '" + name_input.text + "'"
                execSQL(sql)
                d_list.remove(str(row[13]))     # 从列表中删除失败数据

                # 关闭按钮
                name_input = driver.find_element(By.XPATH, "//div[@role='dialog']//button/span[contains(text(),'确定')]/..")
                if not name_input.is_displayed():
                    name_input = driver.find_element(By.XPATH, "//div[@role='dialog']//button/span[contains(text(),'关闭')]/..")
                name_input.click()
                time.sleep(1)

        except Exception:
            # result["err"] = 1
            # result["errMsg"] = "action failed"
            pass

    # 关闭数据库
    cursor.close()
    # conn.close()
    # print("window:", driver.window_handles)
    # driver.quit()
    return result


def enter_by_list7(adviser, classID, courseName, reex):
    # 根据指定班级编号（classID)创建计划，并上传课程表。
    # 获取班级信息
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "exec getClassInfo '" + classID + "'"  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句

    # 培训计划管理菜单
    driver.find_elements(By.XPATH, "//span[contains(text(),'培训计划管理')]")[0].click()  # 点击培训计划管理菜单
    time.sleep(1)
    m_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//li[contains(text(),'计划上报')]")))  # 点击计划上报菜单
    m_input.click()
    time.sleep(1)
    # 选择课程
    # 点击下拉框
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'资格类型')]/following-sibling::div//input[contains(@placeholder, '请选择')]")[0].click()
    time.sleep(1)
    # 点击符合要求的项目
    name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + courseName + "')]")))
    name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + courseName + "')]")[0].click()
    # time.sleep(1)
    # 选择类型
    # 点击下拉框
    name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//form[@class='el-form']//label[contains(text(),'培训类别')]/following-sibling::div//input[contains(@placeholder, '请选择')]")))
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'培训类别')]/following-sibling::div//input[contains(@placeholder, '请选择')]")[0].click()
    time.sleep(1)
    # 点击符合要求的类型
    name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + reex + "')]")[0].click()
    # 新增按钮
    search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '新增')]/..")[0]
    search_btn.click()
    time.sleep(1)
    rs = cursor.fetchall()
    # 计划人数
    wait.until(EC.presence_of_element_located((By.XPATH, "//label[@for='planTrainCnt']")))
    # 添加计划人数
    name_input = driver.find_element(By.XPATH, "//label[@for='planTrainCnt']/following-sibling::div//input[@class='el-input__inner']")
    clean_send(name_input, rs[0][3])
    # 添加办学地点
    name_input = driver.find_element(By.XPATH, "//label[@for='trainAddress']/following-sibling::div//input[@class='el-input__inner']")
    clean_send(name_input, rs[0][4])
    # 添加培训日期
    name_input = driver.find_element(By.XPATH, "//label[@for='startDate']/following-sibling::div//input[@class='el-input__inner']")
    clean_send(name_input, rs[0][5])
    name_input.send_keys(Keys.ENTER)  # 按下Enter键确认选择
    # 添加截止日期
    name_input = driver.find_element(By.XPATH, "//label[@for='endDate']/following-sibling::div//input[@class='el-input__inner']")
    clean_send(name_input, rs[0][6])
    name_input.send_keys(Keys.ENTER)  # 按下Enter键确认选择
    # 添加填写人
    name_input = driver.find_element(By.XPATH, "//label[@for='modifyName']/following-sibling::div//input[@class='el-input__inner']")
    clean_send(name_input, register)
    # name_input.click()
    # 下一步按钮
    search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '下一步')]/..")[0]
    search_btn.click()
    time.sleep(1)
    # 添加班级培训负责人
    name_input = driver.find_element(By.XPATH, "//label[@for='teacherName']/../following-sibling::div//input[@class='el-input__inner']")
    clean_send(name_input, adviser[0])

    # 添加授课计划
    # 获取课表
    sql = "exec getClassScheduleList '" + classID + "'"  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句
    rs = cursor.fetchall()
    # print(len(rs))
    _no = 0
    # _form = []
    _td = []
    _i = 0
    for row in rs:
        try:
            search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '新 增')]/..")[0]
            search_btn.click()
            # 使用JavaScript执行点击操作
            # driver.execute_script("arguments[0].click();", search_btn)
            time.sleep(1)
            # _form = driver.find_elements(By.XPATH, "//colgroup/following-sibling::tbody/tr")[_no]
            # _form1 = driver.find_elements(By.XPATH, "//colgroup/following-sibling::tbody/tr[" + str(_no+1) + "]")[0]
            _td = driver.find_elements(By.XPATH, "//colgroup/following-sibling::tbody/tr/td")
            # 填写日期
            name_input = _td[_i].find_elements(By.XPATH, ".//input")[0]
            clean_send(name_input, row[1])
            # name_input.send_keys(Keys.ENTER)  # 按下Enter键确认选择
            # 填写上下午
            name_input = _td[_i+1].find_elements(By.XPATH, ".//input/following-sibling::span//i")[0].click()
            time.sleep(1)
            # 点击符合要求的项目
            # name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + str(row[2]) + "')]")))
            name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + row[2] + "')]")
            name_input[_no].click()
            # time.sleep(1)
            # 填写课程
            name_input = _td[_i+2].find_elements(By.XPATH, ".//input")[0]
            clean_send(name_input, row[3])
            # 填写学时
            name_input = _td[_i+3].find_elements(By.XPATH, ".//input/following-sibling::span//i")[0].click()
            time.sleep(1)
            # 点击符合要求的项目
            # name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + str(row[4]) + "')]")))
            name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + str(row[4]) + "')]")
            name_input[_no].click()
            # time.sleep(1)
            # 填写老师
            name_input = _td[_i+4].find_elements(By.XPATH, ".//input")[0]
            clean_send(name_input, row[5])
            # 填写老师身份证
            name_input = _td[_i+5].find_elements(By.XPATH, ".//input")[0]
            clean_send(name_input, row[6])
            # 填写课程类型
            name_input = _td[_i+6].find_elements(By.XPATH, ".//input/following-sibling::span//i")[0].click()
            time.sleep(1)
            # 点击符合要求的项目
            # name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + row[7] + "')]")))
            name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + str(row[7]) + "')]")
            name_input[_no].click()
            # time.sleep(1)
            # 填写教室
            name_input = _td[_i+7].find_elements(By.XPATH, ".//input")[0]
            clean_send(name_input, row[8])
            _i += 9
            _no += 1

        except Exception:
            # print("exceptZ:", e)
            # result["err"] = 1
            # result["errMsg"] = "action failed"
            break

    # 暂存按钮
    search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '暂存')]/..")[0]
    search_btn.click()
    time.sleep(2)
    # 判断保存结果
    if driver.find_elements(By.XPATH, "//p[contains(text(),'添加班级信息成功')]"):
        # 提交成功，确定按钮
        name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-message-box__btns']/button/span[contains(text(),'确定')]/..")))
        name_input.click()
        time.sleep(1)

        # 获取计划ID
        m_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//li[contains(text(),'计划管理')]")))  # 点击计划管理菜单
        m_input.click()
        time.sleep(1)
        # 选择课程
        # 点击下拉框
        name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'资格类型')]/following-sibling::div//input[contains(@placeholder, '请选择')]")[0].click()
        time.sleep(1)
        # 点击符合要求的项目
        name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + courseName + "')]")))
        name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + courseName + "')]")[0].click()
        # time.sleep(1)
        # 选择类型
        # 点击下拉框
        name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//form[@class='el-form']//label[contains(text(),'培训类别')]/following-sibling::div//input[contains(@placeholder, '请选择')]")))
        name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'培训类别')]/following-sibling::div//input[contains(@placeholder, '请选择')]")[0].click()
        time.sleep(1)
        # 点击符合要求的类型
        name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + reex + "')]")[0].click()
        # 查询按钮
        search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '查询')]/..")[0]
        search_btn.click()
        time.sleep(1)
        # 查找最后一个计划
        _form = driver.find_elements(By.XPATH, "//colgroup/following-sibling::tbody/tr")
        _i = len(_form)
        if _i > 0:
            # planID = driver.find_elements(By.XPATH, "//colgroup/following-sibling::tbody/tr[" + str(_i) + "]/td[2]/div")[0].text
            divs = driver.find_elements(By.XPATH, "//colgroup/following-sibling::tbody/tr/td[2]/div")     # 获取所有行的第二列（计划编号）
            planID = max([element.text for element in divs])
            # 保存数据
            sql = "exec setUploadSchedule '" + classID + "','" + planID + "','system.'"  # 记录上传日志
            cursor.execute(sql)  # 执行sql语句
            d_list.clear()    # 从列表中删除数据
            result["count_s"] = _no

    # 关闭数据库
    cursor.close()
    # conn.close()
    # print("window:", driver.window_handles)
    # driver.quit()
    return result


def enter_by_list8(elist, classID, courseName, reex):
    # 根据指定开班编号及名单（enterID list)上传照片。
    # 获取名单完整信息
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "exec getApplyListByList '" + ','.join(elist) + "'"  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句

    # 开班管理菜单
    # if len(driver.find_elements(By.XPATH, "//li[contains(text(),'班级管理')]")) == 0:
    driver.find_elements(By.XPATH, "//span[contains(text(),'开班管理')]")[0].click()  # 点击开班管理菜单
    time.sleep(1)
    # else:
    # driver.find_elements(By.XPATH, "//li[contains(text(),'班级管理')]")[0].click()  # 点击班级管理菜单
    name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//li[contains(text(),'班级打印管理')]")))
    name_input.click()
    time.sleep(1)
    # 选择课程
    # 点击下拉框
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'资格类型')]/following-sibling::div//input[contains(@placeholder, '请选择')]")[0].click()
    time.sleep(1)
    # 点击符合要求的项目
    name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + courseName + "')]")))
    name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + courseName + "')]")[0].click()
    time.sleep(1)
    # 选择类型
    # 点击下拉框
    name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//form[@class='el-form']//label[contains(text(),'培训类别')]/following-sibling::div//input[contains(@placeholder, '请选择')]")))
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'培训类别')]/following-sibling::div//input[contains(@placeholder, '请选择')]")[0].click()
    time.sleep(1)
    # 点击符合要求的类型
    name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + reex + "')]")[0].click()
    # 开班编号
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'开班编号')]/following-sibling::div/div//input")[0]
    clean_send(name_input, classID)
    # 查找按钮
    search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '查询')]")[0]
    search_btn.click()
    time.sleep(1)
    # wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(),'" + classID + "')]")))
    driver.find_elements(By.XPATH, "//div[contains(text(),'" + classID + "')]")[0].click()  # 点击班级记录
    # 照片打印
    search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '照片打印')]")[0]
    search_btn.click()
    time.sleep(2)
    # 标记当前窗口
    original_window = driver.current_window_handle
    # 切换新窗口
    driver.switch_to.window(driver.window_handles[-1])
    wait.until(EC.presence_of_element_located((By.XPATH, "//span[@id='kbwyh']")))
    # wait.until(EC.presence_of_element_located((By.XPATH, "//p[contains(text(), '开班编号')]/span[contains(text(),'" + classID + "')]")))
    rs = cursor.fetchall()
    # print(len(rs))
    for row in rs:
        try:
            # 身份证输查找
            if row[10] == "":   # 照片文件
                result["count_e"] += 1
                d_list.remove(str(row[13]))     # 从列表中删除无照片数据
                continue
            if driver.find_elements(By.XPATH, "//span[contains(text(), '" + row[3] + "')]/../../../div/div/img"):
                # wait.until(EC.presence_of_element_located((By.XPATH, "//span[contains(text(), '" + row[3] + "')]/../../../div/div/img")))
                # search_btn = driver.find_elements(By.XPATH, "//span[contains(text(), '" + row[3] + "')]/../../../div[contains(@title, '点击上传考核申请材料')]/div")[0]
                search_btn = wait.until(EC.element_to_be_clickable((By.XPATH, "//span[contains(text(), '" + row[3] + "')]/../../../div/div/img")))
            else:
                if driver.find_elements(By.XPATH, "//span[contains(text(), '" + row[3] + "')]/../../../div/div/div[contains(text(), '无照片')]"):
                    search_btn = wait.until(EC.element_to_be_clickable((By.XPATH, "//span[contains(text(), '" + row[3] + "')]/../../../div/div/div[contains(text(), '无照片')]")))
            search_btn.click()
            # search_btn = driver.find_elements(By.XPATH, "//span[contains(text(), '本地上传')]/following-sibling::div//img")[0]
            # search_btn.click()
            # 上传报名表
            # print(1)
            wait.until(EC.presence_of_element_located((By.XPATH, "//span[contains(text(), '本地上传')]/following-sibling::div//input[@type='file']")))
            p = img_path + row[10]  # 照片
            name_input = driver.find_elements(By.XPATH, "//span[contains(text(), '本地上传')]/following-sibling::div//input[@type='file']")[0]
            time.sleep(3)
            name_input.send_keys(p)
            time.sleep(2)
            # print(2)
            # 弹出窗口
            div_dialog = driver.find_elements(By.XPATH, "//div[@id='app']/div/div[@class='el-dialog__wrapper']")[0]
            # 确定按钮
            name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//button/span[contains(text(),'确 认')]/..")))
            name_input.click()
            while div_dialog.is_displayed():    # 等待弹出窗口消失
                pass
            # time.sleep(3)
            # print(3)

            # 保存结果
            result["count_s"] += 1
            sql = "exec setApplyPhotoUpload " + str(row[13])
            execSQL(sql)
            d_list.remove(str(row[13]))     # 从列表中删除已成功数据
            time.sleep(3)

        except Exception:
            # print("exceptZ:", e)
            # result["err"] = 1
            # result["errMsg"] = "action failed"
            try:
                # 如果发生错误，可能是弹窗未关闭，先尝试关闭
                name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//button[@class='el-dialog__headerbtn',@aria-label='Close']/i/..")))
                name_input.click()
                while name_input.is_displayed() and name_input.is_enabled():    # 等待确认按钮消失
                    pass
            except Exception:
                result["err"] = 1
                result["errMsg"] = "安监系统超时退出"
                break

    # 关闭数据库
    cursor.close()
    # conn.close()
    # print("window:", driver.window_handles)
    # driver.quit()
    return result


def enter_by_list9(elist, classID, courseName, reex):
    # 根据指定开班编号及名单（enterID list)上传报名表。
    # 获取名单完整信息
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "exec getApplyListByList '" + ','.join(elist) + "'"  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句

    # 开班管理菜单
    # if len(driver.find_elements(By.XPATH, "//li[contains(text(),'班级管理')]")) == 0:
    driver.find_elements(By.XPATH, "//span[contains(text(),'开班管理')]")[0].click()  # 点击开班管理菜单
    time.sleep(1)
    # else:
    # driver.find_elements(By.XPATH, "//li[contains(text(),'班级管理')]")[0].click()  # 点击班级管理菜单
    name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//li[contains(text(),'班级管理')]")))
    name_input.click()
    time.sleep(1)
    # 选择课程
    # 点击下拉框
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'资格类型')]/following-sibling::div//input[contains(@placeholder, '请选择')]")[0].click()
    time.sleep(1)
    # 点击符合要求的项目
    name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//div[@class='el-select-dropdown el-popper']/div/div/ul[@class='el-scrollbar__view el-select-dropdown__list']/li/span[contains(text(),'" + courseName + "')]")))
    name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']/div/div/ul[@class='el-scrollbar__view el-select-dropdown__list']/li/span[contains(text(),'" + courseName + "')]")[0].click()
    time.sleep(1)
    # 选择类型
    # 点击下拉框
    name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//form[@class='el-form']//label[contains(text(),'培训类别')]/following-sibling::div//input[contains(@placeholder, '请选择')]")))
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'培训类别')]/following-sibling::div//input[contains(@placeholder, '请选择')]")[0].click()
    time.sleep(1)
    # 点击符合要求的类型
    name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']/div/div/ul[@class='el-scrollbar__view el-select-dropdown__list']/li/span[contains(text(),'" + reex + "')]")[0].click()
    # 开班编号
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'开班编号')]/following-sibling::div/div//input")[0]
    clean_send(name_input, classID)
    # 查找按钮
    search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '查询')]")[0]
    search_btn.click()
    time.sleep(1)
    # wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(),'" + classID + "')]")))
    driver.find_elements(By.XPATH, "//div[contains(text(),'" + classID + "')]")[0].click()  # 点击班级记录
    # 考核申请材料上传
    search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '考核申请材料上传')]")[0]
    search_btn.click()
    time.sleep(1)
    wait.until(EC.presence_of_element_located((By.XPATH, "//p[contains(text(), '开班编号')]/span[contains(text(),'" + classID + "')]")))
    rs = cursor.fetchall()
    # print(len(rs))
    for row in rs:
        try:
            # 身份证输查找
            if row[14] == "":   # 报名表文件
                result["count_e"] += 1
                d_list.remove(str(row[13]))     # 从列表中删除无文件数据
                continue
            wait.until(EC.presence_of_element_located((By.XPATH, "//span[contains(text(), '" + row[3] + "')]/../../../div[contains(@title, '点击上传考核申请材料')]/div")))
            # search_btn = driver.find_elements(By.XPATH, "//span[contains(text(), '" + row[3] + "')]/../../../div[contains(@title, '点击上传考核申请材料')]/div")[0]
            search_btn = wait.until(EC.element_to_be_clickable((By.XPATH, "//span[contains(text(), '" + row[3] + "')]/../../../div[contains(@title, '点击上传考核申请材料')]/div")))
            search_btn.click()
            # search_btn = driver.find_elements(By.XPATH, "//span[contains(text(), '本地上传')]/following-sibling::div//img")[0]
            # search_btn.click()
            # 上传报名表
            # print(1)
            wait.until(EC.presence_of_element_located((By.XPATH, "//span[contains(text(), '本地上传')]/following-sibling::div//input[@type='file']")))
            p = img_path + row[14]  # 报名资料
            name_input = driver.find_elements(By.XPATH, "//span[contains(text(), '本地上传')]/following-sibling::div//input[@type='file']")[0]
            time.sleep(5)
            name_input.send_keys(p)
            time.sleep(5)
            # print(2)
            # 确定按钮
            name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//button/span[contains(text(),'确 认')]/..")))
            name_input.click()
            while name_input.is_displayed() and name_input.is_enabled():    # 等待确认按钮消失
                pass
            # time.sleep(5)
            # print(3)

            # 保存结果
            result["count_s"] += 1
            sql = "exec setApplyUpload " + str(row[13])
            execSQL(sql)
            d_list.remove(str(row[13]))     # 从列表中删除已成功数据
            time.sleep(1)

        except Exception:
            # print("exceptZ:", e)
            # result["err"] = 1
            # result["errMsg"] = "action failed"
            try:
                # 如果发生错误，可能是弹窗未关闭，先尝试关闭
                name_input = wait.until(EC.element_to_be_clickable((By.XPATH, "//button[@class='el-dialog__headerbtn',@aria-label='Close']/i/..")))
                name_input.click()
                while name_input.is_displayed() and name_input.is_enabled():    # 等待确认按钮消失
                    pass
            except Exception:
                result["err"] = 1
                result["errMsg"] = "安监系统超时退出"
                break

    # 关闭数据库
    cursor.close()
    # conn.close()
    # print("window:", driver.window_handles)
    # driver.quit()
    return result


def enter_by_list10(elist, classID, courseName, reex):
    # 根据指定开班编号及名单（enterID list)查询成绩。
    # 获取名单完整信息
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "exec getApplyListByList '" + ','.join(elist) + "'"  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句

    # 考试管理菜单
    driver.find_elements(By.XPATH, "//span[contains(text(),'考试管理')]")[0].click()  # 点击考试管理菜单
    time.sleep(1)
    driver.find_elements(By.XPATH, "//li[contains(text(),'考试打印管理')]")[0].click()  # 点击考试打印管理菜单
    time.sleep(1)
    # 选择课程
    # 点击下拉框
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'资格类型')]/following-sibling::div//input[@placeholder='请选择']")[0].click()
    time.sleep(1)
    # 点击符合要求的项目
    name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//ul/li/span[contains(text(),'" + courseName + "')]")[0].click()
    time.sleep(1)
    # 选择类型
    # 点击下拉框
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'培训类别')]/following-sibling::div//input[@placeholder='请选择']")[0].click()
    time.sleep(1)
    # 点击符合要求的类型
    name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']/div/div/ul[@class='el-scrollbar__view el-select-dropdown__list']/li/span[contains(text(),'" + reex + "')]")[0].click()
    # 开班编号
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'开班编号')]/following-sibling::div//input")[0]
    clean_send(name_input, classID)
    # 查找按钮
    search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '查询')]")[0]
    search_btn.click()
    time.sleep(1)
    # wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(),'" + classID + "')]")))
    driver.find_elements(By.XPATH, "//div[contains(text(),'" + classID + "')]")[0].click()  # 点击班级记录
    # 成绩打印
    search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '成绩打印')]")[0]
    search_btn.click()
    time.sleep(2)
    # 标记当前窗口
    original_window = driver.current_window_handle
    # 切换新窗口
    driver.switch_to.window(driver.window_handles[-1])
    wait.until(EC.presence_of_element_located((By.XPATH, "//div[@class='SubTitle']/font[contains(text(),'" + classID + "')]")))
    rs = cursor.fetchall()
    # print(len(rs))
    reexStr = ''
    if reex.find("补考") >= 0:
        reexStr = '是'
    for row in rs:
        try:
            # 身份证查找
            # search_btn = wait.until(EC.presence_of_element_located((By.XPATH, "//table/tr/td/font[contains(text(), '" + row[3] + "')]/..")))
            examDate = wait.until(EC.presence_of_element_located((By.XPATH, "//table/tr/td/font[contains(text(), '" + row[3] + "')]/../following-sibling::td/font"))).text
            score1 = wait.until(EC.presence_of_element_located((By.XPATH, "//table/tr/td/font[contains(text(), '" + row[3] + "')]/../following-sibling::td[2]/font"))).text
            score2 = wait.until(EC.presence_of_element_located((By.XPATH, "//table/tr/td/font[contains(text(), '" + row[3] + "')]/../following-sibling::td[3]/font"))).text
            diplomaID = wait.until(EC.presence_of_element_located((By.XPATH, "//table/tr/td/font[contains(text(), '" + row[3] + "')]/../following-sibling::td[4]/font"))).text
            # 保存结果
            result["count_s"] += 1
            # @batchID,@ID,@courseID,@certName,@passNo,@username,@name,@score1,@score2,@startDate,@reexam, @host,@registerID
            # sql = "exec generateApplyScore 1, " + str(row[13]) + ", '', '', '" + diplomaID.replace(" ", "") + "', '', '', '" + score1 + "', '" + score2 + "', '" + examDate + "', '" + reexStr + "', '', 'system'"
            sql = "exec generateApplyScore1 " + str(row[13]) + ", '" + diplomaID.replace(" ", "").replace("&nbsp;", "") + "', '" + score1 + "', '" + score2 + "', '" + examDate + "', '" + register + "'"
            # print(sql)
            execSQL(sql)
            d_list.remove(str(row[13]))     # 从列表中删除已成功数据
            # time.sleep(1)

        except Exception:
            # print(e)
            # result["err"] = 1
            # result["errMsg"] = "action failed"
            pass

    # 关闭数据库
    cursor.close()
    # conn.close()
    # print("window:", driver.window_handles)
    # driver.quit()
    return result


def enter_by_list11(elist, classID, courseName, reex):
    # 根据指定开班编号及名单（enterID list)查询考试安排。
    # 获取名单完整信息
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "exec getApplyListByList '" + ','.join(elist) + "'"  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句

    # 考试管理菜单
    driver.find_elements(By.XPATH, "//span[contains(text(),'考试管理')]")[0].click()  # 点击考试管理菜单
    time.sleep(1)
    driver.find_elements(By.XPATH, "//li[contains(text(),'考试打印管理')]")[0].click()  # 点击考试打印管理菜单
    time.sleep(1)
    # 选择课程
    # 点击下拉框
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'资格类型')]/following-sibling::div//input[contains(@placeholder, '请选择')]")[0].click()
    time.sleep(1)
    # 点击符合要求的项目
    name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + courseName + "')]")[0].click()
    time.sleep(1)
    # 选择类型
    # 点击下拉框
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'培训类别')]/following-sibling::div//input[contains(@placeholder, '请选择')]")[0].click()
    time.sleep(1)
    # 点击符合要求的类型
    name_input = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//div/ul/li/span[contains(text(),'" + reex + "')]")[0].click()
    # 开班编号
    name_input = driver.find_elements(By.XPATH, "//form[@class='el-form']//label[contains(text(),'开班编号')]/following-sibling::div/div//input")[0]
    clean_send(name_input, classID)
    # 查找按钮
    search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '查询')]")[0]
    search_btn.click()
    time.sleep(1)
    # wait.until(EC.presence_of_element_located((By.XPATH, "//div[contains(text(),'" + classID + "')]")))
    driver.find_elements(By.XPATH, "//div[contains(text(),'" + classID + "')]")[0].click()  # 点击班级记录
    # 成绩打印
    search_btn = driver.find_elements(By.XPATH, "//button/span[contains(text(), '考试信息打印')]")[0]
    search_btn.click()
    time.sleep(2)
    # 标记当前窗口
    original_window = driver.current_window_handle
    # 切换新窗口
    driver.switch_to.window(driver.window_handles[-1])
    wait.until(EC.presence_of_element_located((By.XPATH, "//td/font/span[contains(text(),'" + classID + "')]")))
    rs = cursor.fetchall()
    # print(len(rs))
    reexStr = ''
    if reex.find("补考") >= 0:
        reexStr = '是'
    for row in rs:
        try:
            # 身份证查找
            # search_btn = wait.until(EC.presence_of_element_located((By.XPATH, "//table/tr/td/font[contains(text(), '" + row[3] + "')]/..")))
            applyNo = wait.until(EC.presence_of_element_located((By.XPATH, "//table/tr/td[contains(text(), '" + row[3] + "')]/following-sibling::td"))).text
            examDate = wait.until(EC.presence_of_element_located((By.XPATH, "//table/tr/td[contains(text(), '" + row[3] + "')]/following-sibling::td[3]"))).text
            # 保存结果
            if examDate > "":
                result["count_s"] += 1
                # @batchID,@ID,@courseID,@certName,@passNo,@username,@name,@score1,@score2,@startDate,@reexam, @host,@registerID
                # sql = "exec generateApplyScore 1, " + str(row[13]) + ", '', '', '" + diplomaID.replace(" ", "") + "', '', '', '" + score1 + "', '" + score2 + "', '" + examDate + "', '" + reexStr + "', '', 'system'"
                sql = "exec generateApply1 " + str(row[13]) + ", '" + applyNo + "', '" + examDate + "', '" + register + "'"
                # print(sql)
                execSQL(sql)
            d_list.remove(str(row[13]))     # 从列表中删除已成功数据
            # time.sleep(1)

        except Exception:
            # print(e)
            # result["err"] = 1
            # result["errMsg"] = "action failed"
            pass

    # 关闭数据库
    cursor.close()
    # conn.close()
    # print("window:", driver.window_handles)
    # driver.quit()
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
    # username = "13651648767"
    # password = "Pqf1823797198"
    # register = "desk."
    # d_list = '9506'.split(',')    # 需要处理的数据列表
    # courseName = "低压电工作业"  # 课程名称
    # # courseName = "低压电工作业"  # 课程名称
    # kind = ('' if courseName.find('危险化学品') < 0 else '安全干部')
    # if login_fr() == 0:
    #     i = 0
    #     while len(d_list) > 0:
    #         enter_by_list0(d_list, kind)
    #         # enter_by_list1(d_list)
    #         # enter_by_list7(d_list, '290', courseName, '初证')
    #         # enter_by_list8(d_list, sys.argv[5], sys.argv[6], sys.argv[7])
    #         # enter_by_list9(d_list, sys.argv[5], sys.argv[6], sys.argv[7])
    #         # enter_by_list10(d_list, sys.argv[5], sys.argv[6], sys.argv[7])
    #         # enter_by_list11(d_list, '0110092507105', courseName, '初证')
    #         i += 1
    #         if i > 3:
    #             break
    #     conn.close()
    #     driver.quit()
    #     print(result)
    # 以上是测试代码
    d_list = sys.argv[1].split(',')    # 需要处理的数据列表
    reexamine = sys.argv[2]     # 0 初训 1 复训 9 报名表 10 成绩
    host = sys.argv[3]
    register = sys.argv[4]  # 填写人
    # classID = sys.argv[5]   # 开班编号
    courseName = sys.argv[6]  # 课程名称
    kind = ('' if courseName.find('危险化学品') < 0 else '安全干部')
    # username = "13817866150" if host == "feng" else "15900646360"
    # password = "123456Asdf" if host == "feng" else "123456Asdf"
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "select accountA, passwdA from hostInfo where hostNo= '" + host + "'"  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句
    rs = cursor.fetchone()  # 获取第一行数据
    if rs is not None:
        username = rs[0]
        password = rs[1]

        # 登录
        if login_fr() == 0:
            # print("reexamine:", reexamine)
            i = 0
            while len(d_list) > 0:
                if reexamine == '0':
                    enter_by_list0(d_list, kind)
                if reexamine == '1':
                    enter_by_list1(d_list)
                if reexamine == '7':    # 上传课表
                    enter_by_list7(d_list, sys.argv[5], sys.argv[6], sys.argv[7])   # adviser, classID, courseName, reex
                if reexamine == '8':    # 上传照片
                    # 5:classID, 6:courseName, 7:reex（初训,复训,初训补考,复训补考）
                    enter_by_list8(d_list, sys.argv[5], sys.argv[6], sys.argv[7])
                if reexamine == '9':    # 上传资料
                    enter_by_list9(d_list, sys.argv[5], sys.argv[6], sys.argv[7])
                if reexamine == '10':   # 查询成绩
                    enter_by_list10(d_list, sys.argv[5], sys.argv[6], sys.argv[7])
                if reexamine == '11':   # 查询考试安排
                    enter_by_list11(d_list, sys.argv[5], sys.argv[6], sys.argv[7])
                i += 1
                if i > 3:
                    break
            conn.close()
            driver.quit()
        print(result)
    else:
        result["err"] = 1
        result["errMsg"] = "No account found."  # err
        print(result)

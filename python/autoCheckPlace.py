from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import numpy as np
import base64
import cv2  # pip install opencv-python
import os
import sys
import tempfile
import traceback
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver import ActionChains
from selenium.common.exceptions import (
    NoSuchElementException,
    TimeoutException,
    ElementNotInteractableException,
    ElementClickInterceptedException
)
import pymssql
from datetime import datetime

new_temp_path = tempfile.gettempdir()
os.makedirs(os.path.join(new_temp_path, "2"), exist_ok=True)
env_dist = os.environ

# ===================== 日志初始化 =====================
py_path = env_dist.get('NODE_ENV_PYTHON')
if not py_path:
    print("【致命错误】环境变量 NODE_ENV_PYTHON 未配置")
    sys.exit(1)
LOG_FILE = os.path.join(py_path, "autoCheckPlace_run.log")
HEARTBEAT_FILE = os.path.join(py_path, "heartbeat.txt")
os.makedirs(os.path.join(py_path, "temp"), exist_ok=True)

# 每次启动清空日志
try:
    with open(LOG_FILE, "w", encoding="utf-8") as f:
        f.write("")
except Exception:
    pass

def log_write(msg: str):
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{now}] {msg}"
    print(line)
    try:
        with open(LOG_FILE, "a", encoding="utf-8") as f:
            f.write(line + "\n")
    except Exception:
        pass

def write_heartbeat():
    try:
        with open(HEARTBEAT_FILE, "w", encoding="utf-8") as f:
            f.write(datetime.now().strftime("%Y-%m-%d %H:%M:%S") + " 运行正常\n")
    except Exception:
        pass

# 安全点击函数：普通click失败，用JS原生click兜底，绕过Selenium可见性拦截
def safe_click(el):
    try:
        el.click()
    except (ElementClickInterceptedException, ElementNotInteractableException):
        log_write("检测到click被拦截，使用JS原生点击兜底")
        driver.execute_script("arguments[0].click();", el)

# 关闭弹窗：同时隐藏dialog本体 + el-dialog__wrapper外层遮罩，解决z-index遮挡页面问题
def closeExamDialog():
    try:
        close_btns = driver.find_elements(By.XPATH, "//div[@aria-label='实操考试预约']/div[@class='el-dialog__header']/button[@aria-label='Close']")
        if len(close_btns) > 0:
            btn = close_btns[0]
            if btn.is_displayed() and btn.is_enabled():
                safe_click(btn)
                log_write("已点击按钮关闭实操考试预约弹窗")
                time.sleep(2)
                return
        # JS同时隐藏弹窗本体 + 外层wrapper遮罩容器（重点修复）
        driver.execute_script("""
            var dialog = document.querySelector('div[aria-label="实操考试预约"].el-dialog');
            if(dialog){dialog.style.display='none';}
            var wrapper = document.querySelector('.el-dialog__wrapper');
            if(wrapper){wrapper.style.display='none';}
            var mask = document.querySelector('.el-dialog__mask');
            if(mask){mask.style.display='none';}
        """)
        log_write("JS强制隐藏弹窗+外层wrapper遮罩")
        time.sleep(2.5)
    except Exception as e:
        log_write(f"关闭弹窗异常(忽略): {str(e)}")

# ===================== Chrome 配置 =====================
options = webdriver.ChromeOptions()
options.add_argument('ignore-certificate-errors')
# options.add_argument("--headless=new")
options.add_argument("--no-sandbox")
options.add_argument("--disable-gpu")
options.add_argument("--disable-dev-shm-usage")

driver = None
wait = None
conn = None

img_path = env_dist.get('NODE_ENV_IMG')
py_path = env_dist.get('NODE_ENV_PYTHON')
result = {"count_s": 0, "count_e": 0, "err": 0, "errMsg": ""}
host = ""
register = "操作员"
username = ""
password = ""

def login_fr():
    aim_url = {
        'login_url':
        r'https://zwdtuser.sh.gov.cn/uc/login/login.jsp?redirect_uri=https%3a%2f%2fks.51safe.com.cn%2faks_platform%2fauth%2fgetToken%3f',
        'username': username,
        'password': password,
        'homepage': 'studentList?pid=3'
    }
    try:
        log_write("开始访问登录页面")
        driver.get(aim_url['login_url'])
        driver.maximize_window()
        user_input = wait.until(EC.presence_of_element_located((By.ID, "userNameFack")))
        pw_input = driver.find_element(by=By.ID, value="password")
        login_btn = driver.find_element(by=By.ID, value="login-btn")
        user_input.send_keys(aim_url['username'])
        pw_input.send_keys(aim_url['password'])
        safe_click(login_btn)
        time.sleep(1)
        n = 0
        while 1:
            n += 1
            log_write(f"滑块验证尝试第{n}次")
            target_link = driver.find_element(By.ID,
                                            "scream").get_attribute('src').replace(
                                                "data:image/png;base64,", "")
            template_link = driver.find_element(By.ID,
                                                "puzzleShadow").get_attribute('style')
            str_url = 'url("'
            url_start = template_link.find(str_url)
            if url_start > -1:
                url_start += len(str_url)
            str_url = '") no-repeat;'
            url_end = template_link.find(str_url)
            template_link = template_link[url_start:url_end].replace(
                "data:image/png;base64,", "")
            target_data = base64.b64decode(target_link)
            with open(os.path.join(py_path, 'temp/target.jpg'), 'wb') as f:
                f.write(target_data)
            template_data = base64.b64decode(template_link)
            with open(os.path.join(py_path, 'temp/template.png'), 'wb') as f:
                f.write(template_data)
            distance = match(os.path.join(py_path, 'temp/target.jpg'), os.path.join(py_path, 'temp/template.png'))
            distance = distance / 400 * 398 + 4
            log_write(f"滑块计算偏移：{distance:.2f}")
            slider = wait.until(
                EC.element_to_be_clickable((By.CLASS_NAME, 'slider-btn')))
            ActionChains(driver).click_and_hold(slider).perform()
            ActionChains(driver).move_by_offset(xoffset=distance, yoffset=0).perform()
            time.sleep(1)
            ActionChains(driver).release().perform()
            time.sleep(2)
            try:
                wait.until(EC.presence_of_element_located((By.XPATH, "//p[contains(text(), '考生管理系统')]")))
                log_write("登录成功，跳转主页")
                driver.execute_script("window.open('studentList?pid=3','_self');")
                time.sleep(3)
                return 0
            except Exception:
                log_write(f"滑块验证失败 n={n}")
                if n > 4:
                    raise Exception("login_fail")
    except Exception as e:
        log_write(f"登录异常:{str(e)}\n{traceback.format_exc()}")
        result["err"] = 1
        result["errMsg"] = "login failed"
        return 1

def autoCheckPlace(course_list):
    log_write(f"==== 进入抓取流程，课程列表：{course_list} ====")
    cursor = conn.cursor()
    try:
        # 进入实操考试预约菜单
        menu1 = driver.find_elements(By.XPATH, "//span[contains(text(),'考试管理')]")
        if len(menu1) == 0:
            raise Exception("找不到【考试管理】菜单")
        safe_click(menu1[0])
        time.sleep(1.5)
        menu2 = driver.find_elements(By.XPATH, "//li[contains(text(),'实操考试预约')]")
        if len(menu2) ==0:
            raise Exception("找不到【实操考试预约】子菜单")
        safe_click(menu2[0])
        time.sleep(2)

        GLOBAL_TIMEOUT = 60 * 55
        global_start = time.time()

        while True:
            if time.time() - global_start > GLOBAL_TIMEOUT:
                log_write(f"全局总运行时间到达 {GLOBAL_TIMEOUT} 秒，整体退出抓取循环")
                break

            for one_course in course_list:
                write_heartbeat()
                log_write(f"------ 当前处理课程：{one_course} ------")
                try:
                    # 点开工种下拉框
                    # driver.find_elements(By.XPATH, "//div[@class='el-select']//input[@placeholder='请选择工种']")[0].click()
                    time.sleep(3)
                    work_inputs = driver.find_elements(By.XPATH, "//div[@class='el-select']//input[@placeholder='请选择工种']")
                    if len(work_inputs) == 0:
                        log_write(f"课程[{one_course}]：找不到【请选择工种】输入框，跳过本课程")
                        continue
                    # safe_click(work_inputs[0])
                    work_inputs[0].click()
                    time.sleep(1)

                    # 选中工种
                    work_items = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//ul/li/span[contains(text(),'" + one_course + "')]")
                    if len(work_items) == 0:
                        log_write(f"课程[{one_course}]：下拉列表找不到工种[{one_course}]，跳过本课程")
                        continue
                    # safe_click(work_items[0])
                    work_items[0].click()
                    time.sleep(1)
                    # 点击查询
                    driver.find_element(By.XPATH, "//div[@class='main-app']//button/span[contains(text(),'查询')]/..").click()

                    rows = driver.find_elements(By.XPATH, "//div[@class='main-app']//div[@class='el-table__body-wrapper is-scrolling-none']//tbody/tr")
                    if len(rows) == 0:
                        log_write(f"课程[{one_course}]：表格无数据行，跳过本课程")
                        continue

                    check_boxes = rows[0].find_elements(By.XPATH, ".//td/div/label//span[@class='el-checkbox__inner']")
                    if len(check_boxes) > 0:
                        # safe_click(check_boxes[0])
                        check_boxes[0].click()
                    time.sleep(1.5)

                    sel_btn_list = driver.find_elements(By.XPATH, "//div//button/span[contains(text(),'选择考点与时间')]/..")
                    if len(sel_btn_list) ==0:
                        log_write(f"课程[{one_course}]：找不到【选择考点与时间】按钮，跳过本课程")
                        continue
                    # safe_click(sel_btn_list[0])
                    sel_btn_list[0].click()
                    time.sleep(1)

                    site_inputs = driver.find_elements(By.XPATH, "//div[@class='el-dialog__body']//input[@placeholder='请选择考点']")
                    if len(site_inputs) == 0:
                        log_write(f"课程[{one_course}]：找不到【请选择考点】输入框，跳过本课程")
                        closeExamDialog()
                        continue
                    # safe_click(site_inputs[0])
                    site_inputs[0].click()
                    time.sleep(2)

                    site_items = driver.find_elements(By.XPATH, "//div[@class='el-select-dropdown el-popper']//ul/li/span[contains(text(),'上海城建职业学院考试点')]")
                    if len(site_items) == 0:
                        log_write(f"课程[{one_course}]：未找到考点【上海城建职业学院考试点】，跳过本课程")
                        closeExamDialog()
                        continue
                    # safe_click(site_items[0])
                    site_items[0].click()
                    log_write(f"课程[{one_course}]：成功选中考点【上海城建职业学院考试点】")
                    time.sleep(1)

                    log_write(f"课程[{one_course}]执行单次查询")
                    query_btns = driver.find_elements(By.XPATH, "//div[@class='el-dialog__body']//button/span[contains(text(),'查询')]/..")
                    if len(query_btns) >0:
                        # safe_click(query_btns[0])
                        query_btns[0].click()
                    time.sleep(1)

                    place_rows = driver.find_elements(By.XPATH, "//div[@class='el-dialog__body']//div[@class='el-table__body-wrapper is-scrolling-none']//tbody/tr")
                    if len(place_rows) > 0:
                        for tr in place_rows:
                            tds = tr.find_elements(By.TAG_NAME, "td")
                            if len(tds) >= 4:
                                r_name = tds[0].find_elements(By.TAG_NAME, "div")[0].text.replace("'","''")
                                r_examDate = tds[1].find_elements(By.TAG_NAME, "div")[0].text.replace("'","''")
                                r_all = tds[2].find_elements(By.TAG_NAME, "div")[0].text.replace("'","''")
                                r_now = tds[3].find_elements(By.TAG_NAME, "div")[0].text.replace("'","''")
                                sql = "exec autoCheckPlace '" + one_course + "', '" + r_name + "', '" + r_examDate + "', '" + r_all + "', '" + r_now + "'"
                                execSQL(sql)
                                log_write(f"入库：{r_name}|{r_examDate}|{r_all}/{r_now}")
                    time.sleep(1)
                    closeExamDialog()

                except Exception as course_err:
                    log_write(f"课程[{one_course}]执行异常，关闭弹窗后跳过该课程：{str(course_err)}\n{traceback.format_exc()}")
                    # closeExamDialog()
                    continue
            time.sleep(1)
    finally:
        cursor.close()
    return result

def add_alpha_channel(img):
    r_channel, g_channel, b_channel = cv2.split(img)
    alpha_channel = np.ones(b_channel.shape,
                            dtype=b_channel.dtype) * 255
    img_new = cv2.merge(
        (r_channel, g_channel, b_channel, alpha_channel))
    return img_new

def handel_img(img):
    imgGray = cv2.cvtColor(img, cv2.COLOR_RGBA2GRAY)
    imgBlur = cv2.GaussianBlur(imgGray, (5, 5), 1)
    imgCanny = cv2.Canny(imgBlur, 60, 60)
    return imgCanny

def match(img_jpg_path, img_png_path):
    img_jpg = cv2.imread(img_jpg_path, cv2.IMREAD_UNCHANGED)
    img_png = cv2.imread(img_png_path, cv2.IMREAD_UNCHANGED)
    if img_jpg.shape[2] == 3:
        img_jpg = add_alpha_channel(img_jpg)
    img = handel_img(img_jpg)
    small_img = handel_img(img_png)
    res_TM_CCOEFF_NORMED = cv2.matchTemplate(img, small_img, 3)
    value = cv2.minMaxLoc(res_TM_CCOEFF_NORMED)
    value = value[3][0]
    return value

def execSQL(text: str):
    curs = conn.cursor()
    curs.execute(text)
    curs.close()

if __name__ == '__main__':
    log_write("==== autoCheckPlace 程序启动 ====")
    try:
        conn = pymssql.connect(
            server=env_dist.get('NODE_ENV_DB'),
            port="14333",
            user="sqlrw",
            password=env_dist.get('NODE_ENV_DB_PASSWD'),
            database="elearning",
            autocommit=True,
            tds_version="7.0"
        )
        driver = webdriver.Chrome(options=options)
        wait = WebDriverWait(driver, 30)

        cursor = conn.cursor()
        sql = "select accountA, passwdA from hostInfo where hostNo= 'znxf'"
        cursor.execute(sql)
        rs = cursor.fetchone()
        if rs is not None:
            username = rs[0]
            password = rs[1]
            log_write("从hostInfo读取登录账号成功")
        else:
            raise Exception("hostInfo表未读取到账号密码")
        cursor.close()

        register = "desk."
        course_list = ["低压电工作业", "焊接", "高处作业"]

        login_ret = login_fr()
        if login_ret == 0:
            autoCheckPlace(course_list)
        else:
            log_write("登录失败，跳过全部课程抓取")

    except Exception as main_e:
        log_write(f"【顶层异常】{str(main_e)}\n{traceback.format_exc()}")
    finally:
        log_write("==== 开始释放资源 ====")
        if driver is not None:
            try:
                driver.quit()
                log_write("driver.quit() 执行完毕，关闭Chrome")
            except Exception as e:
                log_write(f"driver.quit异常：{e}")
        if conn is not None:
            try:
                conn.close()
                log_write("数据库连接已关闭")
            except Exception as e:
                log_write(f"conn.close异常：{e}")
        log_write("==== autoCheckPlace 程序结束 ====\n")

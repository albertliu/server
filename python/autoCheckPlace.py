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
from selenium.webdriver.common.keys import Keys
from selenium.common.exceptions import (
    TimeoutException,
    NoSuchElementException,
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

# 安全点击：普通click失败时用JS原生click兜底
def safe_click(el):
    try:
        el.click()
    except (ElementClickInterceptedException, ElementNotInteractableException):
        # log_write("检测到click被拦截/不可交互，使用JS原生点击兜底")
        driver.execute_script("arguments[0].click();", el)

# 等待全屏loading遮罩层消失
def wait_loading_gone(timeout=10):
    try:
        masks = driver.find_elements(By.CLASS_NAME, "el-loading-mask")
        if len(masks) > 0:
            wait.until(
                EC.invisibility_of_element_located((By.CLASS_NAME, "el-loading-mask")),
                timeout
            )
            # log_write("loading遮罩已消失")
    except TimeoutException:
        log_write(f"等待loading遮罩消失超时（{timeout}秒），继续执行")
    except Exception as e:
        log_write(f"等待loading遮罩异常: {e}")

# 等待el-dialog弹窗wrapper完全消失（关闭弹窗后调用，避免淡出中的遮罩拦截点击）
def wait_dialog_gone(timeout=5):
    try:
        wrappers = driver.find_elements(By.CLASS_NAME, "el-dialog__wrapper")
        if len(wrappers) > 0:
            wait.until(
                EC.invisibility_of_element_located((By.CLASS_NAME, "el-dialog__wrapper")),
                timeout
            )
            # log_write("弹窗wrapper已完全消失")
    except TimeoutException:
        log_write(f"等待弹窗wrapper消失超时（{timeout}秒），继续执行")
    except Exception as e:
        log_write(f"等待弹窗wrapper异常: {e}")

# 关闭实操考试预约弹窗：同时隐藏dialog本体 + el-dialog__wrapper外层遮罩
def closeExamDialog():
    try:
        close_btns = driver.find_elements(
            By.XPATH,
            "//div[@aria-label='实操考试预约']/div[@class='el-dialog__header']/button[@aria-label='Close']"
        )
        if len(close_btns) > 0:
            btn = close_btns[0]
            if btn.is_displayed() and btn.is_enabled():
                safe_click(btn)
                # log_write("已点击按钮关闭实操考试预约弹窗")
                time.sleep(1.5)
                # 等待弹窗wrapper完全消失，避免淡出中的遮罩拦截下一次点击
                wait_dialog_gone()
                return
        # 按钮不可用，JS同时隐藏dialog本体 + 外层wrapper遮罩容器
        driver.execute_script("""
            var dialog = document.querySelector('div[aria-label="实操考试预约"].el-dialog');
            if(dialog){dialog.style.display='none';}
            var wrapper = document.querySelector('.el-dialog__wrapper');
            if(wrapper){wrapper.style.display='none';}
            var mask = document.querySelector('.el-dialog__mask');
            if(mask){mask.style.display='none';}
        """)
        # log_write("JS强制隐藏弹窗+外层wrapper遮罩")
        time.sleep(2)
        # JS隐藏后也等待确认消失
        wait_dialog_gone()
    except Exception as e:
        log_write(f"关闭弹窗异常(忽略): {str(e)}")

# 进入"考试管理" → "实操考试预约"菜单（登录成功后调用一次，不放在课程循环内）
def enter_exam_menu():
    log_write("进入菜单：考试管理 → 实操考试预约")
    driver.find_elements(By.XPATH, "//span[contains(text(),'考试管理')]")[0].click()
    time.sleep(1)
    driver.find_elements(By.XPATH, "//li[contains(text(),'实操考试预约')]")[0].click()
    time.sleep(1)

# ===================== Chrome 配置 =====================
def build_chrome_options():
    opts = webdriver.ChromeOptions()
    opts.add_argument('ignore-certificate-errors')
    # opts.add_argument("--headless=new")
    opts.add_argument("--no-sandbox")
    opts.add_argument("--disable-gpu")
    opts.add_argument("--disable-dev-shm-usage")
    return opts

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

# 关闭当前浏览器并重新登录，然后重新进入菜单；返回True表示成功
def restart_browser_and_login():
    global driver, wait
    log_write("==== 异常恢复：关闭当前浏览器，重新登录 ====")
    if driver is not None:
        try:
            driver.quit()
            log_write("旧浏览器已关闭")
        except Exception as e:
            log_write(f"关闭旧浏览器异常: {e}")
        driver = None
        wait = None
    time.sleep(2)
    try:
        driver = webdriver.Chrome(options=build_chrome_options())
        wait = WebDriverWait(driver, 5)
        log_write("新浏览器已启动")
    except Exception as e:
        log_write(f"启动新浏览器失败: {e}\n{traceback.format_exc()}")
        return False
    ret = login_fr()
    if ret != 0:
        log_write("重新登录失败")
        return False
    log_write("重新登录成功，重新进入菜单")
    try:
        enter_exam_menu()
    except Exception as e:
        log_write(f"重新进入菜单失败: {e}")
        return False
    log_write("恢复完成，继续抓取流程")
    return True

def autoCheckPlace(course_list):
    """
    course_list: 课程数组，循环遍历，每个课程查询一次后切换下一个；
    全局55分钟计时不重置；
    登录成功后先进入菜单（循环外），再进入课程循环；
    异常时关闭浏览器→重新登录→重新进入菜单→继续循环（计时继续）。
    下拉框选择使用显式等待，等选项出现后再点击。
    每个课程循环查询多个考点，全部查完后再关闭弹窗。
    """
    global driver, wait
    log_write(f"==== 进入抓取流程，课程列表：{course_list} ====")
    cursor = conn.cursor()

    # ===== 登录成功后立刻进入菜单（只执行一次，不在课程循环内）=====
    enter_exam_menu()

    GLOBAL_TIMEOUT = 60 * 55
    global_start = time.time()          # 55分钟计时起点，全程不重置
    relogin_fail_count = 0              # 连续重登失败计数，防止死循环
    MAX_RELOGIN_FAIL = 5
    DROPDOWN_WAIT = 4                  # 下拉框选项等待超时（秒）
    TABLE_WAIT = 4                     # 表格数据加载等待超时（秒）
    LOADING_WAIT = 4                   # loading遮罩等待超时（秒）
    DIALOG_WAIT = 5                    # 弹窗wrapper消失等待超时（秒）

    # 考点列表：每个课程依次查询这两个考点，全部查完后再关闭弹窗
    SITE_LIST = ["上海城建职业学院考试点", "沪东中华"]

    try:
        while True:
            # 全局55分钟超时判断（计时继续，不因重登重置）
            elapsed = time.time() - global_start
            if elapsed > GLOBAL_TIMEOUT:
                log_write(f"全局运行时间到达 {GLOBAL_TIMEOUT:.0f} 秒，整体退出抓取循环")
                break

            # ===== 循环遍历课程列表，每个课程查询一次后切换下一个 =====
            for one_course in course_list:
                write_heartbeat()
                log_write(f"------ 当前处理课程：{one_course}（已运行 {elapsed:.0f}s / {GLOBAL_TIMEOUT}s）------")

                # 标记：本轮是否已经打开了"选择考点与时间"弹窗
                # 只有点击了该按钮后弹窗才出现，之前出错不需要关闭
                dialog_opened = False

                try:
                    # ===== 修复：点击工种前，先等待上一个弹窗wrapper完全消失 =====
                    wait_dialog_gone(DIALOG_WAIT)

                    # ===== 选工种：点击下拉框后，显式等待课程选项出现再点击（用safe_click）=====
                    work_inputs = driver.find_elements(By.XPATH, "//div[@class='el-select']//input[@placeholder='请选择工种']")
                    if len(work_inputs) == 0:
                        raise Exception("找不到【请选择工种】输入框")
                    safe_click(work_inputs[0])
                    # log_write(f"已点击工种下拉框，等待选项[{one_course}]出现...")

                    work_option_xpath = "//div[@class='el-select-dropdown el-popper']//ul/li/span[contains(text(),'" + one_course + "')]"
                    try:
                        work_option = wait.until(
                            EC.element_to_be_clickable((By.XPATH, work_option_xpath)),
                            DROPDOWN_WAIT
                        )
                        work_option.click()
                        # log_write(f"工种选项[{one_course}]已出现并点击")
                    except TimeoutException:
                        raise Exception(f"等待工种选项[{one_course}]出现超时（{DROPDOWN_WAIT}秒）")
                    time.sleep(1)

                    # ===== 点击主页面的"查询"按钮，加载该工种的考试点数据 =====
                    # log_write("点击主页面查询按钮，加载工种数据...")
                    main_query_btns = driver.find_elements(
                        By.XPATH,
                        "//div[@class='main-app']//button/span[contains(text(),'查询')]/.."
                    )
                    if len(main_query_btns) > 0:
                        main_query_btns[0].click()
                        # log_write("主页面查询按钮已点击，等待表格数据加载...")
                    else:
                        log_write("未找到主页面查询按钮，直接尝试读取表格")

                    # 等待loading遮罩层消失，避免点击checkbox被拦截
                    wait_loading_gone(LOADING_WAIT)

                    # 显式等待表格数据行出现
                    table_row_xpath = "//div[@class='main-app']//div[@class='el-table__body-wrapper is-scrolling-none']//tbody/tr"
                    try:
                        wait.until(
                            EC.presence_of_element_located((By.XPATH, table_row_xpath)),
                            TABLE_WAIT
                        )
                        log_write("表格数据已加载")
                    except TimeoutException:
                        log_write(f"等待表格数据加载超时（{TABLE_WAIT}秒），可能该工种无数据")

                    # ===== 勾选数据行（用safe_click，被拦截时JS兜底）=====
                    data = driver.find_elements(By.XPATH, table_row_xpath)
                    if len(data) > 0:
                        check_boxes = data[0].find_elements(By.XPATH, ".//td/div/label//span[@class='el-checkbox__inner']")
                        if len(check_boxes) > 0:
                            safe_click(check_boxes[0])
                            # log_write("已勾选第一行数据")
                        else:
                            log_write("未找到checkbox，跳过勾选")

                        # ===== 点击"选择考点与时间"按钮 —— 此后弹窗才出现 =====
                        driver.find_element(By.XPATH, "//div//button/span[contains(text(),'选择考点与时间')]/..").click()
                        dialog_opened = True   # 标记弹窗已打开，后续异常需要关闭
                        time.sleep(1)

                        # ===== 循环查询多个考点，全部查完后再关闭弹窗 =====
                        for site_name in SITE_LIST:
                            # 点击考点下拉框（用safe_click，被拦截时JS兜底）
                            site_inputs = driver.find_elements(By.XPATH, "//div[@class='el-select']//input[@placeholder='请选择考点']")
                            if len(site_inputs) == 0:
                                raise Exception("找不到【请选择考点】输入框")
                            safe_click(site_inputs[0])
                            # log_write(f"已点击考点下拉框，等待选项[{site_name}]出现...")

                            site_option_xpath = "//div[@class='el-select-dropdown el-popper']//ul/li/span[contains(text(),'" + site_name + "')]"
                            try:
                                site_option = wait.until(
                                    EC.element_to_be_clickable((By.XPATH, site_option_xpath)),
                                    DROPDOWN_WAIT
                                )
                                site_option.click()
                                log_write(f"课程[{one_course}]：成功选中考点【{site_name}】")
                            except TimeoutException:
                                # 该考点不存在：点击考点输入框让下拉框收起，跳过该考点
                                log_write(f"课程[{one_course}]：未找到考点【{site_name}】，跳过")
                                safe_click(site_inputs[0])
                                continue
                            time.sleep(1)

                            # 点击弹窗内的"查询"按钮，获取考点预约数据
                            # log_write(f"课程[{one_course}] 考点[{site_name}] 执行弹窗内查询")
                            dialog_query_btns = driver.find_elements(
                                By.XPATH,
                                "//div[@class='el-dialog__body']//button/span[contains(text(),'查询')]/.."
                            )
                            if len(dialog_query_btns) > 0:
                                dialog_query_btns[0].click()
                            else:
                                log_write("未找到弹窗内查询按钮")
                            time.sleep(2)

                            place = driver.find_elements(By.XPATH, "//div[@class='el-dialog__body']//div[@class='el-table__body-wrapper is-scrolling-none']//tbody/tr")
                            if len(place) > 0:
                                for tr in place:
                                    tds = tr.find_elements(By.TAG_NAME, "td")
                                    if len(tds) >= 4:
                                        r_name = tds[0].find_elements(By.TAG_NAME, "div")[0].text.replace("'","''")
                                        r_examDate = tds[1].find_elements(By.TAG_NAME, "div")[0].text.replace("'","''")
                                        r_all = tds[2].find_elements(By.TAG_NAME, "div")[0].text.replace("'","''")
                                        r_now = tds[3].find_elements(By.TAG_NAME, "div")[0].text.replace("'","''")
                                        sql = "exec autoCheckPlace '" + one_course + "', '" + r_name + "', '" + r_examDate + "', '" + r_all + "', '" + r_now + "'"
                                        execSQL(sql)
                                        log_write(f"入库：{r_name}|{r_examDate}|{r_all}/{r_now}")

                        # ===== 全部考点查询完成，关闭弹窗，回到选择课程页面 =====
                        closeExamDialog()
                    else:
                        log_write(f"课程[{one_course}]：表格无数据行，跳过本课程")

                    # 本课程正常完成，重置重登失败计数
                    relogin_fail_count = 0
                    time.sleep(2)

                except Exception as e:
                    # ===== 异常处理 =====
                    log_write(f"课程[{one_course}]异常: {str(e)}\n{traceback.format_exc()}")
                    result["err"] = 1
                    result["errMsg"] = f"action failed:{str(e)}"

                    # 只有弹窗已经打开（点击过"选择考点与时间"按钮）才需要关闭弹窗
                    if dialog_opened:
                        log_write("弹窗已打开，尝试关闭弹窗")
                        try:
                            closeExamDialog()
                        except Exception:
                            pass
                    else:
                        log_write("弹窗未打开（错误发生在点击'选择考点与时间'之前），无需关闭弹窗")

                    # 关闭浏览器 → 重新登录 → 重新进入菜单 → 继续循环（55分钟计时不重置）
                    ok = restart_browser_and_login()
                    if ok:
                        relogin_fail_count = 0
                        log_write("恢复成功，继续下一个课程（55分钟计时继续）")
                    else:
                        relogin_fail_count += 1
                        log_write(f"恢复失败，第 {relogin_fail_count}/{MAX_RELOGIN_FAIL} 次")
                        if relogin_fail_count >= MAX_RELOGIN_FAIL:
                            log_write("连续重登失败达到上限，终止抓取循环")
                            return result
                        time.sleep(10)
                    # 继续for循环下一个课程，计时不重置

            # 一轮全部课程遍历完成，短暂休眠，再进入下一轮循环
            time.sleep(5)
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

def clean_send(element, text: str):
    element.clear()
    element.send_keys(text)

def execSQL(text: str):
    curs = conn.cursor()
    curs.execute(text)
    curs.close()

if __name__ == '__main__':
    log_write("==== autoCheckPlace 程序启动 ====")
    try:
        # 数据库连接
        conn = pymssql.connect(
            server=env_dist.get('NODE_ENV_DB'),
            port="14333",
            user="sqlrw",
            password=env_dist.get('NODE_ENV_DB_PASSWD'),
            database="elearning",
            autocommit=True,
            tds_version="7.0"
        )
        # 初始化浏览器
        driver = webdriver.Chrome(options=build_chrome_options())
        wait = WebDriverWait(driver, 30)
        # 原有逻辑：从 hostInfo 表读取账号密码
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
        # 课程列表
        course_list = ["低压电工", "熔化焊接", "高处安装"]

        login_ret = login_fr()
        if login_ret == 0:
            autoCheckPlace(course_list)
        else:
            log_write("登录失败，跳过业务抓取")

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

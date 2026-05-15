from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoAlertPresentException
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
wait = WebDriverWait(driver, 3)
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


def enter_by_list0(elist, kindID, refID):
    # 根据指定名单（kindID 0 applyID 1 enterID 2 username  @refID:classInfo.ID)查询市监局考试成绩。
    # 获取名单完整信息
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "exec getStudentListByList '" + elist + "', " + str(kindID) + ", " + str(refID)  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句
    rs = cursor.fetchall()
    url = r'http://www.tzsbks.sh.cn/index.shtml'

    # 打开网址
    driver.get(url)
    wait = WebDriverWait(driver, 5)
    # 浏览器全屏，可有可无
    driver.maximize_window()
    driver.execute_script("""
        if (typeof JSON === 'undefined' || typeof JSON.stringify !== 'function') {
            window.JSON = window.parent.JSON || {};
            if (typeof JSON.stringify !== 'function') {
                // 从空白页面重新获取完整的 JSON 对象（最安全的备选）
                var iframe = document.createElement('iframe');
                iframe.style.display = 'none';
                document.body.appendChild(iframe);
                window.JSON = iframe.contentWindow.JSON;
                document.body.removeChild(iframe);
            }
        }
    """)
    current_window = driver.current_window_handle

    for row in rs:
        try:
            # 输入证件号码
            name_input = driver.find_element(By.ID, "sfzh")
            clean_send(name_input, row[2])
            name_input = driver.find_element(By.NAME, "Submit2")  # 查询按钮
            name_input.click()
            wait.until(EC.presence_of_element_located((By.XPATH, "//div[@id='verify-title']/span[contains(text(), '请先完成安全验证')]")))

            n = 0   # 尝试登录，5次失败后退出
            while n < 50:
                n += 1
                # 获取主图以及需要拖动的图片
                # 主图
                target_link = driver.find_element(By.ID,
                                                "verifyBigImg").get_attribute('src').replace(
                                                    "data:image/png;base64,", "")
                # print("target_link:", target_link, end="\n")
                # 需要拖动的图片
                template_link = driver.find_element(By.ID,
                                                    "verifySmallImg").get_attribute('src').replace(
                                                    "data:image/png;base64,", "")

                target_data = base64.b64decode(target_link)
                with open(py_path + '/temp/target_market.png', 'wb') as f:
                    f.write(target_data)
                template_data = base64.b64decode(template_link)
                with open(py_path + '/temp/template_market.png', 'wb') as f:
                    f.write(template_data)

                # 计算滑块移动距离
                distance = match(py_path + '/temp/target_market.png', py_path + '/temp/template_market.png')
                # print(distance)
                distance = distance * 375 / 400  # 这个距离自己慢慢试一下试出来的

                # 移动滑块
                slider = driver.find_element(By.ID, 'verifySliderBtn')
                ActionChains(driver).click_and_hold(slider).perform()
                ActionChains(driver).move_by_offset(xoffset=distance, yoffset=0).perform()
                # time.sleep(1)
                ActionChains(driver).release().perform()
                try:
                    # 切换至警告框
                    alert1 = driver.switch_to.alert

                    # 获取alert窗口的值
                    # print(alert1.text)

                    # 点击 确定
                    alert1.accept()
                    name_input = driver.find_element(By.ID, "verifyRefresh")
                    # name_input = driver.find_element(By.ID, "verifyClose")
                    name_input.click()
                    # driver.switch_to.window(current_window)
                except NoAlertPresentException:
                    # print("No alert is present")
                    try:
                        wait.until(EC.presence_of_element_located((By.XPATH, "//span[@id='_Title_0' and contains(text(), '考试成绩信息')]")))
                        # 进入成绩页面
                        # frame = driver.find_element(By.ID, "_DialogFrame_0")
                        driver.switch_to.frame(0)
                        driver.execute_script("""
                            if (typeof JSON === 'undefined' || typeof JSON.stringify !== 'function') {
                                window.JSON = window.parent.JSON || {};
                                if (typeof JSON.stringify !== 'function') {
                                    // 从空白页面重新获取完整的 JSON 对象（最安全的备选）
                                    var iframe = document.createElement('iframe');
                                    iframe.style.display = 'none';
                                    document.body.appendChild(iframe);
                                    window.JSON = iframe.contentWindow.JSON;
                                    document.body.removeChild(iframe);
                                }
                            }
                        """)
                        # tds = driver.find_elements(By.XPATH, "//td[contains(text(), '特种设备安全管理')]")
                        tds = driver.find_elements(By.XPATH, "//td[contains(text(), '特种设备安全管理')]")
                        if len(tds)>0:
                            examDate = driver.find_elements(By.XPATH, "//tbody//td[contains(text(), '特种设备安全管理')]/../td")[2].text[:10]
                            if examDate >= row[6]:
                                score = driver.find_elements(By.XPATH, "//tbody//td[contains(text(), '特种设备安全管理')]/../td")[6].text
                                # 保存结果
                                result["count_s"] += 1
                                # @enterID int, @date varchar(50), @registerID varchar(50)  删除字符串首尾的空格
                                sql = "exec setMarketScoreCheck " + str(row[4]) + ",'" + score + "', '" + examDate + "', '" + register + "'"
                                # print(sql)
                                execSQL(sql)
                        # 关闭成绩页面
                        driver.switch_to.default_content()
                        name_input = driver.find_element(By.ID, "_ButtonClose_0")
                        name_input.click()
                        n = 50
                    except Exception:
                        # print(e)
                        continue

        except Exception:
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
    # register = "test"
    # enter_by_list0('321002197501271811', 2, 3800)
    # 以上是测试代码
    enter_by_list0(sys.argv[1], sys.argv[2], sys.argv[3])   # argv[2]:0 applyID  1 enterID  2 username  argv[3]:classInfo.ID
    print(result)

from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import os
import tempfile
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver import ActionChains
from selenium.webdriver.common.keys import Keys
from selenium.common.exceptions import TimeoutException
import pymssql
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
# options = webdriver.ChromeOptions()
options = webdriver.EdgeOptions()
options.add_argument('ignore-certificate-errors')
# options.add_experimental_option('debuggerAddress', '127.0.0.1:9222')
# 指定为无界面模式
# options.add_argument('headless')
# driver = webdriver.Chrome(executable_path="G:/Working/Project/eTraining/maintain/deploy/chromedriver.exe", options=options)
driver = webdriver.Edge(executable_path="G:/Working/Project/eTraining/maintain/deploy/msedgedriver.exe", options=options)
# 设置最大等待时间10秒
wait = WebDriverWait(driver, 10)
# 创建连接字符串  （sqlserver默认端口为1433）
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


def list(mark, url):
    # mark: 1142
    # 1 危化生产负责人（初训）账号：6052451154  密码：176069    1	758	409
    # 2 危化生产负责人（复训）账号：6050123131  密码：739233    2	780	416
    # 3 危化管理人员（初训）账号：6051661724  密码：660594      3	993	531
    # 4 危化管理人员（复训）账号：6051856569  密码：571355      4  1018	533
    aim_url = url
    # cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    # 打开链接
    try:
        driver.get(aim_url)

        # 浏览器全屏，可有可无
        # driver.maximize_window()
        # 跳到第一题
        btns = driver.find_elements(By.XPATH, "//div[@class='footer']/input[@value='上一题']")
        bc = [element for element in btns if element.is_displayed()]
        while len(bc) > 0:
            bc[0].click()
            time.sleep(0.3)
            bc = [element for element in btns if element.is_displayed()]

        arr = driver.find_elements(By.XPATH, "//div[@class='exam-content']")
        i = 0
        while i < len(arr):
            ar = driver.find_elements(By.XPATH, "//div[@class='exam-content']")
            li = ar[i]
            ar_li = li.find_elements(By.XPATH, "ul/li")
            question = li.text
            p = li.find_elements(By.XPATH, "p/span")
            print(li.text, p[0].text, p[1].text)
            re = ["", "", "", "", "", ""]
            j = 0
            while j < len(ar_li):
                re[j] = ar_li[j].text
                j += 1
            answer = li.find_elements(By.XPATH, "following-sibling::div[@class='for-wrong']/span")
            memo = ""
            if len(answer) > 3:
                memo = answer[4].text
            # print(answer[4].text)
            sql = "exec setWeixinQuestion " + str(mark) + ", 0, '" + question + "', '" + answer[2].text + "', '" + re[0] + "', '" + re[1] + "', '" + re[2] + "', '" + re[3] + "', '" + re[4] + "', '" + re[5] + "', '" + memo + "'"
            execSQL(sql)
            # 下一题
            input = li.find_elements(By.XPATH, "following-sibling::div[@class='footer']/input[@value='下一题']")[0]
            input.click()
            time.sleep(0.3)

            i += 1

    except Exception as e:
        print(e)
        result["err"] = 1
        result["errMsg"] = "login failed"
        return 1


def execSQL(text: str):
    """
    执行SQL语句, 无返回结果
    """
    curs = conn.cursor()  # 使用cursor()方法获取操作游标
    curs.execute(text)  # 执行sql语句
    curs.close()


if __name__ == '__main__':
    # 以下是测试代码
    username = "13651648767"
    password = "Pqf1823797198"
    # 以上是测试代码

    # 登录
    d_list = [
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=d94dd12158f9f875d360d5c4477b7b24&xuHao=17&UUID=68664110",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=8cd253132be26cd5b7ca9865d3aa423b&xuHao=18&UUID=68664118",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=08cfa7db6629c7ee4764b925fa1817e7&xuHao=19&UUID=68664149",
        "https://www.aqscmnks.com/exam/View/kaoshi.php?type=50a2ed68f591d00dd440997d6dea8ea2&xuHao=20&time=0&UUID=68664160",
        "https://www.aqscmnks.com/exam/View/kaoshi.php?type=86e81cd4dfc4e780efccf198536627c9&xuHao=21&time=0&UUID=68664165",
        "https://www.aqscmnks.com/exam/View/kaoshi.php?type=538db227da1e0060b56f6e32a93c420c&xuHao=22&time=0&UUID=68664173",
        "https://www.aqscmnks.com/exam/View/kaoshi.php?type=8df402374d5cd224df8d05905e8b3828&xuHao=23&time=0&UUID=68664180",
        "https://www.aqscmnks.com/exam/View/kaoshi.php?type=7ddec4e10bf20d5fdb9a565b2ea50ed0&xuHao=24&time=0&UUID=68664188",
        "https://www.aqscmnks.com/exam/View/kaoshi.php?type=bb2f55865ccbc60d3d35386ead57069b&xuHao=25&time=0&UUID=68664209",
        "https://www.aqscmnks.com/exam/View/kaoshi.php?type=6755a28f55cb2f05dcd9bcf9dee63086&xuHao=26&time=0&UUID=68664218",
        "https://www.aqscmnks.com/exam/View/kaoshi.php?type=f34e5346d04975cffcf6e55bdc59b93b&xuHao=27&time=0&UUID=68664232",
        "https://www.aqscmnks.com/exam/View/kaoshi.php?type=547d0fe90752370e91b240bc945ae553&xuHao=28&time=0&UUID=68664244"
    ]
    kind = 5
    n = 0
    while n < len(d_list):
        list(kind, d_list[n])
        n += 1

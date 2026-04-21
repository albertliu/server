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
options = webdriver.ChromeOptions()
# options = webdriver.EdgeOptions()
options.add_argument('ignore-certificate-errors')
# options.add_experimental_option('debuggerAddress', '127.0.0.1:9222')
# 指定为无界面模式
# options.add_argument('headless')
driver = webdriver.Chrome(options)
# driver = webdriver.Edge(executable_path="G:/Working/Project/eTraining/maintain/deploy/msedgedriver.exe", options=options)
# 设置最大等待时间10秒
wait = WebDriverWait(driver, 10)
# 创建连接字符串  （sqlserver默认端口为1433）
py_path = env_dist.get('NODE_ENV_PYTHON')
try:
    conn = pymssql.connect(
        server=env_dist.get('NODE_ENV_DB'),  # 本地服务器
        port="14333",  # TCP端口
        user="sqlrw",
        password=env_dist.get('NODE_ENV_DB_PASSWD'),
        database="elearning",
        autocommit=True,   # 自动提交
        tds_version="7.0"
        )
except pymssql.OperationalError as e:
    print(f"Error code: {e.args}", env_dist.get('NODE_ENV_DB'))
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
    # 焊工：6053726343   612596
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
            # insert into [questionOther]
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
        # "https://www.aqscmnks.com/exam/View/lishijilu.php?type=9066bb909f32a9fa7c99847a09fd185c&xuHao=1&UUID=70443828",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=409bfcf02bf077cbbe33df7ce3660516&xuHao=2&UUID=70521260",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=758ba31620fc4cc0f32b34d14f0ddb81&xuHao=3&UUID=70521273",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=0886d6fbb3ca047595528fbc9c3ccd1a&xuHao=4&UUID=70521277",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=e93e0bdbc7138d0708d0b176852b711c&xuHao=5&UUID=70521290",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=2cc5305ad043ca7922f599363988fbd3&xuHao=6&UUID=70521295",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=ea22a7e851c4ae59912cf2391d0b4164&xuHao=7&UUID=70521301",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=25e3cac6ac03c85bf3c3ea77d32b8992&xuHao=8&UUID=70521303",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=87df0e2b4a3504cc84c420ab57b55b57&xuHao=9&UUID=70521306",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=876e496ceb85bf8f19eb3ca678293ae1&xuHao=10&UUID=70521310",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=2939eaeba52cb1d92c31d3ce14aae279&xuHao=11&UUID=70521314",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=43fea64f486da7732a3b2ec4e9fe1f8d&xuHao=12&UUID=70521318",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=f7f4d9df1cdcf6374cd9ca8959d4992c&xuHao=13&UUID=70521321",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=74c7c9f00466749518606b077a02ffa8&xuHao=14&UUID=70521325",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=bd05e603e9b680a6d482f8d35002758d&xuHao=15&UUID=70521330",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=c9b0056b0f090a0644ff10ce5b2bbd5f&xuHao=16&UUID=70521336",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=795e7ff144bbf12fa85e639255cb826e&xuHao=17&UUID=70521339",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=833125a56c2b2c5cd2fd6df8ebc40e0d&xuHao=18&UUID=70521342",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=23cac0d67b34922274ae04b8ecce0509&xuHao=19&UUID=70521347",
        "https://www.aqscmnks.com/exam/View/lishijilu.php?type=466900fb5a7fbdb910d7e15a08c14622&xuHao=20&UUID=70521353"
    ]
    kind = 5
    n = 0
    while n < len(d_list):
        list(kind, d_list[n])
        n += 1

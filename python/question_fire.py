from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import os
from selenium.webdriver.support.wait import WebDriverWait
import pymssql

env_dist = os.environ
options = webdriver.ChromeOptions()
options.add_argument('ignore-certificate-errors')
# 指定为无界面模式
# options.add_argument('headless')
driver = webdriver.Chrome(options=options)
# driver = webdriver.Chrome()
wait = WebDriverWait(driver, 5)
# 创建连接字符串  （sqlserver默认端口为1433）
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
username = "13621659092"
password = ""


def login_fr():
    # 在指定网页上进行登录：输入用户名、密码、登录，拉动滑块进行验证。
    # 定义目标URL信息, , 
    aim_url = {
        'login_url':
        r'https://study.xiaoe-tech.com/#/acount',
        'username': username,   # 13621659092
        'password': password
    }
    # 打开链接
    try:
        driver.get(aim_url['login_url'])

        # 浏览器全屏，可有可无
        driver.maximize_window()

        time.sleep(1)
        # win = driver.get("https://appweo05moc8553.h5.xiaoeknow.com/p/course/ecourse/course_2X0iZPPICLkIRVLrEdKcUzrpBTx?l_program=xe_know_pc")
        search_btn = driver.find_elements(By.XPATH, "//div[contains(text(), '中级消操')]")
        search_btn.click()
        time.sleep(5)

        driver.switch_to.window(driver.window_handles[-1])
        goods_arr = driver.find_elements_by_xpath("//section[@class='item-wrap']")  # 获取到每个题目
        for i, goods in enumerate(goods_arr):
            questionName = goods.find_elements(By.XPATH, "//div[@class='question-title']/p").text   # 题干
            kind = goods.find_elements(By.XPATH, "//div[@class='quetion-type']/p").text   # 类型
            kindID = 1
            if kind.find("多选") >= 0:
                kindID = 2
            elif kind.find("判断") >= 0:
                kindID = 2
            answer = goods.find_elements(By.XPATH, "//div[@class='correct-answer-text' contains(text(),'正确答案：')]/span").text    # 正确答案
            memo = goods.find_elements(By.XPATH, "//div[@class='answer-analysis']/p").text   # 试题分析
            item_arr = driver.find_elements_by_xpath("//label[@class='option-item-after']")  # 获取到每个选项
            items = ['', '', '', '', '', '']
            for j, item in enumerate(item_arr):
                items[j] = item.find_elements(By.XPATH, "//div[@class='xe-preview__content forbidden_contextmenu']/p").text
            # 写数据库
            sql = "exec addNewQuestionOther 'fire', " + kindID + ", '', '" + questionName + "', '" + answer + "', '" + memo + "','" + items[0] + "','" + items[1] + "','" + items[2] + "','" + items[3] + "','" + items[4] + "','" + items[5] + "'"
            execSQL(sql)
    except Exception:
        print(Exception)
        result["err"] = 1
        result["errMsg"] = "login failed"
        return 1


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

    # 以上是测试代码

    # 登录
    login_fr()

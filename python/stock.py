import os
import tempfile
import pymssql
import tushare as ts  # pip install tushare
import requests
import baostock as bs


# 1. 初始化pro接口 (替换成你自己的token)
ts.set_token('da8ebf75ca93ccbff561dc5fb41c428b7944fdc8a09990e0d8f19cae')

# 如果临时文件目录不存在，则创建该目录
new_temp_path = tempfile.gettempdir()
# print(new_temp_path)
os.makedirs(new_temp_path + "\\2", exist_ok=True)  # 确保目录存在

env_dist = os.environ
# options = webdriver.ChromeOptions()
# 创建连接字符串  （sqlserver默认端口为1433）
py_path = env_dist.get('NODE_ENV_PYTHON')
try:
    conn = pymssql.connect(
        server=env_dist.get('NODE_ENV_DB'),  # 本地服务器
        port="14333",  # TCP端口
        user="sqlrw",
        password=env_dist.get('NODE_ENV_DB_PASSWD'),
        database="stock",
        autocommit=True,   # 自动提交
        tds_version="7.0"
        )
except pymssql.DatabaseError as e:
    print(f"Database error: {e}")

result = {"count_s": 0, "count_e": 0, "err": 0, "errMsg": ""}
host = ""
register = "操作员"
username = ""
password = ""


def getStockData(date):
    # cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    # 打开链接
    curs = conn.cursor()  # 使用cursor()方法获取操作游标
    try:
        bs.login()

        # 获取指定日期的指数、股票数据
        stock_data = bs.query_all_stock(date)
        codes = []
        while stock_data.next():
            codes.append(stock_data.get_row_data()[0])  # 股票代码

        if len(codes) == 0:
            print("没有交易数据。")

        for code in codes:
            # frequency：数据类型，默认为d，日k线；d=日k线、w=周、m=月、5=5分钟、15=15分钟、30=30分钟、60=60分钟k线数据，不区分大小写
            # adjustflag：复权类型，默认不复权：3；1：后复权；2：前复权。已支持分钟线、日线、周线、月线前后复权。
            #             参数名称	参数描述	说明
            # date	交易所行情日期	格式：YYYY-MM-DD
            # code	证券代码	格式：sh.600000。sh：上海，sz：深圳
            # open	今开盘价格	精度：小数点后4位；单位：人民币元
            # high	最高价	精度：小数点后4位；单位：人民币元
            # low	最低价	精度：小数点后4位；单位：人民币元
            # close	今收盘价	精度：小数点后4位；单位：人民币元
            # preclose	昨日收盘价	精度：小数点后4位；单位：人民币元
            # volume	成交数量	单位：股
            # amount	成交金额	精度：小数点后4位；单位：人民币元
            # adjustflag	复权状态	不复权、前复权、后复权
            # turn	换手率	精度：小数点后6位；单位：%
            # tradestatus	交易状态	1：正常交易 0：停牌
            # pctChg	涨跌幅（百分比）	精度：小数点后6位
            # peTTM	滚动市盈率	精度：小数点后6位
            # psTTM	滚动市销率	精度：小数点后6位
            # pcfNcfTTM	滚动市现率	精度：小数点后6位
            # pbMRQ	市净率	精度：小数点后6位
            # isST	是否ST	1是，0否
            rs = bs.query_history_k_data_plus(code, "date,code,open,high,low,close,preclose,volume,amount,adjustflag,turn,tradestatus,pctChg,peTTM,psTTM,pcfNcfTTM,pbMRQ,isST", date, date, frequency="d", adjustflag="3")
            while rs.next():
                row = rs.get_row_data()
                # print("Downloading :" + row[0])
                # sql = "exec updateStockData '" + rs.date + "','" + rs.code + "','" + rs.open + "','" + rs.high + "','" + rs.low + "','" + rs.close + "','" + rs.preclose + "','" + rs.volume + "','" + rs.amount + "','" + rs.adjustflag + "','" + rs.turn + "','" + rs.tradestatus + "','" + rs.pctChg + "','" + rs.peTTM + "','" + rs.psTTM + "','" + rs.pcfNcfTTM + "','" + rs.pbMRQ + "','" + rs.isST + "'"
                sql = "exec updateStockData '" + row[0] + "','" + row[1] + "','" + row[2] + "','" + row[3] + "','" + row[4] + "','" + row[5] + "','" + row[6] + "','" + row[7] + "','" + row[8] + "','" + row[9] + "','" + row[10] + "','" + row[11] + "','" + row[12] + "','" + row[13] + "','" + row[14] + "','" + row[15] + "','" + row[16] + "','" + row[17] + "'"
                curs.execute(sql)
        bs.logout()
    except Exception as e:
        print(e)
        result["err"] = 1
        result["errMsg"] = "login failed"
        return 1
    finally:
        curs.close()


# 获取股票列表，所有股票
def getStockList():
    # cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    # 打开链接
    curs = conn.cursor()  # 使用cursor()方法获取操作游标
    try:
        # 登录系统
        bs.login()
        # 获取指定日期的所有股票列表
        df = bs.query_stock_basic().get_data()
        # 3. 查看数据
        # 返回的DataFrame包含: trade_date, open, high, low, close, vol, amount 等字段
        print(f"获取到 {len(df)} 条股票记录")
        print(df.head())
        try:
            for _, row in df.iterrows():
                sql = "exec updateStockInfo '" + row.code + "','" + row.code_name + "','" + row.status + "','" + row.ipoDate + "','" + row.outDate + "','" + row.type + "'"
                curs.execute(sql)

            print(f"成功插入/更新 {len(df)} 条记录")
        except Exception as e:
            print(f"数据库操作失败：{e}")
        # 登出系统
        bs.logout()
    except Exception as e:
        print(e)
        result["err"] = 1
        result["errMsg"] = "login failed"
        return 1
    finally:
        curs.close()


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
    # getStockList()
    getStockData('2026-03-05')

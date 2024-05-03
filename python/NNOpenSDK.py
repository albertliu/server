from hashlib import sha1
import time
import random
import string
import requests
import base64
import hmac
import sys
import os
import pymssql

env_dist = os.environ

conn = pymssql.connect(
    server=env_dist.get('NODE_ENV_DB'),  # 本地服务器
    port="14333",  # TCP端口
    user="sqlrw",
    password=env_dist.get('NODE_ENV_DB_PASSWD'),
    database="elearning",
    autocommit=True   # 自动提交
    )


def get_sign(secret, appkey, senid, nonce, content, timestamp):
    # 生成并返回签名
    param = 'a=services&l=v1&p=open&k=' + appkey + '&i=' + senid + '&n=' + nonce + '&t=' + timestamp + '&f=' + content
    hmac_code = hmac.new(secret.encode(), param.encode(), sha1).digest()
    return base64.b64encode(hmac_code).decode()


def send_request(request_url, senid, appkey, app_secret, token, taxnum, method, content):
    """
    调用诺诺开放平台API
    发送HTTP POST请求 <同步>
    """
    timestamp = str(int(time.time()))  # 时间戳
    nonce = str(random.randint(10000, 1000000000))  # 随机正整数
    sign = get_sign(app_secret, appkey, senid, nonce, content, timestamp)  # 签名

    request_url = request_url + '?senid=' + senid + '&nonce=' + nonce + '&timestamp=' + timestamp + '&appkey=' + appkey
    head = {'Content-type': 'application/json'}
    head.update({'X-Nuonuo-Sign': sign})
    head.update({'accessToken': token})
    head.update({'userTax': taxnum})
    head.update({'method': method})
    requestdata = content.encode("utf-8")
    r = requests.post(request_url, data=requestdata, headers=head)
    return r.text


def execSQL(text: str):
    """
    执行SQL语句, 无返回结果
    """
    curs = conn.cursor()  # 使用cursor()方法获取操作游标
    curs.execute(text)  # 执行sql语句
    curs.close()


if __name__ == '__main__':
    req_url = 'https://sdk.nuonuo.com/open/v1/services'
    senid = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(32))     # 32位随机码
    host = sys.argv[1]
    taxNo = "" 
    appKey = ''
    appsecret = ''
    accessToken = ''
    cursor = conn.cursor()  # 使用cursor()方法获取操作游标
    sql = "select isnull(regNo,''), isnull(nnAppyKey,''), isnull(nnSecret,''), isnull(nnToken,'') from hostInfo where hostNo= '" + host + "'"  # 数据库查询语句
    cursor.execute(sql)  # 执行sql语句
    rs = cursor.fetchone()  # 获取第一行数据
    if rs is not None:
        taxNo = rs[0]
        appKey = rs[1]
        appsecret = rs[2]
        accessToken = rs[3]
    kind = int(sys.argv[2])  # 0 pay  1 refund  2 invoice
    api_method = ['nuonuo.polymerization.paymentToOrders', "nuonuo.AggregatePay.refundquery", "nuonuo.polymerization.getInvoiceLinks"]
    body = [
        '{"taxNo":"' + taxNo + '", "customerOrderNo":"' + sys.argv[3] + '", "amount":"' + sys.argv[4] + '", "subject":"' + sys.argv[5] + '", "payee":"' + sys.argv[6] + '", "sellerNote":"' + sys.argv[7] + '", "billingType":"1", "autoType":"1", "returnUrl":"", "appKey":"' + appKey + '"}',
        '{"taxNo":"' + taxNo + '", "customerOrderNo":"' + sys.argv[3] + '", "partRefundAmount":"' + sys.argv[4] + '", "refundReason":"' + sys.argv[5] + '", "userName":"' + sys.argv[6] + '", "appKey":"' + appKey + '"}',
        '{"taxNo":"' + taxNo + '", "customerOrderNo":"' + sys.argv[3] + '"}'
    ]
    res = send_request(req_url, senid, appKey, appsecret, accessToken, taxNo, api_method[kind], body[kind])
    print(res)

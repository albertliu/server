from hashlib import sha1
import time
import random
import string
import requests
import base64
import hmac


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


if __name__ == '__main__':
    req_url = 'https://sdk.nuonuo.com/open/v1/services'
    senid = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(32))     # 32位随机码
    appKey = '40293382'
    appsecret = 'A475E209DF12449D'
    accessToken = 'fbcb4ed89bd6888d0dc4780iank3srrs'
    taxNum = '52310106751466629W'
    api_method = 'nuonuo.polymerization.paymentToOrders'
    body = '{"taxNo":"52310106751466629W", "customerOrderNo":"111", "amount":"0.01", "subject":"报名费", "billingType":"1", "sellerNote":"123", "payee":"张三", "autoType":"1", "returnUrl":"localhost:8082", "appKey":"40293382"}'

    res = send_request(req_url, senid, appKey, appsecret, accessToken, taxNum, api_method, body)
    print(res)

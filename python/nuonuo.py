import NNOpenSDK


if __name__ == '__main__':
    req_url = 'https://sdk.nuonuo.com/open/v1/services'  #SDK请求地址
    senid = '8cf2c072c3c44666805878efd0a9c5c8'  #唯一标识，由企业自己生成32位随机码
    appKey = 'Ta***p0I'
    appsecret = 'WF************79'
    accessToken = '44***************************kgi'  #访问令牌
    taxNum = '33***********42'    #ISV下授权商户税号，自用型应用置""即可
    api_method = 'nuonuo.electronInvoice.CheckEInvoice'  #API方法名
    body = '{"invoiceSerialNum":["19***************085"]}'  #API私有请求参数
    res = send_request(req_url, senid, appKey, appsecret, accessToken, taxNum, api_method, body)
    print(res)
    
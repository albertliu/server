const Core = require('@alicloud/pop-core');
// ACCESS_KEY_ID/ACCESS_KEY_SECRET 根据实际申请的账号信息进行替换
const accessKeyId = process.env.NODE_ENV_SMS_ACCESS;
const secretAccessKey = process.env.NODE_ENV_SMS_KEY;

const ssms ={
    async sendSMS(phone, passwd) {
        //发送短信
        var client = new Core({
          accessKeyId: accessKeyId,
          accessKeySecret: secretAccessKey,
          endpoint: 'https://dysmsapi.aliyuncs.com',
          apiVersion: '2017-05-25'
        });
        
        let pa = "{'password':'" + passwd + "'}";
        var params = {
          "RegionId": "cn-hangzhou",
          "PhoneNumbers": phone,
          "SignName": "上海网蓝信息技术有限公司",
          "TemplateCode": "SMS_197890292",
          "TemplateParam": pa
        }
        
        var requestOption = {
          method: 'POST'
        };
        
        client.request('SendSms', params, requestOption).then((result) => {
          //console.log(JSON.stringify(result));
        }, (ex) => {
          console.log(ex);
        })
    }
}
  
module.exports = ssms;
const Core = require('@alicloud/pop-core');
// ACCESS_KEY_ID/ACCESS_KEY_SECRET 根据实际申请的账号信息进行替换
const accessKeyId = process.env.NODE_ENV_SMS_ACCESS;
const secretAccessKey = process.env.NODE_ENV_SMS_KEY;

const ssms ={
    async sendSMS(phone, name, item, address, temp) {
        //发送短信
        var client = new Core({
          accessKeyId: accessKeyId,
          accessKeySecret: secretAccessKey,
          endpoint: 'https://dysmsapi.aliyuncs.com',
          apiVersion: '2017-05-25'
        });
        let tc = "";
        let pa = "";
        if(temp=="reset_password"){
          tc = "SMS_197890292";
          pa = "{'password':'" + item + "'}";
        }
        if(temp=="reupload_material"){
          tc = "SMS_211492862";
          //pa = "{'name':'" + name + "','item':'" + item + "','address':'" + address + "'}";
          pa = "{'name':'" + name + "','item':'" + item + "'}";
        }
        if(temp=="msg_score"){
          tc = "SMS_218725732";
          pa = "{'name':'" + name + "','item':'" + item + ",'address':'" + address + "'}";
        }
        
        var params = {
          "RegionId": "cn-hangzhou",
          "PhoneNumbers": phone,
          "SignName": "上海网蓝信息技术有限公司",
          "TemplateCode": tc,
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
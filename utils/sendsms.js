const Core = require('@alicloud/pop-core');
// ACCESS_KEY_ID/ACCESS_KEY_SECRET 根据实际申请的账号信息进行替换
const accessKeyId = process.env.NODE_ENV_SMS_ACCESS;
const secretAccessKey = process.env.NODE_ENV_SMS_KEY;

const ssms ={
    async sendSMS(phone, name, item, address,dt, temp) {
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
          pa = "{'name':'" + name + "','item':'" + item + "','address':'" + address + "'}";
        }
        if(temp=="msg_exam"){
          tc = "SMS_218286580";
          pa = "{'name':'" + name + "','item':'" + item + "','date':'" + dt + "','address':'" + address + "'}";
        }
        if(temp=="msg_class"){
          tc = "SMS_219616263";
          pa = "{'name':'" + name + "','item':'" + item + "','date':'" + dt + "','address':'" + address + "'}";
        }
        if(temp=="msg_photo"){
          tc = "SMS_219616263";
          pa = "{'name':'" + name + "','item':'" + item + "','address':'" + address + "'}";
        }
        if(temp=="msg_study_alert"){
          tc = "SMS_243995316";
          pa = "{'name':'" + name + "','item':'" + item + "'}";
        }
        
        var params = {
          "RegionId": "cn-hangzhou",
          "PhoneNumbers": phone,
          "SignName": "上海智能消防学校",
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
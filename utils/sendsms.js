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
        if(temp=="msg_exam"){ //考试通知
          tc = "SMS_218286580";
          pa = "{'name':'" + name + "','item':'" + item + "','date':'" + dt + "','address':'" + address + "'}";
        }
        if(temp=="msg_exam_online"){ //考试通知_在线
          tc = "SMS_244770037";
          pa = "{'name':'" + name + "','item':'" + item + "','date':'" + dt + "'}";
        }
        if(temp=="msg_exam_deny"){  //不安排考试
          tc = "SMS_245000170";
          pa = "{'name':'" + name + "','item':'" + item + "','date':'" + dt + "'}";
        }
        if(temp=="msg_class"){ //开课通知
          tc = "SMS_463201166";
          pa = "{'name':'" + name + "','item':'" + item + "','date':'" + dt + "','address':'" + address + "'}";
        }
        if(temp=="msg_class_online"){ //开课通知_在线
          tc = "SMS_244995177";
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
        if(temp=="msg_submit_photo"){
          tc = "SMS_261130422";
          pa = "{'name':'" + name + "','item':'" + item + "'}";
        }
        if(temp=="msg_submit_signature"){
          tc = "SMS_261020451";
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
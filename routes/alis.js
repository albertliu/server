const express = require('express');
const router = express.Router();
const db = require("../utils/mssqldb");
const fs = require('fs');
const sharp = require('sharp'); //npm install sharp
var Readable = require('stream').Readable
const face = require("../utils/face");
// npm install @alicloud/facebody20191230
// 最低SDK版本要求：facebody20191230的SDK版本需大于等于4.0.7
// 可以在此仓库地址中引用最新版本SDK：https://npmjs.com/package/@alicloud/facebody20191230
const FacebodyClient = require('@alicloud/facebody20191230');
const OpenapiClient = require('@alicloud/openapi-client');
const TeaUtil = require('@alicloud/tea-util');
const OSS = require('ali-oss');
const env = process.env.NODE_ENV_BACKEND_ET;

var response, sqlstr, params;
const accessKey_Id = process.env.T0_ACCESS_KEY;
const accessKey_Secret = process.env.T0_ACCESS_SECRET;

const oss_client = new OSS({
  // yourregion填写Bucket所在地域。以华东1（杭州）为例，Region填写为oss-cn-hangzhou。
  region: 'oss-cn-shanghai',
  // 从环境变量中获取访问凭证。运行本代码示例之前，请确保已设置环境变量OSS_ACCESS_KEY_ID和OSS_ACCESS_KEY_SECRET。
  accessKeyId: accessKey_Id,
  accessKeySecret: accessKey_Secret,
  // yourbucketname填写存储空间名称。
  bucket: 'images-t0'
});

/* 添加人脸数据. */
router.post('/addFace', async function (req, res, next) {
  respance = await face.addFace(req.body.username);
  return res.send(response);
});

/* 删除人脸数据. */
router.post('/delFace', async function (req, res, next) {
  respance = await face.delFace(req.body.username);
  return res.send(response);
});

/* 删除人脸数据. */
router.post('/test', async function (req, res, next) {
  params = {kind:0, enterOrder:"re.customerOrderNo", amount:"re.amount", payStatus:"re.payStatus", phone:""};
  sqlstr = "setAutoPayReturn";
  let params1 = {kind:"oderPaymentReturn", memo:"text", memo1:JSON.stringify(params)};
  console.log("params:", params1);
  db.excuteProc(sqlstr, params1, function(err, data){
  });
  response = {status: 0, msg: req.body.username };
  console.log("test:",response);
  return res.send(response);
});

//搜索人脸
router.post('/searchFace', async function (req, res, next) {
  //查找
  let buff = await compressBase64(req.body.base64Data);
  // let fn = './users/1.jpg';
  let stream = Readable.from(buff)
  let search = await face.searchFace(stream);
  // console.log("search:", search);
  if(search && search.confidence>(req.body.confidence || 60)){
    //写数据库
    sqlstr = "setFaceCheckin";
    //保存文件命名
    let ossFileName = search.entityId + "-" + (new Date().getTime()) + ".jpg"; // 自动生成文件名
    params = { username: search.entityId, confidence: search.confidence, file1:ossFileName, selList:req.body.selList };
    // console.log("params:", params);
    const data = await db.excuteProcAsync(sqlstr, params);
    const re = data.recordset[0];
    // console.log("return re", re);
    if (re.status == 0) {
      //签到成功
      // 上传到OSS
      oss_client.put(ossFileName, buff);
    }
    // console.log("response", re.msg);
    // res.end({status:re.status, msg:re.msg});
    return res.send({status:re.status, msg:re.msg, name:re.name});
  }else{
    return res.send({status:9, name:"抱歉", msg:"无法识别"});
  }
});

function streamToString (stream) {
  const chunks = [];
  return new Promise((resolve, reject) => {
    stream.on('data', (chunk) => chunks.push(Buffer.from(chunk)));
    stream.on('error', (err) => reject(err));
    stream.on('end', () => resolve(Buffer.concat(chunks).toString('utf8')));
  })
}

// 上传base64文件到OSS, 比对两个照片
// base64Data: 带有data:image/jpeg;base64,前缀的完整数据
router.post('/uploadFaceDetectOSS', async function (req, res, next) {
  let compareResult = 0;
  const msgRe = ["请先上传证件照片","比对成功","比对失败，请平视摄像头。","网络错误，请稍后再试","照片读取失败，请重试","数据处理失败，请重试"];
  let errCode = ":EC";
  try {
    errCode += "1";
    if(!req.body.base64Data){
      return res.send({status:4, msg: msgRe[4] + errCode});
    }
    // const base64DataFromRequest = Buffer.from(req.body).toString('base64');
    // console.log("req.body.base64Data:", req.body.base64Data.length);
    //压缩图片
    let buff = await compressBase64(req.body.base64Data);
    // console.log("buff:", buff.toString('base64'));
    //保存文件命名
    let ossFileName = req.body.refID + "-" + (new Date().getTime()) + ".jpg"; // 自动生成文件名：refID为studentVideoList.ID
    // 上传到OSS
    errCode += "A";
    oss_client.put(ossFileName, buff);
    errCode += "2";
    // console.log("1:", ossFileName);
    //获取头像
    // 转换拍摄图片
    // let base64Data = req.body.base64Data.split(',')[1];
    let base64Data = buff.toString('base64');
    errCode += "B";
    let photo = "";
    let photoPath = "";
    sqlstr = "getPhotoByUsername";
    params = { username: req.body.username };
    // console.log("params:", params, ossFileName);
    await db.excuteProc(sqlstr, params, async function (err, data) {
      if (err) {
        console.log(err);
        errCode += "3";
      }
      photo = data.recordset[0]["filename"];
      photoPath = './users' + photo;
      if (fs.existsSync(photoPath)) {
        // 文件存在
      } else {
        // 文件不存在
        photo = "";
      }
      // console.log("2:", photo);
      if(photo > ""){
        // 获取头像后，进行人脸比对
        // 将图片转为base64
        let photoData = "";
        errCode += "C";
        await fs.readFile(photoPath, async function (err, data) {
          if (err) throw err;
          photoData = data.toString('base64');
          // console.log("3:", base64Data.substring(0,100), base64Data.substring(base64Data.length - 100));
          errCode += "4";
          // 比较两个人脸
          let config = new OpenapiClient.Config({
            // 创建AccessKey ID和AccessKey Secret，请参考https://help.aliyun.com/document_detail/175144.html。
            // 如果您用的是RAM用户AccessKey，还需要为RAM用户授予权限AliyunVIAPIFullAccess，请参考https://help.aliyun.com/document_detail/145025.html。
            // 从环境变量读取配置的AccessKey ID和AccessKey Secret。运行示例前必须先配置环境变量。 
            accessKeyId: accessKey_Id,   
            accessKeySecret: accessKey_Secret
          });
          config.endpoint = `facebody.cn-shanghai.aliyuncs.com`;
          const client = new FacebodyClient.default(config);
          let compareFaceRequest = new FacebodyClient.CompareFaceRequest({
            imageDataA: base64Data,
            imageDataB: photoData
          });
          let runtime = new TeaUtil.RuntimeOptions({ });
          let confidence = 0.00;
          // console.log("4:", confidence);
          errCode += "D";
          await client.compareFaceWithOptions(compareFaceRequest, runtime)
            .then(function(compareFaceResponse) {
              // 获取单个字段(Confidence置信度，取值范围0~100。供参考的三个阈值是61，69和75，分别对应千分之一，万分之一和十万分之一误识率)
              errCode += "0";
              confidence = compareFaceResponse.body.data.confidence;
              compareResult = (confidence >= 40 ? 1 : 2);
              // console.log("5:", compareResult);
              // console.log('compareFaceResponse', compareFaceResponse.body.data);
              
              // 写数据库
              sqlstr = "uploadFaceDetectOSS";
              params = { refID: req.body.refID, kindID: req.body.kindID, file1: ossFileName, file2: photo, status: compareResult, confidence: confidence };
              // console.log("params1:", params, ossFileName);
              db.excuteProc(sqlstr, params, function (err, data) {
                errCode += "E";
                if (err) {
                  console.log(err);
                  response = {status:5, msg: msgRe[5] + errCode};
                  return res.send(response);
                }else{
                  return res.send({status: compareResult, msg: msgRe[compareResult] + errCode});
                }
              });
            }, function(error) {
              // 获取整体报错信息
              console.log("compareFaceWithOptions error:", error);
              errCode += "5:" + error.data.Code;
              // 获取单个字段
              // console.log(error.data.Code);
              return res.send({status: 3, msg: msgRe[3] + errCode});
            })
        })
      }else{
        // 写数据库
        sqlstr = "uploadFaceDetectOSS";
        params = { refID: req.body.refID, kindID: req.body.kindID, file1: ossFileName, file2: '', status: 0, confidence: 0 };
        errCode += "F";
        // console.log("params2:", params, ossFileName);
        await db.excuteProc(sqlstr, params, function (err, data) {
          errCode += "6";
          if (err) {
            console.log(err);
            response = {status:5, msg: msgRe[5] + errCode};
            return res.send(response);
          }else{
            return res.send({status: compareResult, msg: msgRe[compareResult] + errCode});
          }
        });
      }
    });
  } catch (err) {
      console.error('Upload failed: ', err);
      errCode += "G";
      return res.send({status:3, msg: msgRe[3] + errCode});
  }
});


//22a. get_OSS_file
//status: 0 成功  9 其他  msg, filename
router.get('/get_OSS_file_base64', async function (req, res, next) {
  try {
    const result = await oss_client.get(req.query.filename);
    // console.log(result.res.data);
    var b = new Buffer.from(result.res.data);
    var s = b.toString('base64')
    // console.log("S:", s);
    // console.log("S1:", result.res.data.toString('base64'));
    return res.send([s]);
  } catch (err) {
    console.error('download failed: ', err);
    return res.send([""]);
  }
});

async function compressBase64(data, size) {
    // 转换拍摄图片
    let base64Data = data.split(',')[1];
    // 压缩图片，宽度200pix
    return sharp(new Buffer.from(base64Data, 'base64'))
      .resize({ width: size || 200 })
      .toBuffer()
      .then(data => { 
        return data;
      })
      .catch(err => { return ""; });
}

module.exports = router;
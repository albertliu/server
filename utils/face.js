'use strict';
// This file is auto-generated, don't edit it
// 依赖的模块可通过下载工程中的模块依赖文件或右上角的获取 SDK 依赖信息查看
// npm install  @alicloud/facebody20191230
const db = require("../utils/mssqldb");
const facebody20191230 = require('@alicloud/facebody20191230');
const OpenApi = require('@alicloud/openapi-client');
const Util = require('@alicloud/tea-util');
const Tea = require('@alicloud/tea-typescript');
const fs = require('fs');
const path = require('path');
let response, sqlstr, params;

/**
 * 使用AK&SK初始化账号Client
 * @param accessKeyId
 * @param accessKeySecret
 * @return Client
 * @throws Exception
 */
function createClient() {
  // 工程代码泄露可能会导致 AccessKey 泄露，并威胁账号下所有资源的安全性。以下代码示例仅供参考。
  // 建议使用更安全的 STS 方式，更多鉴权访问方式请参见：https://help.aliyun.com/document_detail/378664.html。
  let config = new OpenApi.Config({
    // 必填，请确保代码运行环境设置了环境变量 ALIBABA_CLOUD_ACCESS_KEY_ID。
    accessKeyId: process.env.T0_ACCESS_KEY,
    accessKeySecret: process.env.T0_ACCESS_SECRET,
  });
  // Endpoint 请参考 https://api.aliyun.com/product/facebody
  config.endpoint = `facebody.cn-shanghai.aliyuncs.com`;
  return new facebody20191230.default(config);
}

const client = createClient();
const runtime = new Util.RuntimeOptions({ });

async function addFaceEntity (_id, _db, _lab) {
  let addFaceEntityRequest = new facebody20191230.AddFaceEntityRequest({
    dbName: _db || 'default',
    entityId: _id,
    labels: _lab || '',
  });
  
  return client.addFaceEntityWithOptions(addFaceEntityRequest, runtime)
      .then(function(searchFaceResponse) {
        // 获取整体结果
        // console.log("addFaceEntity re:", searchFaceResponse);
        // 获取单个字段
        // console.log(searchFaceResponse.statusCode);
        return true;
      }, function(error) {
        // 获取整体报错信息
        console.log(error);
        // 获取单个字段
        console.log(error.data.Code);
        return false;
      })
}

async function addFace (_id, _fn, _db) { //_fn image file name with path, like 'users/upload/students/photos/xxx.jpg'
  let addFaceAdvanceRequest = new facebody20191230.AddFaceAdvanceRequest({
    dbName: _db || 'default',
    entityId: _id,
  });
  
  const fileStream = fs.createReadStream(_fn);
  addFaceAdvanceRequest.imageUrlObject = fileStream;
  return client.addFaceAdvance(addFaceAdvanceRequest, runtime)
      .then(function(searchFaceResponse) {
        // 获取整体结果
        // console.log("addFace re:", searchFaceResponse);
        // 获取单个字段
        // console.log(searchFaceResponse.body.data);
        return searchFaceResponse.body.data;
      }, function(error) {
        // 获取整体报错信息
        console.log(error);
        // 获取单个字段
        console.log(error.data.Code);
        return false;
      })
}

async function delFaceEntity (_id, _db) {
    let deleteFaceEntityRequest = new facebody20191230.DeleteFaceEntityRequest({
      dbName: _db || 'default',
      entityId: _id
    });
    
    return client.deleteFaceEntityWithOptions(deleteFaceEntityRequest, runtime)
      .then(function(searchFaceResponse) {
        // 获取整体结果
        // console.log("delFaceEntity re:", searchFaceResponse);
        // // 获取单个字段
        // console.log(searchFaceResponse.statusCode);
        return true;
      }, function(error) {
        // 获取整体报错信息
        console.log(error);
        // 获取单个字段
        console.log(error.data.Code);
        return false;
      })
}

async function delFace (_id, _db) {
  let deleteFaceRequest = new facebody20191230.DeleteFaceRequest({
    dbName: _db || 'default',
    faceId: _id
  });
  
  return client.deleteFaceWithOptions(deleteFaceRequest, runtime)
      .then(function(searchFaceResponse) {
        // 获取整体结果
        // console.log(searchFaceResponse);
        // 获取单个字段
        // console.log(searchFaceResponse.statusCode);
        return true;
      }, function(error) {
        // 获取整体报错信息
        console.log(error);
        // 获取单个字段
        console.log(error.data.Code);
        return false;
      })
}

const face = {
  /* 添加人脸数据. */
  addFace: async function (username) {
    //删除entity
    if(await delFaceEntity(username)){
      //添加entity
      if(await addFaceEntity(username)){
        // 查找照片
        sqlstr = "getStudentPhotoFile";
        params = { username: username };
        console.log("params:", params);
        await db.excuteProc(sqlstr, params, async function (err, data) {
          if (err) {
            console.log(err);
            response = {status:0};
            return res.send(response);
          }
          let fn = "./users" + data.recordset[0]["re"];
          // console.log("x3", fn);
          //添加face
          const faceID = await addFace(username, fn);
          // console.log("x4", faceID.faceId, faceID.qualitieScore);
          if(faceID.faceId){
            //记录faceID
            sqlstr = "setStudentPhotoFaceID";
            params = { username: username, faceID: faceID.faceId, faceScore:faceID.qualitieScore.toString() };
            console.log("params:", params);
            await db.excuteProcAsync(sqlstr, params, function (err, data) {
              if (err) {
                console.log(err);
                response = {status:0};
                return (response);
              }
            });
          }
        });
      }
    }
    return ({status:0});
  },
  /* 删除人脸数据. */
  delFace: async function (fid, username) {
    //删除entity
    if(await delFace(fid)){
      //删除entity
      if(await delFaceEntity(username)){
        //记录faceID
        sqlstr = "setStudentPhotoFaceError";
        params = { username: username, faceErrCode: '', faceErrMsg:'' };
        console.log("params:", params);
        await db.excuteProcAsync(sqlstr, params, function (err, data) {
          if (err) {
            console.log(err);
            response = {status:0};
            return (response);
          }
        });
      }
    }
    return ({status:0});
  },
  /* 搜索人脸数据. */
  searchFace: async function (_fn, _db) { //_fn image file name with path, like 'users/upload/students/photos/xxx.jpg'
    let searchFaceRequest = new facebody20191230.SearchFaceAdvanceRequest({
      dbName: _db || 'default',
      limit: 1,
      maxFaceNum: 1,
    });
    // const fileStream = fs.createReadStream(_fn);
    // searchFaceRequest.imageUrlObject = fileStream;
    searchFaceRequest.imageUrlObject = _fn;

    return client.searchFaceAdvance(searchFaceRequest, runtime)
        .then(function(searchFaceResponse) {
          // 获取整体结果
          // console.log(searchFaceResponse);
          // 获取单个字段
          // console.log(searchFaceResponse.body.data.matchList[0].faceItems[0]);
          return searchFaceResponse.body.data.matchList[0].faceItems[0];
        }, function(error) {
          // 获取整体报错信息
          // console.log(error);
          // 获取单个字段
          console.log("searchFace Error:", error.data.Code);
          return "";
        })
  },
  /* 添加所有未入库的人脸数据. */
  addFullFace: async function () {
    sqlstr = "getFullFaceFile";
    params = { };
    await db.excuteProc(sqlstr, params, async function (err, data) {
      if (err) {
        console.log(err);
        response = {status:0};
        return res.send(response);
      }
      let re = data.recordset;
      if (re.length > 0) { 
        for (var i in re) {
          const username = re[i]["username"];
          const fn = "./users" + re[i]["filename"];  // 照片
          // console.log("fn:", fn);
          if (fs.existsSync(fn)) {
            // 文件存在
            //删除entity
            if(await delFaceEntity(username)){
              // console.log("delFaceEntity:", username);
              //添加entity
              if(await addFaceEntity(username)){
                // console.log("addFaceEntity:", username);
                //添加face
                const faceID = await addFace(username, fn);
                // console.log("x4", faceID.faceId, faceID.qualitieScore);
                if(faceID.faceId){
                  //记录faceID
                  sqlstr = "setStudentPhotoFaceID";
                  params = { username: username, faceID: faceID.faceId, faceScore:faceID.qualitieScore.toString() };
                  // console.log("params:", params);
                  await db.excuteProcAsync(sqlstr, params, function (err, data1) {
                    if (err) {
                      console.log(err);
                      response = {status:0};
                      return (response);
                    }
                  });
                }
              }
            }
          }
        }
      }
      return ({status:0});
    });
  },
  /* 删除无有效课程的人脸数据. */
  delFreezFace: async function () {
    sqlstr = "getFreezFaceFile";
    params = { };
    await db.excuteProc(sqlstr, params, async function (err, data) {
      if (err) {
        console.log(err);
        response = {status:0};
        return res.send(response);
      }
      let re = data.recordset;
      if (re.length > 0) { 
        for (var i in re) {
          const username = re[i]["username"];
          //删除entity
          if(await delFace(re[i]["faceID"])){
            //删除entity
            if(await delFaceEntity(re[i]["username"])){
              //记录faceID
              sqlstr = "setStudentPhotoFaceError";
              params = { username: re[i]["username"], faceErrCode: '', faceErrMsg:'' };
              console.log("params:", params);
              await db.excuteProcAsync(sqlstr, params, function (err, data) {
                if (err) {
                  console.log(err);
                }
              });
            }
          }
        }
      }
      return ({status:0});
    });
  }
}

module.exports = face;
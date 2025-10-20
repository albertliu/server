var express = require('express');
var router = express.Router();
var db = require("../utils/mssqldb");
var multer = require('multer');
// var util = require('util');
var fs = require('fs');
var date = require("silly-datetime");
var images = require("images");
const moment = require('moment');
const sharp = require('sharp'); //npm install sharp
const shotimg = require("../utils/screenshot");

var response, sqlstr, params;
var uploadHome = './users/upload/';
var pdf = require("../utils/pdf");
var docx = require("../utils/docx");
let xlsxx = require('../utils/xlsx');
const face = require("../utils/face");
let xlsx = require('xlsx');
//let xlsx_free = require('../utils/xlsx_free');
var zip = require("../utils/zip");
const comFunc = require("../utils/commFunction");
const { array } = require('pizzip/js/support');
var upID = "", key = "", mark = "", currUser = "", host = "", today = date.format(new Date(), 'YYYY-MM-DD');
var env = process.env.NODE_ENV_BACKEND;

var createFolder = function (folder) {
  try {
    fs.accessSync(folder);
  } catch (e) {
    fs.mkdirSync(folder);
  }
};
/* GET home page. */
router.get('/', function (req, res, next) {
  //res.render('index', { title: 'Express' });
  console.log("The user order paramaters ip: %s  host: %s", ip, host)
  res.send(response);
});

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    //console.log("query:", req.query.upID, req.query.username)
    var uploadFolder = "";
    upID = req.query.upID;
    host = req.query.host;
    currUser = req.query.currUser;
    switch (upID) {
      case "student_photo":
        uploadFolder = "students/photos/";
        break;
      case "student_IDcardA":
        uploadFolder = "students/IDcards/";
        break;
      case "student_IDcardB":
        uploadFolder = "students/IDcards/";
        break;
      case "student_education":
        uploadFolder = "students/educations/";
        break;
      case "student_CHESICC":
        uploadFolder = "students/CHESICC/";
        break;
      case "student_employment":
        uploadFolder = "students/employments/";
        break;
      case "student_jobCertificate":
        uploadFolder = "students/jobCertificates/";
        break;
      case "student_promise":
        uploadFolder = "students/promises/";
        break;
      case "student_social":
        uploadFolder = "students/socials/";
        break;
      case "student_diploma":
        uploadFolder = "students/diplomas/";
        break;
      case "course_video":
        uploadFolder = "courses/videos/";
        break;
      case "course_courseware":
        uploadFolder = "courses/coursewares/";
        break;
      case "host_logo":
        uploadFolder = "companies/logo/";
        break;
      case "host_QR":
        uploadFolder = "companies/qr/";
        break;
      case "project_brochure":
        uploadFolder = "projects/brochures/";
        break;
      case "student_list":
        uploadFolder = "students/studentList/";
        break;
      case "score_list":
        uploadFolder = "students/scoreList/";
        break;
      case "ref_student_list":
        uploadFolder = "students/ref_student_list/";
        break;
      case "apply_list":
        uploadFolder = "students/apply_list/";
        break;
      case "apply_score_list":
        uploadFolder = "students/apply_score_list/";
        break;
      case "invoice_pdf":
        uploadFolder = "students/invoices/";
        break;
      case "question_image":
      case "question_imageA":
      case "question_imageB":
      case "question_imageC":
      case "question_imageD":
      case "question_imageE":
      case "question_imageF":
        uploadFolder = "questions/images/";
        break;
      default:
        uploadFolder = "others/";
    }
    uploadFolder = uploadHome + uploadFolder;
    createFolder(uploadFolder);
    cb(null, uploadFolder);
  },
  filename: function (req, file, cb) {
    var fn = "";
    var filenameArr = file.originalname.split('.');
    upID = req.query.upID;
    currUser = req.query.currUser;
    host = req.query.host;
    switch (upID) {
      case "student_photo":   //student photo will name with the username and original type, and write the path to studentInfo.
        fn = req.query.username;
        key = req.query.username;
        break;
      case "student_IDcardA":   //IDcard image will name with the username and original type, and write the path to studentInfo(if need two faces, will deal with two files).
        fn = req.query.username + "a";   //mark:a/b, the IDcard have A/B two faces, will be saved as a different name.
        key = req.query.username;
        break;
      case "student_IDcardB":   //IDcard image will name with the username and original type, and write the path to studentInfo(if need two faces, will deal with two files).
        fn = req.query.username + "b";   //mark:a/b, the IDcard have A/B two faces, will be saved as a different name.
        key = req.query.username;
        break;
      case "student_education":   //education image will name with the username and original type, and write the path to studentInfo.
        fn = req.query.username;   //mark:a/b, the IDcard have A/B two faces, will be saved as a different name.
        key = req.query.username;
        break;
      case "student_CHESICC":   //student photo will name with the username and original type, and write the path to studentInfo.
        fn = req.query.username;
        key = req.query.username;
        break;
      case "student_employment":   //IDcard image will name with the username and original type, and write the path to studentInfo(if need two faces, will deal with two files).
        fn = req.query.username;   //mark:a/b, the IDcard have A/B two faces, will be saved as a different name.
        key = req.query.username;
        break;
      case "student_jobCertificate":   //IDcard image will name with the username and original type, and write the path to studentInfo(if need two faces, will deal with two files).
        fn = req.query.username;   //mark:a/b, the IDcard have A/B two faces, will be saved as a different name.
        key = req.query.username;
        break;
      case "student_promise":   //IDcard image will name with the username and original type, and write the path to studentInfo(if need two faces, will deal with two files).
        fn = req.query.username;   //mark:a/b, the IDcard have A/B two faces, will be saved as a different name.
        key = req.query.username;
        break;
      case "student_social":   //IDcard image will name with the username and original type, and write the path to studentInfo(if need two faces, will deal with two files).
        fn = req.query.username;   //mark:a/b, the IDcard have A/B two faces, will be saved as a different name.
        key = req.query.username;
        break;
      case "student_diploma":   //diploma image will keep the original name(diplomaID = username) and type, and write the path to diplomaInfo(if not exist, add new record.).
        fn = req.query.username;
        key = req.query.username;
        break;
      case "course_video":   //video image will keep the original name(videoID = username) and type, and write the path to videoInfo(if not exist, add new record.).
        fn = req.query.username;
        key = req.query.username;
        break;
      case "course_courseware":   //courseware image will keep the original name(coursewareID = username) and type, and write the path to coursewareInfo(if not exist, add new record.).
        fn = req.query.username;
        key = req.query.username;
        break;
      case "host_logo":   //host logo image will keep the original name(hostNo) and type, and write the path to hostInfo.
        fn = req.query.username;
        key = req.query.username;
        break;
      case "host_QR":   //courseware image will keep the original name(hostNo) and type, and write the path to hostInfo.
        fn = req.query.username;
        key = req.query.username;
      case "project_brochure":   //project brochure file will keep the original name(hostNo) and type, and write the path to hostInfo.
        fn = "project_brochure_" + req.query.username;
        key = req.query.username;
      case "student_list":   //courseware image will keep the original name(hostNo) and type, and write the path to hostInfo.
        fn = 'studentlist' + req.query.username;
        key = req.query.username;
        break;
      case "score_list":   //courseware image will keep the original name(hostNo) and type, and write the path to hostInfo.
        fn = 'scorelist' + req.query.username;
        key = req.query.username;
        break;
      case "ref_student_list":   //courseware image will keep the original name(hostNo) and type, and write the path to hostInfo.
        fn = 'ref_student_list' + req.query.username;
        key = req.query.username;
        break;
      case "apply_list":   //courseware image will keep the original name(hostNo) and type, and write the path to hostInfo.
        fn = 'applylist' + req.query.username;
        key = req.query.username;
        break;
      case "apply_score_list":   //courseware image will keep the original name(hostNo) and type, and write the path to hostInfo.
        fn = 'applyScorelist' + req.query.username;
        key = req.query.username;
        break;
      case "invoice_pdf":   //invoice result doc
        fn = req.query.username + '-' + Date.now();   //
        key = req.query.username;
        break;
      case "question_image":
      case "question_imageA":
      case "question_imageB":
      case "question_imageC":
      case "question_imageD":
      case "question_imageE":
      case "question_imageF":
        fn = file.originalname.substr(0, file.originalname.lastIndexOf("."));   //题目图片保留原始文件名
        key = req.query.username;
        break;
      default:
        fn = file.originalname;
        fn = fn.substr(0, fn.lastIndexOf(".")) + '-' + Date.now();
        key = req.query.username;
    }
    cb(null, fn + "." + filenameArr[filenameArr.length - 1]);
  }
});

var maxSize = 5 * 1000 * 1000;  // 最大上传文件字节5M
var upload = multer({
  storage: storage
});

var storageMultiple = multer.diskStorage({
  destination: function (req, files, cb) {
    //console.log("query:", req.query.upID, req.query.username)
    var uploadFolder = "";
    upID = req.query.upID;
    host = req.query.host;
    currUser = req.query.currUser;
    switch (upID) {
      case "student_photo":
        uploadFolder = "students/photos/";
        break;
      case "student_IDcardA":
        uploadFolder = "students/IDcards/";
        break;
      case "student_IDcardB":
        uploadFolder = "students/IDcards/";
        break;
      case "student_education":
        uploadFolder = "students/educations/";
        break;
      case "student_diploma":
        uploadFolder = "students/diplomas/";
        break;
      default:
        uploadFolder = "others/";
    }
    uploadFolder = uploadHome + uploadFolder;
    createFolder(uploadFolder);
    cb(null, uploadFolder);
  },
  filename: function (req, file, cb) {
    var fn = "";
    var filenameArr = file.originalname.split('.');
    //文件名不变
    fn = file.originalname;
    key = fn.substr(0, fn.lastIndexOf("."));
    cb(null, fn);
  }
});

var uploadMultiple = multer({
  storage: storageMultiple
});


//5a. uploadSingle
router.post('/uploadSingle', upload.single('avatar'), async function (req, res, next) {
  //console.log("req.query.upID:", req.query.upID);
  var file = req.file;
  response = { "status": 0, msg: "", "file": "", "count": 0, "err_msg": "", "exist_msg": "" }
  if (!file || file == undefined || file.length === 0 || typeof file.path !== 'string') {  //判断一下文件是否存在，也可以在前端代码中进行判断。
    res.render({ "status": 0, msg: "上传文件不能为空！" });
    return;
  }
  // if (file.size > maxSize) {  //判断一下文件是否超过规定大小。
  //   // console.log("Find MulterError: ", "上传文件大小不能超过5M！");
  //   response = { "status": 0, msg: "文件大小不能超过5M！请处理后重新上传。", reDo: "" };
  //   return res.send(response);
  // }
  //console.log('文件类型：%s', file.mimetype);
  //console.log('原始文件名：%s', file.originalname);
  //console.log('文件大小：%s', file.size);
  //console.log('文件保存路径：%s', file.path);

  //console.log("file:", file);
  response.file = file.path.substr(file.path.indexOf("\\"));
  response.count = 1;
  response.reDo = "";
  response.reList = [];
  sqlstr = "setUploadSingleFileLink";
  let register = key;
  if (currUser > "") {
    register = currUser;
  }
  let size = (file.size/1024).toFixed(0);
  params = { "upID": upID, "key": key, "file": response.file, fsize: size, "multiple": 0, "registerID": register };
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    if(upID=="student_photo"){
      face.addFace(key);  // 照片上传到照片库
    }
    //console.log("response:", response);
    response.count = 1;
    response.status = data.returnValue;
    if (req.query.commMark != "studentList") {
      response.reDo = response.file;
      return res.send(response);
    }
  });

  //deal xlsx  学员注册
  if (upID == "student_list") {
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    var data1 = xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let pn = "";
    let mn = "";
    let p1 = "";
    let p2 = "";
    let p3 = "";
    let r_null = 0;
    let r_err = 0;
    let r_exist = 0;
    let r_existOther = 0;
    let r_err_msg = "";
    let r_exist_msg = "";
    let r_existOther_msg = "";
    let idx = 0;
    let job = "";
    let tax = "";
    data1.forEach(function (val) {
      pn = val["单位地址"];
      if (typeof (pn) == "undefined") {
        pn = '';
      }
      mn = val["手机"];
      if (typeof (mn) == "undefined") {
        mn = '';
      }
      p1 = val["身份证"];
      if (typeof (p1) == "undefined") {
        p1 = '';
      }
      p2 = val["姓名"];
      if (typeof (p2) == "undefined") {
        p2 = '';
      }
      p3 = val["应复训日期"];
      if (typeof (p3) == "undefined") {
        p3 = '';
      }
      if (p3 > "" && String(val["应复训日期"]).slice(0, 2) != "20") {
        p3 = new Date(new Date("1900-01-01").getTime() + (val["应复训日期"] - 2) * 3600 * 24 * 1000 - 3600 * 8 * 1000 + 60 * 1000);
        p3 = p3.Format("yyyy-MM-dd");
      }
      job = val["岗位/职务"] || val["工种/职务"];
      // if(p1>""){
        sqlstr = "generateStudent";
        params = { "username": p1.replace(/\s+/g, ""), "name": p2.replace(/\s+/g, ""), "dept1Name": val["单位名称"] || "", "tax": val["单位代码"] || "", "dept2Name": val["加油站"] || "", "currDiplomaDate": p3, "job": job, "mobile": "" + mn, "address": "" + pn, "education": val["文化程度"], "memo": val["备注"], "classID": key, "oldNo": val["序号"], "registerID": currUser };
        // console.log("params.",params);
        db.excuteProc(sqlstr, params, function (err, data) {
          if (err) {
            console.log(err);
            let response = { "status": 9 };
            return res.send(response);
          }
          if (data.recordset[0]["err"] == 1) {
            r_err += data.recordset[0]["err"];
            r_err_msg += data.recordset[0]["name"] + " " + data.recordset[0]["username"] + "  ";
          }
          if (data.recordset[0]["exist"] == 1) {
            r_exist += data.recordset[0]["exist"];
            r_exist_msg += data.recordset[0]["name"] + "  ";
          }
          if (data.recordset[0]["existOther"] == 1) {
            r_existOther += data.recordset[0]["existOther"];
            r_existOther_msg += data.recordset[0]["name"] + "(" + data.recordset[0]["msg"] + ")  ";
          }
          if (data.recordset[0]["errNull"] == 1) {
            r_null += 1;
          }
          //生成签名资料
          comFunc.generate_entryform_sign(data.recordset[0]["enterID"]);
          //
          idx += 1;
          if (idx == data1.length) {
            sqlstr = "autoSetClassSNo";   //adjuest student No in the class
            params = { "classID": key };
            //console.log("params:", params);
            db.excuteProc(sqlstr, params, function (err, data2) {
              if (err) {
                console.log(err);
                let response = { "status": 9 };
                return res.send(response);
              }
            });
            response.count = data1.length - r_err - r_exist - r_existOther - r_null;
            response.err_msg = r_err_msg > "" ? "身份证号码错误，未导入：" + r_err_msg + "\n" : "";
            r_exist_msg = r_exist_msg > "" ? "学员已在本班级，未导入：" + r_exist_msg + "\n" : "";
            response.exist_msg = r_existOther_msg > "" ? r_exist_msg + "学员已在其他班级，未导入：" + r_existOther_msg : r_exist_msg;
            //console.log("res1:",response,"r_err_msg:",r_err_msg);
            return res.send(response);
          }
        });        
      // }
    });
  }

  //deal xlsx 成绩单
  if (upID == "score_list") {
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    var data1 = xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let score = 0;
    let un = "";
    data1.forEach(val => {
      sqlstr = "generateScore";
      //params = {"batchID":key, "username":val["身份证"], "certID":val["认证项目"], "score":""+val["成绩"], "startDate":val["发证日期"], "term": val["期限"], "diplomaID":""+val["证书编号"], "memo":val["备注"], "host":host, "registerID":currUser};
      score = val["成绩"];
      un = val["身份证"];

      if (typeof (score) == "undefined") {
        score = '';
      }
      if (typeof (un) == "undefined") {
        un = '';
      }
      params = { "batchID": key, "passNo": String(val["考生标识"]), "username": un, "name": String(val["姓名"]), "score": String(score), "registerID": currUser };
      //console.log("params:", params);
      db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
          console.log(err);
          let response = { "status": 9 };
          return res.send(response);
        }
      });
    });
    response.count = data1.length;
    return res.send(response);
  }

  //deal xlsx 申报结果导入
  if (upID == "apply_list") {
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    //console.log(sheet["A1"].v);
    while (sheet["A1"].v != "学号") {
      deleteRow(sheet, 0); //删除表头
    }
    var data1 = xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let un = "";
    let dt = "";
    let n = data1.length;
    let m = 0;
    data1.forEach(val => {
      sqlstr = "generateApply";
      //params = {"batchID":key, "username":val["证件号码"], "certID":val["认证项目"], "score":""+val["成绩"], "startDate":val["发证日期"], "term": val["期限"], "diplomaID":""+val["证书编号"], "memo":val["备注"], "host":host, "registerID":currUser};
      un = '' + val["证件号码"];
      if (String(val["考试时间"]).slice(0, 3) != "202") {
        dt = new Date(new Date("1900-01-01").getTime() + (val["考试时间"] - 2) * 3600 * 24 * 1000 - 3600 * 8 * 1000 + 60 * 1000);
        dt = dt.Format("yyyy-MM-dd hh:mm");
      } else {
        dt = val["考试时间"];
      }

      if (typeof (un) == "undefined") {
        un = '';
      }

      params = { "batchID": key, "passNo": String(val["考核号"]), "username": un.replace(/\s+/g, ""), "name": String(val["姓名"]), "examDate": dt };
      //console.log("params:", params);
      db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
          console.log(err);
          let response = { "status": 9 };
          return res.send(response);
        }
      });
      m += 1;
      if (m == n) {
        //处理完名单后，删除申报未通过的人
        sqlstr = "dealGenerateApply";
        params = { "batchID": key, "registerID": currUser };
        db.excuteProc(sqlstr, params, function (err, data2) {
          if (err) {
            console.log(err);
            let response = { "status": 9 };
            return res.send(response);
          }
        });
      }
    });

    response.count = data1.length;
    return res.send(response);
  }

  //deal xlsx 申报成绩证书导入
  if (upID == "apply_score_list") {
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    deleteRow(sheet, 0); //删除第1行
    deleteRow(sheet, 0); //删除第2行
    deleteRow(sheet, 0); //删除第3行
    deleteRow(sheet, 0); //删除第4行
    deleteRow(sheet, 0); //删除第5行
    //第6行是列标题
    var data1 = xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let un = "";
    let up = "";
    let score1 = "";
    let score2 = "";
    let pn = "";
    let n = data1.length;
    let m = 0;
    let arr = "";
    data1.forEach(val => {
      sqlstr = "generateApplyScore";
      arr = Object.values(val);
      //params = {"batchID":key, "username":val["证件号码"], "certID":val["认证项目"], "score":""+val["成绩"], "startDate":val["发证日期"], "term": val["期限"], "diplomaID":""+val["证书编号"], "memo":val["备注"], "host":host, "registerID":currUser};
      un = val["或其他证件号码"];
      //up = val["上传"];
      up = arr[9];
      score1 = val["应知"];
      score2 = val["应会"];
      pn = arr[9];

      if (typeof (un) == "undefined") {
        un = '';
      }
      if (typeof (up) == "undefined") {
        up = '';
      }
      if (typeof (pn) == "undefined") {
        pn = '';
      }
      if (typeof (up) == "undefined") {
        up = '';
      }
      if (typeof (score1) == "undefined" || parseFloat(score1).toString() == "NaN") {
        score1 = '';
      }
      if (typeof (score2) == "undefined" || parseFloat(score2).toString() == "NaN") {
        score2 = '';
      }

      //params = {"batchID":key, "passNo":String(val["操作证号码"]), "username":un, "name":String(val["姓名"]), "pass":up, "score1":score1, "score2":score2};
      params = { "batchID": key, "ID": 0, "passNo": pn.replace(/\s+/g, ""), "username": un.replace(/\s+/g, ""), "name": arr[3], "pass": up, "score1": score1, "score2": score2, "startDate": (req.query.para==""?changeDate(arr[6],"YYYY-MM-DD"):req.query.para), "registerID": currUser };
      //console.log("params:", params);

      db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
          console.log(err);
          let response = { "status": 9 };
          return res.send(response);
        }
      });
      m += 1;
      if (m == n) {
        //处理完名单后，填写发证日期
        sqlstr = "setGenerateApplyIssue";
        params = { "batchID": key, "startDate": req.query.para, "registerID": currUser };
        db.excuteProc(sqlstr, params, function (err, data2) {
          if (err) {
            console.log(err);
            let response = { "status": 9 };
            return res.send(response);
          }
        });
      }

    });

    response.count = data1.length;
    return res.send(response);
  }

  //deal xlsx 安监补考名单导入
  if (upID == "apply_resit_list") {
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    //console.log(sheet["A1"].v);
    while (sheet["A1"].v != "学号") {
      deleteRow(sheet, 0); //删除表头
    }
    var data1 = xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let un = "";
    let dt = "";
    let n = data1.length;
    let m = 0;
    sqlstr = "applyResit";
    data1.forEach(val => {
      if((/(^[1-9]\d*$)/.test(val["学号"]))){   // 学号为正整数的有效
        //params = {"batchID":key, "username":val["证件号码"], "certID":val["认证项目"], "score":""+val["成绩"], "startDate":val["发证日期"], "term": val["期限"], "diplomaID":""+val["证书编号"], "memo":val["备注"], "host":host, "registerID":currUser};
        un = val["证件号码"];
        if (typeof (un) == "undefined") {
          un = '';
        }
        m += 1;

        params = { "batchID": key, "passNo": String(val["考核号"]), "username": un.replace(/\s+/g, ""), registerID:currUser };
        //console.log("params:", params);
        db.excuteProc(sqlstr, params, function (err, data) {
          if (err) {
            console.log(err);
            let response = { "status": 9 };
            return res.send(response);
          }
        });
      }
    });

    response.count = m;
    return res.send(response);
  }

  //deal xlsx 发票导入
  /*
  if (upID == "invoice_list") {
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表名
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表名得到表对象
    var data1 = xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let phone = "";
    let un = "";
    let ex = "";
    data1.forEach(val => {
      sqlstr = "import_invoice_daily";
      //发票代码	发票号码	购方税号	购方名称	开票日期	主要商品名称	报送状态	报送日志	合计金额	税率	合计税额	清单标志	打印标志	作废标志	发票状态	作废日期
      // @kind,@invCode,@invID,@taxNo,@taxUnit,@invDate,@item,@amount,@cancel,@cancelDate,@operator,@memo,@registerID
      params = { "kind": val["发票种类"], "invCode": val["发票代码"], "invID": val["发票号码"], "taxNo": val["购方税号"], "taxUnit": val["购方名称"], "invDate": val["开票日期"], "item": val["主要商品名称"], "amount": ((val["合计金额"]-0) + (val["合计税额"]-0)), "cancel": val["作废标志"], "cancelDate": val["作废日期"], "operator": val["开票人"], "memo": val["备注"], "registerID": currUser };
      //console.log("params:", params);
      db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
          console.log(err);
          let response = { "status": 9 };
          return res.send(response);
        }
      });
    });
    response.count = data1.length;
    return res.send(response);
  }
*/
  //deal xlsx  名单比较
  if (upID == "check_student_list") {
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    var data1 = xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let pn = currUser + '-' + Date.now();
    let idx = 0;
    let xh = "";
    data1.forEach(function (val) {
      sqlstr = "checkStudentOrder_import";
      xh = val["序号"];
      if (typeof (xh) == "undefined") {
        xh = '';
      }
      params = { "username": val["身份证"].replace(/\s+/g, ""), "name": val["姓名"].replace(/\s+/g, ""), "dept1Name": val["单位"], "memo": val["备注"], "No": xh, "batchID": pn };
      //console.log("params:", params);
      db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
          console.log(err);
          let response = { "status": 9 };
          return res.send(response);
        }
        //console.log("data:",data.recordset[0],"idx:",idx);
        idx += 1;
        if (idx == data1.length) {
          sqlstr = "checkStudentOrder";
          params = { "certID": key, "batchID": pn };
          //console.log("params:", params);
          db.excuteProc(sqlstr, params, function (err, data2) {
            if (err) {
              console.log(err);
              let response = { "status": 9 };
              return res.send(response);
            }
            //console.log("data:",data.recordset[0],"idx:",idx);
            //mark + '模板.xlsx' 模板名称
            //var re = genExcel('学员名单核对结果', '培训人员名单核对情况', data2.recordset);
            //  console.log("re:",re);
            let path = 'users/upload/projects/templates/' + '学员信息核对结果' + '模板.xlsx';
            //generate diploma paper with pdf
            let path1 = 'users/upload/others/' + '学员信息核对结果' + '_' + Date.now() + '.xlsx';
            xlsxx.writeExcel({ "title": '培训人员信息核对情况', "list": data2.recordset }, path, path1, function (re) {
              //console.log('the file:',re);
              //return publish file path
              return res.send({ "file": re });
            });
          });
        }
      });
    });
  }
});

router.post('/uploadMultiple', uploadMultiple.array('avatar', 1000), async function (req, res, next) {
  //console.log("req.query.upID:", req.query.upID);
  var files = req.files;
  response = { "status": 0, msg: "", "file": "", "count": 0 }
  if (req.files.length === 0) {  //判断一下文件是否存在，也可以在前端代码中进行判断。
    res.render({ "status": 1, msg: "上传文件不能为空！" });
    return;
  }
  //生成上传记录
  sqlstr = "generateMaterial";
  params = { "kindID": upID, "qty": req.files.length, "host": host, "registerID": currUser };
  response.count = req.files.length;
  let r_err_msg = "";
  let r_no_msg = "";
  let r_err_count = 0;
  //console.log("params:", params);
  try {
    const fileData = await db.excuteProcAsync(sqlstr, params);
    let batchID = fileData.returnValue;
    if (batchID > 0) {
      for (var i in files) {
        let file = files[i];
        let fn = file.filename;
        let size = (file.size/1024).toFixed(0);
        sqlstr = "setUploadSingleFileLink";
        params = { "upID": upID, "key": fn.substr(0, fn.lastIndexOf(".")), "file": file.path.substr(file.path.indexOf("\\")), fsize: size, "multiple": batchID, "registerID": currUser };
        //console.log("params:", params);
        const data = await db.excuteProcAsync(sqlstr, params);

        if (data.returnValue == 1) {
          r_err_msg += fn.substr(0, fn.lastIndexOf(".")) + ",";
          r_err_count += 1;
        }
        if (data.returnValue == 2) {
          r_no_msg += fn.substr(0, fn.lastIndexOf(".")) + ",";
          r_err_count += 1;
        }
      }
      if (r_err_msg > "") {
        r_err_msg = "以下身份证号码错误：" + r_err_msg;
      }
      if (r_no_msg > "") {
        r_no_msg = " 以下人员系统中不存在：" + r_no_msg;
      }
      response.err_msg = r_err_msg + r_no_msg;
      response.count = response.count - r_err_count;
      res.send(response);
    }

  } catch (err) {
    console.log(err);
    let response = { "status": 9 };
    return res.send(response);
  }
});

router.post('/uploadBase64img', async function (req, res, next) {
  //console.log("req.query.upID:", req.query.upID);
  //接收前台POST过来的base64
  var imgData = req.body.imgData;
  //过滤data:URL
  var uploadFolder = "";
  var fn = "";
  upID = req.body.upID;
  currUser = req.body.currUser;
  switch (upID) {
    case "student_photo":
      uploadFolder = "students/photos/";
      fn = req.body.username;
      break;
    case "student_education":
      uploadFolder = "students/educations/";
      fn = req.body.username;
      break;
    case "student_employment":
      uploadFolder = "students/employments/";
      fn = req.body.username;
      break;
    case "student_social":
      uploadFolder = "students/socials/";
      fn = req.body.username;
      break;
    case "student_jobCertificate":
      uploadFolder = "students/jobCertificates/";
      fn = req.body.username;
      break;
    case "student_IDcardA":
      uploadFolder = "students/IDcards/";
      fn = req.body.username + "a";
      break;
    case "student_IDcardB":
      uploadFolder = "students/IDcards/";
      fn = req.body.username + "b";
      break;
    case "student_letter_signature":
      uploadFolder = "students/signature/";
      fn = req.body.username;
      break;
    default:
      uploadFolder = "others/";
      fn = req.body.username;
  }
  uploadFolder = uploadHome + uploadFolder;
  createFolder(uploadFolder);
  fn = uploadFolder + fn + (upID=="student_letter_signature"? ".png":".jpg");

  var base64Data = imgData.replace(/^data:image\/\w+;base64,/, "");
  var dataBuffer = "";
  if(req.body.compress == 1){
    dataBuffer = await compressBase64(base64Data);
  }else{
    dataBuffer = Buffer.from(base64Data, 'base64');
  }
  let size = (dataBuffer.length/1024).toFixed(0);
  fs.writeFile(fn, dataBuffer, function (err) {
    if (err) {
      res.send(err);
    } else {
      //res.send("保存成功！");
      fn = fn.replace("./users", "");
      //response.count = 1;
      sqlstr = "setUploadSingleFileLink";
      params = { "upID": upID, "key": req.body.username, "file": fn, fsize: size, "multiple": 0, "registerID": currUser };
      // console.log("params:", params);
      db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
          console.log(err);
          let response = { "status": 9 };
          return res.send(response);
        }
        if(upID=="student_photo"){
          face.addFace(req.body.username);  // 照片上传到照片库
        }
      });

      res.send({ "status": 0, "size": size });
    }
  });
});

//22. generate_diploma_byCertID
//status: 0 成功  9 其他  msg, filename
router.get('/generate_diploma_byCertID', function (req, res, next) {
  sqlstr = "generateDiplomaByCertID";
  params = { certID: req.query.certID, batchID: req.query.batchID, selList: req.query.selList, selList1: req.query.selList1, host: req.query.host, registerID: req.query.username };
  //console.log(params);
  //generate diploma data
  let response = [];
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    let batchID = data.returnValue;
    //console.log(data,":",batchID);
    let filename = "";
    if (batchID > 0) {
      sqlstr = "select *,'No.' as diplomaNo from v_diplomaInfo where type=1 and batchID=" + batchID;   //企业内证书
      params = {};
      db.excuteSQL(sqlstr, params, function (err, data1) {
        if (err) {
          console.log(err);
          response = [];
          return res.send(response);
        }
        let pages = [];
        let paths = [];
        //generate diploma paper with pdf
        for (var i in data1.recordset) {
          let str = [data1.recordset[i]["name"], data1.recordset[i]["certName"], data1.recordset[i]["diplomaID"], data1.recordset[i]["dept1Name"], data1.recordset[i]["job"], data1.recordset[i]["startDate"], data1.recordset[i]["term"], data1.recordset[i]["title"], data1.recordset[i]["photo_filename"], data1.recordset[i]["logo"], data1.recordset[i]["certID"], data1.recordset[i]["host"], data1.recordset[i]["stamp"], data1.recordset[i]["trainingDate"], data1.recordset[i]["score"]];
          sqlstr = env + "/pdf.asp?kindID=" + (str.join(","));
          //arr.push(str.join(","));
          let path = 'users/upload/students/diplomas/' + data1.recordset[i]["diplomaID"] + '.pdf';
          //console.log('path',path);
          pages.push(sqlstr);
          paths.push(path);
        }
        pdf.genPDF(pages, paths, '180mm', '120mm', '1', false, 1, false);
        //publish diploma on A4 with pdf
        //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));
        sqlstr = env + "/pdfs.asp?refID=" + batchID;
        //console.log(sqlstr);
        let path = 'users/upload/students/diplomaPublish/' + batchID + '.pdf';
        filename = path;
        pdf.genPDF([sqlstr], [path], '297mm', '210mm', '', false, 0.5, false);
        //console.log('the path:',path);
        //return publish file path
        response = [filename];
        return res.send(response);
      });
    } else {
      response = [];
      return res.send(response);
    }
  });
});

//22. re-generate diploma with username list, incloude all live diplomas under the username
//status: 0 成功  9 其他  msg, filename
router.post('/generate_diploma_byUsername', function (req, res, next) {
  sqlstr = "generate_diploma_byUsername";
  params = { selList: req.body.selList, registerID: req.body.username };
  console.log('params',params);
  db.excuteProc(sqlstr, params, function (err, data1) {
    if (err) {
      console.log(err);
      response = [0];
      return res.send(response);
    }
    let pages = [];
    let paths = [];
    //generate diploma paper with pdf
    for (var i in data1.recordset) {
      let str = [data1.recordset[i]["name"], data1.recordset[i]["certName"], data1.recordset[i]["diplomaID"], data1.recordset[i]["dept1Name"], data1.recordset[i]["job"], data1.recordset[i]["startDate"], data1.recordset[i]["term"], data1.recordset[i]["title"], data1.recordset[i]["photo_filename"], data1.recordset[i]["logo"], data1.recordset[i]["certID"], data1.recordset[i]["host"], data1.recordset[i]["stamp"], data1.recordset[i]["trainingDate"], data1.recordset[i]["score"]];
      sqlstr = env + "/pdf.asp?kindID=" + (str.join(","));
      //arr.push(str.join(","));
      let path = 'users/upload/students/diplomas/' + data1.recordset[i]["diplomaID"] + '.pdf';
      //console.log('path',path);
      pages.push(sqlstr);
      paths.push(path);
    }
    pdf.genPDF(pages, paths, '180mm', '120mm', '1', false, 1, false);
    response = [1+parseInt(i)];
    return res.send(response);
  });
});

//22. generate_diploma_byClassID
//status: 0 成功  9 其他  msg, filename
router.post('/generate_diploma_byClassID', function (req, res, next) {
  sqlstr = "updateGenerateDiplomaInfo";
  //@ID int,@classID varchar(50), @selList varchar(4000),@printed int,@printDate varchar(50),@delivery int,@deliveryDate varchar(50),@host nvarchar(50),@memo nvarchar(500),@registerID varchar(50)
  params = { ID: req.query.ID, certID: req.query.certID, selList: req.body.selList, startDate: req.query.startDate, class_startDate: req.query.class_startDate, class_endDate: req.query.class_endDate, printed: 0, printDate: '', delivery: 0, deliveryDate: '', styleID: req.query.card, host: '', memo: req.query.memo, registerID: req.query.registerID };
  console.log("params:", params);
  //generate diploma data
  let response = [];
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    let batchID = data.returnValue;
    //console.log(data,":",batchID);
    let filename = "";
    if (batchID > 0) {
      //sqlstr = "select * from v_diplomaInfo where batchID=" + batchID;   //证书
      sqlstr = "getDiplomaListByBatchID";
      params = { batchID: batchID };
      db.excuteProc(sqlstr, params, function (err, data1) {
        if (err) {
          console.log(err);
          response = [];
          return res.send(response);
        }
        let arr = new Array();
        let certID = 'C1';
        let pW1 = '180mm';
        let pH1 = '265mm';
        let pW2 = '210mm';
        let pH2 = '297mm';
        let pages = [];
        let paths = [];
        let _certID = data1.recordset[0]["certID"];
        if (["C2","C30","C31","C35","C18","C19"].includes(_certID)) {
          certID = "C2";
        } else {
          pW1 = '280mm';
          pH1 = '180mm';
          pW2 = '178mm';
          pH2 = '123mm';
          if(["C20","C20A","C21"].includes(_certID)){
            certID = "C20";
            pW1 = '190mm';
            pH1 = '135mm';
          }
        }

        //generate diploma paper with pdf
        for (var i in data1.recordset) {
          let str = [data1.recordset[i]["diplomaID"], data1.recordset[i]["name"], data1.recordset[i]["username"], data1.recordset[i]["certID"], data1.recordset[i]["certName"], data1.recordset[i]["hostName"], data1.recordset[i]["job"], data1.recordset[i]["startDate"], data1.recordset[i]["endDate"], data1.recordset[i]["title"], data1.recordset[i]["photo_filename"], data1.recordset[i]["term"], data1.recordset[i]["sexName"], data1.recordset[i]["diplomaNo"], data1.recordset[i]["educationName"], data1.recordset[i]["class_startDate"], data1.recordset[i]["class_endDate"], data1.recordset[i]["birthday"], data1.recordset[i]["ID"]];
          if (req.query.card == 0) {
            sqlstr = env + "/pdf_" + certID + ".asp?kindID=" + (str.join(","));
          } else {
            //************ */ card diploma style
            sqlstr = env + "/pdf_card.asp?kindID=" + (str.join(","));
          }
          let path = 'users/upload/students/diplomas/' + data1.recordset[i]["diplomaID"] + '.pdf';
          //console.log('path',path);
          pages.push(sqlstr);
          paths.push(path);
          //pdf.genPDF(sqlstr, path, pW1, pH1, '1', false, 1, false);
        }
        if (req.query.card == 0) {
          pdf.genPDF(pages, paths, pW1, pH1, '1', false, 1, true);
        } else {
          //************ */ card diploma style
          pW2 = '86mm';
          pH2 = '54mm';
          pdf.genPDF(pages, paths, pW2, pH2, '1', false, 0.5, true);
        }
        //publish diploma on A4 with pdf
        //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));

        let path = 'users/upload/students/diplomaPublish/' + batchID + '.pdf';
        if (req.query.card == 0) {
          sqlstr = env + "/pdfs_diploma_" + certID + ".asp?refID=" + batchID + "&kindID=" + req.query.kindID;
        } else {
          //************ */ card diploma style
          sqlstr = env + "/pdfs_diploma_card.asp?refID=" + batchID;
        }

        filename = path;
        //pdf.genPDF(sqlstr, path, pW2, pH2, '', false, 0.5, false);
        pdf.genPDF([sqlstr], [path], pW2, pH2, '', false, 0.5, false);
        //console.log('the path:',path);
        //return publish file path
        response = [batchID];
        return res.send(response);
      });
    } else {
      response = [];
      return res.send(response);
    }
  });
});

//22.1. cancel_diplomas 批量撤销证书
//status: 0 成功  9 其他  msg, filename
router.post('/cancel_diplomas', function (req, res, next) {
  sqlstr = "cancelDiplomas";   
  params = { selList: req.body.selList, kind: req.query.kind, registerID: req.query.registerID};
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    return res.send(["0"]);
  });
});

//22.1. cancel_diploma 撤销某个证书
//status: 0 成功  9 其他  msg, filename
router.post('/cancel_diploma', function (req, res, next) {
  sqlstr = "cancelDiploma";   
  params = { diplomaID: req.query.diplomaID, registerID: req.query.registerID};
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    return res.send(["0"]);
  });
});

//22.1. re_generate_diploma_spc 重新生成企业内证书
//status: 0 成功  9 其他  msg, filename
router.get('/re_generate_diploma_spc', function (req, res, next) {
  sqlstr = "select *,'No.' as diplomaNo from v_diplomaInfo where type=1 and diplomaID=@diplomaID";   //企业内证书
  params = { diplomaID: req.query.diplomaID };
  db.excuteSQL(sqlstr, params, function (err, data1) {
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    let pages = [];
    let paths = [];
    let str = [data1.recordset[0]["name"], data1.recordset[0]["certName"], data1.recordset[0]["diplomaID"], data1.recordset[0]["dept1Name"], data1.recordset[0]["job"], data1.recordset[0]["startDate"], data1.recordset[0]["term"], data1.recordset[0]["title"], data1.recordset[0]["photo_filename"], data1.recordset[0]["logo"], data1.recordset[0]["certID"], data1.recordset[0]["host"], data1.recordset[0]["stamp"]];
    sqlstr = env + "/pdf.asp?kindID=" + (str.join(","));
    //arr.push(str.join(","));
    let path = 'users/upload/students/diplomas/' + data1.recordset[i]["diplomaID"] + '.pdf';
    pages.push(sqlstr);
    paths.push(path);
    pdf.genPDF(pages, paths, '180mm', '120mm', '1', false, 1, false);
  });
});

//22a. generate_student_photos
//status: 0 成功  9 其他  msg, filename
//kindID: 0 照片  1 身份证正面  2 身份证背面  3 学历证书  4 其他证书
router.get('/generate_student_photos', function (req, res, next) {
  let response = [];
  let filename = "";
  sqlstr = env + "/pdfs_student_photos.asp?item=" + req.query.item + "&kindID=" + req.query.kindID;
  //sqlstr = env + "/pdf1.asp?kindID=" + req.query.kindID;
  //console.log(sqlstr);
  let path = 'users/public/temp/student_photos_' + Date.parse(new Date()).toString() + '.pdf';
  filename = path;
  //console.log(sqlstr, filename);
  pdf.genPDF([sqlstr], [path], '297mm', '210mm', '1', false, 1, false);
  //pdf.genPDF(sqlstr, path, '180mm', '120mm', '1', false, 1);

  //return publish file path
  response = [filename];
  return res.send(response);
});

//generate_entryform_byProjectID
//status: 0 成功  9 其他  msg, filename
router.get('/generate_entryform_byProjectID', function (req, res, next) {
  let projectID = req.query.projectID;
  let certID = req.query.certID;
  let path1 = 'users/upload/projects/templates/entry_form_' + certID + '.docx';
  let path2 = 'users/upload/projects/entryforms/培训报名表[' + projectID + '].docx';
  var arr = new Array();
  sqlstr = "select a.*,(case when b.SNo=0 then '' else cast(b.SNo as varchar) end) as SNo,b.ID as enterID from v_studentInfo a, studentCourseList b where a.username=b.username and b.checked=1 and b.projectID='" + projectID + "'";   //获取指定招生批次下的已确认名单
  params = {};
  db.excuteSQL(sqlstr, params, function (err, data1) {
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    //generate entry form to a single file for every student.
    for (var i in data1.recordset) {
      params = { ID: data1.recordset[i]["username"], name: data1.recordset[i]["name"], SNo: data1.recordset[i]["SNo"], sex: data1.recordset[i]["sexName"], birthday: data1.recordset[i]["birthday"], age: data1.recordset[i]["age"], host: data1.recordset[i]["hostName"], dept1: data1.recordset[i]["dept1Name"], dept2: data1.recordset[i]["dept2Name"], job: data1.recordset[i]["job"], education: data1.recordset[i]["educationName"], phone: data1.recordset[i]["phone"], mobile: data1.recordset[i]["mobile"], imgPhoto: "users" + data1.recordset[i]["photo_filename"], imgIDa: "users" + data1.recordset[i]["IDa_filename"], imgID: "users" + data1.recordset[i]["IDa_filename"], imgEdu: "users" + data1.recordset[i]["edu_filename"], address: '', date: today };
      //console.log(params);
      let path0 = 'users/upload/projects/entryforms/projectID' + data1.recordset[i]["enterID"] + '.docx';
      arr.push(path0);
      docx.writeDoc(params, path1, path0);
    }
    //merge all the single file to one big file, and delete them after merging.
    //console.log(arr);
    docx.mergeDocx(arr, path2);
    //link the filename to the project
    sqlstr = "setUploadSingleFileLink";
    path2 = path2.substr(path2.indexOf("\/"));
    params = { "upID": 'project_entryform', "key": projectID, "file": path2, fsize: 0, "multiple": 0, "registerID": req.query.registerID };
    //console.log("params:", params);
    db.excuteProc(sqlstr, params, function (err, data) {
      if (err) {
        console.log(err);
        let response = { "status": 9 };
        return res.send(response);
      }
      response.count = 1;
    });
    //give student no for every student of the project
    sqlstr = "setProjectStudentNo";
    params = { "projectID": projectID, "username": req.query.registerID };
    //console.log("params:", params);
    db.excuteProc(sqlstr, params, function (err, data) {
      if (err) {
        console.log(err);
        let response = { "status": 9 };
        return res.send(response);
      }
    });

    //return file path
    response = [path2];
    return res.send(response);
  });
});

//generate_entryform
//status: 0 成功  9 其他  msg, filename
router.get('/generate_entryform', function (req, res, next) {
  let enterID = req.query.enterID;
  let certID = req.query.certID;
  let path1 = 'users/upload/projects/templates/entry_form_' + certID + '.docx';
  var arr = new Array();
  sqlstr = "select a.*,(case when b.SNo=0 then '' else cast(b.SNo as varchar) end) as SNo,b.ID as enterID from v_studentInfo a, studentCourseList b where a.username=b.username and b.ID=" + enterID;   //获取指定报名表信息
  params = {};
  db.excuteSQL(sqlstr, params, function (err, data1) {
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    //generate entry form to a single file for every student.
    var i = 0;
    params = { ID: data1.recordset[i]["username"], name: data1.recordset[i]["name"], SNo: data1.recordset[i]["SNo"], sex: data1.recordset[i]["sexName"], birthday: data1.recordset[i]["birthday"], age: data1.recordset[i]["age"], host: data1.recordset[i]["hostName"], dept1: data1.recordset[i]["dept1Name"], dept2: data1.recordset[i]["dept2Name"], job: data1.recordset[i]["job"], education: data1.recordset[i]["educationName"], phone: data1.recordset[i]["phone"], mobile: data1.recordset[i]["mobile"], imgPhoto: "users" + data1.recordset[i]["photo_filename"], imgIDa: "users" + data1.recordset[i]["IDa_filename"], imgID: "users" + data1.recordset[i]["IDa_filename"], imgEdu: "users" + data1.recordset[i]["edu_filename"], address: '', date: today };
    //console.log(params);
    let path0 = 'users/upload/projects/entryforms/projectID' + data1.recordset[i]["enterID"] + '.docx';
    docx.writeDoc(params, path1, path0);
    //merge all the single file to one big file, and delete them after merging.
    //console.log(arr);
    //link the filename to the enter
    sqlstr = "setUploadSingleFileLink";
    path0 = path0.substr(path0.indexOf("\/"));
    params = { "upID": 'enter_entryform', "key": enterID, "file": path0, fsize: 0, "multiple": 0, "registerID": req.query.registerID };
    //console.log("params:", params);
    db.excuteProc(sqlstr, params, function (err, data) {
      if (err) {
        console.log(err);
        let response = { "status": 9 };
        return res.send(response);
      }
      response.count = 1;
    });

    //return file path
    response = [path0];
    return res.send(response);
  });
});

//22d. generate_entryform_sign
//生成报名表, 带协议书 keyID: 4
//status: 0 成功  9 其他  msg, emergency item
router.get('/generate_entryform_sign', function (req, res, next) {
  comFunc.generate_entryform_sign(req.query.nodeID);
  return res.send([]);
  // if (req.query.nodeID > 0) {
  //   let filename1 = "";
  //   let path = "";
  //   //publish diploma on A4 with pdf
  //   sqlstr = "updateEnterMaterials";
  //   //params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
  //   path = 'users/upload/students/firemanMaterials/' + req.query.nodeID + '_4.pdf';
  //   filename1 = path.replace("users/", "/");
  //   params = { enterID: req.query.nodeID, filename1: "", filename2: "", filename3: "", filename4: filename1 };
  //   //generate diploma data
  //   // console.log("params:", params);
  //   db.excuteProc(sqlstr, params, function (err, data) {
  //     if (err) {
  //       console.log(err);
  //       response = [];
  //       return res.send(response);
  //     }
  //     // console.log("data:", data.recordset[0]);
  //     let entryform = data.recordset[0]["entryForm"];  //报名表样式
  //     let username = data.recordset[0]["username"];  //报名表样式
  //     //班级归档资料
  //     sqlstr = env + "/entryform_" + entryform + ".asp?public=1&nodeID=" + req.query.nodeID + "&refID=" + username + "&keyID=4";
  //     pdf.genPDF([sqlstr], [path], '210mm', '290mm', '', false, 1, false);
  //     //return publish file path
  //     response = [filename1];
  //     return res.send(response);
  //   });
  // } else {
  //   response = [];
  //   return res.send(response);
  // }
});

//22. generate_diploma_byCertID
//status: 0 成功  9 其他  msg, filename
//mark: 0 生成准考证  1 保存信息
router.get('/generate_passcard_byClassID', function (req, res, next) {
  sqlstr = "updateGeneratePasscardInfo";
  params = { mark: req.query.mark, ID: req.query.ID, classID: req.query.classID, selList: req.query.selList, title: req.query.title, startNo: req.query.startNo, startDate: req.query.startDate, startTime: req.query.startTime, address: req.query.address, notes: req.query.notes, memo: req.query.memo, registerID: req.query.username };
  //console.log(params);
  //generate diploma data
  let response = [];
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    let batchID = data.returnValue;
    //console.log(data,":",batchID);
    let filename = "";
    if (batchID > 0 && req.query.mark == 0) {
      //publish diploma on A4 with pdf
      //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));
      sqlstr = env + "/pdfs_passcard.asp?refID=" + batchID;
      //console.log(sqlstr);
      let path = 'users/upload/students/passcardPublish/' + batchID + '.pdf';
      filename = path;
      pdf.genPDF([sqlstr], [path], '297mm', '210mm', '', false, 0.5, false);
      //console.log('the path:',path);
      //return publish file path
      sqlstr = "updateGeneratePasscardFile";
      params = { ID: batchID, filename: filename.replace("users/", "/") };
      //console.log(params);
      //generate diploma data
      let response = [];
      db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
          console.log(err);
          response = [];
          return res.send(response);
        }
        response = [batchID];
        return res.send(response);
      });
    } else {
      response = [];
      return res.send(response);
    }
  });
});

//22. generate_diploma_byCertID
//status: 0 成功  9 其他  msg, filename
//mark: 0 生成准考证  1 保存信息
router.get('/generate_passcard_byExamID', function (req, res, next) {
  sqlstr = "setPassNo4Exam";
  params = { examID: req.query.ID, registerID: req.query.username };
  //console.log(params);
  //generate diploma data
  let response = [];
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    let batchID = req.query.ID;
    //console.log(data,":",batchID);
    let filename = "";
    if (batchID > 0 && req.query.mark == 0) {
      //publish diploma on A4 with pdf
      //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));
      sqlstr = env + "/pdfs_passcard.asp?refID=" + batchID;
      //console.log(sqlstr);
      let path = 'users/upload/students/passcardPublish/' + batchID + '.pdf';
      filename = path;
      pdf.genPDF([sqlstr], [path], '297mm', '210mm', '', false, 0.5, false);
      //console.log('the path:',path);
      //return publish file path
      sqlstr = "updateGeneratePasscardFile";
      params = { ID: batchID, filename: filename.replace("users/", "/") };
      //console.log(params);
      //generate diploma data
      let response = [];
      db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
          console.log(err);
          response = [];
          return res.send(response);
        }
        response = [batchID];
        return res.send(response);
      });
    } else {
      response = [];
      return res.send(response);
    }
  });
});

//22a. generate_fireman_materials
//status: 0 成功  9 其他  msg, filename
router.get('/generate_fireman_materials', function (req, res, next) {
  let filename = "";
  let filename1 = "";
  if (req.query.enterID > 0) {
    //publish diploma on A4 with pdf
    //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));
    sqlstr = env + "/pdfs_fireman.asp?item=" + req.query.username + "&refID=0";
    let path = 'users/upload/students/firemanMaterials/' + req.query.username + '_' + req.query.enterID + '证明材料.pdf';
    filename = path.replace("users/", "/");
    pdf.genPDF([sqlstr], [path], '210mm', '297mm', '', false, 1, false);

    sqlstr = env + "/pdf_entryform_C20.asp?nodeID=" + req.query.enterID;
    let path1 = 'users/upload/students/firemanMaterials/' + req.query.username + '_' + req.query.enterID + '报名表.pdf';
    filename1 = path1.replace("users/", "/");
    pdf.genPDF([sqlstr], [path1], '210mm', '297mm', '', false, 0.5, false);
    //console.log('the path:',path);
    //return publish file path
    sqlstr = "updateFiremanMaterials";
    //params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
    params = { enterID: req.query.enterID, filename: filename, filename1: filename1 };
    //console.log(params);
    //generate diploma data
    db.excuteProc(sqlstr, params, function (err, data) {
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      response = [filename];
      return res.send(response);
    });
  } else {
    response = [];
    return res.send(response);
  }
});

//22a. generate_IDcard_materials
//status: 0 成功  9 其他  msg, filename
router.get('/generate_IDcard_materials', function (req, res, next) {
  let filename = "";
  if (req.query.username > "") {
    //publish diploma on A4 with pdf
    //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));
    sqlstr = env + "/pdfs_fireman.asp?item=" + req.query.username + "&refID=1";
    let path = 'users/upload/students/IDcardMaterials/' + req.query.username + '身份证正反面.pdf';
    filename = path.replace("users/", "/");
    pdf.genPDF([sqlstr], [path], '210mm', '297mm', '', false, 1, false);
    sqlstr = "updateIDcardsMaterials";
    //params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
    params = { username: req.query.username, filename: filename };
    //console.log(params);
    //generate diploma data
    db.excuteProc(sqlstr, params, function (err, data) {
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      response = [filename];
      return res.send(response);
    });
  } else {
    response = [];
    return res.send(response);
  }
});

//22b. generate_fireman_zip
//status: 0 成功  9 其他  msg, filename
router.get('/generate_fireman_zip', function (req, res, next) {
  let filename = "";
  if (req.query.enterID > 0) {
    let path = 'users/upload/students/firemanMaterials/' + req.query.username + '_' + req.query.enterID + '.zip';
    filename = path.replace("users/", "/");
    let p = [];
    let t = [];
    let f = [];
    sqlstr = "select * from v_firemanEnterInfo where enterID=@enterID";   //获取指定招生批次下的已确认名单
    params = { enterID: req.query.enterID };
    db.excuteSQL(sqlstr, params, function (err, data1) {
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      if (data1.recordset[0]["photo_filename"] > "") {
        p.push("users" + data1.recordset[0]["photo_filename"]);
      }
      if (data1.recordset[0]["IDa_filename"] > "") {
        p.push("users" + data1.recordset[0]["IDa_filename"]);
      }
      if (data1.recordset[0]["materials"] > "") {
        p.push("users" + data1.recordset[0]["materials"]);
      }
      if (data1.recordset[0]["materials1"] > "") {
        p.push("users" + data1.recordset[0]["materials1"]);
      }
      t.push("");
      f.push("");
      p.push('users/upload/projects/ref/消防行业职业技能鉴定考生报名指导手册.docx');
      t.push("");
      f.push("");
      p.push('users/upload/projects/ref/消防行业职业技能鉴定考生报名过程演示.mp4');
      t.push("");
      f.push("");
      //zip.doZIP([path,path1,'users/upload/projects/ref/消防行业职业技能鉴定考生报名指导手册.docx','users/upload/projects/ref/消防行业职业技能鉴定考生报名过程演示.mp4'],path2);
      zip.doZIP(p, path, t, f);
    });
    //console.log('the path:',path);
    //return publish file path
    sqlstr = "updateFiremanZip";
    //params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
    params = { enterID: req.query.enterID, zip: filename };
    //console.log(params);
    //generate diploma data
    db.excuteProc(sqlstr, params, function (err, data) {
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      response = [filename];
      return res.send(response);
    });
  } else {
    response = [];
    return res.send(response);
  }
});

//22d. generate_emergency_materials
//status: 0 成功  9 其他  msg, emergency item  keyID: 2 归档资料  5 报名表
router.get('/generate_emergency_materials', function (req, res, next) {
  let filename2 = "";
  let filename1 = "";
  let path = "";
  if (req.query.nodeID > 0) {
    //publish diploma on A4 with pdf
    // let certID = req.query.certID;
    // if(certID=="C16" || certID=="C17"){
    //   certID = "C16";
    // }
    // if(certID=="C12" || certID=="C15" || certID=="C24" || certID=="C25" || certID=="C26" || certID == "C27"){
    //   certID = "C12";
    // }
    //申报材料
    sqlstr = env + "/entryform_" + req.query.entryForm + ".asp?public=1&nodeID=" + req.query.nodeID + "&refID=" + req.query.refID + "&keyID=" + req.query.keyID;
    path = 'users/upload/students/firemanMaterials/' + req.query.refID + '_' + req.query.nodeID + '报名材料.pdf';
    filename1 = path.replace("users/", "/");
    pdf.genPDF([sqlstr], [path], '210mm', '297mm', '', false, 1, false);

    //报名表
    sqlstr = env + "/entryform_" + req.query.entryForm + ".asp?public=1&nodeID=" + req.query.nodeID + "&refID=" + req.query.refID + "&keyID=5";
    path = 'users/upload/students/firemanMaterials/' + req.query.refID + '_' + req.query.nodeID + '报名表.jpg';
    filename2 = path.replace("users/", "/");
    // pdf.genPDF([sqlstr], [path], '210mm', '297mm', '', false, 1, false);
    shotimg.genImg(sqlstr, path, 2160, 1020);

    //return publish file path
    sqlstr = "updateEnterMaterials";
    //params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
    params = { enterID: req.query.nodeID, filename1: filename1, filename2: filename2, filename3:"", filename4: "" };
    //generate diploma data
    db.excuteProc(sqlstr, params, function (err, data) {
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      response = [filename1];
      return res.send(response);
    });
  } else {
    response = [];
    return res.send(response);
  }
});

//22d. generate_emergency_exam_materials_byclass
//同时一个班级的归档/报名表 keyID: 2/5
//status: 0 成功  9 其他  msg, emergency item
router.post('/generate_emergency_exam_materials_byclass', function (req, res, next) {
  let path = "";
  let f = ['','','班级归档资料.pdf','','','报名表.jpg']
  let keyID = req.query.keyID;

  // sqlstr = "select ID,name,username,enterID,entryform from v_applyInfo where refID=@refID and signature>'' order by ID";   //获取指定申报下的有签名的名单
  sqlstr = "generate_emergency_exam_materials_byclass";   //获取指定申报下的有签名的名单
  params = { batchID: req.query.refID, keyID: keyID, selList: req.body.selList, fn: f[keyID], registerID: req.query.registerID };
  // console.log(params);
  db.excuteProc(sqlstr, params, async function (err, data) {
    if (err) {
      console.log(err);
      response = [0];
      return res.send(response);
    }

    if (data.recordset.length > 0) {
      // console.log("len:", data.recordset.length);
      let dat = data.recordset;
      response = [dat.length];
      let kindID = req.query.kindID || 0;
      for (var i in dat) {
        //班级归档资料
        sqlstr = env + "/entryform_" + dat[i]["entryform"] + ".asp?public=1&nodeID=" + dat[i]["enterID"] + "&refID=" + dat[i]["username"] + "&host=" + req.query.host + "&kindID=" + kindID + "&status=" + req.query.refID + "&keyID=";
        path = 'users/upload/students/firemanMaterials/' + dat[i]["ID"] + '_' + dat[i]["name"] + '_' + dat[i]["username"];
        if(keyID==2){ //班级存档资料\考站资料生成pdf文件
          await pdf.genPDF([sqlstr + keyID], [path + f[keyID]], '210mm', '290mm', '', false, 1, false);
        }
        if(keyID==5){ //申报资料生成jpg文件
          await shotimg.genImg(sqlstr + keyID, path + f[keyID], (kindID==0?2160:2800), 1020);
        }
      }
      // console.log("len:", response);
      return res.send(response);
    } else {
      response = [0];
      return res.send(response);
    }
  });
});

//22e. generate_material_zip
//kind: class - classID; apply - apply.ID
//type: m - materials; p - photo
//status: 0 成功  9 其他  msg, filename
router.get('/generate_material_zip', function (req, res, next) {
  let filename = "";
  if (req.query.refID > "") {
    let path = 'users/upload/students/firemanMaterials/' + req.query.type + '_' + req.query.kind + '_' + req.query.refID + '.zip';
    filename = path.replace("users/", "/");
    
    if(req.query.kind=="class"){
      if(req.query.type=="m"){
        sqlstr = "select file1,'' as name from studentCourseList where classID=@ID and file1>''";   //获取指定班级下的存档材料
      }
      if(req.query.type=="p"){ 
        sqlstr = "select photo_filename as file1,name from v_studentCourseList where classID=@ID and photo_filename>''";   //获取指定班级下的照片
      }
      if(req.query.type=="e"){ 
        sqlstr = "select file2 as file1,name from v_studentCourseList where classID=@ID and file2>''";   //获取指定班级下的报名表
      }
    }else{
      if(req.query.type=="m"){
        sqlstr = "select file1,'' as name from studentCourseList where applyID=@ID and file1>''";   //获取指定申报下的存档材料
      }
      if(req.query.type=="p"){ 
        sqlstr = "select photo_filename as file1,name from v_studentCourseList where applyID=@ID and photo_filename>''";   //获取指定班级下的照片
      }
      if(req.query.type=="e"){
        sqlstr = "select file2 as file1,'' as name from studentCourseList where applyID=@ID and file2>''";   //获取指定申报下的报名表
      }
    }
    
    params = { ID: req.query.refID };
    db.excuteSQL(sqlstr, params, function (err, data1) {
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }

      if(data1.recordset.length > 0){
        let p = [];
        let t = [];
        let f = [];
        for (var i in data1.recordset) {
          p.push("users" + data1.recordset[i]["file1"]);
          t.push(data1.recordset[i]["name"]);
          f.push("");
        }
        //console.log("p", p);
        zip.doZIP(p, path, t, f);

        sqlstr = "updateMaterialZip";
        params = { refID: req.query.refID, kind:req.query.kind, type:req.query.type, zip: filename };
        //console.log(params);
        //generate diploma data
        db.excuteProc(sqlstr, params, function (err, data) {
          if (err) {
            console.log(err);
            response = [];
            return res.send(response);
          }
          response = [filename];
          return res.send(response);
        });
      }else {
        response = [];
        return res.send(response);
      }
    });
  } else {
    response = [];
    return res.send(response);
  }
});

//22e. generate_student_material_zip
//kind: class - classID; apply - apply.ID
//获取班级里每个学员的所有材料，并打包。文件名重命名：身份证号码_类型（120109xxxx_照片.jpg）
//status: 0 成功  9 其他  msg, filename
router.get('/generate_student_material_zip', function (req, res, next) {
  let filename = "";
  response = [];
  if (req.query.refID > "") {
    let path = 'users/upload/students/temp/student_material_' + req.query.kind + '_' + req.query.refID + '.zip';
    filename = path.replace("users/", "/");
    
    if(req.query.kind=="class"){
      sqlstr = "select a.SNo,a.username,d.name,c.filename,b.ID,b.item from studentCourseList a, dictionaryDoc b, studentMaterials c, studentInfo d where a.username=c.username and b.ID=c.kindID and a.username=d.username and a.classID=@ID and b.kind='material' order by a.SNo, b.ID";
    }else{
      sqlstr = "select a.SNo,a.username,d.name,c.filename,b.ID,b.item from studentCourseList a, dictionaryDoc b, studentMaterials c, studentInfo d, applyInfo e where a.ID=e.enterID and a.username=c.username and b.ID=c.kindID and a.username=d.username and e.refID=@ID and b.kind='material' order by a.SNo, b.ID";
    }
    
    params = { ID: req.query.refID };
    db.excuteSQL(sqlstr, params, function (err, data1) {
      if (err) {
        console.log(err);
        return res.send(response);
      }

      if(data1.recordset.length > 0){
        let p = [];
        let t = [];
        let f = [];
        let SNo = "";
        let j = 0;
        for (var i in data1.recordset) {
          p.push("users" + data1.recordset[i]["filename"]);
          if(SNo != data1.recordset[i]["SNo"]){
            j += 1;
            SNo = data1.recordset[i]["SNo"];
          }
          t.push(data1.recordset[i]["name"] + "_" + data1.recordset[i]["ID"] + data1.recordset[i]["item"]);
          f.push(j);
        }
        // console.log("t", t);
        zip.doZIP(p, path, t, f);
        sqlstr = "updateMaterialZip";
        params = { refID: req.query.refID, kind:req.query.kind, type:req.query.type, zip: filename };
        //console.log(params);
        //generate diploma data
        db.excuteProc(sqlstr, params, function (err, data) {
          if (err) {
            console.log(err);
            return res.send(response);
          }
          response = [filename];
          return res.send(response);
        });
      }else {
        return res.send(response);
      }
    });
  } else {
    return res.send(response);
  }
});

//get_entryform_shot 获取报名表的图片buffer(base64)
//status: 0 成功  9 其他  msg, filename
router.get('/get_entryform_shot', async function (req, res, next) {
  if (req.query.nodeID > 0) {
    //publish diploma on A4 with pdf
    let entryform = req.query.entryform;  //报名表样式

    //报名表
    sqlstr = env + "/entryform_" + entryform + ".asp?public=1&nodeID=" + req.query.nodeID + "&refID=" + req.query.refID + "&keyID=4";
    // console.log("str:", sqlstr);
    // let img = await shotimg.genImg(sqlstr, "", 50);
    // res.send(img);
    let path = 'users/upload/students/firemanMaterials/' + req.query.username + '_' + req.query.enterID + '报名表.jpg';
    let filename = path.replace("users/", "/");
    shotimg.genImg(sqlstr, path, 700, 800);

    //return publish file path
    sqlstr = "updateEnterMaterials";
    //params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
    params = { enterID: req.query.nodeID, filename1: "", filename2: "", filename3: "", filename4: filename };
    //generate diploma data
    db.excuteProc(sqlstr, params, function (err, data) {
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      response = [filename];
      return res.send(response);
    });
  } else {
    response = [];
    return res.send(response);
  }
});

//get_trainProof_shot 获取机构培训证明的图片buffer(base64)
//status: 0 成功  9 其他  msg, filename
router.get('/get_trainProof_shot', async function (req, res, next) {
  if (req.query.nodeID > 0) {
    sqlstr = env + "/trainingProofUnit.asp?public=1&nodeID=" + req.query.nodeID + "&keyID=0";
    // console.log("str:", sqlstr);
    // let img = await shotimg.genImg(sqlstr, "", 50);
    // res.send(img);
    // let path = 'users/upload/students/trainingProof/unit' + req.query.nodeID + '.png';
    let path = 'users/upload/students/trainingProof/unit' + req.query.nodeID + '.pdf';
    let filename = path.replace("users/", "/");
    // shotimg.genImg(sqlstr, path, 700, 800);
    pdf.genPDF([sqlstr], [path], '96mm', '140mm', '', false, 0.5, false);

    //return publish file path
    sqlstr = "updateTrainingProof";
    //params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
    params = { classID: req.query.nodeID, filename: filename };
    //generate diploma data
    db.excuteProc(sqlstr, params, function (err, data) {
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      response = [filename];
      return res.send(response);
    });
  } else {
    response = [];
    return res.send(response);
  }
});

//22a. generate_refund_list
//status: 0 成功  9 其他  msg, filename
router.get('/generate_excel', function (req, res, next) {
  let filename = "";
  var title = "";
  if (req.query.classID > '') {
    //publish diploma on A4 with pdf
    //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));
    //sqlstr = "select * from dbo.getRefundList(@selList,@price)";
    if (req.query.tag == "generate_refund_list") {
      sqlstr = "select * from dbo.getRefundListByClass(@classID,@price)";
      params = { classID: req.query.classID, price: req.query.price };
      title = { "className": req.query.className, "date": req.query.date, "adviser": req.query.adviser, "teacher": req.query.teacher };
    }
    if (req.query.tag == "student_list_in_class") {
      sqlstr = "select * from dbo.getStudentListInClass(@classID,@row,@top)";
      params = { classID: req.query.classID, row: req.query.row, top: req.query.top };
      title = { "className": req.query.className, "date": req.query.date, "adviser": req.query.adviser, "teacher": req.query.teacher };
    }
    if (req.query.tag == "class_schedule") {
      sqlstr = "select * from v_classSchedule where classID=@classID and mark=@mark order by seq";
      params = { classID: req.query.classID, mark: req.query.keyID };
      title = eval('(' + req.query.pobj + ')');
    }
    if (req.query.tag == "standard_schedule") {
      sqlstr = "select * from v_schedule where courseID=@courseID order by seq";
      params = { courseID: req.query.classID };
      title = eval('(' + req.query.pobj + ')');
    }
    // console.log('the params:', params);
    db.excuteSQL(sqlstr, params, function (err, data) {
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      let arr = new Array();
      arr.push(data.recordset);
      //let path = 'users/upload/projects/templates/退费清单模板.xlsx';
      let path = 'users/upload/projects/templates/' + req.query.mark + '模板.xlsx';
      //generate diploma paper with pdf
      let path1 = 'users/upload/others/' + req.query.mark + '_' + Date.now() + '.xlsx';
      xlsxx.writeExcel({ "title": title, "list": data.recordset }, path, path1, function (fn) {
        //console.log('the class:',req.query.class);
        //return publish file path
        response = [fn];
        return res.send(response);
      });
    });
  } else {
    response = [];
    return res.send(response);
  }
});

// 从指定目录读取文件，写入题库表  小鹅通
router.post('/readQustionOther', function (req, res, next) {
  let path = 'users/upload/questions/others';
  //console.log(path);
  fs.readdir(path, function (err, files) {
    //err 为错误 , files 文件名列表包含文件夹与文件
    if (err) {
      console.log('error:\n' + err);
      return;
    }
    let i = 0;
    //console.log(1);
    files.forEach(function (file) {
      let q = fs.readFileSync(path + '/' + file, { encoding: 'utf8' });
      // console.log("file:",file);
      let arr = JSON.parse(q.replace(/\r\n/g,""));
      if(arr.length>0){
        // console.log("question1:",arr[1]);
        for(const x of arr){
          let answer = "";
          let items = ["","","","","",""];
          let items_id = ["","","","","",""];
          let questionName = x.content.replace("<p>","").replace("</p>","");
          let type = x.type;
          let kindID = type + 1;
          let memo = x.analysis.replace("<p>","").replace("</p>","");
          let answers = x.correct_answer;
          for(const a of answers){
            answer += (req.query.mark=="lx"?a:a[0]) + ",";   //练习["xxx","xxx"] 试卷[["xxx"],["xxx"]]
          }
          answer = answer.substring(0, answer.length-1);
          let k = 0;
          if(x.option){
            for(const option of x.option){
              items[k] = option.content.replace("<p>","").replace("</p>","");
              items_id[k] = option.id;
              k += 1;
            }
          }
          sqlstr = "addNewQuestionOther";
          // params = {mark:(req.query.mark=="lx"?file.replace(".txt",""):req.query.mark), knowPointID:'', kindID:kindID, questionName:questionName, answer:answer, memo:memo, A:items[0], B:items[1], C:items[2], D:items[3], E:items[4], F:items[5], id_A:items_id[0], id_B:items_id[1], id_C:items_id[2], id_D:items_id[3], id_E:items_id[4], id_F:items_id[5] };
          params = {mark:(req.query.mark=="lx"?file.replace(".txt",""):req.query.mark), knowPointID:'', kindID:kindID, questionName:questionName, answer:answer, memo:memo, A:items[0], B:items[1], C:items[2], D:items[3], E:items[4], F:items[5] };
         console.log("addNewQuestionOther params:",params);
          db.excuteProc(sqlstr, params, function (err, data) {
              if (err) {
                  console.log(err);
              }
          });
          i += 1;
        }
      }
    });
    response = [i];
    return res.send(response);
  });
});


// 从指定目录读取文件，写入题库表  小鹅通
router.post('/readQustionOther_xfgly', function (req, res, next) {
  let path = 'users/upload/questions/others';
  //console.log(path);
  fs.readdir(path, function (err, files) {
    //err 为错误 , files 文件名列表包含文件夹与文件
    if (err) {
      console.log('readQustionOther_xfgly error:\n' + err);
      return;
    }
    let i = 0;
    // console.log("files:", files);
    files.forEach(function (file) {
      let q = fs.readFileSync(path + '/' + file, { encoding: 'utf8' });
      // console.log("file:",file);
      // let arr = JSON.parse(q.replace(/\r\n/g,""));
      let arr = eval(q.replace(/\r\n/g,""));
      if(arr.length>0){
        // console.log("question1:",arr[1]);
        for(const x of arr){
          let answer = "";
          let items = ["","","","","",""];
          let items_id = ["","","","","",""];
          // let questionName = x.content.replace("<p>","").replace("</p>","");
          let questionName = x.content.replace(/<[^>]*>/g, '');   // 去除所有<>内容
          let type = x.type;
          let kindID = type + 1;
          let memo = x.analysis.replace("<p>","").replace("</p>","");
          let answers = x.correct_answer;
          for(const a of answers){
            answer += a + ",";   //练习["xxx","xxx"] 试卷[["xxx"],["xxx"]]
          }
          answer = answer.substring(0, answer.length-1);
          let k = 0;
          if(x.option){
            for(const option of x.option){
              items[k] = option.content.replace("<p>","").replace("</p>","");
              items_id[k] = option.id;
              k += 1;
            }
          }
          sqlstr = "addNewQuestionOther";
          params = {mark:(req.query.mark=="lx"?file.replace(".txt",""):req.query.mark), knowPointID:'', kindID:kindID, questionName:questionName, answer:answer, memo:memo, A:items[0], B:items[1], C:items[2], D:items[3], E:items[4], F:items[5], id_A:items_id[0], id_B:items_id[1], id_C:items_id[2], id_D:items_id[3], id_E:items_id[4], id_F:items_id[5] };
          // console.log(params);
          db.excuteProc(sqlstr, params, function (err, data) {
              if (err) {
                  console.log(err);
              }
          });
          i += 1;
        }
      }
    });
    response = [i];
    return res.send(response);
  });
});

//test
router.get('/compressImages', function (req, res, next) {
  let path = req.query.path;
  //console.log(path);
  fs.readdir(path, function (err, files) {
    //err 为错误 , files 文件名列表包含文件夹与文件
    if (err) {
      console.log('error:\n' + err);
      return;
    }
    let i = 0;
    //console.log(1);
    files.forEach(function (file) {
      //console.log("file:",file);
      fs.stat(path + '/' + file, function (err, stat) {
        if (err) { console.log(err); return; }
        if (!stat.isDirectory() && file.indexOf('.png') == -1 && stat.size > 100000) {
          // 如果是文件夹遍历
          //explorer(path + '/' + file);
          // 读出所有的文件
          //console.log('文件名:' + path + '/' + file);
          var name = path + '/' + file;
          var outName = name;
          i += 1;
          images(name)

            .save(outName, {               //Save the image to a file,whih quality 50
              quality: 50                    //保存图片到文件,图片质量为50
            });

        }
      });

    });
    response = [i];
    return res.send(response);

  });
});

//test
router.get('/compressImage', function (req, res, next) {
    let fn = req.query.fn;
    var obj = images(fn).size();
    let n = req.query.s || 2;   //缩小尺寸，默认一半
    images(fn).size(obj.width/n,obj.height/n).save(fn, {
        quality : req.query.q || 50                    //保存图片覆盖原文件,图片质量默认50
    });
    response = [i];
    return res.send(response);
});

/*
//status: 0 成功  9 其他  msg, filename
router.get('/rpt_daily_unit_course', function(req, res, next) {
    sqlstr = "rpt_dailyUnitCourse";
    params = {dateStart:req.query.dateStart, dateEnd:req.query.dateEnd};
    //console.log(params);
    //generate diploma data
    db.excuteProc(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      xlsx_free.writeExcel(data, function(fn){
        return res.send([fn]);
      });
    });
});*/

function genExcel(mark, title, rs) {
  //let path = 'users/upload/projects/templates/退费清单模板.xlsx';
  let path = 'users/upload/projects/templates/' + mark + '模板.xlsx';
  //generate diploma paper with pdf
  let path1 = 'users/upload/others/' + mark + '_' + Date.now() + '.xlsx';
  xlsxx.writeExcel({ "title": title, "list": rs }, path, path1, function (fn) {
    console.log('the file:', fn);
    //return publish file path
    return fn;
  });
}

function encodeCell(r, c) {
  return xlsx.utils.encode_cell({ r, c });
}

//删除指定一行  ws:wooksheet, index: 行号 0开始
function deleteRow(ws, index) {
  const range = xlsx.utils.decode_range(ws['!ref']);

  for (let row = index; row < range.e.r; row++) {
    for (let col = range.s.c; col <= range.e.c; col++) {
      ws[encodeCell(row, col)] = ws[encodeCell(row + 1, col)];
    }
  }

  range.e.r--;

  ws['!ref'] = xlsx.utils.encode_range(range.s, range.e);
}

//删除指定一列  ws:wooksheet, index: 列号 0开始
function deleteCol(ws, index) {
  const range = xlsx.utils.decode_range(ws['!ref']);

  for (let col = index; col < range.e.c; col++) {
    for (let row = range.s.r; row <= range.e.r; row++) {
      ws[encodeCell(row, col)] = ws[encodeCell(row, col + 1)];
    }
  }

  range.e.c--;

  ws['!ref'] = xlsx.utils.encode_range(range.s, range.e);
}

Date.prototype.Format = function (fmt) {
  //author:wangweizhen
  var o = {
    "M+": this.getMonth() + 1,                 //月份   
    "d+": this.getDate(),                    //日
    "h+": this.getHours(),                   //小时   
    "m+": this.getMinutes(),                 //分   
    "s+": this.getSeconds(),                 //秒   
    "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
    "S": this.getMilliseconds()             //毫秒   
  };
  if (/(y+)/.test(fmt))
    fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
  for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt))
      fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
  return fmt;
};

const changeDate = (timeNum, fmt) => {
  const d = timeNum - 1;
  const t = Math.round((d - Math.floor(d)) * 24 * 60 * 60);
  return moment(new Date(1900, 0, d, 0, 0, t)).format(fmt);
}
/*
Date.prototype.Format = function(formatStr)   
{   
    var str = formatStr;   
    var Week = ['日','一','二','三','四','五','六'];  
  
    str=str.replace(/yyyy|YYYY/,this.getFullYear());   
    str=str.replace(/yy|YY/,(this.getYear() % 100)>9?(this.getYear() % 100).toString():'0' + (this.getYear() % 100));   
  
    str=str.replace(/MM/,this.getMonth()>9?this.getMonth().toString():'0' + this.getMonth());   
    str=str.replace(/M/g,this.getMonth());   
  
    str=str.replace(/w|W/g,Week[this.getDay()]);   
  
    str=str.replace(/dd|DD/,this.getDate()>9?this.getDate().toString():'0' + this.getDate());   
    str=str.replace(/d|D/g,this.getDate());   
  
    str=str.replace(/hh|HH/,this.getHours()>9?this.getHours().toString():'0' + this.getHours());   
    str=str.replace(/h|H/g,this.getHours());   
    str=str.replace(/mm/,this.getMinutes()>9?this.getMinutes().toString():'0' + this.getMinutes());   
    str=str.replace(/m/g,this.getMinutes());   
  
    str=str.replace(/ss|SS/,this.getSeconds()>9?this.getSeconds().toString():'0' + this.getSeconds());   
    str=str.replace(/s|S/g,this.getSeconds());   
  
    return str;   
}*/

async function compressBase64(base64Data, size) {
  // 压缩图片，宽度300pix
  return sharp(new Buffer.from(base64Data, 'base64'))
    .resize({ width: size || 300 })
    .toBuffer()
    .then(data => { 
      return data;
    })
    .catch(err => { return ""; });
}

module.exports = router;

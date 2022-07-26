var express = require('express');
var router = express.Router();
var db = require("../utils/mssqldb");
var multer = require('multer');
var util = require('util');
var fs = require('fs');
var date = require("silly-datetime");
var images = require("images");

var response, sqlstr, params;
var uploadHome = './users/upload/';
var pdf = require("../utils/pdf");
var docx = require("../utils/docx");
let xlsxx = require('../utils/xlsx');
let xlsx = require('xlsx');
var zip = require("../utils/zip");
const { array } = require('pizzip/js/support');
var upID = "", key = "", mark = "", currUser = "", host = "", today = date.format(new Date(),'YYYY-MM-DD');
var env = process.env.NODE_ENV_BACKEND;

var createFolder = function(folder){
  try{
      fs.accessSync(folder); 
  }catch(e){
      fs.mkdirSync(folder);
  }  
};
/* GET home page. */
router.get('/', function(req, res, next) {
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
    switch(upID){
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
    switch(upID){
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
      default:
        fn = file.originalname;
        fn = fn.substr(0,fn.lastIndexOf(".")) + '-' + Date.now();
        key = req.query.username;
    }
    cb(null, fn + "." + filenameArr[filenameArr.length-1]);
  }
});

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
    switch(upID){
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
    key = fn.substr(0,fn.lastIndexOf("."));
    cb(null, fn);
  }
});

var uploadMultiple = multer({ 
  storage: storageMultiple
});


//5a. uploadSingle
router.post('/uploadSingle', upload.single('avatar'), async function(req, res, next) {
  //console.log("req.query.upID:", req.query.upID);
  var file = req.file;
  response = {"status":0, msg:"", "file":"", "count":0, "err_msg":"", "exist_msg":""}
  if (req.file.length === 0 || file == undefined) {  //判断一下文件是否存在，也可以在前端代码中进行判断。
    res.render({"status":0, msg: "上传文件不能为空！"});
    return;
  }
  //console.log('文件类型：%s', file.mimetype);
  //console.log('原始文件名：%s', file.originalname);
  //console.log('文件大小：%s', file.size);
  //console.log('文件保存路径：%s', file.path);

  //console.log("file:", file);
  response.file = file.path.substr(file.path.indexOf("\\"));
  response.count = 1;
  sqlstr = "setUploadSingleFileLink";
  let register = key;
  if(currUser>""){
    register = currUser;
  }
  params = {"upID":upID, "key":key, "file":response.file, "multiple":0, "registerID":register};
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    response.count = 1;
  });

  //deal xlsx  学员注册
  if(upID == "student_list"){
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    var data1 =xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let pn = "";
    let mn = "";
    let r_err = 0;
    let r_exist = 0;
    let r_existOther = 0;
    let r_err_msg = "";
    let r_exist_msg = "";
    let r_existOther_msg = "";
    let idx = 0;
    data1.forEach(function(val){
      pn = val["电话"];
      if(typeof(pn) == "undefined"){
        pn = '';
      }
      mn = val["手机"];
      if(typeof(mn) == "undefined"){
         mn = '';
      }
      sqlstr = "generateStudent";
      params = {"username":val["身份证"].replace(/\s+/g,""), "name":val["姓名"].replace(/\s+/g,""), "dept1Name":val["部门"], "job":val["工种"], "mobile": ""+mn, "phone":""+pn, "education":val["文化程度"], "memo":val["备注"], "classID":key, "registerID":currUser};
      //console.log("params:", params);
      db.excuteProc(sqlstr, params, function(err, data){
        if (err) {
          console.log(err);
          let response = {"status":9};
          return res.send(response);
        }
        if(data.recordset[0]["err"]==1){
          r_err += data.recordset[0]["err"];
          r_err_msg += val["姓名"].replace(/\s+/g,"") + " " + val["身份证"].replace(/\s+/g,"") + "  ";
        }
        if(data.recordset[0]["exist"]==1){
          r_exist += data.recordset[0]["exist"];
          r_exist_msg += val["姓名"].replace(/\s+/g,"") + "  ";
        }
        if(data.recordset[0]["existOther"]==1){
          r_existOther += data.recordset[0]["existOther"];
          r_existOther_msg += val["姓名"].replace(/\s+/g,"") + "  ";
        }
        //console.log("data:",data.recordset[0],"idx:",idx);
        idx += 1;
        if(idx==data1.length){
          response.count = data1.length - r_err - r_exist - r_existOther;
          response.err_msg = r_err_msg>""?"身份证号码错误，未导入：" + r_err_msg:"";
          r_exist_msg = r_exist_msg>""?"学员已在本班级，未导入：" + r_exist_msg:"";
          response.exist_msg = r_existOther_msg>""?r_exist_msg + " 学员已在其他班级，未导入：" + r_existOther_msg:r_exist_msg;
          //console.log("res1:",response);
          return res.send(response);
        }
      });
    });
  }

  //deal xlsx 成绩单
  if(upID == "score_list"){
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    var data1 =xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let score = 0;
    let un = "";
    data1.forEach(val=>{
      sqlstr = "generateScore";
      //params = {"batchID":key, "username":val["身份证"], "certID":val["认证项目"], "score":""+val["成绩"], "startDate":val["发证日期"], "term": val["期限"], "diplomaID":""+val["证书编号"], "memo":val["备注"], "host":host, "registerID":currUser};
      score = val["成绩"];
      un = val["身份证"];

      if(typeof(score) == "undefined"){
        score = '';
      }
      if(typeof(un) == "undefined"){
        un = '';
      }
      params = {"batchID":key, "passNo":String(val["考生标识"]), "username":un, "name":String(val["姓名"]), "score":String(score)};
      //console.log("params:", params);
      db.excuteProc(sqlstr, params, function(err, data){
        if (err) {
          console.log(err);
          let response = {"status":9};
          return res.send(response);
        }
      });
    });
    response.count = data1.length;
    return res.send(response);
  }

  //deal xlsx 申报结果导入
  if(upID == "apply_list"){
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    //console.log(sheet["A1"].v);
    while(sheet["A1"].v != "学号"){
      deleteRow(sheet,0); //删除第表头
    }
    /*
    deleteRow(sheet,0); //删除第1行
    deleteRow(sheet,0); //删除第2行
    deleteRow(sheet,0); //删除第3行
    deleteRow(sheet,0); //删除第4行
    deleteRow(sheet,0); //删除第5行
    deleteRow(sheet,0); //删除第6行
    deleteRow(sheet,0); //删除第7行
    */
    //第8行是列标题
    var data1 =xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let un = "";
    let dt = "";
    let n = data1.length;
    let m = 0;
    data1.forEach(val=>{
      sqlstr = "generateApply";
      //params = {"batchID":key, "username":val["证件号码"], "certID":val["认证项目"], "score":""+val["成绩"], "startDate":val["发证日期"], "term": val["期限"], "diplomaID":""+val["证书编号"], "memo":val["备注"], "host":host, "registerID":currUser};
      un = val["证件号码"];
      if(String(val["考试时间"]).slice(0,3) != "202"){
        dt = new Date(new Date("1900-01-01").getTime() + (val["考试时间"] - 2) * 3600*24*1000 - 3600*8*1000 + 60*1000); 
        dt = dt.Format("yyyy-MM-dd hh:mm");
      }else{
        dt = val["考试时间"];
      }

      if(typeof(un) == "undefined"){
        un = '';
      }
      
      params = {"batchID":key, "passNo":String(val["考核号"]), "username":un.replace(/\s+/g,""), "name":String(val["姓名"]), "examDate":dt};
      //console.log("params:", params);
      db.excuteProc(sqlstr, params, function(err, data){
        if (err) {
          console.log(err);
          let response = {"status":9};
          return res.send(response);
        }
      });
      m += 1;
      if(m==n){
        //处理完名单后，删除申报未通过的人
        sqlstr = "dealGenerateApply";
        params = {"batchID":key, "registerID":currUser};
        db.excuteProc(sqlstr, params, function(err, data2){
          if (err) {
            console.log(err);
            let response = {"status":9};
            return res.send(response);
          }
        });
      }
    });
    
    response.count = data1.length;
    return res.send(response);
  }

  //deal xlsx 申报成绩证书导入
  if(upID == "apply_score_list"){
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    deleteRow(sheet,0); //删除第1行
    deleteRow(sheet,0); //删除第2行
    deleteRow(sheet,0); //删除第3行
    deleteRow(sheet,0); //删除第4行
    deleteRow(sheet,0); //删除第5行
    //第6行是列标题
    var data1 =xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let un = "";
    let up = "";
    let score1 = "";
    let score2 = "";
    let pn = "";
    let n = data1.length;
    let m = 0;
    let arr = "";
    data1.forEach(val=>{
      sqlstr = "generateApplyScore";
      arr = Object.values(val);
      //params = {"batchID":key, "username":val["证件号码"], "certID":val["认证项目"], "score":""+val["成绩"], "startDate":val["发证日期"], "term": val["期限"], "diplomaID":""+val["证书编号"], "memo":val["备注"], "host":host, "registerID":currUser};
      un = val["或其他证件号码"];
      //up = val["上传"];
      up = arr[9];
      score1 = val["应知"];
      score2 = val["应会"];
      pn = arr[9];

      if(typeof(un) == "undefined"){
        un = '';
      }
      if(typeof(up) == "undefined"){
        up = '';
      }
      if(typeof(pn) == "undefined"){
        pn = '';
      }
      if(typeof(up) == "undefined"){
        up = '';
      }
      if(typeof(score1) == "undefined" || parseFloat(score1).toString() == "NaN"){
        score1 = '';
      }
      if(typeof(score2) == "undefined" || parseFloat(score2).toString() == "NaN"){
        score2 = '';
      }
      
      //params = {"batchID":key, "passNo":String(val["操作证号码"]), "username":un, "name":String(val["姓名"]), "pass":up, "score1":score1, "score2":score2};
      params = {"batchID":key, "passNo":pn.replace(/\s+/g,""), "username":un.replace(/\s+/g,""), "name":arr[3], "pass":up, "score1":score1, "score2":score2, "startDate":req.query.para, "registerID":currUser};
      //console.log("params:", params);
      
      db.excuteProc(sqlstr, params, function(err, data){
        if (err) {
          console.log(err);
          let response = {"status":9};
          return res.send(response);
        }
      });
      m += 1;
      if(m==n){
        //处理完名单后，填写发证日期
        sqlstr = "setGenerateApplyIssue";
        params = {"batchID":key, "startDate":req.query.para, "registerID":currUser};
        db.excuteProc(sqlstr, params, function(err, data2){
          if (err) {
            console.log(err);
            let response = {"status":9};
            return res.send(response);
          }
        });
      }
      
    });
    
    response.count = data1.length;
    return res.send(response);
  }

  //deal xlsx 预报名名单
  if(upID == "ref_student_list"){
    //console.log("file:", file.path);
    //先删除以前的名单
    sqlstr = "delRefStudent";
    params = {"batchID":key};
    db.excuteProc(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        let response = {"status":9};
        return res.send(response);
      }
    });
    
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表名
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表名得到表对象
    if(sheet['A1'] != '序号'){
      deleteRow(sheet,0); //删除第一行(标题)
    }
    var data1 =xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    let phone = "";
    let un = "";
    let ex = "";
    data1.forEach(val=>{
      sqlstr = "generateRefStudent";
      phone = val["手机"];
      un = val["身份证号码"];
      ex = val["证书有效期"];

      if(typeof(phone) == "undefined"){
        phone = '';
      }
      if(typeof(un) == "undefined"){
        un = '';
      }
      if(typeof(ex) == "undefined"){
        ex = '';
      }
      params = {"batchID":key, "ID":String(val["序号"]), "dept1":val["公司"], "dept2":val["加油站名称"], "name":val["姓名"], "username":un, "education":val["文化程度"], "job":val["岗位"], "mobile":String(phone), "expireDate":String(ex), "memo":val["备注"], "invoice":val["开票信息"]};
      //console.log("params:", params);
      db.excuteProc(sqlstr, params, function(err, data){
        if (err) {
          console.log(err);
          let response = {"status":9};
          return res.send(response);
        }
      });
    });
    response.count = data1.length;
    return res.send(response);
  }
  //console.log(response);
});

router.post('/uploadMultiple', uploadMultiple.array('avatar',1000), function(req, res, next) {
  //console.log("req.query.upID:", req.query.upID);
  var files = req.files;
  response = {"status":0, msg:"", "file":"", "count":0}
  if (req.files.length === 0) {  //判断一下文件是否存在，也可以在前端代码中进行判断。
    res.render({"status":1, msg: "上传文件不能为空！"});
    return;
  }
  //生成上传记录
  sqlstr = "generateMaterial";
  params = {"kindID":upID, "qty":req.files.length, "host":host, "registerID":currUser};
  response.count = req.files.length;
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    let batchID = data.returnValue;
    //console.log(data);
    if(batchID > 0){
      for (var i in files) {
        let file = files[i];
        let fn = file.filename;
        sqlstr = "setUploadSingleFileLink";
        params = {"upID":upID, "key":fn.substr(0,fn.lastIndexOf(".")), "file":file.path.substr(file.path.indexOf("\\")), "multiple":batchID};
        //console.log("params:", params);
        db.excuteProc(sqlstr, params, function(err, data){
          if (err) {
            console.log(err);
            let response = {"status":9};
            return res.send(response);
          }
        });
      }
    }
  });
  
  res.send(response);
});

router.post('/uploadBase64img', function(req, res, next) {
  //console.log("req.query.upID:", req.query.upID);
    //接收前台POST过来的base64
    var imgData = req.body.imgData;
    //过滤data:URL
    var uploadFolder = "";
    var fn = "";
    upID = req.body.upID;
    currUser = req.body.currUser;
    switch(upID){
      case "student_photo":
        uploadFolder = "students/photos/";
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
    fn = uploadFolder + fn + ".png";

    var base64Data = imgData.replace(/^data:image\/\w+;base64,/, "");
    var dataBuffer = Buffer.from(base64Data, 'base64');
    fs.writeFile(fn, dataBuffer, function(err) {
        if(err){
          res.send(err);
        }else{
          //res.send("保存成功！");
          fn = fn.replace("./users","");
          //response.count = 1;
          sqlstr = "setUploadSingleFileLink";
          params = {"upID":upID, "key":req.body.username, "file":fn, "multiple":0, "registerID":currUser};
          //console.log("params:", params);
          db.excuteProc(sqlstr, params, function(err, data){
            if (err) {
              console.log(err);
              let response = {"status":9};
              return res.send(response);
            }
            //response.count = 1;
          });
          
          res.send({"status":0});
        }
    });
});

//22. generate_diploma_byCertID
//status: 0 成功  9 其他  msg, filename
router.get('/generate_diploma_byCertID', function(req, res, next) {
  sqlstr = "generateDiplomaByCertID";
  params = {certID:req.query.certID, batchID:req.query.batchID, selList:req.query.selList, selList1:req.query.selList1, host:req.query.host, registerID:req.query.username};
  //console.log(params);
  //generate diploma data
  let response = [];
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    let batchID = data.returnValue;
    //console.log(data,":",batchID);
    let filename = "";
    if(batchID > 0){
      sqlstr = "select *,'No.' as diplomaNo from v_diplomaInfo where type=1 and batchID=" + batchID;   //企业内证书
      params = {};
      db.excuteSQL(sqlstr, params, function(err, data1){
        if (err) {
          console.log(err);
          response = [];
          return res.send(response);
        }
        let pages = [];
        let paths = [];
        //generate diploma paper with pdf
        for (var i in data1.recordset){
          let str = [data1.recordset[i]["name"],data1.recordset[i]["certName"],data1.recordset[i]["diplomaID"],data1.recordset[i]["dept1Name"],data1.recordset[i]["job"],data1.recordset[i]["startDate"],data1.recordset[i]["term"],data1.recordset[i]["title"],data1.recordset[i]["photo_filename"],data1.recordset[i]["logo"],data1.recordset[i]["certID"],data1.recordset[i]["host"],data1.recordset[i]["stamp"]];
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
    }else{
      response = [];
      return res.send(response);
    }
  });
});

//22. generate_diploma_byClassID
//status: 0 成功  9 其他  msg, filename
router.post('/generate_diploma_byClassID', function(req, res, next) {
  sqlstr = "updateGenerateDiplomaInfo";
  //@ID int,@classID varchar(50), @selList varchar(4000),@printed int,@printDate varchar(50),@delivery int,@deliveryDate varchar(50),@host nvarchar(50),@memo nvarchar(500),@registerID varchar(50)
  params = {ID:req.query.ID, certID:req.query.certID, selList:req.body.selList, startDate:req.query.startDate, class_startDate:req.query.class_startDate, class_endDate:req.query.class_endDate, printed:0, printDate:'', delivery:0, deliveryDate:'', host:'', memo:'', registerID:req.query.registerID};
  //console.log(params);
  //generate diploma data
  let response = [];
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    let batchID = data.returnValue;
    //console.log(data,":",batchID);
    let filename = "";
    if(batchID > 0){
      //sqlstr = "select * from v_diplomaInfo where batchID=" + batchID;   //证书
      sqlstr = "getDiplomaListByBatchID";
      params = {batchID:batchID};
      db.excuteProc(sqlstr, params, function(err, data1){
        if (err) {
          console.log(err);
          response = [];
          return res.send(response);
        }
        let arr = new Array();
        let certID = '';
        let pW1 = '180mm';
        let pH1 = '265mm';
        let pW2 = '210mm';
        let pH2 = '297mm';
        let pages = [];
        let paths = [];
        certID = data1.recordset[0]["certID"];
        if(certID == "C2" || certID=="C30" || certID=="C31" || certID == "C18" || certID == "C19"){
          certID = "C2";
        }else{
          pW1 = '280mm';
          pH1 = '180mm';
          pW2 = '178mm';
          pH2 = '123mm';
          certID = "C1";
        }

        //generate diploma paper with pdf
        for (var i in data1.recordset){
          let str = [data1.recordset[i]["diplomaID"],data1.recordset[i]["name"],data1.recordset[i]["username"],data1.recordset[i]["certID"],data1.recordset[i]["certName"],data1.recordset[i]["hostName"],data1.recordset[i]["job"],data1.recordset[i]["startDate"],data1.recordset[i]["endDate"],data1.recordset[i]["title"],data1.recordset[i]["photo_filename"],data1.recordset[i]["term"],data1.recordset[i]["sexName"],data1.recordset[i]["diplomaNo"],data1.recordset[i]["educationName"],data1.recordset[i]["class_startDate"],data1.recordset[i]["class_endDate"]];
          sqlstr = env + "/pdf_" + certID + ".asp?kindID=" + (str.join(","));
          //console.log(str.join(","));
          let path = 'users/upload/students/diplomas/' + data1.recordset[i]["diplomaID"] + '.pdf';
          //console.log('path',path);
          pages.push(sqlstr);
          paths.push(path);
          //pdf.genPDF(sqlstr, path, pW1, pH1, '1', false, 1, false);
        }
        pdf.genPDF(pages, paths, pW1, pH1, '1', false, 1, true);
        //publish diploma on A4 with pdf
        //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));

        sqlstr = env + "/pdfs_diploma_" + certID + ".asp?refID=" + batchID + "&kindID=" + req.query.kindID;
        let path = 'users/upload/students/diplomaPublish/' + batchID + '.pdf';
        //************ */ card diploma style
        //*pW2 = '86mm';
        //*pH2 = '54mm';
        //sqlstr = env + "/pdfs_diploma_C1_card.asp?refID=" + batchID;
        //let path = 'users/upload/students/diplomaPublish/' + batchID + '1.pdf';
        //************ */

        filename = path;
        //pdf.genPDF(sqlstr, path, pW2, pH2, '', false, 0.5, false);
        pdf.genPDF([sqlstr], [path], pW2, pH2, '', false, 0.5, false);
        //console.log('the path:',path);
        //return publish file path
        response = [batchID];
        return res.send(response);
      });
    }else{
      response = [];
      return res.send(response);
    }
  });
});

//22a. generate_student_photos
//status: 0 成功  9 其他  msg, filename
//kindID: 0 照片  1 身份证正面  2 身份证背面  3 学历证书  4 其他证书
router.get('/generate_student_photos', function(req, res, next) {
  let response = [];
  let filename = "";
  sqlstr = env + "/pdfs_student_photos.asp?item=" + req.query.item + "&kindID=" + req.query.kindID;
  //sqlstr = env + "/pdf1.asp?kindID=" + req.query.kindID;
  //console.log(sqlstr);
  let path = 'users/public/temp/student_photos_' + Date.parse( new Date() ).toString() + '.pdf';
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
router.get('/generate_entryform_byProjectID', function(req, res, next) {
  let projectID = req.query.projectID;
  let certID = req.query.certID;
  let path1 = 'users/upload/projects/templates/entry_form_' + certID + '.docx';
  let path2 = 'users/upload/projects/entryforms/培训报名表[' + projectID + '].docx';
  var arr = new Array();
  sqlstr = "select a.*,(case when b.SNo=0 then '' else cast(b.SNo as varchar) end) as SNo,b.ID as enterID from v_studentInfo a, studentCourseList b where a.username=b.username and b.checked=1 and b.projectID='" + projectID + "'";   //获取指定招生批次下的已确认名单
  params = {};
  db.excuteSQL(sqlstr, params, function(err, data1){
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    //generate entry form to a single file for every student.
    for (var i in data1.recordset){
      params = {ID:data1.recordset[i]["username"], name:data1.recordset[i]["name"], SNo:data1.recordset[i]["SNo"], sex:data1.recordset[i]["sexName"], birthday:data1.recordset[i]["birthday"], age:data1.recordset[i]["age"], host:data1.recordset[i]["hostName"], dept1:data1.recordset[i]["dept1Name"], dept2:data1.recordset[i]["dept2Name"], job:data1.recordset[i]["job"], education:data1.recordset[i]["educationName"], phone:data1.recordset[i]["phone"], mobile:data1.recordset[i]["mobile"], imgPhoto:"users" + data1.recordset[i]["photo_filename"], imgIDa:"users" + data1.recordset[i]["IDa_filename"], imgID:"users" + data1.recordset[i]["IDa_filename"], imgEdu:"users" + data1.recordset[i]["edu_filename"], address:'', date:today};
      //console.log(params);
      let path0 = 'users/upload/projects/entryforms/projectID' + data1.recordset[i]["enterID"] + '.docx';
      arr.push(path0);
      docx.writeDoc(params, path1, path0);
    }
    //merge all the single file to one big file, and delete them after merging.
    //console.log(arr);
    docx.mergeDocx(arr,path2);
    //link the filename to the project
    sqlstr = "setUploadSingleFileLink";
    path2 = path2.substr(path2.indexOf("\/"));
    params = {"upID":'project_entryform', "key":projectID, "file":path2, "multiple":0, "registerID":req.query.registerID};
    //console.log("params:", params);
    db.excuteProc(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        let response = {"status":9};
        return res.send(response);
      }
      response.count = 1;
    });
    //give student no for every student of the project
    sqlstr = "setProjectStudentNo";
    params = {"projectID":projectID, "username":req.query.registerID};
    //console.log("params:", params);
    db.excuteProc(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        let response = {"status":9};
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
router.get('/generate_entryform', function(req, res, next) {
  let enterID = req.query.enterID;
  let certID = req.query.certID;
  let path1 = 'users/upload/projects/templates/entry_form_' + certID + '.docx';
  var arr = new Array();
  sqlstr = "select a.*,(case when b.SNo=0 then '' else cast(b.SNo as varchar) end) as SNo,b.ID as enterID from v_studentInfo a, studentCourseList b where a.username=b.username and b.ID=" + enterID;   //获取指定报名表信息
  params = {};
  db.excuteSQL(sqlstr, params, function(err, data1){
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    //generate entry form to a single file for every student.
    var i = 0;
      params = {ID:data1.recordset[i]["username"], name:data1.recordset[i]["name"], SNo:data1.recordset[i]["SNo"], sex:data1.recordset[i]["sexName"], birthday:data1.recordset[i]["birthday"], age:data1.recordset[i]["age"], host:data1.recordset[i]["hostName"], dept1:data1.recordset[i]["dept1Name"], dept2:data1.recordset[i]["dept2Name"], job:data1.recordset[i]["job"], education:data1.recordset[i]["educationName"], phone:data1.recordset[i]["phone"], mobile:data1.recordset[i]["mobile"], imgPhoto:"users" + data1.recordset[i]["photo_filename"], imgIDa:"users" + data1.recordset[i]["IDa_filename"], imgID:"users" + data1.recordset[i]["IDa_filename"], imgEdu:"users" + data1.recordset[i]["edu_filename"], address:'', date:today};
      //console.log(params);
      let path0 = 'users/upload/projects/entryforms/projectID' + data1.recordset[i]["enterID"] + '.docx';
      docx.writeDoc(params, path1, path0);
    //merge all the single file to one big file, and delete them after merging.
    //console.log(arr);
    //link the filename to the enter
    sqlstr = "setUploadSingleFileLink";
    path0 = path0.substr(path0.indexOf("\/"));
    params = {"upID":'enter_entryform', "key":enterID, "file":path0, "multiple":0, "registerID":req.query.registerID};
    //console.log("params:", params);
    db.excuteProc(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        let response = {"status":9};
        return res.send(response);
      }
      response.count = 1;
    });
    
    //return file path
    response = [path0];
    return res.send(response);
  });
});

//22. generate_diploma_byCertID
//status: 0 成功  9 其他  msg, filename
//mark: 0 生成准考证  1 保存信息
router.get('/generate_passcard_byClassID', function(req, res, next) {
  sqlstr = "updateGeneratePasscardInfo";
  params = {mark:req.query.mark, ID:req.query.ID, classID:req.query.classID, selList:req.query.selList, title:req.query.title, startNo:req.query.startNo, startDate:req.query.startDate, startTime:req.query.startTime, address:req.query.address, notes:req.query.notes, memo:req.query.memo, registerID:req.query.username};
  //console.log(params);
  //generate diploma data
  let response = [];
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    let batchID = data.returnValue;
    //console.log(data,":",batchID);
    let filename = "";
    if(batchID > 0 && req.query.mark==0){
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
      params = {ID:batchID, filename:filename.replace("users/","/")};
      //console.log(params);
      //generate diploma data
      let response = [];
      db.excuteProc(sqlstr, params, function(err, data){
        if (err) {
          console.log(err);
          response = [];
          return res.send(response);
        }
        response = [batchID];
        return res.send(response);
      });
    }else{
      response = [];
      return res.send(response);
    }
  });
});

//22. generate_diploma_byCertID
//status: 0 成功  9 其他  msg, filename
//mark: 0 生成准考证  1 保存信息
router.get('/generate_passcard_byExamID', function(req, res, next) {
  sqlstr = "setPassNo4Exam";
  params = {examID:req.query.ID, registerID:req.query.username};
  //console.log(params);
  //generate diploma data
  let response = [];
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    let batchID = req.query.ID;
    //console.log(data,":",batchID);
    let filename = "";
    if(batchID > 0 && req.query.mark==0){
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
      params = {ID:batchID, filename:filename.replace("users/","/")};
      //console.log(params);
      //generate diploma data
      let response = [];
      db.excuteProc(sqlstr, params, function(err, data){
        if (err) {
          console.log(err);
          response = [];
          return res.send(response);
        }
        response = [batchID];
        return res.send(response);
      });
    }else{
      response = [];
      return res.send(response);
    }
  });
});

//22a. generate_fireman_materials
//status: 0 成功  9 其他  msg, filename
router.get('/generate_fireman_materials', function(req, res, next) {
    let filename = "";
    let filename1 = "";
    if(req.query.enterID > 0){
      //publish diploma on A4 with pdf
      //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));
      sqlstr = env + "/pdfs_fireman.asp?item=" + req.query.username + "&refID=0";
      let path = 'users/upload/students/firemanMaterials/' + req.query.username + '_' + req.query.enterID + '证明材料.pdf';
      filename = path.replace("users/","/");
      pdf.genPDF([sqlstr], [path], '210mm', '297mm', '', false, 1, false);
      
      sqlstr = env + "/pdf_entryform_C20.asp?nodeID=" + req.query.enterID;
      let path1 = 'users/upload/students/firemanMaterials/' + req.query.username + '_' + req.query.enterID + '报名表.pdf';
      filename1 = path1.replace("users/","/");
      pdf.genPDF([sqlstr], [path1], '210mm', '297mm', '', false, 0.5, false);
      //console.log('the path:',path);
      //return publish file path
      sqlstr = "updateFiremanMaterials";
      //params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
      params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
      //console.log(params);
      //generate diploma data
      db.excuteProc(sqlstr, params, function(err, data){
        if (err) {
          console.log(err);
          response = [];
          return res.send(response);
        }
        response = [filename];
        return res.send(response);
      });
    }else{
      response = [];
      return res.send(response);
    }
});

//22a. generate_IDcard_materials
//status: 0 成功  9 其他  msg, filename
router.get('/generate_IDcard_materials', function(req, res, next) {
  let filename = "";
  if(req.query.username > ""){
    //publish diploma on A4 with pdf
    //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));
    sqlstr = env + "/pdfs_fireman.asp?item=" + req.query.username + "&refID=1";
    let path = 'users/upload/students/IDcardMaterials/' + req.query.username + '身份证正反面.pdf';
    filename = path.replace("users/","/");
    pdf.genPDF([sqlstr], [path], '210mm', '297mm', '', false, 1, false);
    sqlstr = "updateIDcardsMaterials";
    //params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
    params = {username:req.query.username, filename:filename};
    //console.log(params);
    //generate diploma data
    db.excuteProc(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      response = [filename];
      return res.send(response);
    });
  }else{
    response = [];
    return res.send(response);
  }
});

//22b. generate_fireman_zip
//status: 0 成功  9 其他  msg, filename
router.get('/generate_fireman_zip', function(req, res, next) {
  let filename = "";
  if(req.query.enterID > 0){
    let path = 'users/upload/students/firemanMaterials/' + req.query.username + '_' + req.query.enterID + '.zip';
    filename = path.replace("users/","/");
    var p = [];
    sqlstr = "select * from v_firemanEnterInfo where enterID=@enterID";   //获取指定招生批次下的已确认名单
    params = {enterID:req.query.enterID};
    db.excuteSQL(sqlstr, params, function(err, data1){
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      if(data1.recordset[0]["photo_filename"]>""){
        p.push("users" + data1.recordset[0]["photo_filename"]);
      }
      if(data1.recordset[0]["IDa_filename"]>""){
        p.push("users" + data1.recordset[0]["IDa_filename"]);
      }
      if(data1.recordset[0]["materials"]>""){
        p.push("users" + data1.recordset[0]["materials"]);
      }
      if(data1.recordset[0]["materials1"]>""){
        p.push("users" + data1.recordset[0]["materials1"]);
      }
      p.push('users/upload/projects/ref/消防行业职业技能鉴定考生报名指导手册.docx');
      p.push('users/upload/projects/ref/消防行业职业技能鉴定考生报名过程演示.mp4');
      //zip.doZIP([path,path1,'users/upload/projects/ref/消防行业职业技能鉴定考生报名指导手册.docx','users/upload/projects/ref/消防行业职业技能鉴定考生报名过程演示.mp4'],path2);
      zip.doZIP(p,path);
    });
    //console.log('the path:',path);
    //return publish file path
    sqlstr = "updateFiremanZip";
    //params = {enterID:req.query.enterID, filename:filename, filename1:filename1};
    params = {enterID:req.query.enterID, zip:filename};
    //console.log(params);
    //generate diploma data
    db.excuteProc(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        response = [];
        return res.send(response);
      }
      response = [filename];
      return res.send(response);
    });
  }else{
    response = [];
    return res.send(response);
  }
});

//22a. generate_refund_list
//status: 0 成功  9 其他  msg, filename
router.get('/generate_excel', function(req, res, next) {
  let filename = "";
  var title = "";
  if(req.query.classID > ''){
    //publish diploma on A4 with pdf
    //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));
    //sqlstr = "select * from dbo.getRefundList(@selList,@price)";
    if(req.query.tag=="generate_refund_list"){
      sqlstr = "select * from dbo.getRefundListByClass(@classID,@price)";
      params = {classID:req.query.classID, price:req.query.price};
      title = {"className":req.query.className, "date":req.query.date, "adviser":req.query.adviser, "teacher":req.query.teacher};
    }
    if(req.query.tag=="student_list_in_class"){
      sqlstr = "select * from dbo.getStudentListInClass(@classID,@row,@top)";
      params = {classID:req.query.classID, row:req.query.row, top:req.query.top};
      title = {"className":req.query.className, "date":req.query.date, "adviser":req.query.adviser, "teacher":req.query.teacher};
    }
    if(req.query.tag=="class_schedule"){
      sqlstr = "select * from v_classSchedule where classID=@classID";
      params = {classID:req.query.classID};
      title = eval('(' + req.query.pobj + ')');
    }
    db.excuteSQL(sqlstr, params, function(err, data){
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
      xlsxx.writeExcel({"title":title, "list":data.recordset},path,path1,function(fn){
        //console.log('the class:',req.query.class);
        //return publish file path
        response = [fn];
        return res.send(response);
      });
    });
  }else{
    response = [];
    return res.send(response);
  }
});

router.get('/form', function(req, res, next){
  var form = fs.readFileSync('./form.html', {encoding: 'utf8'});
  res.send(form);
});

//test
router.get('/compressImages', function(req, res, next) {
  let path = req.query.path;
  //console.log(path);
  fs.readdir(path, function(err, files){
    //err 为错误 , files 文件名列表包含文件夹与文件
        if(err){
            console.log('error:\n' + err);
            return;
        }
        let i = 0;
        //console.log(1);
        files.forEach(function(file){
            //console.log("file:",file);
            fs.stat(path + '/' + file, function(err, stat){
                if(err){console.log(err); return;}
                if(!stat.isDirectory() && file.indexOf('.png') == -1 && stat.size>100000){                 
                    // 如果是文件夹遍历
                    //explorer(path + '/' + file);
                    // 读出所有的文件
                    //console.log('文件名:' + path + '/' + file);
                    var name = path + '/' + file;
                    var outName = name;
                    i += 1;
                    images(name)

                        .save(outName, {               //Save the image to a file,whih quality 50
                                quality : 50                    //保存图片到文件,图片质量为50
                            });

                }               
            });

        });
        response = [i];
        return res.send(response);
    
    });
});

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

Date.prototype.Format = function(fmt)   
{ 
//author:wangweizhen
  var o = {   
    "M+" : this.getMonth()+1,                 //月份   
    "d+" : this.getDate(),                    //日
    "h+" : this.getHours(),                   //小时   
    "m+" : this.getMinutes(),                 //分   
    "s+" : this.getSeconds(),                 //秒   
    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
    "S"  : this.getMilliseconds()             //毫秒   
  };   
  if(/(y+)/.test(fmt))   
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
  for(var k in o)   
    if(new RegExp("("+ k +")").test(fmt))   
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
  return fmt;   
}; 

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
  
module.exports = router;

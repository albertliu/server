var express = require('express');
var router = express.Router();
var db = require("../utils/mssqldb");
var multer = require('multer');
var util = require('util');
var fs = require('fs');
var date = require("silly-datetime");
let xlsx = require('xlsx');

var response, sqlstr, params;
var uploadHome = './users/upload/';
var pdf = require("../utils/pdf");
var docx = require("../utils/docx");
var upID = "", key = "", mark = "", currUser = "", host = "", today = date.format(new Date(),'YYYY-MM-DD');

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
router.post('/uploadSingle', upload.single('avatar'), function(req, res, next) {
  //console.log("req.query.upID:", req.query.upID);
  var file = req.file;
  response = {"status":0, msg:"", "file":"", "count":0}
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
  params = {"upID":upID, "key":key, "file":response.file, "multiple":0, "registerID":key};
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    response.count = 1;
  });

  //deal xlsx
  if(upID == "student_list"){
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    var data1 =xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    data1.forEach(val=>{
      sqlstr = "generateStudent";
      params = {"username":val["身份证"], "name":val["姓名"], "dept1Name":val["部门"], "job":val["工种"], "mobile": ""+val["手机"], "phone":""+val["电话"], "email":""+val["邮箱"], "memo":val["备注"], "host":host, "certID":val["报名课程"], "registerID":currUser, "mark":val["更新"]};
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
  }

  //deal xlsx
  if(upID == "score_list"){
    //console.log("file:", file.path);
    let workbook = xlsx.readFile(file.path); //workbook就是xls文档对象
    let sheetNames = workbook.SheetNames; //获取表明
    let sheet = workbook.Sheets[sheetNames[0]]; //通过表明得到表对象
    var data1 =xlsx.utils.sheet_to_json(sheet); //通过工具将表对象的数据读出来并转成json
    data1.forEach(val=>{
      sqlstr = "generateScore";
      params = {"batchID":key, "username":val["身份证"], "certID":val["认证项目"], "score":""+val["成绩"], "startDate":val["发证日期"], "term": val["期限"], "diplomaID":""+val["证书编号"], "memo":val["备注"], "host":host, "registerID":currUser};
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
  }
  //console.log(response);
  return res.send(response);
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



//22. generate_diploma_byCertID
//status: 0 成功  9 其他  msg, filename
router.get('/generate_diploma_byCertID', function(req, res, next) {
  sqlstr = "generateDiplomaByCertID";
  params = {certID:req.query.certID,batchID:req.query.batchID,selList:req.query.selList,host:req.query.host,registerID:req.query.username};
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
      sqlstr = "select * from v_diplomaInfo where type=1 and batchID=" + batchID;   //企业内证书
      params = {};
      db.excuteSQL(sqlstr, params, function(err, data1){
        if (err) {
          console.log(err);
          response = [];
          return res.send(response);
        }
        let arr = new Array();
        //generate diploma paper with pdf
        for (var i in data1.recordset){
          let str = [data1.recordset[i]["name"],data1.recordset[i]["certName"],data1.recordset[i]["diplomaID"],data1.recordset[i]["dept1Name"],data1.recordset[i]["job"],data1.recordset[i]["startDate"],data1.recordset[i]["term"],data1.recordset[i]["title"],data1.recordset[i]["photo_filename"],data1.recordset[i]["logo"],data1.recordset[i]["certID"],data1.recordset[i]["host"]];
          sqlstr = process.env.NODE_ENV_BACKEND + "/pdf.asp?kindID=" + (str.join(","));
          //arr.push(str.join(","));
          let path = 'users/upload/students/diplomas/' + data1.recordset[i]["diplomaID"] + '.pdf';
          //console.log(sqlstr);
          pdf.genPDF(sqlstr, path, '180mm', '120mm', '1', false, 1);
        }
        //publish diploma on A4 with pdf
        //sqlstr = "http://localhost:8082/pdfs.asp?kindID=" + (arr.join("|"));
        sqlstr = process.env.NODE_ENV_BACKEND + "/pdfs.asp?refID=" + batchID;
        let path = 'users/upload/students/diplomaPublish/' + batchID + '.pdf';
        filename = path;
        pdf.genPDF(sqlstr, path, '297mm', '210mm', '', false, 0.5);
      
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

//generate_entryform_byProjectID
//status: 0 成功  9 其他  msg, filename
router.get('/generate_entryform_byProjectID', function(req, res, next) {
  let projectID = req.query.projectID;
  let certID = req.query.certID;
  let path1 = 'users/upload/projects/templates/entry_form_' + certID + '.docx';
  let path2 = 'users/upload/projects/entryforms/培训报名表[' + projectID + '].docx';
  sqlstr = "select a.* from v_studentInfo a, studentCourseList b where a.username=b.username and b.checked=1 and b.projectID='" + projectID + "'";   //获取指定招生批次下的已确认名单
  params = {};
  db.excuteSQL(sqlstr, params, function(err, data1){
    if (err) {
      console.log(err);
      response = [];
      return res.send(response);
    }
    //delete the destination folder if it exist
    if(fs.existsSync(path2)) {
      fs.unlinkSync(path2, function(err){
        if(err){
          res.send("文件删除失败。");
          return;
        }
      });
    }
    //generate entry form to a single file include all the students.
    for (var i in data1.recordset){
      params = {ID:data1.recordset[i]["username"], name:data1.recordset[i]["name"], sex:data1.recordset[i]["sexName"], birthday:data1.recordset[i]["birthday"], age:data1.recordset[i]["age"], dept:data1.recordset[i]["dept1Name"] + data1.recordset[i]["dept2Name"], job:data1.recordset[i]["job"], education:data1.recordset[i]["educationName"], phone:data1.recordset[i]["phone"], mobile:data1.recordset[i]["mobile"], company:data1.recordset[i]["hostName"], address:'', date:today};
      console.log(params);
      docx.writeDoc(params, path1, path2);
    }
    
    //link the filename to the project
    sqlstr = "setUploadSingleFileLink";
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
    
    //return file path
    response = [path2];
    return res.send(response);
  });
});

router.get('/form', function(req, res, next){
  var form = fs.readFileSync('./form.html', {encoding: 'utf8'});
  res.send(form);
});

//test
router.get('/testPDF', function(req, res, next) {
  sqlstr = "select * from v_diplomaInfo where ID=1";
  params = {};
  db.excuteSQL(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    let str = [data.recordset[0]["name"],data.recordset[0]["certName"],data.recordset[0]["diplomaID"],data.recordset[0]["dept1Name"],data.recordset[0]["job"],data.recordset[0]["startDate"],data.recordset[0]["term"],data.recordset[0]["title"],data.recordset[0]["photo_filename"],data.recordset[0]["logo"],data.recordset[0]["certID"],data.recordset[0]["host"]];
    sqlstr = "http://localhost:8082/pdf.asp?kindID=" + (str.join("|"));
    let path = 'users/upload/students/diplomas/' + data.recordset[0]["diplomaID"] + '.pdf';
    //console.log(str.join("|"));
    pdf.genSinglePDF(sqlstr, path);
    response = data.recordset;
    return res.send(response);
  });
});

module.exports = router;

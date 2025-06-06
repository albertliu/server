var express = require('express');
var router = express.Router();
var db = require("../utils/mssqldb");
var sendsms = require("../utils/sendsms");
let xlsx = require('xlsx');
var qr = require('qr-image');
const path = require('path');
const pdf = require('pdf-poppler');
//const jimp= require("jimp");
const images= require("images");
const { NetworkAuthenticationRequire } = require('http-errors');
const shell = require('shelljs');
var uploadHome = './users/upload/';
var downloadHome = './users/public/';
var homeUrl = process.env.NODE_ENV_HOME_URL;
var pyUrl = path.resolve(__dirname, '..') + "/python";
var response, sqlstr, params;

/* GET home page. */
router.get('/', function(req, res, next) {
  //res.render('index', { title: 'Express' });
  console.log("The user order paramaters ip: %s  host: %s", ip, host)
  res.send(response);
});

//1a. getCompanyByHost
router.get('/getCompanyByHost', function(req, res, next) {
  sqlstr = "select hostNo, iif(hostNo='spc','危化安全培训系统',a.title) as hostName, logo, b.deptID, b.deptName from hostInfo a, deptInfo b where a.hostNo=b.host and b.pID=0 and a.hostNo=@host";
  let host = req.get('origin').split("//")[1].split(".")[0];
  if(host>""){
    params = {host:host};
    db.excuteSQL(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        let response = {"status":9};
        return res.send(response);
      }
      response = data.recordset;
      return res.send(response);
    });
  }else{
    //don't accepted a blank host
    return res.send([]);
  }
});

//6a. getDeptListByPID
router.get('/getDeptListByPID', function(req, res, next) {
  sqlstr = "select * from v_deptInfo where pID=@pID and kindID=@kindID and dept_status<9 order by deptName";
  params = {pID:req.query.pID, kindID:req.query.kindID};
  //console.log("params:", params);
  db.excuteSQL(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    response = data.recordset;
    return res.send(response);
    return next();
  });
});

//6b. getDicListByKind
router.get('/getDicListByKind', function(req, res, next) {
  sqlstr = "select ID,item from dictionaryDoc where kind=@kindID";
  params = {kindID:req.query.kindID};
  //console.log("params:", params);
  db.excuteSQL(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    response = data.recordset;
    return res.send(response);
  });
});

//6c. getProjectListBycertID
router.get('/getProjectListBycertID', function(req, res, next) {
    if(req.query.op == 0){
        sqlstr = "select * from projectInfo where courseID=@certID and status>0 order by projectID desc";
    }else{
        sqlstr = "select * from v_projectInfo where courseID=@certID and status=1 and host_kindID=0 order by projectID desc";
    }
    if(req.query.host>""){
        sqlstr = "select * from projectInfo where courseID=@certID and status=1 and host='" + req.query.host + "' order by projectID desc";
    }
    
    params = {certID:req.query.certID};
    db.excuteSQL(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        let response = {"status":9};
        return res.send(response);
      }
      response = data.recordset;
      return res.send(response);
    });
});

router.get('/getDeptTreeJson', function(req, res, next) {
  //sqlstr = "SELECT dbo.getDeptJson(@nodeID) as item";
  if(req.query.indexByDate==0){
    sqlstr = "SELECT * from dbo.getDeptTreeByPID(@nodeID) order by pID,kindID,[text]";
  }else{
    sqlstr = "SELECT * from dbo.getDeptTreeByPID(@nodeID) order by pID,kindID,regDate desc";
  }
  
  params = {nodeID:req.query.nodeID};
  //console.log("params:", params);
  db.excuteSQL(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    //response = data.recordset[0]["item"];
    response = data.recordset;
    //console.log(response);
    return res.send(response);
  });
});

//23. getDiplomaListByBatchID
router.get('/getDiplomaListByBatchID', function(req, res) {
  //sqlstr = "SELECT diplomaID,name,certID,certName,startDate,term,host,dept1Name,title,job,logo,photo_filename,stamp FROM v_diplomaInfo where batchID=@refID";
  sqlstr = "getDiplomaListByBatchID";
  params = {batchID:req.query.refID};
  //console.log("params:", params);
  //db.excuteSQL(sqlstr, params, function(err, data){
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    response = data.recordset;
    //console.log(response);
    return res.send(response);
  });
});

//23a. getStudentPhotoList
router.get('/getStudentPhotoList', function(req, res) {
  sqlstr = "SELECT photo_filename as f0,IDa_filename as f1,IDb_filename as f2,edu_filename as f3,cert_filename as f4,username,name,SNo as no FROM v_studentCourseList where " + req.query.where;
  params = {};
  //console.log("params:", sqlstr);
  db.excuteSQL(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    response = data.recordset;
    //console.log(response);
    return res.send(response);
  });
});

//23b. getPasscardListByBatchID
router.get('/getPasscardListByBatchID', function(req, res) {
  //sqlstr = "SELECT username,name,sexName,b.title,b.startDate,b.startTime,b.notes,b.address FROM v_studentCourseList a, v_generatePasscardInfo b where a.passcardID=b.ID and b.ID=@refID";
  sqlstr = "SELECT username,name,sexName,passNo,password,b.title,b.startDate,b.startTime,b.notes,b.address FROM v_passcardInfo a, v_generatePasscardInfo b where a.refID=b.ID and b.ID=@refID order by passNo";
  params = {refID:req.query.refID};
  //console.log("params:", params);
  db.excuteSQL(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    response = data.recordset;
    //console.log(response);
    return res.send(response);
  });
});

//23c. getNeed2knowByEnterID
router.get('/getNeed2knowByEnterID', function(req, res) {
  //sqlstr = "SELECT username,name,sexName,b.title,b.startDate,b.startTime,b.notes,b.address FROM v_studentCourseList a, v_generatePasscardInfo b where a.passcardID=b.ID and b.ID=@refID";
  sqlstr = "SELECT * from dbo.getNeed2knowByEnterID(@refID)";
  params = {refID:req.query.refID};
  //console.log("params:", params);
  db.excuteSQL(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    response = data.recordset;
    //console.log(response);
    return res.send(response);
  });
});

//23c. getClassCheckin  线下考勤表
router.get('/getClassCheckin', function(req, res) {
  sqlstr = "getClassCheckinList";
  params = {classID:req.query.refID};
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {};
      return res.send(response);
    }
    response = data.recordset;
    // console.log(response);
    return res.send(response);
  });
});

//23d. getStudentMaterials
router.get('/getStudentMaterials', function(req, res) {
  sqlstr = "select * from studentMaterials where username=@username " + (req.query.IDcard==1?"and kindID in (1,2)":"") + " order by kindID";
  params = {username:req.query.username};
  //console.log("params:", params);
  db.excuteSQL(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    response = data.recordset;
    //console.log(response);
    return res.send(response);
  });
});

//23e. getFiremanEnterInfo
router.get('/getFiremanEnterInfo', function(req, res) {
  sqlstr = "select *,[dbo].[getMissingItems](enterID) as missingItems from v_firemanEnterInfo where enterID=@refID";
  params = {refID:req.query.refID};
  //console.log("params:", params);
  db.excuteSQL(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    response = (data.recordset? data.recordset[0]:{});
    //console.log(response);
    return res.send(response);
  });
});


//24. getRptList  generate a report, output a json data or an excel file.
router.get('/getRptList', function(req, res) {
  switch(req.query.op){
    case "income":
      sqlstr = "getIncomeRpt";
      params = { host: req.query.host, mark: req.query.mark1, startDate: req.query.startDate, endDate: req.query.endDate, sales: req.query.sales, courseID: req.query.courseID };
      break;
    case "sales":
      sqlstr = "getSalesRpt";
      params = { host: req.query.host, startDate: req.query.startDate, endDate: req.query.endDate, sales: req.query.sales };
      break;
    case "payInvoice":
      sqlstr = "getPayInvoiceRpt";
      params = { host: req.query.host, startDate: req.query.startDate, endDate: req.query.endDate, startDate1: req.query.startDate1, endDate1: req.query.endDate1, autoPay: req.query.autoPay, autoInvoice: req.query.autoInvoice, receivable: req.query.receivable, received: req.query.received };
      break;
    case "dailyTotal":
      sqlstr = "getDailyRptTotal";
      params = { host: req.query.host, startDate: req.query.startDate, mark: req.query.mark};
      break;
    case "dailyTotalTrail":
      sqlstr = "getDailyRptTotalTrail";
      params = { host: req.query.host, startDate: req.query.startDate, mark:req.query.kind};
      break;
    case "student":
      sqlstr = "p_rptStudentRegister";
      //@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(20),@groupHost int,@groupDept1 int,@groupKindID int,@groupDate
      params = {host:req.query.host, startDate:req.query.startDate,endDate:req.query.endDate,kindID:req.query.kindID,groupHost:req.query.groupHost,groupDept1:req.query.groupDept1,groupKindID:req.query.groupKindID,groupDate:req.query.groupDate,fromID:req.query.fromID};
      break;
    case "trainning":
      sqlstr = "p_rptStudentTrainning";
      //@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(50),@courseID varchar(50),@status varchar(50),@groupHost int,@groupDept1 int,@groupKindID int,@groupCourseID int,@groupStatus int,@groupDate varchar(20)
      params = {host:req.query.host, startDate:req.query.startDate,endDate:req.query.endDate,kindID:req.query.kindID,courseID:req.query.courseID,status:req.query.status,groupHost:req.query.groupHost,groupDept1:req.query.groupDept1,groupKindID:req.query.groupKindID,groupCourseID:req.query.groupCourseID,groupStatus:req.query.groupStatus,groupDate:req.query.groupDate,fromID:req.query.fromID};
      break;
    case "diploma":
      sqlstr = "p_rptStudentDiploma";
      //@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(50),@certID varchar(50),@status varchar(50),@agencyID varchar(50),@groupHost int,@groupDept1 int,@groupKindID int,@groupCertID int,@groupStatus int,@groupAgencyID int,@groupDate varchar(20)
      params = {host:req.query.host, startDate:req.query.startDate,endDate:req.query.endDate,kindID:req.query.kindID,certID:req.query.certID,status:req.query.status,agencyID:req.query.agencyID,groupHost:req.query.groupHost,groupDept1:req.query.groupDept1,groupKindID:req.query.groupKindID,groupCertID:req.query.groupCertID,groupStatus:req.query.groupStatus,groupAgencyID:req.query.groupAgencyID,groupDate:req.query.groupDate,fromID:req.query.fromID};
      break;
    case "diplomaLast":
      sqlstr = "p_rptStudentDiplomaLast";
      //@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(50),@certID varchar(50),@status varchar(50),@agencyID varchar(50),@groupHost int,@groupDept1 int,@groupKindID int,@groupCertID int,@groupStatus int,@groupAgencyID int,@groupDate varchar(20)
      params = {host:req.query.host, startDate:req.query.startDate,endDate:req.query.endDate,kindID:req.query.kindID,certID:req.query.certID,status:req.query.status,agencyID:req.query.agencyID,groupHost:req.query.groupHost,groupDept1:req.query.groupDept1,groupKindID:req.query.groupKindID,groupCertID:req.query.groupCertID,groupStatus:req.query.groupStatus,groupAgencyID:req.query.groupAgencyID,groupDate:req.query.groupDate,fromID:req.query.fromID};
      break;
    case "daily_unit_course":
      sqlstr = "rpt_dailyUnitCourse";
      params = {dateStart:req.query.startDate,dateEnd:req.query.endDate};
      break;
    case "daily_course":
      sqlstr = "rpt_dailyCourse";
      params = {dateStart:req.query.startDate,dateEnd:req.query.endDate};
      break;
    case "dailyIncome":
      sqlstr = "getDailyIncomeRpt";
      params = {startDate:req.query.startDate,endDate:req.query.endDate};
      break;
    case "dailyEnter":
      sqlstr = "getDailyEnterRpt";
      params = {startDate:req.query.startDate,endDate:req.query.endDate};
      break;
    default:
  }
  // console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    if(req.query.mark=="data"){
      //return json data
      response = data.recordset;  
    }
    if(req.query.mark=="file"){
      //return excel file
      if(data.recordset.length > 0){
        let sheet = xlsx.utils.json_to_sheet(data.recordset);
        let workBook = {
          SheetNames: ['sheet1'],
          Sheets: {
            'sheet1': sheet
          }
        };
        // 将workBook写入文件
        let path = downloadHome + "temp/" + req.query.op + Date.now() + ".xlsx";
        xlsx.writeFile(workBook, path);
        response = [path];
      }else{
        response = [];
      }
    }
    //console.log(response);
    return res.send(response);
  });
});

//24. getRptDetailList  generate a report, output a json data or an excel file.
router.get('/getRptDetailList', function (req, res) {
  switch (req.query.op) {
    case "income":
      sqlstr = "getIncomeRptDetail";
      params = { thisDate: req.query.thisDate, startDate: req.query.startDate, endDate: req.query.endDate, courseID: req.query.courseID, sales: req.query.sales, mark: req.query.mark1, key: req.query.key };
      break;
    case "sales":
      sqlstr = "getSalesRptDetail";
      params = { host: req.query.host, startDate: req.query.startDate, endDate: req.query.endDate, sales: req.query.sales, kind: req.query.kind };
      break;
    case "dailyIncome":
      sqlstr = "getDailyIncomeRptDetail";
      params = { startDate: req.query.startDate, endDate: req.query.endDate, kind: req.query.kind };
      break;
    case "dailyEnter":
      sqlstr = "getDailyEnterRptDetail";
      params = { startDate: req.query.startDate, endDate: req.query.endDate, kind: req.query.kind };
      break;
    default:
  }
  // console.log("params:", params);
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    let mark = req.query.mark || "data";
    if(mark=="data"){
      //return json data
      response = data.recordset;  
    }
    if(mark=="file"){
      //return excel file
      if(data.recordset.length > 0){
        let sheet = xlsx.utils.json_to_sheet(data.recordset);
        let workBook = {
          SheetNames: ['sheet1'],
          Sheets: {
            'sheet1': sheet
          }
        };
        // 将workBook写入文件
        let path = downloadHome + "temp/" + req.query.op + Date.now() + ".xlsx";
        xlsx.writeFile(workBook, path);
        response = [path];
      }else{
        response = [];
      }
    }
    //console.log(response);
    return res.send(response);
  });
});

//3. reset_student_password
router.post('/reset_student_password', function(req, res, next) {
  sqlstr = "reset_student_password";
  params = { username: req.body.username, phone: req.body.mobile };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, msg:"系统错误。" };
      return res.send(response);
    }
    let msg = "密码重置成功，请注意接收短信。";
    let status = data.recordset[0]["status"];
    //return: 0 success; other error:1 the user not exist  2 the phone error.
    //console.log(status,":",data.recordset[0]["password"])
    if(status==0){
      sendsms.sendSMS(req.body.mobile, '', data.recordset[0]["password"], '', '', "reset_password");
      sqlstr = "writeSSMSlog";
      params = { username: req.body.username, mobile: req.body.mobile, kind: "密码重置", message: data.recordset[0]["password"],refID:0, registerID: "system." };
      db.excuteProc(sqlstr, params, function (err, data1) {
        if (err) {
          console.log(err);
          let response = { "status": 9, msg:"系统错误。" };
          return res.send(response);
        }
      });
    }
    if(status==1){
      msg = "该用户不存在。";
    }
    if(status==2){
      msg = "该手机号码与注册登记的不一致。";
    }
    let response = { "status": status, "msg": msg };
    return res.send(response);
  });
});

//4. 批量通知学员，重新上传图片资料。同时发送系统消息和短信。
router.get('/resubmit_student_materials', function(req, res, next) {
  sqlstr = "doStudentMaterial_resubmit";
  params = {status:req.query.status, selList: req.query.selList, registerID: req.query.registerID };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, msg:"系统错误。" };
      return res.send(response);
    }
    //return: 0 success; other error:1 the user not exist  2 the phone error.
    //console.log(data.recordset[0]);
    if(req.query.status==1){ //发通知
      let re = data.recordset;
      for (var i in re){
        let address = "www";
        if(re[i]["host"]>""){
          address = re[i]["host"];
        }
        address = "http://" + address + ".shznxfxx.cn:3000";
        sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["item"], address, '', "reupload_material");
        sqlstr = "writeSSMSlog";
        params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "资料不合规通知", message: re[i]["item"],refID:0, registerID: req.query.registerID };
        //console.log(params);
        db.excuteProc(sqlstr, params, function (err, data1) {
          if (err) {
            console.log(err);
            let response = { "status": 9, msg:"系统错误。" };
            return res.send(response);
          }
        });
      }
    }
    let response = { "status": 0, "msg": "操作成功。" };
    return res.send(response);
  });
});

//4. 批量通知学员，考试时间地点。同时发送系统消息和短信。
router.get('/send_message_exam', function(req, res, next) {
  sqlstr = "sendMsg4Exam";
  params = {batchID:req.query.batchID, registerID: req.query.registerID };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, msg:"系统错误。" };
      return res.send(response);
    }
    //return: 0 success; other error:1 the user not exist  2 the phone error.
    //console.log(data.recordset[0]);
    if(req.query.SMS==1){ //发通知
      let re = data.recordset;
      for (var i in re){
        if(re[i]["mobile"].length == 11){
          sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["certName"], re[i]["address"], re[i]["dt"], (re[i]["kindID"]==1?"msg_exam_online":"msg_exam"));
          sqlstr = "writeSSMSlog";
          params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "考试通知", message: re[i]["item"], refID: re[i]["enterID"], registerID: req.query.registerID };
          //console.log(params);
          db.excuteProc(sqlstr, params, function (err, data1) {
            if (err) {
              console.log(err);
              let response = { "status": 9, msg:"系统错误。" };
              return res.send(response);
            }
          });
        }
      }
    }
    let response = { "status": 0, "msg": "操作成功。" };
    return res.send(response);
  });
});

//4. 批量通知学员，考试时间地点。同时发送系统消息和短信。
router.get('/send_message_exam_apply', function(req, res, next) {
  sqlstr = "sendMsg4ExamApply";
  params = {batchID:req.query.batchID, registerID: req.query.registerID };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, msg:"系统错误。" };
      return res.send(response);
    }
    //return: 0 success; other error:1 the user not exist  2 the phone error.
    //console.log(data.recordset[0]);
    if(req.query.SMS==1){ //发通知
      let re = data.recordset;
      for (var i in re){
        if(re[i]["mobile"].length == 11){
          sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["certName"], re[i]["address"], re[i]["dt"], "msg_exam");
          sqlstr = "writeSSMSlog";
          params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "考试通知", message: re[i]["item"], refID: re[i]["enterID"], registerID: req.query.registerID };
          //console.log(params, re[i]["address"]);
          db.excuteProc(sqlstr, params, function (err, data1) {
            if (err) {
              console.log(err);
              let response = { "status": 9, msg:"系统错误。" };
              return res.send(response);
            }
          });
        }
      }
    }
    let response = { "status": 0, "msg": "操作成功。" };
    return res.send(response);
  });
});

//4. 批量通知学员，培训时间地点。发送短信。
router.post('/send_message_class', function(req, res, next) {
  sqlstr = "sendMsg4Class";
  params = {batchID:req.body.batchID, selList:req.body.selList, registerID: req.body.registerID };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, msg:"系统错误。" };
      return res.send(response);
    }
    //return: 0 success; other error:1 the user not exist  2 the phone error.
    //console.log(req.body.SMS, params, data.recordset);

    if(req.body.SMS==1){ //发通知
      let re = data.recordset;
      for (var i in re){
        if(re[i]["mobile"].length == 11){
          sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["certName"], re[i]["address"], re[i]["dt"], (re[i]["kindID"]==1?"msg_class_online":"msg_class"));
          sqlstr = "writeSSMSlog";
          params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "培训通知", message: re[i]["item"], refID: re[i]["enterID"], registerID: req.body.registerID };
          //console.log(params);
          db.excuteProc(sqlstr, params, function (err, data1) {
            if (err) {
              console.log(err);
              let response = { "status": 9, msg:"系统错误。" };
              return res.send(response);
            }
          });
        }
      }
    }
    let response = { "status": 0, "msg": "操作成功。" };
    return res.send(response);
  });
});

//4. 批量提醒学员，抓紧学习进度。发送短信。
router.post('/send_message_study_alert', function(req, res, next) {
  sqlstr = "sendMsg4StudyAlert";
  params = {batchID:req.body.batchID, selList:req.body.selList, registerID: req.body.registerID };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, msg:"系统错误。" };
      return res.send(response);
    }
    //return: 0 success; other error:1 the user not exist  2 the phone error.
    //console.log(req.body.SMS, params, data.recordset);

    if(req.body.SMS==1){ //发通知
      let re = data.recordset;
      for (var i in re){
        if(re[i]["mobile"].length == 11){
          sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["certName"], '', '', "msg_study_alert");
          sqlstr = "writeSSMSlog";
          params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "督促学习", message: re[i]["item"], refID: re[i]["enterID"], registerID: req.body.registerID };
          //console.log(params);
          db.excuteProc(sqlstr, params, function (err, data1) {
            if (err) {
              console.log(err);
              let response = { "status": 9, msg:"系统错误。" };
              return res.send(response);
            }
          });
        }
      }
    }
    let response = { "status": 0, "msg": "操作成功。" };
    return res.send(response);
  });
});

//4. 批量通知学员，不予安排考试。发送短信。
router.post('/send_message_exam_deny', function(req, res, next) {
  sqlstr = "sendMsg4ExamDeny";
  params = {batchID:req.body.batchID, selList:req.body.selList, registerID: req.body.registerID };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, msg:"系统错误。" };
      return res.send(response);
    }
    //return: 0 success; other error:1 the user not exist  2 the phone error.
    //console.log(req.body.SMS, params, data.recordset);

    if(req.body.SMS==1){ //发通知
      let re = data.recordset;
      for (var i in re){
        if(re[i]["mobile"].length == 11){
          sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["certName"], '', '', "msg_exam_deny");
          sqlstr = "writeSSMSlog";
          params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "不予安排考试", message: re[i]["item"], refID: re[i]["enterID"], registerID: req.body.registerID };
          //console.log(params);
          db.excuteProc(sqlstr, params, function (err, data1) {
            if (err) {
              console.log(err);
              let response = { "status": 9, msg:"系统错误。" };
              return res.send(response);
            }
          });
        }
      }
    }
    let response = { "status": 0, "msg": "操作成功。" };
    return res.send(response);
  });
});

//4. 批量通知学员，补交报名材料。发送短信。
router.post('/send_message_photo', function(req, res, next) {
  sqlstr = "sendMsg4Photo";
  params = {selList:req.body.selList, registerID: req.body.registerID };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, msg:"系统错误。" };
      return res.send(response);
    }
    //return: 0 success; other error:1 the user not exist  2 the phone error.
    //console.log(req.body.SMS, params, data.recordset);

    if(req.body.SMS==1){ //发通知
      let re = data.recordset;
      for (var i in re){
        if(re[i]["mobile"].length == 11){
          sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["certName"], re[i]["address"], "msg_photo");
          sqlstr = "writeSSMSlog";
          params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "报名材料催缴通知", message: re[i]["item"],refID:0, registerID: req.body.registerID };
          //console.log(params);
          db.excuteProc(sqlstr, params, function (err, data1) {
            if (err) {
              console.log(err);
              let response = { "status": 9, msg:"系统错误。" };
              return res.send(response);
            }
          });
        }
      }
    }
    let response = { "status": 0, "msg": "操作成功。" };
    return res.send(response);
  });
});

//4. 批量通知学员，考试成绩。同时发送系统消息和短信。
router.get('/send_message_score', function(req, res, next) {
  sqlstr = "sendMsg4Score";
  params = {batchID:req.query.batchID, registerID: req.query.registerID };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, msg:"系统错误。" };
      return res.send(response);
    }
    //return: 0 success; other error:1 the user not exist  2 the phone error.
    //console.log(data.recordset[0]);
    if(req.query.SMS==1){ //发通知
      let re = data.recordset;
      for (var i in re){
        if(re[i]["mobile"].length == 11){
          sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["certName"], re[i]["address"], '', "msg_score");
          sqlstr = "writeSSMSlog";
          params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "成绩通知", message: re[i]["item"], refID: re[i]["enterID"], registerID: req.query.registerID };
          //console.log(params);
          db.excuteProc(sqlstr, params, function (err, data1) {
            if (err) {
              console.log(err);
              let response = { "status": 9, msg:"系统错误。" };
              return res.send(response);
            }
          });
        }
      }
    }
    let response = { "status": 0, "msg": "操作成功。" };
    return res.send(response);
  });
});

//4. 批量通知学员，考试成绩。同时发送系统消息和短信。
router.get('/send_message_score_apply', function(req, res, next) {
    let ec = 0;
    sqlstr = "sendMsg4ScoreApply";
    params = {batchID:req.query.batchID, registerID: req.query.registerID };
    db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
            console.log(err);
            let response = { "status": 9, msg:"系统错误。" };
            return res.send(response);
        }
        //return: 0 success; other error:1 the user not exist  2 the phone error.
        //console.log(data.recordset[0]);
        if(req.query.SMS==1){ //发通知
            let re = data.recordset;
            for (var i in re){
                if(re[i]["mobile"].length == 11){
                    sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["certName"], re[i]["address"], '', "msg_score");
                    sqlstr = "writeSSMSlog";
                    params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "成绩通知", message: re[i]["item"], refID: re[i]["enterID"], registerID: req.query.registerID };
                    //console.log(params);
                    db.excuteProc(sqlstr, params, function (err, data1) {
                        if (err) {
                            console.log(err);
                            let response = { "status": 9, msg:"系统错误。" };
                            return res.send(response);
                        }
                    });
                    ec += 1;
                }
            }
        }
        let response = { "status": 0, "msg": "操作成功。" };
        return res.send(response);
    });
});

//4. 批量通知学员，领取证书。同时发送系统消息和短信。
router.post('/send_message_diploma_apply', function(req, res, next) {
    let ec = 0;
    sqlstr = "sendMsg4DiplomaApply";
    params = {batchID:req.query.batchID, selList: req.body.selList, registerID: req.query.registerID };
    db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
            console.log(err);
            let response = { "status": 9, msg:"系统错误。" };
            return res.send(response);
        }
        //return: 0 success; other error:1 the user not exist  2 the phone error.
        //console.log(data.recordset[0]);
        if(req.query.SMS==1){ //发通知
            let re = data.recordset;
            for (var i in re){
                if(re[i]["mobile"].length == 11){
                    sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["certName"], re[i]["address"], '', "msg_diploma");
                    sqlstr = "writeSSMSlog";
                    params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "领证通知", message: re[i]["item"], refID: re[i]["enterID"], registerID: req.query.registerID };
                    //console.log(params);
                    db.excuteProc(sqlstr, params, function (err, data1) {
                        if (err) {
                            console.log(err);
                            let response = { "status": 9, msg:"系统错误。" };
                            return res.send(response);
                        }
                    });
                    ec += 1;
                }
            }
        }
        let response = { "status": 0, "msg": "操作成功。" };
        return res.send(response);
    });
});

//4. 批量通知学员，提交电子照片。同时发送系统消息和短信。
router.post('/send_message_submit_photo', function(req, res, next) {
    let ec = 0;
    sqlstr = "sendMsg4SubmitPhoto";
    params = {kind:req.body.kind, selList: req.body.selList, registerID: req.body.registerID };
    //console.log(params);
    db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
            console.log(err);
            let response = { "status": 9, msg:"系统错误。" };
            return res.send(response);
        }
        //return: 0 success; other error:1 the user not exist  2 the phone error.
        //console.log(data.recordset[0]);
        if(req.body.SMS==1){ //发通知
            let re = data.recordset;
            for (var i in re){
                if(re[i]["mobile"].length == 11){
                    sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["certName"], '', '', "msg_submit_photo");
                    sqlstr = "writeSSMSlog";
                    params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "提交电子照片通知", message: re[i]["item"], refID: 0, registerID: req.body.registerID };
                    //console.log(params);
                    db.excuteProc(sqlstr, params, function (err, data1) {
                        if (err) {
                            console.log(err);
                            let response = { "status": 9, msg:"系统错误。" };
                            return res.send(response);
                        }
                    });
                    ec += 1;
                }
            }
        }
        let response = { "status": 0, "msg": "操作成功。" };
        return res.send(response);
    });
});

//4. 批量通知学员，提交电子签名。同时发送系统消息和短信。
router.post('/send_message_submit_signature', function(req, res, next) {
    let ec = 0;
    sqlstr = "sendMsg4SubmitSignature";
    params = {batchID:req.body.batchID, selList: req.body.selList, registerID: req.body.registerID };
    db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
            console.log(err);
            let response = { "status": 9, msg:"系统错误。" };
            return res.send(response);
        }
        //return: 0 success; other error:1 the user not exist  2 the phone error.
        //console.log(data.recordset[0]);
        if(req.body.SMS==1){ //发通知
            let re = data.recordset;
            for (var i in re){
                if(re[i]["mobile"].length == 11){
                    sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["certName"], '', '', "msg_submit_signature");
                    sqlstr = "writeSSMSlog";
                    params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "提交电子签名通知", message: re[i]["item"], refID: re[i]["enterID"], registerID: req.body.registerID };
                    //console.log(params);
                    db.excuteProc(sqlstr, params, function (err, data1) {
                        if (err) {
                            console.log(err);
                            let response = { "status": 9, msg:"系统错误。" };
                            return res.send(response);
                        }
                    });
                    ec += 1;
                }
            }
        }
        let response = { "status": 0, "msg": "操作成功。" };
        return res.send(response);
    });
});

//4. 批量通知学员，登录系统并进行签名和付款。同时发送系统消息和短信。
router.post('/send_message_submit_login', function(req, res, next) {
    let ec = 0;
    sqlstr = "sendMsg4SubmitLogin";
    params = {batchID:req.body.batchID, selList: req.body.selList, registerID: req.body.registerID };
    db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
            console.log(err);
            let response = { "status": 9, msg:"系统错误。" };
            return res.send(response);
        }
        //return: 0 success; other error:1 the user not exist  2 the phone error.
        //console.log(data.recordset[0]);
        if(req.body.SMS==1){ //发通知
            let re = data.recordset;
            for (var i in re){
                if(re[i]["mobile"].length == 11){
                    sendsms.sendSMS(re[i]["mobile"], re[i]["name"], '', '', '', "msg_submit_login");
                    sqlstr = "writeSSMSlog";
                    params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "登录签名付费通知", message: re[i]["item"], refID: re[i]["enterID"], registerID: req.body.registerID };
                    //console.log(params);
                    db.excuteProc(sqlstr, params, function (err, data1) {
                        if (err) {
                            console.log(err);
                            let response = { "status": 9, msg:"系统错误。" };
                            return res.send(response);
                        }
                    });
                    ec += 1;
                }
            }
        }
        let response = { "status": 0, "msg": "操作成功。" };
        return res.send(response);
    });
});

//4. 批量关闭提交电子照片/签名通知。
router.post('/send_message_submit_attention_close', function(req, res, next) {
    let ec = 0;
    sqlstr = "closeAttections";
    params = {batchID:req.body.batchID, kind:req.body.kind, kindID:req.body.kindID, selList: req.body.selList, registerID: req.body.registerID };
    //console.log(params);
    db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
            console.log(err);
            let response = { "status": 9, msg:"系统错误。" };
            return res.send(response);
        }
        let response = { "status": 0, "msg": "操作成功。" };
        return res.send(response);
    });
});

//4. 批量确认应收款已到账。
router.post('/checkReceiveList', function(req, res, next) {
    let ec = 0;
    sqlstr = "checkReceiveList";
    params = {selList: req.body.selList, theDate: req.body.theDate, registerID: req.body.registerID };
    console.log(params);
    db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
            console.log(err);
            let response = { "status": 9, msg:"系统错误。" };
            return res.send(response);
        }
        let response = { "status": 0, "msg": "操作成功。" };
        return res.send(response);
    });
});

//4. 批量拒绝/撤销制作证书申请。
router.post('/refuse_diploma_order', function(req, res, next) {
    sqlstr = "refuse_diploma_order";
    params = {kind:req.body.kind, selList: req.body.selList, registerID: req.body.registerID };
    //console.log(params);
    db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
            console.log(err);
            let response = { "status": 9, msg:"系统错误。" };
            return res.send(response);
        }
        let response = { "status": 0, "msg": "操作成功。" };
        return res.send(response);
    });
});

//4. 批量确认应收款。
router.post('/check_nopay_invoice', function(req, res, next) {
    sqlstr = "setPayReceive";
    params = {selList: req.body.selList, registerID: req.body.registerID };
    console.log(params);
    db.excuteProc(sqlstr, params, function (err, data) {
        if (err) {
            console.log(err);
            let response = { "status": 9, msg:"系统错误。" };
            return res.send(response);
        }
        let response = { "status": 0, "msg": "操作成功。" };
        return res.send(response);
    });
});

router.get('/get_user_qr', function (req, res, next) {
  //console.log("homeUrl:", homeUrl);
  var text = "http://" + req.query.host + homeUrl.replace("http://",".") + "?username=" + req.query.username;
  var size = req.query.size;
  //console.log(homeUrl, text);
  try {
    var img = qr.image(text,{size: parseInt(size)});
    res.writeHead(200, {'Content-Type': 'image/png'});
    img.pipe(res);
  } catch (e) {
    res.writeHead(414, {'Content-Type': 'text/html'});
    res.end('<h1>414 Request-URI Too Large</h1>');
  }
})

router.get('/get_qr_img', function (req, res, next) {
  //console.log("homeUrl:", homeUrl);
  var size = req.query.size;
  //console.log(homeUrl, text);
  try {
    var img = qr.image(req.query.text,{size: parseInt(size)});
    res.writeHead(200, {'Content-Type': 'image/png'});
    img.pipe(res);
  } catch (e) {
    res.writeHead(414, {'Content-Type': 'text/html'});
    res.end('<h1>414 Request-URI Too Large</h1>');
  }
})

router.get('/msg_score', function (req, res, next) {
  sendsms.sendSMS(req.query.phone, req.query.name, req.query.item, req.query.address,'', "msg_score");
  res.send(req.query.phone + "'s message send success!");
})

//16. 提交课堂交互信息 submit_feedback_class  return: 0 成功  9 其他
router.post('/submit_feedback_class', function (req, res, next) {
  sqlstr = "submit_feedback_class";
  params = { username: req.body.username, item: req.body.item, kindID: req.body.kindID || 4, refID: req.body.refID || 0, type: req.body.type || 0, classID:req.body.classID, readerID:req.body.readerID || null };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    let response = { "status": data.returnValue || 0, "msg": "" };
    return res.send(response);
  });
});

//17. 提交课堂交互信息 cancel_feedback_class  return: 0 成功  9 其他
router.post('/cancel_feedback_class', function (req, res, next) {
  sqlstr = "cancelFeedbackInfo";
  params = { ID: req.body.ID || 0 };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    let response = { "status": data.returnValue || 0, "msg": "" };
    return res.send(response);
  });
});

//18. get_feedback_class_list: 返回课堂交互信息列表
router.get('/get_feedback_class_list', function (req, res, next) {
  sqlstr = "select * from dbo.getFeedbackClassList(@username,@classID,@type) order by ID " + (req.query.type!=1?"desc":"");
  params = { username: req.query.username, classID:req.query.classID, type:req.query.type || 0 };
  db.excuteSQL(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    response = data.recordset;
    return res.send(response);
  });
});

//
router.post('/applyEnter', function (req, res) {
  // 配置初始化信息 selList:applyID
  shell.exec('@echo off')
  // shell.exec('chcp 65001')
  let url = pyUrl + '/apply.py ' + req.body.selList + ' ' + req.query.reexamine + ' ' + req.query.host + ' ' + req.query.register + ' ' + req.query.classID + ' ' + req.query.courseName + ' ' + req.query.reex;
  console.log('url code:', url);
  shell.exec(url, function (code, stdout, stderr) {
    // console.log('Exit code:', code);
    // console.log('Program output:', stdout);    
    let response = {};
    try{
      if(stderr){
        console.log('Program stderr:', stderr);
      }
      // response = eval("(" + stdout + ")");  //字符串转为JSON
      response = eval(`( ${stdout} )`);  //字符串转为JSON
      // console.log('Exit stdout:', response);
    } catch(err){
      console.log('shell err:', err);
      response = {"count_s": 0, "count_e": 0, "err": 1, "errMsg": "访问异常，请稍后重试。"};
    } finally {
      return res.send(response);
    }
  });
});

//
router.post('/enterPay', function (req, res) {
  // 自动支付接口：kindID: 0 pay  1 refund  2 invoice  3 对账单
  shell.exec('@echo off')
  sqlstr = "getEnterPayInfo";
  params = { enterID: req.body.enterID, kindID: req.body.kindID };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    const re = (data.recordset? data.recordset[0]:{});
    let url = pyUrl + '/NNOpenSDK.py ' + re["host"] + ' ' + req.body.kindID + ' ' + re["enterOrder"] + ' ' + re["amount"] + ' ' + re["item"] + ' ' + re["name"] + ' ' + 'system.';
    console.log('url code:', url);
    shell.exec(url, function (code, stdout, stderr) {
      // console.log('Exit code:', code);
      // console.log('Program output:', stdout);    
      let response = {};
      try{
        if(stderr){
          console.log('Program stderr:', stderr);
        }
        // response = eval("(" + stdout + ")");  //字符串转为JSON
        response = eval(`( ${stdout} )`);  //字符串转为JSON
        console.log('Exit stdout:', response);
      } catch(err){
        console.log('shell err:', err);
        response = {"code": "JH000", "describe": "支付接口访问异常，请稍后重试。"};
      } finally {
        return res.send(response);
      }
    });
  });
});

//
router.post('/diplomaCheck', function (req, res) {
  // 配置初始化信息 selList: when kindID:0 applyID  1 enterID
  shell.exec('@echo off')
  // shell.exec('chcp 65001')
  let url = pyUrl + '/diplomaCheck.py ' + req.body.selList + ' ' + req.body.kindID + ' ' + req.query.host + ' ' + req.query.register;
  // console.log("url:", url)
  shell.exec(url, function (code, stdout, stderr) {
    // console.log('Exit code:', code);
    // console.log('Program output:', stdout);    
    let response = {};
    try{
      if(stderr){
        console.log('Program stderr:', stderr);
      }
      response = eval("(" + stdout + ")");  //字符串转为JSON
    } catch(err){
      console.log('shell err:', err, "stdout:", stdout, "response:", response);
      response = {"count_s": 0, "count_e": 0, "err": 1, "errMsg": "访问异常，请稍后重试。"};
    } finally {
      return res.send(response);
    }
  });
});

//
router.post('/diplomaCheckSingle', function (req, res) {
  // 配置初始化信息 selList: when kindID:0 applyID  1 enterID
  shell.exec('@echo off')
  // shell.exec('chcp 65001')
  let url = pyUrl + '/diplomaCheck.py ' + req.body.username + ' 2 ' + req.body.name + ' ' + req.body.courseName;
  // console.log("url:", url);
  shell.exec(url, function (code, stdout, stderr) {
    // console.log('Exit code:', code);
    // console.log('Program output:', stdout);    
    let response = {};
    try{
      if(stderr){
        console.log('Program stderr:', stderr);
      }
      response = eval("(" + stdout + ")");  //字符串转为JSON
    } catch(err){
      // console.log('shell err:', err, "stdout:", stdout, "response:", response);
      response = {"count_s": 0, "count_e": 0, "err": 1, "msg": ""};
    } finally {
      return res.send(response);
    }
  });
});

//
router.post('/fireScoreCheck', function (req, res) {
  // 配置初始化信息 selList: when kindID:0 applyID  1 enterID  2 username
  shell.exec('@echo off')
  // shell.exec('chcp 65001')
  let url = pyUrl + '/fireScoreCheck.py ' + req.body.selList + ' ' + req.body.kindID + ' ' + req.body.refID + ' ' + req.query.host + ' ' + req.query.register;
  // console.log("url:", url)
  shell.exec(url, function (code, stdout, stderr) {
    // console.log('Exit code:', code);
    // console.log('Program output:', stdout);    
    let response = {};
    try{
      if(stderr){
        console.log('Program stderr:', stderr);
      }
      response = eval("(" + stdout + ")");  //字符串转为JSON
    } catch(err){
      console.log('shell err:', err, "stdout:", stdout, "response:", response);
      response = {"count_s": 0, "count_e": 0, "err": 1, "errMsg": "访问异常，请稍后重试。"};
    } finally {
      return res.send(response);
    }
  });
});


//4. 某学校批量将学员退回到提交的合作单位
router.get('/getScheduleCheckInList', function (req, res, next) {
  sqlstr = "getScheduleCheckInList";
  params = { selList:req.query.selList };
  // console.log('getScheduleCheckInList',params);
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      return res.send({ "status": 9, "msg": "操作失败。" });
    }
    let response = data.recordset || [];
  // console.log("responsed1:", response);
    return res.send(response);
  });
});

//4. 某学校批量将学员退回到提交的合作单位
router.get('/getScheduleNoCheckInList', function (req, res, next) {
  sqlstr = "getScheduleNoCheckInList";
  params = { selList:req.query.selList };
  // console.log('getScheduleNoCheckInList',params);
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      return res.send({ "status": 9, "msg": "操作失败。" });
    }
    let response = data.recordset || [];
  // console.log("responsed2:", response);
    return res.send(response);
  });
});

//4. 将一批学员的发票设为一组
router.post('/setInvoiceGroup', function(req, res) {
  sqlstr = "setInvoiceGroup";
  params = { selList:req.body.selList, kind:req.body.kind, classID:req.body.classID, invoice:req.body.invoice, registerID:req.body.registerID };
  // console.log('setInvoiceGroup',params);
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      return res.send({ "status": 9, "msg": "操作失败。" });
    }
    let response = data.recordset[0] || [];
  // console.log("responsed2:", response);
    return res.send(response);
  });
});

//4. 
router.get('/getTrainingProofInfo', function (req, res, next) {
  sqlstr = "getTrainingProofInfo";
  params = { enterID:req.query.enterID };
  // console.log(params);
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      return res.send({ "status": 9, "msg": "操作失败。" });
    }
    let response = (data.recordset? data.recordset[0]:{});
    // console.log(response);
    return res.send(response);
  });
});

//4. 培训证明（机构版）
router.get('/getUnitTrainingProofInfo', function (req, res, next) {
  sqlstr = "getUnitTrainingProofInfo";
  params = { classID:req.query.classID };
  // console.log(params);
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      return res.send({ "status": 9, "msg": "操作失败。" });
    }
    let response = (data.recordset? data.recordset[0]:{});
    // console.log(response);
    return res.send(response);
  });
});

//4. comm proc whit params, return josn data
router.post('/postCommInfo', function (req, res, next) {
  sqlstr = req.body.proc;
  params = req.body.params;
  // console.log(params);
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      return res.send({ "status": 9, "msg": "操作失败。" });
    }
    let mark = req.query.mark || "data";
    if(mark=="data"){
      //return json data
      response = data.recordset || [];  
    }
    if(mark=="file"){
      //return excel file
      if(data.recordset.length > 0){
        let sheet = xlsx.utils.json_to_sheet(data.recordset);
        let workBook = {
          SheetNames: ['sheet1'],
          Sheets: {
            'sheet1': sheet
          }
        };
        // 将workBook写入文件
        let path = downloadHome + "temp/" + req.body.proc + Date.now() + ".xlsx";
        xlsx.writeFile(workBook, path);
        response = [path];
      }else{
        response = [];
      }
    }
    //console.log(response);
    return res.send(response);
  });
});

//11a. getInvoiceList 获取某个学员的发票列表
router.get('/getInvoiceList', function (req, res, next) {
  //firstly check the paper has its questions, if has not, create them now.
  params = { username: req.query.username };
  sqlstr = "getStudentInvoiceList";
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    response = data.recordset || [];
    // console.log("response:", response);
    return res.send(response);
  });
});

//getEnterRpt
router.post('/getEnterRpt', function(req, res) {
    sqlstr = "getEnterRpt";
    params = {refID:req.body.refID, startDate:req.body.startDate, endDate:req.body.endDate, certID:req.body.certID, fromID:req.body.fromID};
    //console.log("params:", params);
    db.excuteProc(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        let response = {"status":9};
        return res.send(response);
      }
      var list = data.recordset;
      if(list){
        var arr = new Array();
        var obj_title = new Array();
        var obj_pie = new Array();
        var obj_list1 = new Array();
        var obj_list2 = new Array();
        var obj_list3 = new Array();
        var total = 0;
        var total1 = 0;
        var total2 = 0;
        var total3 = 0;
        //console.log(list);
        list.forEach((item) =>{
          //console.log("item:", item["submitDate"]);
          obj_title.push(item["submitDate"]);
          obj_list1.push(nullNoDisp(item["znxf"]));
          obj_list2.push(nullNoDisp(item["spc"]));
          obj_list3.push(nullNoDisp(item["shm"]));
          total += item["count"];
          total1 += item["znxf"];
          total2 += item["spc"];
          total3 += item["shm"];
        });
        obj_pie = [{'name':'社会', 'value':total1, 'per': total1*100/total},{'name':'中石化', 'value':total2, 'per': total2*100/total},{'name':'申通地铁', 'value':total3, 'per': total3*100/total}];
        response = {'total':total,'title':obj_title,'pie':obj_pie,'list':[{'key':'社会', 'val':obj_list1},{'key':'中石化', 'val':obj_list2},{'key':'申通地铁', 'val':obj_list3}]};
        //console.log(response);
        return res.send(response);
      }else{
        //console.log("result:", 0);
        return res.send([]);
      }
    });
  });

//getEnterRptPie1
router.post('/getEnterRptPie1', function(req, res) {
    sqlstr = "getEnterRptPie1";
    params = {startDate:req.body.startDate, endDate:req.body.endDate, fromID:req.body.fromID};
    //console.log("params:", params);
    db.excuteProc(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        let response = {"status":9};
        return res.send(response);
      }
      var response = data.recordset || [];
      return res.send(response);
    });
  });

//getExamRpt
router.post('/getExamRpt', function(req, res) {
  sqlstr = "getExamRpt";
  params = {refID:req.body.refID, startDate:req.body.startDate, endDate:req.body.endDate};
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    var list = data.recordset;
    if(list && list.length>0){
      var arr = new Array();
      var obj_title = ['certName'];
      var arr_cert = new Array();
      var last_cert = "";
      arr_cert.push(list[0]["certName"]);
      last_cert = list[0]["certID"];
      //var last_date = "";
      var certName = "";
      var i = 0;
      //console.log(list);
      list.forEach((item) =>{
        //console.log("certID:", item["certID"], item["startDate"], "last:",last_cert);
        if(item["certID"] == last_cert){
          arr_cert.push(item["per"]);
        }else{
          arr.push(arr_cert);
          //console.log(certName, arr_cert);
          arr_cert = [item["certName"],item["per"]];
        }
        if(obj_title.indexOf(item["startDate"]) < 0){
          obj_title.push(item["startDate"]);
        }
        certName = item["certName"];
        last_cert = item["certID"];
        //last_date = item["startDate"];
        i += 1;
      });

      if(i>0){
        arr.push(arr_cert);
        //console.log(certName, arr_cert);
      }
      arr.splice(0, 0, obj_title);
      response = arr;
      return res.send(response);
    }else{
      //console.log("result:", 0);
      return res.send([]);
    }
  });
});

//getMockRpt
router.post('/getMockRpt', function(req, res) {
  sqlstr = "getMockRpt";
  params = {refID:req.body.refID, startDate:req.body.startDate, endDate:req.body.endDate, fromID:req.body.fromID};
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    var list = data.recordset;
    if(list && list.length>0){
      var arr = new Array();
      var obj_title = ['certName'];
      var arr_cert = new Array();
      var last_cert = "";
      arr_cert.push(list[0]["certName"]);
      last_cert = list[0]["certID"];
      //var last_date = "";
      var certName = "";
      var i = 0;
      //console.log(list);
      list.forEach((item) =>{
        //console.log("certID:", item["certID"], item["submitDate"], "last:",last_cert);
        if(item["certID"] == last_cert){
          arr_cert.push(item["examScore"]);
        }else{
          arr.push(arr_cert);
          //console.log(certName, arr_cert);
          arr_cert = [item["certName"],item["examScore"]];
        }
        if(obj_title.indexOf(item["submitDate"]) < 0){
          obj_title.push(item["submitDate"]);
        }
        certName = item["certName"];
        last_cert = item["certID"];
        //last_date = item["startDate"];
        i += 1;
      });

      if(i>0){
        arr.push(arr_cert);
        //console.log(certName, arr_cert);
      }
      arr.splice(0, 0, obj_title);
      response = arr;
      return res.send(response);
    }else{
      //console.log("result:", 0);
      return res.send([]);
    }
  });
});

//getClassRpt
router.post('/getClassRpt', function(req, res) {
  sqlstr = "getClassRpt";
  params = {adviserID:req.body.adviserID, startDate:req.body.startDate, endDate:req.body.endDate, certID:req.body.certID, archived:req.body.archived};
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    var list = data.recordset;
    if(list){
      var arr = new Array();
      var obj_title = new Array();
      var obj_adviser = new Array();
      var obj_examScore = new Array();
      var obj_examTimes = new Array();
      var obj_list1 = new Array();
      var obj_list2 = new Array();
      var obj_list3 = new Array();
      var obj_list4 = new Array();
      var obj_list5 = new Array();
      var obj_list1s = new Array();
      var obj_list2s = new Array();
      var obj_list3s = new Array();
      var obj_list4s = new Array();
      var total = 0;
      //console.log(list);
      list.forEach((item) =>{
        //console.log("item:", item["submitDate"]);
        obj_title.push(item["className"]);
        obj_adviser.push(item["adviserName"]);
        obj_examScore.push(item["examScore"]);
        obj_examTimes.push(item["examTimes"]);
        obj_list1.push(nullNoDisp(item["days_study0"]));
        obj_list2.push(nullNoDisp(item["days_exam0"]));
        obj_list3.push(nullNoDisp(item["days_diploma0"]));
        obj_list4.push(nullNoDisp(item["days_archive0"]));
        obj_list5.push(item["archiveDate"]>""?3:"");
        obj_list1s.push(nullNoDisp(item["days_study"]));
        obj_list2s.push(nullNoDisp(item["days_exam"]));
        obj_list3s.push(nullNoDisp(item["days_diploma"]));
        obj_list4s.push(nullNoDisp(item["days_archive"]));
        total += 1;
      });
      response = {'total':total,'title':obj_title,'adviser':obj_adviser,'examScore':obj_examScore,'examTimes':obj_examTimes,'list':[{'key':'上课', 'val':obj_list1},{'key':'安排考试', 'val':obj_list2},{'key':'制作证书', 'val':obj_list3},{'key':'归档', 'val':obj_list4},{'key':'结束', 'val':obj_list5}],'lists':[obj_list1s,obj_list2s,obj_list3s,obj_list4s]};
      //console.log(response);
      return res.send(response);
    }else{
      //console.log("result:", 0);
      return res.send([]);
    }
  });
});

//getIncomeRpt
router.post('/getIncomeRpt', function(req, res) {
  sqlstr = "getIncomeRpt";
  params = {refID:req.body.refID, startDate:req.body.startDate, endDate:req.body.endDate, certID:req.body.certID, fromID:req.body.fromID};
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    var list = data.recordset;
    if(list){
      var arr = new Array();
      var obj_title = new Array();
      var obj_pie = new Array();
      var obj_list1 = new Array();
      var obj_list2 = new Array();
      var obj_list3 = new Array();
      var total = 0;
      var total1 = 0;
      var total2 = 0;
      var total3 = 0;
      //console.log(list);
      list.forEach((item) =>{
        //console.log("item:", item["submitDate"]);
        obj_title.push(item["submitDate"]);
        obj_list1.push(nullNoDisp(item["znxf"]));
        obj_list2.push(nullNoDisp(item["spc"]));
        obj_list3.push(nullNoDisp(item["shm"]));
        total += item["count"];
        total1 += item["znxf"];
        total2 += item["spc"];
        total3 += item["shm"];
      });
      obj_pie = [{'name':'社会', 'value':total1, 'per': total1*100/total},{'name':'中石化', 'value':total2, 'per': total2*100/total},{'name':'申通地铁', 'value':total3, 'per': total3*100/total}];
      response = {'total':total,'title':obj_title,'pie':obj_pie,'list':[{'key':'社会', 'val':obj_list1},{'key':'中石化', 'val':obj_list2},{'key':'申通地铁', 'val':obj_list3}]};
      //console.log(response);
      return res.send(response);
    }else{
      //console.log("result:", 0);
      return res.send([]);
    }
  });
});

//getIncomeRptPie1
router.post('/getIncomeRptPie1', function(req, res) {
  sqlstr = "getIncomeRptPie1";
  params = {startDate:req.body.startDate, endDate:req.body.endDate, fromID:req.body.fromID};
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    var response = data.recordset || [];
    return res.send(response);
  });
});

//transfer PDF to png file, file name auto add "-1" in the trail
router.get('/getPDF2img', function(req, res, next) {
  //let file = "users/upload/students/diplomas/C1-22-01352.pdf";
  let file = req.query.path;
  let opts = {
    format: 'png',
    out_dir: path.dirname(file),
    out_prefix: path.basename(file, path.extname(file)),
    page: null
  }

  pdf.convert(file, opts)
    .then(function () {
        let response = file.replace(".pdf","-1.png");
        //console.log('Successfully converted： ',response);
        return res.send(response);
    })
    .catch(error => {
        console.error(error);
        return res.send(error);
    })
});

	
	function nullNoDisp(m){
		var s = "";
		if(m != null && m > "" && m != "null" && m != "0"){
			s = m;
		}
		return s;
	}
  
module.exports = router;

var express = require('express');
var router = express.Router();
var db = require("../utils/mssqldb");
var sendsms = require("../utils/sendsms");
let xlsx = require('xlsx');
const { NetworkAuthenticationRequire } = require('http-errors');
var uploadHome = './users/upload/';
var downloadHome = './users/public/';
var response, sqlstr, params;

/* GET home page. */
router.get('/', function(req, res, next) {
  //res.render('index', { title: 'Express' });
  console.log("The user order paramaters ip: %s  host: %s", ip, host)
  res.send(response);
});

//1a. getCompanyByHost
router.get('/getCompanyByHost', function(req, res, next) {
  sqlstr = "select hostNo, hostName, logo, b.deptID, b.deptName from hostInfo a, deptInfo b where a.hostNo=b.host and b.pID=0 and a.hostNo=@host";
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
  sqlstr = "select * from projectInfo where certID=@certID and status>0 order by projectID desc";
  params = {certID:req.query.certID};
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

router.get('/getDeptTreeJson', function(req, res, next) {
  //sqlstr = "SELECT dbo.getDeptJson(@nodeID) as item";
  sqlstr = "SELECT * from dbo.getDeptTreeByPID(@nodeID) order by pID,kindID,[text]";
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
  sqlstr = "SELECT diplomaID,name,certID,certName,startDate,term,host,dept1Name,title,job,logo,photo_filename,stamp FROM v_diplomaInfo where batchID=@refID";
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
  sqlstr = "SELECT username,name,sexName,b.title,b.startDate,b.startTime,b.notes,b.address FROM v_studentCourseList a, v_generatePasscardInfo b where a.passcardID=b.ID and b.ID=@refID";
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


//24. getRptList  generate a report, output a json data or an excel file.
router.get('/getRptList', function(req, res) {
  switch(req.query.op){
    case "student":
      sqlstr = "p_rptStudentRegister";
      //@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(20),@groupHost int,@groupDept1 int,@groupKindID int,@groupDate
      params = {host:req.query.host, startDate:req.query.startDate,endDate:req.query.endDate,kindID:req.query.kindID,groupHost:req.query.groupHost,groupDept1:req.query.groupDept1,groupKindID:req.query.groupKindID,groupDate:req.query.groupDate};
      break;
    case "trainning":
      sqlstr = "p_rptStudentTrainning";
      //@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(50),@courseID varchar(50),@status varchar(50),@groupHost int,@groupDept1 int,@groupKindID int,@groupCourseID int,@groupStatus int,@groupDate varchar(20)
      params = {host:req.query.host, startDate:req.query.startDate,endDate:req.query.endDate,kindID:req.query.kindID,courseID:req.query.courseID,status:req.query.status,groupHost:req.query.groupHost,groupDept1:req.query.groupDept1,groupKindID:req.query.groupKindID,groupCourseID:req.query.groupCourseID,groupStatus:req.query.groupStatus,groupDate:req.query.groupDate};
      break;
    case "diploma":
      sqlstr = "p_rptStudentDiploma";
      //@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(50),@certID varchar(50),@status varchar(50),@agencyID varchar(50),@groupHost int,@groupDept1 int,@groupKindID int,@groupCertID int,@groupStatus int,@groupAgencyID int,@groupDate varchar(20)
      params = {host:req.query.host, startDate:req.query.startDate,endDate:req.query.endDate,kindID:req.query.kindID,certID:req.query.certID,status:req.query.status,agencyID:req.query.agencyID,groupHost:req.query.groupHost,groupDept1:req.query.groupDept1,groupKindID:req.query.groupKindID,groupCertID:req.query.groupCertID,groupStatus:req.query.groupStatus,groupAgencyID:req.query.groupAgencyID,groupDate:req.query.groupDate};
      break;
    case "diplomaLast":
      sqlstr = "p_rptStudentDiplomaLast";
      //@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(50),@certID varchar(50),@status varchar(50),@agencyID varchar(50),@groupHost int,@groupDept1 int,@groupKindID int,@groupCertID int,@groupStatus int,@groupAgencyID int,@groupDate varchar(20)
      params = {host:req.query.host, startDate:req.query.startDate,endDate:req.query.endDate,kindID:req.query.kindID,certID:req.query.certID,status:req.query.status,agencyID:req.query.agencyID,groupHost:req.query.groupHost,groupDept1:req.query.groupDept1,groupKindID:req.query.groupKindID,groupCertID:req.query.groupCertID,groupStatus:req.query.groupStatus,groupAgencyID:req.query.groupAgencyID,groupDate:req.query.groupDate};
      break;
    default:
  }
  //console.log("params:", params);
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
      sendsms.sendSMS(req.body.mobile, '', data.recordset[0]["password"], '', "reset_password");
      sqlstr = "writeSSMSlog";
      params = { username: req.body.username, mobile: req.body.mobile, kind: "密码重置", message: data.recordset[0]["password"], registerID: "system." };
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
        sendsms.sendSMS(re[i]["mobile"], re[i]["name"], re[i]["item"], address, "reupload_material");
        sqlstr = "writeSSMSlog";
        params = { username: re[i]["username"], mobile: re[i]["mobile"], kind: "资料不合规通知", message: re[i]["item"], registerID: req.query.registerID };
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

module.exports = router;

var express = require('express');
var router = express.Router();
var db = require("../utils/mssqldb");
var response, sqlstr, params;

/* GET students listing. */
router.get('/', function (req, res, next) {
  var username = req.query.username;
  var password = req.query.password;
  res.send("your input is %s:%s", username, password);
});
/*
router.get('/*', function(req, res, next) {
  // do something...
  next();
});*/

//1a. getCompanyByHost
router.get('/getCompanyByHost', function (req, res, next) {
  var cid = req.get('origin').split("//")[1].split(".")[0];
  //console.log("host:", cid);
  if (cid == "") {
    cid = "spc";
  }
  sqlstr = "select hostNo,hostName,logo from v_hostInfo where hostNo='" + cid + "'";
  params = {};
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

//1b. logout
router.get('/logout', function (req, res, next) {
  params = { username: req.session.user.username, student: 0 };
  sqlstr = "writeStudentLogoutLog";
  let username = req.session.user.username;
  db.excuteProc(sqlstr, params, function (e, re) { });
  req.session.destroy();
  return res.send({ "status": 0, "username": username });
});

//6. get_student
router.get('/get_student', function (req, res, next) {
  sqlstr = "select * from v_studentInfo where username='" + req.query.username + "'";
  params = {};
  //console.log("params:", params);
  db.excuteSQL(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    /*
    //console.log(req);
    let p = "insert into log_get_student(username,ip,host) values('" + req.query.username + "','" + req.ip.match(/\d+\.\d+\.\d+\.\d+/)[0] + "','" + req.subdomains[0] + "')";
    db.excuteSQL(p, {}, function (err1, data1) {
      if (err1) {
        console.log(err);
        let response = { "status": 9 };
        return res.send(response);
      }
    });
    */
    response = data.recordset;
    return res.send(response);
  });
});

//7. getStudentCourseList
router.get('/getStudentCourseList', function (req, res, next) {
  //console.log("session", req.session, req.query.username);
  sqlstr = "select *,[dbo].[getPassCondition](ID) as pass_condition from v_studentCourseList where username='" + req.query.username + "' order by status";
  params = {};
  //console.log("params:", params);
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

//8. getStudentCertPickList
router.get('/getStudentCertPickList', function (req, res, next) {
  sqlstr = "select a.*,b.checked from v_studentCertList a, studentCourseList b where a.ID=b.refID and a.username='" + req.query.username + "' and a.status<2";
  params = {};
  //console.log("session:", req.session.user);
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

//8a. getStudentCertRestList
router.get('/getStudentCertRestList', function (req, res, next) {
  sqlstr = "select * from dbo.getStudentCertRestList('" + req.query.username + "') order by mark, certID";
  params = {};
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

//8b. getStudentCertCourseList
router.get('/getStudentCertCourseList', function (req, res, next) {
  sqlstr = "select * from v_studentCourseList where username='" + req.query.username + "' and status<2";
  params = {};
  //console.log("params:", params);
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

//8c. getExamListByUsername
router.get('/getExamListByUsername', function (req, res, next) {
  sqlstr = "select * from dbo.getExamListByUsername('" + req.query.username + "') order by startDate";
  params = {};
  //console.log("params:", params);
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

//9. getStudentLessonList
router.get('/getStudentLessonList', function (req, res, next) {
  sqlstr = "select * from dbo.getStudentLessonList(" + req.query.refID + ")";
  params = {};
  //console.log("params:", params);
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

//9. getStudentLessonListByUser
router.get('/getStudentLessonListByUser', function (req, res, next) {
  sqlstr = "select * from dbo.getStudentLessonListByUser('" + req.query.username + "')";
  params = {};
  //console.log("params:", params);
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

//9a. getStudentLesson
router.get('/getStudentLesson', function (req, res, next) {
  sqlstr = "select * from dbo.getStudentLesson(" + req.query.ID + ")";
  params = {};
  //console.log("params:", params);
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

//9b. getStudentVideo
router.get('/getStudentVideo', function (req, res, next) {
  sqlstr = "select * from dbo.getStudentVideo(" + req.query.refID + ")";
  params = {};
  //console.log("params:", params);
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

//9c. getStudentCourseware
router.get('/getStudentCourseware', function (req, res, next) {
  sqlstr = "select * from dbo.getStudentCourseware(" + req.query.refID + ")";
  params = {};
  //console.log("params:", params);
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

//11. getStudentExamInfo
router.get('/getStudentExamInfo', function (req, res, next) {
  sqlstr = "select *,dbo.getOnlineExamStatus(paperID) as startExamMsg from v_studentExamList where paperID=" + req.query.paperID;
  params = {};
  //console.log("params:", params);
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

//11a. getStudentQuestionList
router.get('/getStudentQuestionList', function (req, res, next) {
  //firstly check the paper has its questions, if has not, create them now.
  params = { paperID: req.query.paperID, mark: req.query.mark };
  //sqlstr = "exec writeStudentLoginLog @username, @host, @cid";
  sqlstr = "addQuestions4StudentExam";
  db.excuteProc(sqlstr, params, function (e, re) {
    sqlstr = "select * from v_studentQuestionList where refID=" + req.query.paperID;
    params = {};
    //console.log("params:", params);
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
});

//17. getDictionaryList
router.get('/getDictionaryList', function (req, res, next) {
  sqlstr = "select * from dbo.getDictionaryList(@kind) order by ID";
  params = { kind: req.query.kind };
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

//18. get_student_message_List: 不包括已撤销消息
router.get('/get_student_message_List', function (req, res, next) {
  sqlstr = "select * from v_studentMessageInfo where username=@username and status<2 order by ID desc";
  params = { username: req.query.username };
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

//19. get_student_message_info  return: 0 成功  9 其他
router.get('/get_student_message_info', function (req, res, next) {
  sqlstr = "select * from v_studentMessageInfo where ID=@ID";
  params = { ID: req.query.ID };
  db.excuteSQL(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    response = data.recordset;
    //set message status as having been read
    params = { ID: req.query.ID, status: 1 };
    sqlstr = "setMessageReadStatus";
    db.excuteProc(sqlstr, params, function (e, re) { });
    return res.send(response);
  });
});

//20. get_student_diploma_list  return: 0 成功  9 其他
router.get('/get_student_diploma_list', function (req, res, next) {
  if (req.query.certID > "") {
    sqlstr = "select * from v_studentDiplomaList where username=@username and certID=@certID order by certID, endDate desc";
    params = { username: req.query.username, certID: req.query.certID };
  } else {
    sqlstr = "select * from v_studentDiplomaList where username=@username order by certID, endDate desc";
    params = { username: req.query.username };
  }
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

//25. find_student  return: 0 成功  9 其他
router.get('/find_student', function (req, res, next) {
  let find = req.query.find;
  sqlstr = "select username,name,hostName from v_studentInfo where username like('%" + find + "%') or name like('%" + find + "%') order by name";
  params = {};
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

//26. get_cert_list  return: 0 成功  9 其他
router.get('/get_cert_list', function (req, res, next) {
  sqlstr = "select '' as certID, '' as certName union select certID,certName from v_certificateInfo where status=0 and (kindID=0 or host='" + req.session.user.host + "') order by certID";
  params = {};
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

//27. get_reexamine_diploma_list  return: 0 成功  9 其他
router.get('/get_reexamine_diploma_list', function (req, res, next) {
  sqlstr = "select dbo.getReexamineDiploma('" + req.query.username + "')";
  params = {};
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

//28. get_student_need2complete  return: 0 成功  9 其他
router.get('/get_student_need2complete', function (req, res, next) {
  sqlstr = "select dbo.getMissingItems(" + req.query.enterID + ") as item";
  params = {};
  db.excuteSQL(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    response = data.recordset[0]["item"];
    return res.send(response);
  });
});

/* POST students listing. */
/*
router.post('/*', function(req, res, next) {
  // do something...
  next();
});
*/

//1. login
router.post('/login', function (req, res, next) {
  //console.log("ip",req.ip.match(/\d+\.\d+\.\d+\.\d+/), req.host, req.hostname, req.subdomains[0]);
  //console.log("req.host:", req.host, req.hostname, req.ip.match(/\d+\.\d+\.\d+\.\d+/)[0], req.subdomains[0]);
  //console.log(req.get('origin').split("//")[1].split(".")[0]);
  var username = req.body.username;
  var ip = req.ip.match(/\d+\.\d+\.\d+\.\d+/)[0];
  var domain = req.hostname;
  var cid = req.get('origin');
  if(cid){
    cid = cid.split("//")[1].split(".")[0];
  }
  if (!cid) {
    cid = "spc";
  }

  sqlstr = "select * from dbo.studentLogin('" + req.body.username + "','" + req.body.password + "','" + cid + "')";
  db.excuteSQL(sqlstr, {}, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, "msg":"发生未知错误。" };
      return res.send(response);
    }

    let response = { "status": data.recordset[0]["e"], "msg": data.recordset[0]["msg"], "username": req.body.username, "hostName": data.recordset[0]["hostName"], "newCourse": data.recordset[0]["newCourse"] };
    var user = { "username": req.body.username, "name": data.recordset[0]["name"], "host": cid, "ip": ip, "domain": req.subdomains, "auditor":0 }
    if (data.recordset[0]["e"] == 0) {
      req.session.user = user;
    }

    params = { username: req.body.username, ip: ip, host: cid, student: 0, memo: 'passwd:' + req.body.password + '  re:' + data.recordset[0]["e"] };
    //sqlstr = "exec writeStudentLoginLog @username, @host, @cid";
    sqlstr = "writeStudentLoginLog";
    db.excuteProc(sqlstr, params, function (e, re) { });
    return res.send(response);
  });
});

//2. new_student   return: 0 成功  1 用户已存在  9 其他
router.post('/new_student', function (req, res, next) {
  sqlstr = "updateStudentInfo";
  var cid = req.get('origin').split("//")[1].split(".")[0];
  if (!cid) {
    cid = "spc";
  }
  var fromID = req.body.fromID;
  if(fromID > ''){
      fromID += ".";
  }
  params = { mark: 0, username: req.body.username, name: req.body.name, password: req.body.password, kindID: req.body.kindID, companyID: req.body.companyID, dept1: req.body.dept1, dept1Name: req.body.dept1Name, dept2: req.body.dept2, dept3: req.body.dept3, job: req.body.job,linker:'',job_status:1, mobile: req.body.mobile, phone: req.body.phone, email: req.body.email, address: req.body.address, limitDate: req.body.limitDate, unit:req.body.unit, dept:req.body.dept,ethnicity:'',IDaddress:'',bureau:'',IDdateStart:'',IDdateEnd:'',experience: req.body.experience, fromID: fromID, memo: req.body.memo, education: req.body.education, host: cid, registerID: req.body.username };
  //console.log("add params:", params);
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, "msg":"发生未知错误。" };
      return res.send(response);
    }
    //console.log('returnValue :', data.returnValue);
    let p = "exec writeSQLlog '" + sqlstr + "','" + JSON.stringify(params) + "','" + req.body.username + "','" + req.ip.match(/\d+\.\d+\.\d+\.\d+/)[0] + "','" + cid + "'";
    db.excuteSQL(p, {}, function (err1, data1) { });
    let msg = "注册成功";
    //return: 0 success; other error:1 the user already exist  2 the user not exist  3 the companyID wrong.
    if(data.returnValue==1){
      msg = "该用户已经存在，不能注册。";
    }
    if(data.returnValue==2){
      msg = "该用户不存在。";
    }
    if(data.returnValue==3){
      msg = "所属公司错误。";
    }
    let response = { "status": data.returnValue, "msg": msg };
    return res.send(response);
  });
});

//4. change_passwd  return: 0 成功  1 用户不存在  2 用户禁用  3 邮箱错误  9 其他
router.post('/change_passwd', function (req, res, next) {
  sqlstr = "updateStudentPassword";
  //@username varchar(50),@password varchar(50),@email varchar(50),@host varchar(50),@ip varchar(50),@registerID varchar(50)
  params = { username: req.body.username, password: req.body.password, mobile: req.body.mobile, host: req.session.user.host, registerID: req.body.username };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    let response = { "status": data.returnValue, "msg": "" };
    return res.send(response);
  });
});

//5. update_student  return: 0 成功 2 用户不存在 9 其他
router.post('/update_student', function (req, res, next) {
  sqlstr = "updateStudentInfo";
  var fromID = req.body.fromID;
  if(fromID > ''){
      fromID += ".";
  }
  params = { mark: 1, username: req.body.username, name: req.body.name, password: req.body.password, kindID: req.body.kindID, companyID: req.body.companyID, dept1: req.body.dept1, dept1Name: req.body.dept1Name, dept2: req.body.dept2, dept3: req.body.dept3, job: req.body.job,linker:'', job_status:1, mobile: req.body.mobile, phone: req.body.phone, email: req.body.email, address: req.body.address, limitDate: req.body.limitDate, unit:req.body.unit, dept:req.body.dept,ethnicity:'',IDaddress:'',bureau:'',IDdateStart:'',IDdateEnd:'',experience: req.body.experience, fromID: fromID, memo: req.body.memo, education:req.body.education, host: req.session.user.host, registerID: req.body.username };
  //console.log("update params:", params);
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, "msg":"发生未知错误。" };
      return res.send(response);
    }
    let msg = "注册成功";
    //return: 0 success; other error:1 the user already exist  2 the user not exist  3 the companyID wrong.
    if(data.returnValue==1){
      msg = "该用户已经存在，不能注册。";
    }
    if(data.returnValue==2){
      msg = "该用户不存在。";
    }
    if(data.returnValue==3){
      msg = "所属公司错误。";
    }
    let response = { "status": data.returnValue, "msg": msg };
    return res.send(response);
  });
});

//10. save_video_currentTime  return: 0 成功  9 其他
router.post('/update_video_currentTime', function (req, res, next) {
  sqlstr = "update_video_currentTime";
  params = { ID: req.body.ID, currentTime: req.body.currentTime };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    let response = { "status": data.returnValue, "msg": "" };
    return res.send(response);
  });
});

//10a. update_courseware_currentPage  return: 0 成功  9 其他
router.post('/update_courseware_currentPage', function (req, res, next) {
  sqlstr = "update_courseware_currentPage";
  params = { ID: req.body.ID, currentPage: req.body.currentPage };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    let response = { "status": data.returnValue, "msg": "" };
    return res.send(response);
  });
});

//12. update_student_question_answer  return: 0 成功  9 其他
router.post('/update_student_question_answer', function (req, res, next) {
  sqlstr = "update_student_question_answer";
  params = { ID: req.body.ID, answer: req.body.answer.split('').sort().join('') };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    let response = { "status": data.returnValue, "msg": "" };
    return res.send(response);
  });
});

//12a. update_student_exam_secondRest  return: 0 成功  9 其他
router.post('/update_student_exam_secondRest', function (req, res, next) {
  sqlstr = "update_student_exam_secondRest";
  params = { paperID: req.body.paperID, secondRest: req.body.secondRest };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    let response = { "status": data.returnValue, "msg": "" };
    return res.send(response);
  });
});

//13. submit_student_exam  return: 0 成功  9 其他
router.post('/submit_student_exam', function (req, res, next) {
  sqlstr = "submit_student_exam";
  params = { paperID: req.body.paperID };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    let response = { "status": data.returnValue, "msg": "" };
    return res.send(response);
  });
});

//14. add_student_certificate  return: 0 成功  1 已有相同课程不能重复添加  9 其他
router.post('/add_student_certificate', function (req, res, next) {
  let msg = "";
  sqlstr = "select status, msg from dbo.getStudentMaterialsOmit(@username,@certID,@mark,0)";
  params = { certID: req.body.certID, mark: req.body.mark, username: req.body.username };
  db.excuteSQL(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9, "msg": msg };
      return res.send(response);
    }
    if (data.recordset[0]["status"] > 0) {
      msg = data.recordset[0]["msg"];
      let response = { "status": data.recordset[0]["status"], "msg": msg };
      return res.send(response);
    } else {
      sqlstr = "addStudentCert";
      params = { certID: req.body.certID, mark: req.body.mark, username: req.body.username, reexamine: req.body.reexamine, currDiplomaID:'', currDiplomaDate:'' };
      //console.log(params);
      db.excuteProc(sqlstr, params, function (err, data1) {
        if (err) {
          console.log(err);
          let response = { "status": 9, "msg": msg };
          return res.send(response);
        }
        if (data1.returnValue == 1) {
          msg = "不能重复添加课程。"
        }
        let response = { "status": data1.returnValue, "msg": msg };
        return res.send(response);
      });
    }
  });
});

//15. remove_student_certificate  return: 0 成功  9 其他
router.post('/remove_student_certificate', function (req, res, next) {
  sqlstr = "delStudentCert";
  params = { ID: req.body.ID, mark: req.body.mark };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    let response = { "status": data.returnValue, "msg": "" };
    return res.send(response);
  });
});

//16. submit_student_feedback  return: 0 成功  9 其他
router.post('/submit_student_feedback', function (req, res, next) {
  sqlstr = "submit_student_feedback";
  params = { username: req.body.username, mobile: req.body.mobile, email: req.body.email, item: req.body.item, kindID: req.body.kindID, refID: req.body.refID, host: req.session.user.host };
  db.excuteProc(sqlstr, params, function (err, data) {
    if (err) {
      console.log(err);
      let response = { "status": 9 };
      return res.send(response);
    }
    let response = { "status": data.returnValue, "msg": "" };
    return res.send(response);
  });
});

//28. set_reexamine_diploma  return: 0 成功  9 其他
router.post('/set_reexamine_diploma', function (req, res, next) {
  sqlstr = "setReexamineDiploma";
  let list = req.body.list;
  for(let i in list){
    params = { enterID: list[i]["enterID"], item: list[i]["item"]};
    db.excuteProc(sqlstr, params, function (err, data) {
      if (err) {
        console.log(err);
        let response = { "status": 9 };
        return res.send(response);
      }
    });
  }
  let response = { "status": 0, "msg": "" };
  return res.send(response);
});

module.exports = router;

var express = require('express');
var router = express.Router();
var db = require("../utils/mssqldb");
const md5 = require('js-md5');
var response, sqlstr, params;

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

//101. login
router.post('/login', function(req, res, next) {
  //console.log("ip",req.ip.match(/\d+\.\d+\.\d+\.\d+/), req.host, req.hostname, req.subdomains[0]);
  //console.log("req.host:", req.host, req.hostname, req.ip.match(/\d+\.\d+\.\d+\.\d+/)[0], req.subdomains[0]);
  var username = req.body.username;
  var ip = req.ip.match(/\d+\.\d+\.\d+\.\d+/)[0];
  var domain = req.hostname;
  var cid = req.subdomains[0];
  if (!cid) {
    cid = "spc";
  }

  sqlstr = "select * from dbo.userLogin('" + req.body.username + "','" + md5(req.body.password) + "','" + cid + "')";
  db.excuteSQL(sqlstr, {}, function(err, data){
    if (err) {
      console.log(err);
      let response = {"status":9};
      return res.send(response);
    }
    let dt = data.recordset[0];
    let response = {"status":dt["e"], "msg":dt["msg"], "username":req.body.username, "hostName":dt["hostName"], "name":dt["realName"], "auditor":1, "teacher":dt["teacher"]};
    var user = {"username":dt["username"], "name":dt["realName"], "host":cid, "ip":ip, "domain": req.subdomains, "auditor":1, "teacher":""};
    if(dt["teacher"]>0){
      //教师登录，转换为指定的学生
      user = {"username":"120109196812070029", "name":"测试学员", "host":cid, "ip":ip, "domain": req.subdomains, "auditor":1, "teacher":req.body.username};
    }
    if(dt["e"]==0){
      req.session.user = user;
    }
    params = {username:dt["username"], ip:ip, host:cid, student:1, memo:'passwd:' + req.body.password + '  re:' + dt["e"]};
    //sqlstr = "exec writeStudentLoginLog @username, @host, @cid";
    sqlstr = "writeStudentLoginLog";
    db.excuteProc(sqlstr, params, function(e, re){});
    return res.send(response);
  });
});


//102. logout
router.get('/logout', function(req, res, next) {
  params = {username:req.session.user.username, student:1};
  sqlstr = "writeStudentLogoutLog";
  db.excuteProc(sqlstr, params, function(e, re){});
  res.send({"status": 0, "msg": "成功退出。"});
  req.session.destroy();
});

module.exports = router;

var express = require('express');
var router = express.Router();
var db = require("../utils/mssqldb");
var response, sqlstr, params;

/* GET home page. */
router.get('/', function(req, res, next) {
  //res.render('index', { title: 'Express' });
  console.log("The user order paramaters ip: %s  host: %s", ip, host)
  res.send(response);
});

//8b. getCourseListByCertID
router.get('/getCourseListByCertID', function(req, res, next) {
  sqlstr = "select * from dbo.getCourseListByCertID('" + req.query.certID + "')";
  params = {};
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



module.exports = router;

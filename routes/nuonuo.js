var express = require('express');
var router = express.Router();
var db = require("../utils/mssqldb");
// 安装插件
// npm instyall crypto-js -S
//================加密================
const crypto = require("crypto-js");
var response, sqlstr, params;


//支付回调接口
router.post('/oderPaymentReturn', function(req, res, next) {
  console.log("body:", req.body, "query:", req.query);
  let hexData = req.body.data;
  let encryptedHexStr  = crypto.enc.Hex.parse(hexData);
  let encryptedBase64Str  = crypto.enc.Base64.stringify(encryptedHexStr);
  let decryptedData  = crypto.AES.decrypt(encryptedBase64Str, key, {
      mode: crypto.mode.ECB,
      padding: crypto.pad.Pkcs7
  });
  let text = decryptedData.toString(crypto.enc.Utf8);
  console.log(text);
  return res.send(text);
});

//退款回调接口
router.post('/nuonuo/oderRefundReturn', function(req, res, next) {
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
  });
});



module.exports = router;

var express = require('express');
var router = express.Router();
var db = require("../utils/mssqldb");
// 安装插件
// npm instyall crypto-js -S
//================加密================
const crypto = require("crypto-js");
var response, sqlstr, params;
const key = "A475E209DF12449D";

function decrypt(word, keyStr){
  let keyHex = crypto.enc.Utf8.parse(keyStr); //
  let base64 = crypto.enc.Base64.parse(word);
  let src =  crypto.enc.Base64.stringify(base64);
  var decrypt = crypto.AES.decrypt(src, keyHex, 
  {
       mode:crypto.mode.ECB, 
       padding: crypto.pad.Pkcs7
  });
  return decrypt.toString(crypto.enc.Utf8);
}

//支付回调接口
router.post('/oderPaymentReturn', function(req, res, next) {
  // console.log("oderPaymentReturn body:", req.body);
  const hexData = req.body.param;
  // console.log("hexData:", hexData);
  let text = decrypt(hexData,key);
  let re = eval("(" + text + ")");
  // 返回解密结果
  sqlstr = "setAutoPayInfo";
  params = {kind:0, enterID:re.customerOrderNo, amount:re.amount, payStatus:re.payStatus, payTime:re.payTime, payType:re.payType, customerTaxnum:re.customerTaxnum, orderNo:re.orderNo, outOrderNo:re.outOrderNo, subject:re.subject, userId:re.userId, memo:re.sellerNote, phone:""};
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      response = {"status":9};
      return res.send(response);
    }
    response = {"status":0};
    //console.log(response);
    return res.send(response);
  });
});

//退款回调接口
router.post('/oderRefundReturn', function(req, res, next) {
  // console.log("oderRefundReturn body:", req.body);
  let hexData = req.body.param;
  let text = decrypt(hexData,key);
  console.log("text", text);
  let re = eval("(" + text + ")");
  sqlstr = "setAutoPayInfo";
  params = {kind:1, enterID:0, amount:re.refundAmount, payStatus:re.payStatus, payTime:re.refundTime, payType:"", customerTaxnum:"", orderNo:re.orderNo, outOrderNo:re.originOrderNo, subject:"", userId:"", memo:"", phone:""};
  console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      response = {"status":9};
      return res.send(response);
    }
    response = {"status":0};
    //console.log(response);
    return res.send(response);
  });
});

//发票回调接口
router.post('/oderInvoiceReturn', function(req, res, next) {
  console.log("oderInvoiceReturn body:", req.body, "query:", req.query);
  let hexData = req.body.param;
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


module.exports = router;

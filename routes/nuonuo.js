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

function encrypt(word, keyStr) {
  if (typeof word === "object") {
    try {
      // eslint-disable-next-line no-param-reassign
      word = JSON.stringify(word);
    } catch (error) {
      console.log("encrypt error:", error);
    }
  }
  let keyHex = crypto.enc.Utf8.parse(keyStr); //
  const dataHex = crypto.enc.Utf8.parse(word);
  const encrypted = crypto.AES.encrypt(dataHex, keyHex, {
    mode: crypto.mode.ECB,
    padding: crypto.pad.Pkcs7
  });
  return encrypted.toString();
}

//支付回调接口
router.post('/oderPaymentReturn', function(req, res, next) {
  // console.log("oderPaymentReturn body:", req.body);
  const hexData = req.body.param;
  // console.log("hexData:", hexData);
  let text = decrypt(hexData, key);
  // 返回解密结果
  let re = eval("(" + text + ")");
  // 记录返回结果
  params = {kind:0, enterOrder:re.customerOrderNo, amount:re.amount, payStatus:re.payStatus, payTime:re.payTime, payType:re.payType, customerTaxnum:re.customerTaxnum, orderNo:re.orderNo, outOrderNo:re.outOrderNo, subject:re.subject, userId:re.userId, memo:re.sellerNote, phone:""};
  sqlstr = "setAutoPayReturn";
  let params1 = {kind:"oderPaymentReturn", memo:text, memo1:JSON.stringify(params)};
  //console.log("params:", params);
  db.excuteProc(sqlstr, params1, function(err, data){
  });
  sqlstr = "setAutoPayInfo";
  //console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      response = {"status":9};
      return res.send(response);
    }
    response = encrypt({"code":"200","describe":"回传成功","result":null}, key);
    console.log("oderPaymentReturn response:", response);
    return res.send(response);
  });
});

//退款回调接口
router.post('/oderRefundReturn', function(req, res, next) {
  // console.log("oderRefundReturn body:", req.body);
  let hexData = req.body.param;
  let text = decrypt(hexData,key);
  // console.log("text", text);
  let re = eval("(" + text + ")");
  // 记录返回结果
  params = {kind:1, enterOrder:'', amount:re.refundAmount, payStatus:re.payStatus, payTime:re.refundTime, payType:"", customerTaxnum:"", orderNo:re.originOrderNo, outOrderNo:re.orderNo, subject:"", userId:"", memo:"", phone:""};
  sqlstr = "setAutoPayReturn";
  let params1 = {kind:"oderPaymentReturn", memo:text, memo1:JSON.stringify(params)};
  //console.log("params:", params);
  db.excuteProc(sqlstr, params1, function(err, data){
  });
  sqlstr = "setAutoPayInfo";
  // console.log("params:", params);
  db.excuteProc(sqlstr, params, function(err, data){
    if (err) {
      console.log(err);
      response = {"status":9};
      return res.send(response);
    }
    response = encrypt({"code":"200","describe":"回传成功","result":null}, key);
    //console.log(response);
    return res.send(response);
  });
});

//发票回调接口
router.post('/oderInvoiceReturn', function(req, res, next) {
  let text = req.body.content;
  let re = eval("(" + text + ")");
  if(re && re.c_status && re.c_status==1){
    let date = new Date(re.c_kprq * 1);
    const Y = date.getFullYear() + '-';
    const M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
    const D = (date.getDate()<10 ? '0'+date.getDate() : date.getDate());
    const dt = Y + M + D;
    params = {kind:2, enterOrder:'', amount:re.c_hjje, payStatus:re.c_status, payTime:dt, payType:re.c_invoice_line, customerTaxnum:re.taxnum, orderNo:re.c_orderno, outOrderNo:re.c_fphm, subject:re.invoiceItems[0].itemName, userId:re.buyername, memo:re.c_url, phone:re.phone};
    // 记录返回结果
    sqlstr = "setAutoPayReturn";
    let params1 = {kind:"oderPaymentReturn", memo:text, memo1:JSON.stringify(params)};
    //console.log("params:", params);
    db.excuteProc(sqlstr, params1, function(err, data){
    });
    sqlstr = "setAutoPayInfo";
    // console.log("params:", params);
    db.excuteProc(sqlstr, params, function(err, data){
      if (err) {
        console.log(err);
        response = {"status":9};
        return res.send(response);
      }
    });
  }
  response = {"status":"0000","message":"同步成功"};
  return res.send(response);
});

module.exports = router;

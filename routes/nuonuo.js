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
  console.log("oderPaymentReturn body:", req.body, "query:", req.query);
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
router.post('/oderRefundReturn', function(req, res, next) {
  console.log("oderRefundReturn body:", req.body, "query:", req.query);
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

//发票回调接口
router.post('/oderInvoiceReturn', function(req, res, next) {
  console.log("oderInvoiceReturn body:", req.body, "query:", req.query);
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


module.exports = router;

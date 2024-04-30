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
  const data = {
    // param: 'qaL5EVspsZ8Cu/5L7OPbtzXKtE+YS3aNM10dNscwQvYVEA1n9nj1/eZ4P2dDwxLGU0Fzn6U7B4rPzG5s2z0o3BF/2ml4x+3WPtOHsKlKxZ6ILsQSKPKyodv4ta2bnVj/a1aMzhL/HSDRwpt0y+hcPfaAOlWNn5EXwmTZE+HlCRFFRhUiGFd8XH6sclO5QAiuYgioRifjHbgKh9rg+Jwmd5HUSplWrke3RmktdJlObCOFsL58lSCYwxVftHZwXfZXauWgSiw5u28qhdW4v7ApVw=='
    param: 'L61otBN8s1lueZYOnK+5Uz5wz51J4VNwy4gHm2d/+k635X/ilt6YVTPnpg7ewt5V+8uipRF1IW7ZLmmrsI1g68jkou0KAxFdweqgnvYVCosX/WwrtLkp5R9chAkdN9+RFw6q7/CEWH3XE4y5x3+0DF0WlPSMu/2gLEOGiDNKvAD+UcDG+JWsVCwY4w3y/E4cqLe2y/1wSczKdvZKTLpxQzSTCUuv5owsDiIDfNk5Ofl+ba45NLabI3Jh9cCYoodsFxqPfUj54EVyMWvOkIVw3nivhTFkBDiy4syUkmfauvg8A4NSwRh5WMbslBV1STx2mwsV7PE3jfXPlh8LS16xXy1sO2AXJBHRWXt33tqTbq/ihaAf6/PmDnLrmUmfniL1wpSfQ6bk+vEfO+v8lEp8XiXjWiP41hD3laOORq1004Kk6n4eD/Wr2XEKDMQ28r5whmo5vDHFZ6NJsQZv/9Mg7A=='
  }
  // console.log("oderPaymentReturn body:", req.body, "query:", req.query);
  let hexData = data.param;
  console.log("hexData:", hexData);
  let text = decrypt(hexData,key);
  let re = eval("(" + text + ")");
  // 返回解密结果
  console.log("text:",re, re.amount);
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

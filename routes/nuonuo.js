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
    response = encrypt({"code":"200","describe":"回传成功","result":null}, key);
    //console.log(response);
    return res.send(response);
  });
});

//发票回调接口
router.post('/oderInvoiceReturn', function(req, res, next) {
  // console.log("oderInvoiceReturn body.content:", req.body.content);
  // let hexData = req.body.param;
  // let encryptedHexStr  = crypto.enc.Hex.parse(hexData);
  // let encryptedBase64Str  = crypto.enc.Base64.stringify(encryptedHexStr);
  // let decryptedData  = crypto.AES.decrypt(encryptedBase64Str, key, {
  //     mode: crypto.mode.ECB,
  //     padding: crypto.pad.Pkcs7
  // });
  // let text = decryptedData.toString(crypto.enc.Utf8);
  // console.log(text);
  let text = req.body.content;
  let re = eval("(" + text + ")");
  console.log("oderInvoiceReturn text", text, re);
  sqlstr = "setAutoPayInfo";
  /*
  re = {
    "terminalNumber":"",
    "c_cjsj":"1715688101000",
    "naturalPersonFlag":"0",
    "managerCardNo":"",
    "c_saletaxnum":"52310106751466629W",
    "c_payee":"",
    "c_remark":"",
    "cipherText":"",
    "qrCode":"01,32,,24312000000136634917,0.01,20240514,,1DD6",
    "c_invoice_line":"pc",
    "c_paper_pdf_url":"",
    "c_kprq":"1715688107000",
    "c_status":"1",
    "c_checker":"",
    "specificFactor":0,
    "c_orderno":"20240514200006941204927",
    "bankAccount":"",
    "c_imgUrls":"https://inv.jss.com.cn/fp2/AlbMom_Ik6qbApwQ0iNlQ4lOdARo2dQ7RUuw90jyh_Ui3ZfLy5Ll4oPVWHoGXY9fHBm_9C9lyR3fEewKcAP9jw.jpg",
    "machineCode":"",
    "telephone":"",
    "c_qdxmmc":"",
    "c_salerAddress":"上海市杨浦区黄兴路158号长阳创谷内D楼D103",
    "checkCode":"",
    "c_clerk":"刘小川",
    "c_url":"https://inv.jss.com.cn/fp2/AlbMom_Ik6qbApwQ0iNlQ5RN64wgkx6KQdUKs5hoQSHSktgWBUEuWKEQFf8wO8uSwK4uBL06Zu5WG5eSqb5QRw.pdf",
    "invoiceItems":[{
      "itemSpec":"",
      "invoiceLineProperty":"0",
      "favouredPolicyName":"",
      "itemUnit":"",
      "itemCode":"3070201020000000000",
      "favouredPolicyFlag":"01",
      "itemSumAmount":"0.01",
      "itemCodeAbb":"非学历教育服务",
      "itemNum":"",
      "itemName":"消防设施操作员中级培训费",
      "isIncludeTax":"true",
      "deduction":"0.00",
      "itemSelfCode":"",
      "zeroRateFlag":"",
      "immediateTaxReturnType":"",
      "itemIndex":"1",
      "itemPrice":"",
      "itemTaxAmount":"0.00",
      "itemTaxRate":"0.03"
    }],
    "phone":"13331987897",
    "c_bhsje":"0.01",
    "dt_invoicedate":"1715688100000",
    "c_gxsj":"1715688100000",
    "c_hjje":"0.01",
    "allElectronicInvoiceNumber":"24312000000136634917",
    "managerCardType":"",
    "c_salerTel":"021-52132119",
    "c_ofd_url":"https://inv.jss.com.cn/fp2/DtTCGikOBJs9AM7snCYhI2e-X66Ovm8BYkeda5IqSD_q50hlVLuK5Y4_WoZBEVo9h-X9rjx6aWSjMrN730Ne9w.ofd",
    "c_qdbz":0,
    "c_salerAccount":"上海银行股份有限公司浦东分行31619103001905464",
    "buyerManagerName":"",
    "email":"",
    "address":"",
    "additionalElementList":[],
    "c_hjse":"0.00",
    "c_clerkId":"",
    "c_deptId":"",
    "c_fphm":"24312000000136634917",
    "c_fpdm":"",
    "c_fpqqlsh":"24051420014001423596",
    "productOilFlag":"0",
    "extensionNumber":"666",
    "additionalElementName":"",
    "taxnum":"",
    "c_salerName":"上海智能消防学校",
    "buyername":"上海测试"
  };*/
  if(re && re.c_status && re.c_status==1){
    let dt = new Date(new Date("1900-01-01").getTime() + (re.c_kprq - 2) * 3600 * 24 * 1000 - 3600 * 8 * 1000 + 60 * 1000);
    dt = dt.Format("yyyy-MM-dd hh:mm");
    params = {kind:2, enterID:0, amount:re.c_hjje, payStatus:re.c_status, payTime:dt, payType:re.c_invoice_line, customerTaxnum:re.taxnum, orderNo:re.c_fphm, outOrderNo:re.c_orderno, subject:re.invoiceItems[0].itemName, userId:re.buyername, memo:re.c_url, phone:re.phone};
    console.log("params:", params);
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

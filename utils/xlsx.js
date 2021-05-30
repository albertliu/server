var express = require('express');
var router = express.Router();
var db = require("./mssqldb");
var multer = require('multer');
var util = require('util');
var fs = require('fs');
var path = require('path');
const ejsExcel = require('ejsExcel');
var uploadHome = './users/upload/';

var createFolder = function(folder){
  try{
      fs.accessSync(folder); 
  }catch(e){
      fs.mkdirSync(folder);
  }  
};

const xlsx ={
    //data: json格式 {name1:"value1", name2:"value2"}
    //fileSource: 带路径的word模板文件名，占位符{name1}，将由data中的变量值替换
    async writeExcel(data, fileSource, fileDest, callback) {
        var buf=fs.readFileSync(fileSource);
        //Load the docx file as a binary

        // buf is a nodejs buffer, you can either write it to a file or do anything else with it.
        //fs.writeFileSync(path.resolve(__dirname, 'output.docx'), buf);
        //fs.appendFileSync(fileDest, buf);  //append data to a file, creating the file if it does not yet exist. data can be a string or a Buffer.
        //fs.writeFileSync(fileDest, buf);    //When file is a filename, writes data to the file, replacing the file if it already exists. data can be a string or a buffer.
        //渲染Excel表格
        ejsExcel.renderExcel(buf, data).then(function(exlBuf) {
            fs.writeFileSync(fileDest, exlBuf);
            //console.log("生成" + fileDest);
            callback(fileDest);
        }).catch(function(err) {
            console.error(err);
        });
    }
}
module.exports = xlsx;

var express = require('express');
var router = express.Router();
var fs = require('fs');
var path = require('path');
/*
const excel = require('node-xlsx');
var uploadHome = './users/public/temp/';
var fn = uploadHome + Date.now() + '.xlsx';

var createFolder = function(folder){
  try{
      fs.accessSync(folder); 
  }catch(e){
      fs.mkdirSync(folder);
  }  
};

const xlsx_free ={
    //data: json格式 [{name: 'firstSheet',data: [[1, 2, 3],[4, 5, 6]]},...] 每个nmae 为一个新的sheet
    //保存到一个随机文件名中
    async writeExcel(data, callback) {
        fs.writeFileSync(fn,excel.build(xlsxObj),"binary");
        callback(fn);
    }
}*/
module.exports = xlsx_free;

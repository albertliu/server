var express = require('express');
var router = express.Router();
var fs = require('fs');
var path = require('path');
const JSZIP  = require('jszip');

var zips = new JSZIP();
var uploadHome = './users/upload/';

var createFolder = function(folder){
  try{
      fs.accessSync(folder); 
  }catch(e){
      fs.mkdirSync(folder);
  }  
};

//读取目录及文件
function readDir(obj, nowPath) {
    let files = fs.readdirSync(nowPath);//读取目录中的所有文件及文件夹（同步操作）
    files.forEach(function (fileName, index) {//遍历检测目录中的文件
        console.log(fileName, index);//打印当前读取的文件名
        let fillPath = nowPath + "/" + fileName;
        let file = fs.statSync(fillPath);//获取一个文件的属性
        if (file.isDirectory()) {//如果是目录的话，继续查询
            let dirlist = zip.folder(fileName);//压缩对象中生成该目录
            readDir(dirlist, fillPath);//重新检索目录文件
        } else {
            obj.file(fileName, fs.readFileSync(fillPath));//压缩目录添加文件
        }
    });
}

//开始压缩文件:fList=["upload/photos/12.png","upload/photos/13.png"], target="temp/111.zip"
const zip ={
    //data: json格式 {name1:"value1", name2:"value2"}
    //fileSource: 带路径的word模板文件名，占位符{name1}，将由data中的变量值替换
    async doZIP(fList,target) {
        //添加文件到目标
        for (var i in fList){
            zips.file(path.basename(fList[i]), fs.readFileSync(fList[i]));
        }
        zips.generateAsync({//设置压缩格式，开始打包
            type: "nodebuffer",//nodejs用
            compression: "DEFLATE",//压缩算法
            compressionOptions: {//压缩级别
                level: 9
            }
        }).then(function (content) {
            fs.writeFileSync(target, content, "utf-8");//将打包的内容写入target中
        });
    }
}
module.exports = zip;

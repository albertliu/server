var express = require('express');
var router = express.Router();
var db = require("./mssqldb");
var multer = require('multer');
var util = require('util');
var fs = require('fs');
var path = require('path');
const PizZip = require('pizzip');
const Docxtemplater = require('docxtemplater');
const DocxMerger = require('docx-merger');
var uploadHome = './users/upload/';

var createFolder = function(folder){
  try{
      fs.accessSync(folder); 
  }catch(e){
      fs.mkdirSync(folder);
  }  
};

// The error object contains additional information when logged with JSON.stringify (it contains a properties object containing all suberrors).
function replaceErrors(key, value) {
    if (value instanceof Error) {
        return Object.getOwnPropertyNames(value).reduce(function(error, key) {
            error[key] = value[key];
            return error;
        }, {});
    }
    return value;
}

function errorHandler(error) {
    console.log(JSON.stringify({error: error}, replaceErrors));

    if (error.properties && error.properties.errors instanceof Array) {
        const errorMessages = error.properties.errors.map(function (error) {
            return error.properties.explanation;
        }).join("\n");
        console.log('errorMessages', errorMessages);
        // errorMessages is a humanly readable message looking like this :
        // 'The tag beginning with "foobar" is unopened'
    }
    throw error;
}

const docx ={
    //data: json格式 {name1:"value1", name2:"value2"}
    //fileSource: 带路径的word模板文件名，占位符{name1}，将由data中的变量值替换
    async writeDoc(data, fileSource, fileDest) {

        //Load the docx file as a binary
        var content = fs
            .readFileSync(fileSource, 'binary');
            //.readFileSync(path.resolve(__dirname, fileSource), 'binary');

        var zip = new PizZip(content);
        var doc;
        try {
            doc = new Docxtemplater(zip);
        } catch(error) {
            // Catch compilation errors (errors caused by the compilation of the template : misplaced tags)
            errorHandler(error);
        }

        //set the templateVariables
        /*
        doc.setData({
            first_name: 'John',
            last_name: 'Doe',
            phone: '0652455478',
            description: 'New Website'
        });*/
        doc.setData(data);

        try {
            // render the document (replace all occurences of {first_name} by John, {last_name} by Doe, ...)
            doc.render()
        }
        catch (error) {
            // Catch rendering errors (errors relating to the rendering of the template : angularParser throws an error)
            errorHandler(error);
        }

        var buf = doc.getZip()
                    .generate({type: 'nodebuffer'});

        // buf is a nodejs buffer, you can either write it to a file or do anything else with it.
        //fs.writeFileSync(path.resolve(__dirname, 'output.docx'), buf);
        //fs.appendFileSync(fileDest, buf);  //append data to a file, creating the file if it does not yet exist. data can be a string or a Buffer.
        fs.writeFileSync(fileDest, buf);    //When file is a filename, writes data to the file, replacing the file if it already exists. data can be a string or a buffer.
    },

    //merge docx files to one file
    async mergeDocx(fileSource, fileDest) {
        //delete the destination file if it exist
        if(fs.existsSync(fileDest)) {
            fs.unlinkSync(fileDest, function(err){
                if(err){
                    res.send("文件删除失败。");
                    return;
                }
            });
        }
        //read files
        let arr = new Aarry();
        for (var i in fileSource){
            arr.push(fs.readFileSync(fileSource[i], 'binary'));
        }

        //merge them
        var files = new DocxMerger({},arr);
        
        //SAVING THE DOCX FILE
        files.save('nodebuffer',function (data) {
            // fs.writeFile("output.zip", data, function(err){/*...*/});
            fs.writeFileSync(fileDest, data, function(err){/*...*/});
        });

        //delete files
        for (var i in fileSource){
            if(fs.existsSync(fileSource[i])) {
                fs.unlinkSync(fileSource[i], function(err){
                    if(err){
                        return;
                    }
                });
            }
        }
    }
}
module.exports = docx;

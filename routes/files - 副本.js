var express = require('express');
var router = express.Router();
var db = require("../utils/mssqldb");
var multer = require('multer');
var util = require('util');
var fs = require('fs');
var response, sqlstr, params;
var uploadHome = './users/upload/';

var createFolder = function(folder){
  try{
      fs.accessSync(folder); 
  }catch(e){
      fs.mkdirSync(folder);
  }  
};
/* GET home page. */
router.get('/', function(req, res, next) {
  //res.render('index', { title: 'Express' });
  console.log("The user order paramaters ip: %s  host: %s", ip, host)
  res.send(response);
});

  var storage = multer.diskStorage({
    destination: function (req, file, cb) { 
      var uploadFolder = "";
      switch(req.query.upID){
        case "student_photo":
          uploadFolder = "students/photos/";
          break;
        case "IDcard":
          uploadFolder = "students/IDcards/";
          break;
        case "diploma":
          uploadFolder = "students/diplomas/";
          break;
        default:
          uploadFolder = "others/";
      }
      uploadFolder = uploadHome + uploadFolder;
      createFolder(uploadFolder);
      cb(null, uploadFolder);
    },
    filename: function (req, file, cb) {
      var fn = "";
      var filenameArr = file.originalname.split('.');
      switch(req.query.upID){
        case "student_photo":   //student photo will name with the username and original type, and write the path to studentInfo.
          fn = req.query.username;
          break;
        case "IDcard":   //IDcard image will name with the username and original type, and write the path to studentInfo(if need two faces, will deal with two files).
          fn = req.query.username;
          break;
        case "diploma":   //diploma image will keep the original name and type, and write the path to diplomaInfo(if not exist, add new record.).
          fn = req.query.username;
          break;
        default:
          fn = file.originalname + '-' + Date.now();
      }
      cb(null, fn + "." + filenameArr[filenameArr.length-1]);
    }
  });
  
  var upload = multer({ storage: storage });
//6a. uploadSingle
router.post('/uploadSingle', upload.single('avatar'), function(req, res, next) {

  console.log("req.query.upID:", req.query.upID);
  res.send({"file":req.file.filename});
});

router.get('/form', function(req, res, next){
  var form = fs.readFileSync('./form.html', {encoding: 'utf8'});
  res.send(form);
});

module.exports = router;

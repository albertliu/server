var createError = require('http-errors');
var express = require('express');
var session = require('express-session');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var bodyParser = require('body-parser');
const redisStore = require('connect-redis')(session);
const cors = require('cors');
const redis = require('redis');
const compression = require('compression');
const schedule = require('node-schedule');
const face = require("./utils/face");
require('events').EventEmitter.defaultMaxListeners = 0;

var redisConfig = require("./utils/redisdb");
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var studentsRouter = require('./routes/students');
var publicRouter = require('./routes/public');
var courseRouter = require('./routes/course');
var filesRouter = require('./routes/files');
var outfilesRouter = require('./routes/files');
var alisRouter = require('./routes/alis');
var nuonuoRouter = require('./routes/nuonuo');
var bodyParser = require('body-parser');

let redisClient = redis.createClient(redisConfig.sessionStore);

var app = express();

var hosts = ['','znxf.','spc.','shm.','yuc.','lix.','jia.','jiah.','tai.','wen.','ding.','zich.'];
//var hosts = ['','znxf.','spc.','shm.'];
var ports = ['',':3000',':3003',':8082'];
var orig = [];
for(var v of hosts){
  for(var x of ports){
    orig.push('http://' + v + 'shznxfxx.cn' + x);
    orig.push('http://' + v + 'localhost' + x);
    orig.push('http://www.shznxfxx.cn' + x);
  }
  orig.push('https://shznxfxx.cn');
}
//console.log("origin:",orig);
var corsOptions = {
  //origin: ['http://spc.shznxfxx.cn:3000','http://spc.shznxfxx.cn:3003','http://shm.shznxfxx.cn:3000','http://znxf.shznxfxx.cn:3000','http://znxf.shznxfxx.cn:3003','http://shznxfxx.cn:3000','http://spc.localhost:3000','http://shm.localhost:3000','http://znxf.localhost:3000','http://127.0.0.1:3000','http://localhost:8082','http://znxf.localhost:8082','http://spc.localhost:8082','http://yuc.localhost:8082','http://shznxfxx.cn','http://spc.shznxfxx.cn','http://znxf.shznxfxx.cn','http://shznxfxx.cn:8082','http://spc.shznxfxx.cn:8082','http://znxf.shznxfxx.cn:8082'],
  origin: orig,
  credentials: true,
  optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204
}
app.use(cors(corsOptions));  //跨域访问
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({limit: '50mb', extended: true}));

redisClient.on('error', console.error);
app.use(express.static('users'))
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(cookieParser('sessiontest'));

app.use(session({
  name : redisConfig.appID,
  secret : redisConfig.session_secret,
  resave : true,
  rolling:true,
  saveUninitialized : false,
  cookie : redisConfig.cookie,
  //store : new redisStore(redisConfig.sessionStore)
  store : new redisStore({client: redisClient})
}));

//验证用户session
app.use(function(req, res, next) {
  //console.log("url:",req.get('origin'))
  if (!req.session.user) {
      if (req.url.endsWith("/login") || req.url.endsWith("/logout") || req.url.endsWith("/change_passwd") || req.url.endsWith("/new_student") || req.url.startsWith("/public/") || req.url.startsWith("/outfiles/") || req.url.startsWith("/nuonuo/") || req.url.startsWith("/alis/")) {
          console.log("url:",req.get('origin'));
          next(); //如果请求的地址是登录则通过，进行下一个请求
      } else {
          //console.log("sessionExpire url：",req.url,req.session.user);
          res.send({"username": ""});
      }
  } else {
      next();//如果已经登录，则可以进入
  }
});
app.disable('etag');
app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/students', studentsRouter);
app.use('/outfiles', outfilesRouter);
app.use('/public', publicRouter);
app.use('/course', courseRouter);
app.use('/files', filesRouter);
app.use('/nuonuo', nuonuoRouter);
app.use('/alis', alisRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  console.log("error",err.message)
  res.render('error');
});

// *  *  *  *  *  *
// ┬  ┬  ┬  ┬  ┬  ┬
// │  │  │  │  │  |
// │  │  │  │  │  └ 星期几，取值：0 - 7，其中 0 和 7 都表示是周日
// │  │  │  │  └─── 月份，取值：1 - 12
// │  │  │  └────── 日期，取值：1 - 31
// │  │  └───────── 时，取值：0 - 23
// │  └──────────── 分，取值：0 - 59
// └─────────────── 秒，取值：0 - 59（可选）
// 当前时间的秒值为 10 时执行任务，如：2018-7-8 13:25:10
let job = schedule.scheduleJob('55 55 23 * * *', async () => {
  let x = await face.addFullFace();
  let y = await face.delFreezFace();
  console.log("addFullFace log:", new Date());
});

module.exports = app;

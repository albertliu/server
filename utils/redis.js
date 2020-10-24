var ioRedis = require('ioredis');
var logger = require('./logger');
var redis = new ioRedis();
// 默认127.0.0.1:6379
// redis 链接错误
redis.on("error", function (error) {
    logger.error(error);
});
exports.redis = redis;

module.exports = {
  apps: [{
    name: 'elearning',           // 你的应用名称
    script: './bin/www',           // 你的入口文件（根据实际情况修改，比如 app.js）
    cwd: 'D:/project/elearning/elearningserver', // 项目根目录绝对路径
    
    // 进程管理（解决数据库超时自动重启的关键）
    autorestart: true,            // 进程退出后自动重启（默认就是 true）
    max_restarts: 10,             // 防止无限循环，最多重启10次
    min_uptime: '10s',            // 如果运行少于10s就挂了，计为异常重启
    
    // 让 Node 自身在 1000M 时就开始拼命回收，PM2 的 1.5G 作为最后的“物理保险”
    node_args: '--max-old-space-size=1000',
    // 内存限制
    max_memory_restart: '1.5G'
  }]
};
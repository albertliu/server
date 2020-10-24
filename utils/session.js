
function checkSession(req, res){
    if(!req.session.user){
        res.send("请重新登录。");
    }
}

module.exports = checkSession;
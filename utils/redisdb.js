const redisConfig = {
    appID : "elearning",
    session_secret : 'Asecret123-ShElearning2020',
    cookie : {
        maxAge : 10 * 24 * 60 * 60 * 1000,     //user page cookie expire(ms)  10 days
        secure: false,
        httpOnly: true,
        sameSite: 'none',
    },
    sessionStore : {
        host : "127.0.0.1",
        port : "6379",
        pass : "ad08Shi93!asT",
        db : 1,
        ttl : 24 * 60 * 60,       //redis store session expire(s) 24 hour
        logErrors : true
    }
};

module.exports = redisConfig;
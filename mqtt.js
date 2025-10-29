const aedes = require("aedes")();
const server = require("net").createServer(aedes.handle);
const PORT = 1883;
const URL = "47.100.186.148";

const mqtt = require("mqtt");

// 用户认证信息（示例），包含用户名、密码和ClientID
const USERS = [
  { username: "test", password: "111", clientId: "client1" },
  { username: "sender1", password: "Sh123456", clientId: "client_sender1" },
  { username: "sender2", password: "Sh123456", clientId: "client_sender2" },
  { username: "sender3", password: "Sh123456", clientId: "client_sender3" },
  { username: "reciever1", password: "FXcw123456", clientId: "client_sender1" },
  { username: "reciever2", password: "FXcw123456", clientId: "client_sender2" }
];

server.listen(PORT, function () {
  console.log(`MQTT server is running on port ${PORT}`);
});

// 用户认证方法，验证ClientID、用户名和密码
aedes.authenticate = (client, username, password, callback) => {
  const user = USERS.find(item => item.username === username.toString());
  // console.log("user:", client.id, username.toString(), password.toString(), user);
  if (!user) {
    // 用户名不存在
    const error = new Error("Authentication Failed: Username not found");
    error.returnCode = 4;
    return callback(error, null);
  }

  if (user.password !== password.toString()) {
    // 密码错误
    const error = new Error("Authentication Failed: Incorrect password");
    error.returnCode = 4;
    return callback(error, null);
  }

  if (user.clientId !== client.id) {
    // ClientID不匹配
    const error = new Error(`Authentication Failed: ClientID "${client.id}" is not authorized`);
    error.returnCode = 4;
    return callback(error, null);
  }

  // 认证成功
  callback(null, true);
};

aedes.on("client", (client) => {
  console.log(`Client Connected: ${client.id}`);
});

aedes.on("clientDisconnect", (client) => {
  console.log(`Client Disconnected: ${client.id}`);
});

aedes.on("publish", (packet, client) => {
  console.log(`Message Published: ${packet.topic.toString()}:${packet.payload.toString()}`);
});

const clientId = "client1";
const username = "test";
const password = "111";
const client = mqtt.connect(`mqtt://${URL}:${PORT}`, {
  clientId,
  username,
  password,
  // ...other options
});

const topic = 'testt'
const qos = 0

client.subscribe(topic, { qos }, (error) => {
  if (error) {
    console.log('subscribe error:', error)
    return
  }
  console.log(`Subscribe to topic '${topic}'`)
});

const payload = 'nodejs mqtt test,就离开就离开,0.223,2036-12-09 23:22:15'
client.publish(topic, payload, { qos }, (error) => {
  if (error) {
    console.error(error)
  }
})

client.on('message', (topic, payload) => {
  console.log('Received Message:', topic, payload.toString())
})
const PORT = 1883;
const URL = "47.100.186.148";
const mqtt = require("mqtt");

const clientId = "client_sender1";
const username = "reciever1";
const password = "FXcw123456";
console.log("url:", `mqtt://${URL}:${PORT}`);
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

client.on('message', (topic, payload) => {
  console.log('Received Message:', topic, payload.toString())
})
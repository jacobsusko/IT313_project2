// Author: Jacob
const express = require('express')
const https = require('https')
const http = require('http');
const fs = require('fs');
const app = express()
const { Client} = require('pg');
const { nextTick } = require('process');
const port = 7304

const properToken = 'pQrz7Yr3gX'

// Not sure if own SSL is required separate from one already obtained since it is a different node.js server 

// Create HTTPS server
// const server = https.createServer({
//   key: fs.readFileSync('/home/ec2-user/node-website/privkey.pem'),
//   cert: fs.readFileSync('/home/ec2-user/node-website/fullchain.pem'),
//   passphrase: 'C3n7r@1^73@NN'
// }, app);

const client = new Client({
    user: 'postgres',
     host: 'localhost',
     database: 'room_occupancy',
     password: 'C3n7r@1^73@NN',
     port: 5432, // Default PostgreSQL port
  });
  
// Connect the client to the PostgreSQL database
client.connect()
    .then(() => console.log('Connected to PostgreSQL database'))
    .catch(err => console.error('Connection error', err));

app.use(express.json());

// Authentication Middleware using API Keys
const authenticate = (req, res, next) => {
  const authToken = req.headers['apikey'];

  if (!authToken || authToken !== properToken) {
    console.log(authToken);
    return res.status(401).send('Unauthorized');
  }
  next();
}

// id = room_num
// Figure out how to adjust and edit to fit
// API to Put New Data into Database
app.put('/room_occupancy/:hall/:room', authenticate, async (req, res) => {
    const { hall, room } = req.params;
    const { occupancy } = req.body
  
    try {
      const id =  `${hall}_${room}`;

      const query = `
        UPDATE occupancy."Study_Room"
        SET occupied = $1
        WHERE hall_name = $2 AND room_num = $3
        `;
      const values = [occupancy, hall, parseInt(room)];
      await client.query(query, values);
      res.status(200).send('Success');
    } catch (error) {
      console.error(error);
      res.status(500).send('fail');
    }
});


// GET for testing
app.get('/room_occupancy', authenticate, async (req, res) => {
  try {
    const query = 'SELECT * FROM occupancy."Study_Room"';
    const { rows } = await client.query(query);
    res.status(200).json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('failed');
  }
})

app.listen(port, () => {
    
})

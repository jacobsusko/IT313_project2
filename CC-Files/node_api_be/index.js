// Author: Jacob
const express = require('express')
const https = require('https')
const http = require('http');
const fs = require('fs');
const app = express()
const { Client} = require('pg');
const port = 7304
const port2 = 7305

const properToken = 'pQrz7Yr3gX' 


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
    const client = new Client({
      user: 'centralteam',
      host: 'localhost',
      database: 'occupancy',
      password: 'C3n7r@1^73@NN',
      port: 3254, // Default PostgreSQL port
    });
  
    // Connect the client to the PostgreSQL database
    client.connect()
        .then(() => console.log('Connected to PostgreSQL database'))
        .catch(err => console.error('Connection error', err));
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
      
      // Possible solutions if BE can not find solution to constant sending
        // only update when room being set to occupied as True:
          // will result in no repeated emails being sent out since they won't be sent while the room is occupied
          // will still be ready to send email once room is set to empty and will not reset
        // only update when there is change in room state (false > true or true > false)
          // will work
          // will require additional get call to database
      const query2 = `
        UPDATE occupancy."Watch_Room"
        SET already_emailed = false
        WHERE room_hall = $1 AND room_num = $2
        `;
      const params = [hall, parseInt(room)];
      await client.query(query2, params);
      res.status(200).send('Success');
    } catch (error) {
      console.error(error);
      res.status(500).send('fail');
    }

    await client.end();

});


// GET for testing
app.get('/room_occupancy', authenticate, async (req, res) => {
  const client = new Client({
    user: 'centralteam',
    host: 'localhost',
    database: 'occupancy',
    password: 'C3n7r@1^73@NN',
    port: 3254, // Default PostgreSQL port
  });

  // Connect the client to the PostgreSQL database
  client.connect()
      .then(() => console.log('Connected to PostgreSQL database'))
      .catch(err => console.error('Connection error', err));
      const { hall, room } = req.params;
      const { occupancy } = req.body

  try {
    const query = 'SELECT * FROM occupancy."Study_Room"';
    const { rows } = await client.query(query);
    res.status(200).json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('failed');
  }

  await client.end();
})


const httpServer = http.createServer(app);

// Create HTTPS server
const server = https.createServer({
  key: fs.readFileSync('privkey.pem'),
  cert: fs.readFileSync('fullchain.pem'),
  passphrase: 'C3n7r@1^73@NN'
}, app);

httpServer.listen(port2, () => {
})

server.listen(port, () => {    
})

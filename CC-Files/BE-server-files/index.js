const express = require('express')
const http = require('http')
const app = express()
const { Client} = require('pg');
const port = 7304


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


// API Post Function to Post to Database
app.post('/room_occupancy', async (req, res) => {
    const { hall, room, occupancy } = req.body;
    console.log(req.body);
    if (!hall || !room || !occupancy) {
        return res.status(400).send('Missing data')
    }

try {
    // try to send data to the database
    const query = `INSERT INTO Study_Room (hall, room, occupancy)
    VALUES ($1, $2, $3)
    RETURNING id;
    `;
    const values = [hall, room, occupancy];

    const result = await Client.query(query, values);
    res.status(201).send({message: ''})

} catch (eer) {
    console.error(err);
    res.status(500).send('error occured');
}

})

// Figure out how to adjust and edit to fit
// API to Put New Data into Database
app.put('/room_occupancy', async (req, res) => {
    const id = parseInt(req.params.id)
    const { name, email } = req.body
  
    client.query(
      'UPDATE users SET name = $1, email = $2 WHERE id = $3',
      [, email, id],
      (error, res) => {
        if (error) {
          throw error
        }
        response.status(200).send(`User modified with ID: ${id}`)
      })
})


// GET for testing
app.get('/room_occupancy', async (req, res) => {
  try {
    const query = 'SELECT * FROM Study_Room;';
    const { rows } = await client.query(query);
    res.status(200).json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('failed');
  }
})

app.listen(port, () => {
    
})

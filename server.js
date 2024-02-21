const express = require('express');
const https = require('https'); // Import the HTTPS module
const http = require('http');
const path = require("path");
const fs = require('fs'); // Enables interaction with the file system
const bodyParser = require('body-parser');
const { Client } = require('pg');
const session = require('express-session');
const pgSession = require('connect-pg-simple')(session);

const app = express();
// const server = http.createServer(app);

app.use(bodyParser.urlencoded({extended: false}));


// HTTPS server setup
const server = https.createServer({
    // Your SSL certificate and private key are not needed here as Cloudflare handles SSL termination
    // However, you still need to provide dummy values for the key and cert parameters
    key: fs.readFileSync('cloudflare-key.pem'),
    cert: fs.readFileSync('cloudflare-cert.pem'),
    passphrase: 'C3n7r@1^73@NN'
}, app);

app.use(bodyParser.urlencoded({extended: false}));

// Define a middleware function to check if the user is logged in
function requireLogin(req, res, next) {
    // Assuming you have a session or a variable to check if the user is logged in
    // For example, you might have a session variable like req.session.loggedIn
    if (req.session && req.session.loggedIn) {
        // If the user is logged in, call the next middleware function
        next();
    } else {
        // If the user is not logged in, redirect to the login page
        res.redirect('/');
    }
}

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

// Session configuration
app.use(session({
    // store: new pgSession({
    //     pool: client, // Use the same PostgreSQL client for session storage
    //     tableName: 'user_sessions' // Table name to store sessions
    // }),
    secret: 'your_secret_key', // Secret used to sign the session ID cookie
    resave: false,
    saveUninitialized: false
}));


// Apply the middleware to specific routes that you want to protect
app.get('/building.html', requireLogin, (req, res) => {
    // This route is protected by the requireLogin middleware
    // Only logged-in users can access it
    res.sendFile(path.join(__dirname, './express/building.html'));
});


// Serve static files from the 'express' directory
app.use(express.static(path.join(__dirname, './express')));


app.get('/',(req,res) => {
    res.sendFile(path.join(__dirname,'express/index.html'));
});

// Add a new route to handle the request to retrieve email and password data
app.get('/userData', requireLogin, async (req, res) => {
    try {
    // Retrieve email and password from session
    const username = req.session.username;
    const password = req.session.password;

    const query = 'SELECT * FROM occupancy."Student" WHERE username = $1 AND password = $2';
    const params = [username, password];
    const result = await client.query(query, params);
    if (result.rows.length > 0) {
        const userData = result.rows[0];
        // Send email and password data as JSON response
        res.json(userData);
    } else {
        res.status(404).json({ error: 'User not found'});
    }

    } catch (err){
        console.error('Error executing query', err);
        res.send("Internal server error");       
    }
});

app.get('/logout', (req, res) => {
    req.session.destroy(err => {
        if (err) {
            console.error('Error destroying session:', err);
            res.status(500).json({error: 'Internal server error'});
        } else {
            res.redirect('/')
        }
    });
});


app.post('/login', async (req, res) => {
    try{
        const username = req.body.username;
        const password = req.body.password;

           const result = await client.query(`
               SELECT *
               FROM occupancy."Student"
               WHERE username = $1 AND password = $2;
              `, [username, password]);


                if (result.rows.length > 0) {
                    req.session.loggedIn = true;
                    // If login is successful, store email and password in session
                    req.session.username = username;
                    req.session.password = password;
                    console.log(req.session.username);
                    // res.redirect('/dashboard'); // Redirect to dashboard after login
                    res.sendFile(path.join(__dirname, 'express', 'building.html'));
                } else {
                    res.send("<div align ='center'><h2>Invalid Username or password</h2></div><br><br><div align='center'><a href='./index.html'>login again<a><div>");
                }
    } catch (err){
        console.error('Error executing query', err);
        res.send("Internal server error");       
    }
});

// app.get('/dashboard', (req, res) => {
//     // Retrieve email and password from session
//     const email = req.session.email;
//     const password = req.session.password;

//     res.send(`Email: ${email}, Password: ${password}`); // Example usage of stored data
// });


server.listen(443, function(){
    console.log("server is listening on port: 443");
});

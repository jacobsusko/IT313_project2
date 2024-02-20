const express = require('express');
const http = require('http');
const path = require("path");
const bodyParser = require('body-parser');
const { Client } = require('pg');
const session = require('express-session');
const pgSession = require('connect-pg-simple')(session);

const app = express();
const server = http.createServer(app);

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
    database: 'login',
    password: 'Seiden!977',
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
app.get('/home.html', requireLogin, (req, res) => {
    // This route is protected by the requireLogin middleware
    // Only logged-in users can access it
    res.sendFile(path.join(__dirname, './express/home.html'));
});

// Apply the middleware to specific routes that you want to protect
app.get('/merch.html', requireLogin, (req, res) => {
    // This route is protected by the requireLogin middleware
    // Only logged-in users can access it
    res.sendFile(path.join(__dirname, './express/merch.html'));
});

app.get('/about.html', requireLogin, (req, res) => {
    // This route is protected by the requireLogin middleware
    // Only logged-in users can access it
    res.sendFile(path.join(__dirname, './express/about.html'));
});

app.get('/music.html', requireLogin, (req, res) => {
    // This route is protected by the requireLogin middleware
    // Only logged-in users can access it
    res.sendFile(path.join(__dirname, './express/music.html'));
});

app.get('/tours.html', requireLogin, (req, res) => {
    // This route is protected by the requireLogin middleware
    // Only logged-in users can access it
    res.sendFile(path.join(__dirname, './express/tours.html'));
});


// Serve static files from the 'express' directory
app.use(express.static(path.join(__dirname, './express')));


app.get('/',(req,res) => {
    res.sendFile(path.join(__dirname,'express/login.html'));
});

// Add a new route to handle the request to retrieve email and password data
app.get('/userData', requireLogin, async (req, res) => {
    try {
    // Retrieve email and password from session
    const email = req.session.email;
    const password = req.session.password;

    const query = 'SELECT * FROM login.login WHERE username = $1 AND password = $2';
    const params = [email, password];
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
        const email = req.body.email;
        const password = req.body.password;

            const result = await client.query(`
                SELECT *
                FROM login.login
                WHERE username = $1 AND password = $2;
                `, [email, password]);


                if (result.rows.length > 0) {
                    req.session.loggedIn = true;
                    // If login is successful, store email and password in session
                    req.session.email = email;
                    req.session.password = password;
                    // res.redirect('/dashboard'); // Redirect to dashboard after login
                    res.sendFile(path.join(__dirname, 'express', 'home.html'));
                } else {
                    res.send("<div align ='center'><h2>Invalid email or password</h2></div><br><br><div align='center'><a href='./login.html'>login again<a><div>");
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

server.listen(3000, function(){
    console.log("server is listening on port: 3000");
});
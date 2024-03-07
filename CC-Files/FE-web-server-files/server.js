// Created by: David
const {express, https, http, fs, path, bodyParser, session,
    Client, pgSession} = require('./server-files/modules'); //import all modules from module.js
const routes = require('./server-files/routes');

const app = express();

app.use(bodyParser.urlencoded({ extended: false })); // Add this line to parse urlencoded request bodies

app.use(session({
    secret: 'your_secret_key',
    resave: false,
    saveUninitialized: false
}));

app.use((req, res, next) => {
    if (req.secure) {
        next();
    } else {
        const expectedHostname = 'www.jmustudyhall.com';
        res.redirect('https://' + expectedHostname + req.url);
    }
});

app.use((req, res, next) => {
    if (req.secure && req.hostname === '3.128.186.180') {
        const expectedHostname = 'www.jmustudyhall.com';
        res.redirect('https://' + expectedHostname + req.url);
    } else {
        next();
    }
});

// Use routes
app.use('/', routes);

// Create HTTP server
const httpServer = http.createServer(app);

// Create HTTPS server
const server = https.createServer({
    key: fs.readFileSync('privkey.pem'),
    cert: fs.readFileSync('fullchain.pem'),
    passphrase: 'C3n7r@1^73@NN'
}, app);

// Start servers
httpServer.listen(80, () => {
    console.log('HTTP server running on port 80');
});

server.listen(443, function(){
    console.log("HTTPS server is listening on port 443");
});

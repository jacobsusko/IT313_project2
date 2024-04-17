// Created by: David
const {express, https, http, fs, path, bodyParser, session,
    Client, pgSession} = require('./server-files/modules'); //import all modules from module.js
const routes = require('./server-files/routes');

const app = express();
app.use(express.json());

app.use(bodyParser.urlencoded({ extended: false })); // Add this line to parse urlencoded request bodies

app.use(session({
    secret: 'your_secret_key',
    resave: false,
    saveUninitialized: false
}));

// Create HTTPS server
const httpsServer = https.createServer({
    key: fs.readFileSync('privkey.pem'),
    cert: fs.readFileSync('fullchain.pem'),
    passphrase: 'C3n7r@1^73@NN'
}, app);

// Create HTTP server
const httpServer = http.createServer(app);


// app.use((req, res, next) => {
//     // List of specific URLs to redirect
//     const urlsToRedirect = ['http://3.128.186.180', 'http://3.128.186.180:80', 'http://3.128.186.180:443', 'https://3.128.186.180', 'https://3.128.186.180:80', 'https://3.128.186.180:443']; // Add your desired URLs here

//     // Check if the requested URL path is in the list of URLs to redirect
//     if (urlsToRedirect.includes(req.url)) {
//         // Redirect the client to the desired URL
//         const redirectTo = 'https://www.jmustudyhall.com'; // Replace with your desired URL
//         return res.redirect(301, redirectTo);
//     }

//     // If the requested URL is not in the list, proceed with normal request handling
//     next();
// });

// app.use((req, res, next) => {
//     if (req.secure) {
//         next();
//     } else {
//         const expectedHostname = 'www.jmustudyhall.com';
//         res.redirect('https://' + expectedHostname + req.url);
//     }
// });

// app.use((req, res, next) => {
//     if (req.secure && (req.hostname === '3.128.186.180' || req.hostname === '3.128.186.180:443')) {
//         const expectedHostname = 'www.jmustudyhall.com';
//         res.redirect('https://' + expectedHostname + req.url);
//     } else {
//         next();
//     }
// });

// Use routes
app.use('/', routes);


// Start servers
httpServer.listen(80, () => {
    console.log('HTTP server running on port 80');
});

httpsServer.listen(443, function(){
    console.log("HTTPS server is listening on port 443");
});

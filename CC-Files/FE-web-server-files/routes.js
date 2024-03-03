const { express, path } = require('./modules');
const router = express.Router();
const { login, signup, logout, requireLogin } = require('./userController');
const { getUserData, getHalls, getRoomOccupancy } = require('./dataController');

// Home page route
router.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../express', 'index.html'));
});

// Login route
router.post('/login', login);

// Signup route
router.post('/signup', signup);

// Logout route
router.get('/logout', logout);

// Protected route
router.get('/building.html', requireLogin, (req, res) => {
    console.log(req.session.loggedIn);
    console.log(req.session);
    res.sendFile(path.join(__dirname, '../express', 'building.html'));
});

// Data routes
router.get('/userData', requireLogin, getUserData);
router.get('/halls', requireLogin, getHalls);
router.get('/getRoomOccupancy', requireLogin, getRoomOccupancy); // Add getRoomOccupancy route

// Serve static files
router.use(express.static(path.join(__dirname, '../express')));

module.exports = router;

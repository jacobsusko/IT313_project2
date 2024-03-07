// Created by: David
const { express, path, Client } = require('./modules');
const router = express.Router();
const { login, signup, logout, requireLogin, requireLoginEmp, requireEitherLogin } = require('./userController');
const { getUserData, getHalls, getRoomOccupancy, getCredentials, updateRoom, updateFlag, updateEmail, 
    updatePassword, resetFlag } = require('./dataController');

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
router.get('/building.html', requireEitherLogin, (req, res) => {
    res.sendFile(path.join(__dirname, '../express', 'building.html'));
});
router.get('/UserSettings.html', requireEitherLogin, (req, res) => {
    res.sendFile(path.join(__dirname, '../express', 'UserSettings.html'));
});
router.get('/schedulling.html', requireLogin, (req, res) => {
    res.sendFile(path.join(__dirname, '../express', 'schedulling.html'));
});

// Data routes
// Author: Teo, with assistance from David
router.get('/userData', requireEitherLogin, getUserData);
router.get('/halls', requireEitherLogin, getHalls);
router.get('/getRoomOccupancy', requireEitherLogin, getRoomOccupancy); // Add getRoomOccupancy route
router.get('/getCredentials', requireEitherLogin, getCredentials);

router.post('/updateRoom', requireLoginEmp, updateRoom);
router.post('/resetFlag', requireLoginEmp, resetFlag);
router.post('/updateFlag', requireEitherLogin, updateFlag);
// Author: Austin, with assistance from David
router.post('/updateEmail', requireEitherLogin, updateEmail);
router.post('/updatePassword', requireEitherLogin, updatePassword);



// Serve static files
router.use(express.static(path.join(__dirname, '../express')));

module.exports = router;

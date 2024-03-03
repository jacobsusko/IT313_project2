const { Client, path } = require('./modules');

async function login(req, res) {
    const client = new Client({
        user: 'postgres',
        host: 'localhost',
        database: 'room_occupancy',
        password: 'C3n7r@1^73@NN',
        port: 5432,
    });

    try {
        await client.connect();
        const username = req.body.username;
        const password = req.body.password;

        const result = await client.query(`
            SELECT *
            FROM occupancy."Student"
            WHERE username = $1 AND password = $2;
        `, [username, password]);

        await client.end();

        if (result.rows.length > 0) {
            req.session.loggedIn = true;
            req.session.username = username;
            req.session.password = password;
            res.redirect('/building.html')
        } else {
            res.send("<div align='center'><h2>Invalid Username or password</h2></div><br><br><div align='center'><a href='./index.html'>login again<a><div>");
        }
    } catch (err) {
        console.error('Error executing query', err);
        res.send("Internal server error");
    }
}

async function signup(req, res) {
    const client = new Client({
        user: 'postgres',
        host: 'localhost',
        database: 'room_occupancy',
        password: 'C3n7r@1^73@NN',
        port: 5432,
    });

    try {
        await client.connect();
        const username = req.body.username;
        const password = req.body.password;
        const email = req.body.email;
        const fname = req.body.fname;
        const lname = req.body.lname;

        const studentResult = await client.query(`
            SELECT *
            FROM occupancy."Student"
            WHERE username = $1 OR email = $2;
        `, [username, email]);
        const employeeResult = await client.query(`
            SELECT *
            FROM occupancy."Employee"
            WHERE username = $1 OR email = $2;
        `, [username, email]);

        if (studentResult.rows.length > 0 || employeeResult.rows.length > 0) {
            res.send("<div align ='center'><h2>Username/Email already in use</h2></div><br><br><div align='center'><a href='./signup.html'>Register Again<a><div>");
            await client.end();
        } else {
            const sql = 'INSERT INTO occupancy."Student" (username, first_name, last_name, email, password) VALUES ($1, $2, $3, $4, $5)';
            const sqldata = [username, fname, lname, email, password];
            client.query(sql, sqldata, (err, result) => {
                if (err) {
                    client.end();
                    console.log(err);
                    res.send("<div align ='center'><h2>Internal Server Error</h2></div><br><br><div align='center'><a href='./signup.html'>Register Again<a><div>");
                    return;
                } else {
                    client.end();
                    res.send("<div align ='center'><h2>User Added Successfully</h2></div><br><br><div align='center'><a href='./index.html'>Log in<a><div>");
                }
            });
        }
    } catch (err) {
        console.error('Error executing query', err);
        res.send("Internal server error");
    }
}

function logout(req, res) {
    req.session.destroy(err => {
        if (err) {
            console.error('Error destroying session:', err);
            res.status(500).json({error: 'Internal server error'});
        } else {
            res.redirect('/');
        }
    });
}

// Modify requireLogin middleware to check if user is logged in
function requireLogin(req, res, next) {
    if (req.session && req.session.loggedIn) {
        console.log(req.session);
        console.log(req.session.loggedIn);
        next(); // Proceed to the next middleware if user is logged in
    } else {
        res.redirect('/'); // Redirect to the login page if user is not logged in
    }
}

module.exports = {
    login,
    signup,
    logout,
    requireLogin
};

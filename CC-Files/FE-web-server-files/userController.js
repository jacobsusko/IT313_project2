// Created by: David
const { Client, path } = require('./modules');

async function login(req, res) {
    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
    });

    try {
        await client.connect();
        const username = req.body.username;
        const password = req.body.password;

        // Query the Student table
        let result = await client.query(`
            SELECT *
            FROM occupancy."Student"
            WHERE username = $1 AND password = $2;
        `, [username, password]);

        if (result.rows.length > 0) {
            // console.log('Student Found');
            await client.end();
            req.session.loggedIn = true;
            req.session.username = username;
            req.session.password = password;
            return res.redirect('/building.html'); // Return to exit function
        }

        // If not found in Student, check Employee table
        result = await client.query(`
            SELECT *
            FROM occupancy."Employee"
            WHERE username = $1 AND password = $2;
        `, [username, password]);

        await client.end();

        if (result.rows.length > 0) {
            // console.log('Employee Found');
            req.session.loggedInEmp = true;
            req.session.username = username;
            req.session.password = password;
            return res.redirect('/building.html'); // Return to exit function
        }

        // If not found in either table, return invalid message
        // return res.send("<div align='center'><h2>Invalid Username or password</h2></div><br><br><div align='center'><a href='./index.html'>login again<a><div>");
        return res.status(200).send(`
                    <script>
                        alert('Invalid Username or password');
                        window.location.href = './signup.html';
                    </script>
                    `)

    } catch (err) {
        console.error('Error executing query', err);
        return res.send("Internal server error");
    }
}

// Author: Teo, with assistance from David
async function signup(req, res) {
    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
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
            // res.send("<div align ='center'><h2>Username/Email already in use</h2></div><br><br><div align='center'><a href='./signup.html'>Register Again<a><div>");
            res.status(200).send(`
            <script>
                alert('Username/Email already in use');
                window.location.href = './signup.html';
            </script>
            `)
            await client.end();
        } else {
            const sql = 'INSERT INTO occupancy."Student" (username, first_name, last_name, email, password) VALUES ($1, $2, $3, $4, $5)';
            const sqldata = [username, fname, lname, email, password];
            client.query(sql, sqldata, (err, result) => {
                if (err) {
                    client.end();
                    console.log(err);
                    // res.send("<div align ='center'><h2>Internal Server Error</h2></div><br><br><div align='center'><a href='./signup.html'>Register Again<a><div>");
                    res.status(200).send(`
                    <script>
                        alert('Internal Server Error');
                        window.location.href = './signup.html';
                    </script>
                    `)
                    return;
                } else {
                    client.end();
                    // res.send("<div align ='center'><h2>User Added Successfully</h2></div><br><br><div align='center'><a href='./index.html'>Log in<a><div>");
                    res.status(200).send(`
                    <script>
                        alert('User Added Successfully');
                        window.location.href = './index.html';
                    </script>
                    `)
                }
            });
        }
    } catch (err) {
        console.error('Error executing query', err);
        res.send("Internal server error");
    }
}

// Author: Robbie, with assistance from David
async function signupEmp(req, res) {
    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
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
            // res.send("<div align ='center'><h2>Username/Email already in use</h2></div><br><br><div align='center'><a href='./newadmin.html'>Register Again<a><div>");
            res.status(200).send(`
                    <script>
                        alert('Username/Email already in use');
                        window.location.href = './newadmin.html';
                    </script>
                    `)
            await client.end();
        } else {
            const sql = 'INSERT INTO occupancy."Employee" (username, first_name, last_name, email, password) VALUES ($1, $2, $3, $4, $5)';
            const sqldata = [username, fname, lname, email, password];
            client.query(sql, sqldata, (err, result) => {
                if (err) {
                    client.end();
                    console.log(err);
                    // res.send("<div align ='center'><h2>Internal Server Error</h2></div><br><br><div align='center'><a href='./signup.html'>Register Again<a><div>");
                    res.status(200).send(`
                    <script>
                        alert('Internal Server Error');
                        window.location.href = './signup.html';
                    </script>
                    `)
                    return;
                } else {
                    client.end();
                    // res.send("<div align ='center'><h2>Employee Added Successfully</h2></div><br><br><div align='center'><a href='./index.html'>Log in<a><div>");
                    res.status(200).send(`
                    <script>
                        alert('Employee Added Successfully');
                        window.location.href = './index.html';
                    </script>
                    `)
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
        next(); // Proceed to the next middleware if user is logged in
    } else {
        // res.status(200).send("You are not logged in as a Student.<br><div align='center'><a href='./building.html'>Building Page<a><div>");
        res.status(200).send(`
                    <script>
                        alert('You are not logged in as a Student');
                        window.location.href = './building.html';
                    </script>
                    `)
    }
}
function requireLoginEmp(req, res, next) {
    if (req.session && req.session.loggedInEmp) {
        next(); // Proceed to the next middleware if user is logged in
    } else {
        // res.status(200).send("You are not logged in as an Employee.<br><div align='center'><a href='./building.html'>Building Page<a><div>");
        res.status(200).send(`
                    <script>
                        alert('You are not logged in as an Employee');
                        window.location.href = './building.html';
                    </script>
                    `)
    }
}

// Custom middleware function to check for either requireLogin or requireLoginEmp
const requireEitherLogin = (req, res, next) => {
    if (req.session && (req.session.loggedIn || req.session.loggedInEmp)) {
        // User is authenticated as either a regular user or an employee
        next();
    } else {
        res.redirect('/'); // Redirect to the login page if user is not logged in
    }
};

module.exports = {
    login,
    signup,
    signupEmp,
    logout,
    requireLogin,
    requireLoginEmp,
    requireEitherLogin
};

// Created by: David
const { Client, path } = require('./modules');

async function getCredentials(req, res){
    const {loggedIn, loggedInEmp} = req.session;
    res.json({loggedIn, loggedInEmp});
}

// Author: Teo, with assistance from David
async function getUserData(req, res) {
    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
    });

    try {
        await client.connect();
        const username = req.session.username;
        const password = req.session.password;
        let userData;

        let query = 'SELECT * FROM occupancy."Student" WHERE username = $1 AND password = $2';
        let params = [username, password];
        let result = await client.query(query, params);

        if (result.rows.length > 0) {
            userData = result.rows[0];
            await client.end();
        } else {

        query = 'SELECT * FROM occupancy."Employee" WHERE username = $1 AND password = $2';
        params = [username, password];
        result = await client.query(query, params);

        if (result.rows.length > 0) {
            userData = result.rows[0];
            await client.end();
        } else {
            await client.end();
            return res.status(404).json({ error: 'User not found'});
        }
        }
        res.json(userData);

    } catch (err) {
        console.error('Error executing query', err);
        res.send("Internal server error");
    } finally {
        await client.end();
    }
}

// Author: Teo, with assistance from David
async function getHalls(req, res) {
    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
    });

    try {
        await client.connect();
        const query = 'SELECT * FROM occupancy."Hall"';
        const result = await client.query(query);

        if (result.rows.length > 0) {
            const halls = result.rows.map(row => row.hall_name);
            await client.end();
            res.json(halls);
        } else {
            res.status(404).json({ error: 'No Halls found'});
        }

    } catch (err) {
        console.error('Error executing query', err);
        res.send("Internal server error");
    } finally {
        await client.end();
    }
}


// Author: Teo, with assistance from David
async function getRoomOccupancy(req, res) {
    try {
        const hallName = req.query.hall_name; // Access the parameter from the URL query string


        const client = new Client({
            user: 'centralteam',
            host: 'localhost',
            database: 'occupancy',
            password: 'C3n7r@1^73@NN',
            port: 3254,
        });

        await client.connect();

        const query = 'SELECT * FROM occupancy."Study_Room" WHERE hall_name = $1 ORDER BY room_num ASC';
        const params = [hallName];
        const result = await client.query(query, params);
        
        await client.end();
        res.json(result.rows);
    } catch (error) {
        // Handle errors if any
        console.error('Error fetching room occupancy:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
}

// Author: Teo, with assistance from David
async function updateRoom(req, res){
    try {
        let hallName = req.body[`hallName`];
        let roomNum = req.body[`roomNum`];
        let roomNumInt = parseInt(roomNum);
        // console.log(hallName);
        // console.log(roomNum);

        const client = new Client({
            user: 'centralteam',
            host: 'localhost',
            database: 'occupancy',
            password: 'C3n7r@1^73@NN',
            port: 3254,
        });

        await client.connect();

        const query = 'UPDATE occupancy."Study_Room" SET occupied = CASE WHEN occupied THEN FALSE ELSE TRUE END, flag=FALSE WHERE hall_name = $1 AND room_num = $2';
        const params = [hallName, roomNumInt];
        await client.query(query, params);

        await client.end();

        res.status(200).send("Room occupancy updated successfully.<br><div align='center'><a href='./building.html'>Building Page<a><div>");
    } catch (error) {
        console.error('Error updating room:', error);
        res.status(500).send('Internal Server Error');
    }
}

// Author: Teo, with assistance from David
async function resetFlag(req, res){
    try {
        let hallName = req.body[`hallName`];
        let roomNum = req.body[`roomNum`];
        let roomNumInt = parseInt(roomNum);
        // console.log(hallName);
        // console.log(roomNum);

        const client = new Client({
            user: 'centralteam',
            host: 'localhost',
            database: 'occupancy',
            password: 'C3n7r@1^73@NN',
            port: 3254,
        });

        await client.connect();

        const query = 'UPDATE occupancy."Study_Room" SET flag=FALSE WHERE hall_name = $1 AND room_num = $2';
        const params = [hallName, roomNumInt];
        await client.query(query, params);

        await client.end();

        res.status(200).send("Flag reset successfully.<br><div align='center'><a href='./building.html'>Building Page<a><div>");
    } catch (error) {
        console.error('Error updating room:', error);
        res.status(500).send('Internal Server Error');
    }
}

// Author: Teo, with assistance from David
async function updateFlag(req, res){
    try {
        let hallName = req.body[`hallName`];
        let roomNum = req.body[`roomNum`];
        let roomNumInt = parseInt(roomNum);
        // console.log(hallName);
        // console.log(roomNum);

        const client = new Client({
            user: 'centralteam',
            host: 'localhost',
            database: 'occupancy',
            password: 'C3n7r@1^73@NN',
            port: 3254,
        });

        await client.connect();

        const query = 'UPDATE occupancy."Study_Room" SET flag = CASE WHEN flag THEN FALSE ELSE TRUE END WHERE hall_name = $1 AND room_num = $2';
        const params = [hallName, roomNumInt];
        await client.query(query, params);

        await client.end();

        res.status(200).send("Room flag updated successfully.<br><div align='center'><a href='./building.html'>Building Page<a><div>");
    } catch (error) {
        console.error('Error updating room:', error);
        res.status(500).send('Internal Server Error');
    }
}

// Author: Austin, with assistance from David
async function updateEmail(req, res){
    try{
        const username = req.session.username;
        const email = req.body.email;

        const client = new Client({
            user: 'centralteam',
            host: 'localhost',
            database: 'occupancy',
            password: 'C3n7r@1^73@NN',
            port: 3254,
        });

        await client.connect();

        const query = 'UPDATE occupancy."Student" SET email=$1 WHERE username = $2';
        const params = [email, username];
        await client.query(query, params);

        await client.end();

        res.status(200).send("email updated successfully.<br><div align='center'><a href='./UserSettings.html'>Settings Page<a><div>");
    
    } catch (error) {
        console.error('Error updating room:', error);
        res.status(500).send('Internal Server Error');
    }
}

// Author: Austin, with assistance from David
async function updatePassword(req, res){
    try{
        const username = req.session.username;
        const password = req.body.password;

        const client = new Client({
            user: 'centralteam',
            host: 'localhost',
            database: 'occupancy',
            password: 'C3n7r@1^73@NN',
            port: 3254,
        });

        await client.connect();

        const query = 'UPDATE occupancy."Student" SET password=$1 WHERE username = $2';
        const params = [password, username];
        await client.query(query, params);

        await client.end();

        res.status(200).send("Password updated successfully.<br><div align='center'><a href='./UserSettings.html'>Settings Page<a><div>");
    
    } catch (error) {
        console.error('Error updating room:', error);
        res.status(500).send('Internal Server Error');
    }
}

module.exports = {
    getUserData,
    getHalls,
    getRoomOccupancy,
    getCredentials,
    updateRoom,
    resetFlag,
    updateFlag,
    updateEmail,
    updatePassword,
};

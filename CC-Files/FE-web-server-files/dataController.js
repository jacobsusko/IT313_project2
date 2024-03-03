const { Client, path } = require('./modules');

async function getUserData(req, res) {
    const client = new Client({
        user: 'postgres',
        host: 'localhost',
        database: 'room_occupancy',
        password: 'C3n7r@1^73@NN',
        port: 5432,
    });

    try {
        await client.connect();
        const username = req.session.username;
        const password = req.session.password;

        const query = 'SELECT * FROM occupancy."Student" WHERE username = $1 AND password = $2';
        const params = [username, password];
        const result = await client.query(query, params);

        if (result.rows.length > 0) {
            const userData = result.rows[0];
            await client.end();
            res.json(userData);
        } else {
            res.status(404).json({ error: 'User not found'});
        }

    } catch (err) {
        console.error('Error executing query', err);
        res.send("Internal server error");
    } finally {
        await client.end();
    }
}

async function getHalls(req, res) {
    const client = new Client({
        user: 'postgres',
        host: 'localhost',
        database: 'room_occupancy',
        password: 'C3n7r@1^73@NN',
        port: 5432,
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


// Define an async function to handle the route with parameter
async function getRoomOccupancy(req, res) {
    try {
        const hallName = req.query.hall_name; // Access the parameter from the URL query string


        const client = new Client({
            user: 'postgres',
            host: 'localhost',
            database: 'room_occupancy',
            password: 'C3n7r@1^73@NN',
            port: 5432,
        });

        await client.connect();

        const query = 'SELECT * FROM occupancy."Study_Room" WHERE hall_name = $1';
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

module.exports = {
    getUserData,
    getHalls,
    getRoomOccupancy
};

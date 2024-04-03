// Created by: David
const { Client, path} = require('./modules');

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

        res.status(200).send(`
        <script>
            alert('Room occupancy updated successfully.');
            window.location.href = './building.html';
        </script>
        `)
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

        res.status(200).send(`
        <script>
            alert('Flag reset successfully.');
            window.location.href = './building.html';
        </script>
    `)
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

        // res.status(200).send(".<br><div align='center'><a href='./building.html'>Building Page<a><div>");
        res.status(200).send(`
            <script>
                alert('Room flag updated successfully.');
                window.location.href = './building.html';
            </script>
        `);
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

        
        // res.status(200).send(`
        //     <script>
        //         alert('Email updated successfully.');
        //         window.location.href = './UserSettings.html';
        //     </script>
        // `);
   
    } catch (error) {
        console.error('Error updating email:', error);
        res.status(200).send(`
            <script>
                alert('Error updating email');
                window.location.href = './UserSettings.html';
            </script>
        `);
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

        res.status(200).send(`
            <script>
                alert('Password updated successfully.');
                window.location.href = './UserSettings.html';
            </script>
        `);

    } catch (error) {
        console.error('Error updating password:', error);
        res.status(200).send(`
            <script>
                alert('Error updating password.');
                window.location.href = './UserSettings.html';
            </script>
        `);
    }
}

async function scheduleRoom(req, res){
    // Extract data from the request body
    const { room_hall, room_num, scheduled_time } = req.body;
    const username = req.session.username;

    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
    });

    try {
        await client.connect();

        let query = 'SELECT * FROM occupancy."Schedule_Room" WHERE room_hall = $1 AND room_num = $2 AND scheduled_time = $3';
        let params = [room_hall, room_num, scheduled_time];
        const result = await client.query(query, params);

        if (result.rows.length > 0) {
            return res.status(400).json({ error: 'Time already scheduled' });
        } else {
            query = 'INSERT INTO occupancy."Schedule_Room" (username, scheduled_time, room_num, room_hall) VALUES ($1, $2, $3, $4)';
            params = [username, scheduled_time, room_num, room_hall];
            await client.query(query, params);

            console.log('SUCCESS!')
            // Return success response
            return res.status(200).json({ message: 'Room scheduled successfully' });
        }
    } catch (error) {
        console.error('Error:', error);
        return res.status(500).json({ error: 'Internal Server Error' });
    } finally {
        await client.end();
    }
}

async function scheduledRooms(req, res){
    // Extract data from the request body
    const { room_hall, room_num, date } = req.body;

    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
    });

    try {
        await client.connect();

        let query = 'SELECT scheduled_time FROM occupancy."Schedule_Room" WHERE room_hall = $1 AND room_num = $2 AND lower(scheduled_time)::date = $3::date';
        let params = [room_hall, room_num, date];
        const result = await client.query(query, params);
        console.log(result.rows);

        if (result.rows.length > 0) {
            console.log('Length > 1');
            return  res.json(result.rows);
        } else {
            return res.json(null);
        }
    } catch (error) {
        console.error('Error:', error);
        return res.status(500).json({ error: 'Internal Server Error' });
    } finally {
        await client.end();
    }
}

async function scheduledRoomPerHall(req, res){
    const hallName = req.query.hall_name; // Access the parameter from the URL query string

    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
    });

    try {
        await client.connect();

        let currentDate = new Date(); // Get current date
        let year = currentDate.getFullYear();
        let month = String(currentDate.getMonth() + 1).padStart(2, '0'); // Adding 1 because months are zero-indexed
        let day = String(currentDate.getDate()).padStart(2, '0');
        let hours = String(currentDate.getHours()).padStart(2, '0');
        let minutes = String(currentDate.getMinutes()).padStart(2, '0');
        let seconds = String(currentDate.getSeconds()).padStart(2, '0');

        let currentTimestamp = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
        console.log(hallName);
        console.log(currentTimestamp);

        let query = `SELECT room_hall, room_num FROM occupancy."Schedule_Room" 
            WHERE room_hall = $1 AND $2 BETWEEN lower(scheduled_time) AND upper(scheduled_time)`;
        let params = [hallName, currentTimestamp];
        const result = await client.query(query, params);
        console.log(result.rows);

        if (result.rows.length > 0) {
            console.log('Length > 1');
            return  res.json(result.rows);
        } else {
            return res.json(null);
        }
    } catch (error) {
        console.error('Error:', error);
        return res.status(500).json({ error: 'Internal Server Error' });
    } finally {
        await client.end();
    }
}

async function submitWatchRoom(req, res) {
    const username = req.session.username;
    const { room_hall, room_num, start_time, end_time, day } = req.body;

    console.log(username);
    console.log(room_hall);
    console.log(room_num);
    console.log(start_time);
    console.log(end_time);
    console.log(day);
    console.log(typeof room_num);

    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
    });

    try {
        await client.connect();
        if (Number.isInteger(room_num)) {
            console.log('Specific Room');
            let query = `SELECT * FROM occupancy."Watch_Room" 
                WHERE username = $1 AND weekday =$2 AND room_hall = $3 AND room_num = $4 AND start_time <= $5 AND end_time >= $6`;
            let params = [username, day, room_hall, room_num, start_time, end_time];
            let result = await client.query(query, params);
            console.log(result.rows);

            if (result.rows.length > 0){
                console.log('Already in DB')
            } else {
                let query = 'INSERT INTO occupancy."Watch_Room" (username, weekday, room_num, room_hall, start_time, end_time, already_emailed) VALUES ($1, $2, $3, $4, $5, $6, $7)';
                let params = [username, day, room_num, room_hall, start_time, end_time, 0];
                await client.query(query, params);
            }



            console.log('Successfully added new Notification Schedule to Database.');

            try {
                let merged = true;
                while (merged) {
                    console.log('Restarting loop');
                    merged = false;

                    // Attempt to merge overlapping records
                    await client.query(`
                        UPDATE occupancy."Watch_Room" t1
                        SET start_time = (
                                SELECT MIN(start_time) 
                                FROM occupancy."Watch_Room" t2
                                WHERE t1.username = t2.username
                                AND t1.weekday = t2.weekday
                                AND t1.room_hall = t2.room_hall
                                AND t1.room_num = t2.room_num
                                AND t1.start_time <= t2.end_time
                                AND t1.end_time >= t2.start_time
                            ),
                            end_time = (
                                SELECT MAX(end_time) 
                                FROM occupancy."Watch_Room" t3
                                WHERE t1.username = t3.username
                                AND t1.weekday = t3.weekday
                                AND t1.room_hall = t3.room_hall
                                AND t1.room_num = t3.room_num
                                AND t1.start_time <= t3.end_time
                                AND t1.end_time >= t3.start_time
                            )
                        FROM occupancy."Watch_Room" t2
                        WHERE t1.username = t2.username
                        AND t1.weekday = t2.weekday
                        AND t1.room_hall = t2.room_hall
                        AND t1.room_num = t2.room_num
                        AND t1.start_time <= t2.end_time
                        AND t1.end_time >= t2.start_time
                        AND t1.watch_id != t2.watch_id
                    `);

                    // Delete redundant records
                    await client.query(`
                        DELETE FROM occupancy."Watch_Room" t2
                        USING occupancy."Watch_Room" t1
                        WHERE t1.start_time <= t2.start_time
                        AND t1.end_time >= t2.end_time
                        AND t1.username = t2.username
                        AND t1.weekday = t2.weekday
                        AND t1.room_hall = t2.room_hall
                        AND t1.room_num = t2.room_num
                        AND t1.watch_id < t2.watch_id
                    `);

                    // Check if any overlapping records were merged
                    const result = await client.query(`
                        SELECT COUNT(*) AS count
                        FROM occupancy."Watch_Room" t1
                        JOIN occupancy."Watch_Room" t2 ON
                            t1.username = t2.username
                            AND t1.weekday = t2.weekday
                            AND t1.room_hall = t2.room_hall
                            AND t1.room_num = t2.room_num
                            AND t1.start_time <= t2.end_time
                            AND t1.end_time >= t2.start_time
                            AND t1.watch_id != t2.watch_id
                    `);
                    merged = result.rows[0].count > 0;
                }


                
            
                // Leave records without overlap alone
            
                // Close the connection pool
                await client.end();
                console.log("Data processed successfully.");
              } catch (error) {
                console.error("Error processing data:", error);
              }
            


        } else {
            console.log('All Rooms in Hall');
            let query = `SELECT room_num FROM occupancy."Study_Room" 
                        WHERE hall_name = $1`;
            let params = [room_hall];
            const roomResult = await client.query(query, params); // Renamed result variable
            console.log(roomResult.rows);
            if (roomResult.rows.length < 1) {
                console.log('Hall has no rooms.');
            } else {
                // Iterate over each room number
                for (let i = 0; i < roomResult.rows.length; i++) {
                    let currentRoomNum = roomResult.rows[i].room_num;
                    console.log('Processing room number:', currentRoomNum);
                    
                    // Execute the same logic as for specific room
                    // Replace occurrences of room_num with currentRoomNum
                    let query = `SELECT * FROM occupancy."Watch_Room" 
                        WHERE username = $1 AND weekday =$2 AND room_hall = $3 AND room_num = $4 AND start_time <= $5 AND end_time >= $6`;
                    let params = [username, day, room_hall, currentRoomNum, start_time, end_time];
                    let watchResult = await client.query(query, params); // Renamed result variable
                    console.log(watchResult.rows);
        
                    if (watchResult.rows.length > 0) {
                        console.log('Already in DB');
                    } else {
                        let query = 'INSERT INTO occupancy."Watch_Room" (username, weekday, room_num, room_hall, start_time, end_time, already_emailed) VALUES ($1, $2, $3, $4, $5, $6, $7)';
                        let params = [username, day, currentRoomNum, room_hall, start_time, end_time, 0];
                        await client.query(query, params);
                    }
        
                    // Merge overlapping records, delete redundant records, etc.
                    // This part remains unchanged
                    try {
                        let merged = true;
                        while (merged) {
                            console.log('Restarting loop');
                            merged = false;
        
                            // Attempt to merge overlapping records
                            await client.query(`
                                UPDATE occupancy."Watch_Room" t1
                                SET start_time = (
                                        SELECT MIN(start_time) 
                                        FROM occupancy."Watch_Room" t2
                                        WHERE t1.username = t2.username
                                        AND t1.weekday = t2.weekday
                                        AND t1.room_hall = t2.room_hall
                                        AND t1.room_num = t2.room_num
                                        AND t1.start_time <= t2.end_time
                                        AND t1.end_time >= t2.start_time
                                    ),
                                    end_time = (
                                        SELECT MAX(end_time) 
                                        FROM occupancy."Watch_Room" t3
                                        WHERE t1.username = t3.username
                                        AND t1.weekday = t3.weekday
                                        AND t1.room_hall = t3.room_hall
                                        AND t1.room_num = t3.room_num
                                        AND t1.start_time <= t3.end_time
                                        AND t1.end_time >= t3.start_time
                                    )
                                FROM occupancy."Watch_Room" t2
                                WHERE t1.username = t2.username
                                AND t1.weekday = t2.weekday
                                AND t1.room_hall = t2.room_hall
                                AND t1.room_num = t2.room_num
                                AND t1.start_time <= t2.end_time
                                AND t1.end_time >= t2.start_time
                                AND t1.watch_id != t2.watch_id
                            `);
        
                            // Delete redundant records
                            await client.query(`
                                DELETE FROM occupancy."Watch_Room" t2
                                USING occupancy."Watch_Room" t1
                                WHERE t1.start_time <= t2.start_time
                                AND t1.end_time >= t2.end_time
                                AND t1.username = t2.username
                                AND t1.weekday = t2.weekday
                                AND t1.room_hall = t2.room_hall
                                AND t1.room_num = t2.room_num
                                AND t1.watch_id < t2.watch_id
                            `);
        
                            // Check if any overlapping records were merged
                            const result = await client.query(`
                                SELECT COUNT(*) AS count
                                FROM occupancy."Watch_Room" t1
                                JOIN occupancy."Watch_Room" t2 ON
                                    t1.username = t2.username
                                    AND t1.weekday = t2.weekday
                                    AND t1.room_hall = t2.room_hall
                                    AND t1.room_num = t2.room_num
                                    AND t1.start_time <= t2.end_time
                                    AND t1.end_time >= t2.start_time
                                    AND t1.watch_id != t2.watch_id
                            `);
                            merged = result.rows[0].count > 0;
                        }
        
                        console.log("Data processed successfully.");
                      } catch (error) {
                        console.error("Error processing data:", error);
                      }
        
                }
                
                // Close the connection pool after processing all rooms
                await client.end();
                console.log("Data processed successfully.");
            }
        }
        return res.status(200).json({ message: 'Notifications updated successfully' });

    } catch (error) {
        console.error('Error:', error);
        return res.status(500).json({ error: 'Internal Server Error' });
    } finally {
        await client.end();
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
    scheduleRoom,
    scheduledRooms,
    scheduledRoomPerHall,
    submitWatchRoom
};

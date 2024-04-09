// Creator: Jacob Susko

const { sendEmail_toUser } = require('./index.js');

const express = require('express');
const fs = require('fs');
const app = express()
const { Client} = require('pg');
const { send } = require('process');

// For resetting emails being sent
    // a) Every time we see a change in the room being occupied turn to false 
    // b) Let user adjust on front end for how often they would like to be notified

main();

async function main() {
    console.log('running');
    const result = await openRooms();
    console.log(result)
    const result2 = await getWatchedUsers(result);
    console.log(result2);

    send_to = await getFinal(result2, result);
    console.log(send_to);
    
    emails = await getEmail(send_to);

    info_to_send = await create_list(send_to, emails);
    console.log(info_to_send);

    await sendEmails(info_to_send);
}


// Add in functionality to put that email has been sent
async function sendEmails(info_to_send) {
    if (info_to_send.length == 0) {
        return
    }

    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
    });

    await client.connect();

    for (const person of info_to_send) {
        const username = person['username'];
        const room_num = person['room_num'];
        const room_hall = person['room_hall'];
        const email = person['email'];
        const first = person['first_name'];
        const last = person['last_name'];
        await sendEmail_toUser(username, room_num, room_hall, email, first, last);

        try {

            const query = `
                UPDATE occupancy."Watch_Room"
                SET already_emailed = true
                WHERE username = $1 AND room_hall = $2 AND room_num = $3
                `;

            const params = [username, room_hall, parseInt(room_num)];
            await client.query(query, params);
        } catch (error) {
            console.error(error);
        }
        
    }
    await client.end();
}


// create list with all info to send
async function create_list(watch_room, emails) {

    let send_info = [];
    let i = 0;
    for (const watch of watch_room) {
        if (emails.hasOwnProperty(watch['username'])) {
            const username = watch['username'];
            send_info[i] = {"username": username, "room_num": watch['room_num'], "room_hall": watch['room_hall'], 
                            "email": emails[username][0]['email'], "first_name": emails[username][0]['first_name'],
                            "last_name": emails[username][0]['last_name']};
        }
        i++;
    }
    return send_info;
}




// Get Emails of users and call function to send them
async function getEmail(people) {
    
    let result = {};
    
    // connection to db
    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
    });
    
    try {
        await client.connect();

        const query = `
        SELECT username, email, first_name, last_name FROM occupancy."Student"
        WHERE  username = $1`;

        for (let i = 0; i < people.length; i++) {
            const username = people[i]['username'];
            const queryResult = await client.query(query, [username]);
            result[username] = queryResult.rows;
        }
        

    } catch (err) {
        console.error('Error executing query', err);
        throw err; // Rethrow the error or handle it accordingly
    } finally {
        await client.end();
    }
    return result;
}

// Finalize list of users to whom to send emails to
async function getFinal(people, openRooms) {
    const usernames = [];

    for (let i = 0; i < people.length; i++) {
        for (let p = 0; p < openRooms.length; p++) {
             if (openRooms[p]['hall_name'] === people[i]['room_hall'] && 
                 openRooms[p]['room_num'] === people[i]['room_num']) {
                    usernames.push(people[i]);
                }
        }
    }
    return usernames;
}


// Returns list of all open rooms
async function openRooms() {
    let result; // Declare result variable outside try block
    
    // connection to db
    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
    });

    try {
        await client.connect();

        const query = `
        SELECT * FROM occupancy."Study_Room"
        WHERE occupied = false`;

        result = await client.query(query); // Assign result within try block

    } catch (err) {
        console.error('Error executing query', err);
        throw err; // Rethrow the error or handle it accordingly
    } finally {
        await client.end();
    }
    return result.rows; // Return result.rows
}


// Get all users who have watch room in current time and room is open
// openRooms: list of openRooms at current time
// db
    // time format: 08:00:00
    // hour:minute:second
async function getWatchedUsers(openRooms) {
    let result;
    const currentDate = new Date();
    const hour = currentDate.getHours();
    const minute = currentDate.getMinutes();
    const second = currentDate.getSeconds();

    const day = currentDate.getDay();
    const time = (`${hour}:${minute}:${second}`);

    const client = new Client({
        user: 'centralteam',
        host: 'localhost',
        database: 'occupancy',
        password: 'C3n7r@1^73@NN',
        port: 3254,
    });

    try {
        await client.connect();

        const query = `
        SELECT username, room_num, room_hall FROM occupancy."Watch_Room"
        WHERE weekday = $1 AND already_emailed = false
        AND start_time < $2 AND end_time > $2`;

        const params = [day, time];
        result = await client.query(query, params);

    } catch (err) {
        console.error('Error executing query', err);
        throw err;
    } finally {
        await client.end();
    }
    return result.rows;
}


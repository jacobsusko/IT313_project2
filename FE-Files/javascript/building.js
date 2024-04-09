//Done by Teo and David
async function hidePages() {
    const credentials = await getCredentials();
    if (credentials.loggedInEmp) {
        var schedule = document.getElementById('schedule');
        schedule.style.display = 'none';
    }
    if (credentials.loggedIn) {
        var addEmp = document.getElementById('addEmp');
        addEmp.style.display = 'none';
    }
}

window.addEventListener('load', hidePages);

// Make an HTTP request to retrieve user data
fetch('/userData')
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to retrieve user data');
        }
        return response.json();
    })
    .then(userData => {
        document.getElementById('userData').innerHTML = `Hello ${userData.first_name}!`;
        console.log(userData);
    })
    .catch(error => console.error('Error:', error));

// Function to fetch hall names from the server and display them as buttons
async function fetchHallsAndDisplay() {
    const response = await fetch('/halls');
    const halls = await response.json();

    const hallListDiv = document.getElementById('hallList');
    hallListDiv.innerHTML = ''; // Clear previous content

    halls.forEach(hall => {
        const hallButton = document.createElement('button');
        hallButton.textContent = hall;
        hallButton.id = hall; // Set the id attribute to the hall name
        hallButton.addEventListener('click', () => {
            const parameter = hallButton.textContent; // Get the inner text of the hall button
            fetchRoomOccupancy(parameter);
        });
        hallListDiv.appendChild(hallButton);
    });
}

async function fetchRoomOccupancy(parameter) {
    try {
        const roomList = document.getElementById('roomList');
        roomList.innerText = '';
        const room_response = await fetch(`/getRoomOccupancy?hall_name=${parameter}`);
        const rooms = await room_response.json();
        const scheduled_room_response = await fetch(`/scheduledRoomPerHall?hall_name=${parameter}`);
        const schedule_rooms = await scheduled_room_response.json();
        console.log('Rooms for hall:', rooms); // Move this line here
        console.log(schedule_rooms);

        // Create a table and header row
        const table = document.getElementById('roomList');
        const headerRow = document.createElement('tr');
        const headers = ['Hall', 'Room', 'Empty?', 'Flagged?'];
        headers.forEach(headerText => {
            const headerCell = document.createElement('th');
            headerCell.textContent = headerText;
            headerRow.appendChild(headerCell);
        });
        table.appendChild(headerRow);
        const credentials = await getCredentials();

        // Loop through each room and add a row to the table
        rooms.forEach(room => {
            const row = document.createElement('tr');
            const columns = [room.hall_name, room.room_num, room.occupied ? "&#10007;" : "&#10003;", room.flag ? "&#10003;" : "&#10007;"];
            columns.forEach((columnText, index) => {
                const cell = document.createElement('td');
                if (index === 2) {
                    console.log(schedule_rooms);
                    let isScheduled = false; // Initialize a variable to track if the room is scheduled
                    if (schedule_rooms != null) {
                        for (let schedule_room of schedule_rooms) {
                            if (schedule_room.room_hall === room.hall_name && schedule_room.room_num === room.room_num) {
                                console.log('The schedule room and room match');
                                isScheduled = true;
                                break; // No need to continue checking once we find a matching scheduled room
                            }
                        }

                        if (isScheduled) {
                            cell.innerHTML = "&#10007;";
                        } else {
                            cell.innerHTML = "&#10003;";
                        }
                    } else {
                        console.log('No scheduled rooms in this hall');
                        console.log(columnText);
                        cell.innerHTML = columnText;
                    }
                } else {
                    console.log('Not the occupied column');
                    console.log(columnText);
                    cell.innerHTML = columnText;
                }
                row.appendChild(cell);
            });
            let cell1 = document.createElement('td');
            if (credentials.loggedInEmp) {
                cell1.innerHTML = `
                    <form action="/updateRoom" method="POST">
                        <input type="hidden" name="hallName" value="${room.hall_name}">
                        <input type="hidden" name="roomNum" value="${room.room_num}">
                        <button class='roomButton' onclick="">Update Occupancy</button>
                    </form>
                    <form action="/resetFlag" method="POST">
                        <input type="hidden" name="hallName" value="${room.hall_name}">
                        <input type="hidden" name="roomNum" value="${room.room_num}">
                        <button class='roomButton' onclick="">Reset Flag</button>
                    </form>
                `;
            } else {
                cell1.innerHTML = `
                    <form action="/updateFlag" method="POST">
                        <input type="hidden" name="hallName" value="${room.hall_name}">
                        <input type="hidden" name="roomNum" value="${room.room_num}">
                        <button class='roomButton flagButton' onclick="">Update Flag</button>
                    </form>
                `;
            }
            cell1.classList.add("forms");
            row.appendChild(cell1);
            table.appendChild(row);


            //average busyness
// Data representing average busyness per day
var averageBusyness = {
    'Sunday': 10,
    'Monday': 20,
    'Tuesday': 15,
    'Wednesday': 25,
    'Thursday': 30,
    'Friday': 35,
    'Saturday': 40
};

// Create table element
var avgb = document.createElement('table');

// Create thead element
var thead = document.createElement('thead');
var trHead = document.createElement('tr');

// Create table headers
var thDay = document.createElement('th');
thDay.textContent = 'Day';
var thAverage = document.createElement('th');
thAverage.textContent = 'Average Busyness';

// Append headers to thead
trHead.appendChild(thDay);
trHead.appendChild(thAverage);
thead.appendChild(trHead);

// Append thead to table
avgb.appendChild(thead);

// Create tbody element
var tbody = document.createElement('tbody');

// Populate tbody with data
for (var day in averageBusyness) {
    var tr = document.createElement('tr');
    var tdDay = document.createElement('td');
    tdDay.textContent = day;
    var tdAverage = document.createElement('td');
    tdAverage.textContent = averageBusyness[day];
    tr.appendChild(tdDay);
    tr.appendChild(tdAverage);
    tbody.appendChild(tr);
}

// Append tbody to table
avgb.appendChild(tbody);

// Append table to container
document.getElementById('tableContainer').appendChild(avgb);
        });

    } catch (error) {
        // Handle errors if any
        console.error('Error fetching room occupancy:', error);
    }
}

// Call the function to fetch halls and display them as buttons when the HTML is loaded
window.addEventListener('load', fetchHallsAndDisplay);

function logout() {
    fetch('/logout')
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to logout');
            }
            // Redirect to login page after logout
            window.location.href = '/';
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

async function getCredentials() {
    try {
        const response = await fetch('/getCredentials');
        if (!response.ok) {
            throw new Error('Failed to logout');
        }
        return await response.json();
    } catch (error) {
        console.error('Error: ', error)
    }
}
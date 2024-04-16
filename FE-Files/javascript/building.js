//Done by Teo and David
async function hidePages() {
    const credentials = await getCredentials();
    if (credentials.loggedInEmp) {
        var schedule = document.getElementById('schedule');
        schedule.style.display = 'none';
        var email = document.getElementById('RoomEmail');
        email.style.display = 'none';
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
        //console.log(userData);
    })
    .catch(error => console.error('Error:', error));

        async function handleHallClick() {
        selectedHall = this.textContent; // Update the selected hall
        console.log('Initial fetch');
        await refreshRoomOccupancy(selectedHall); // Refresh room occupancy for the selected hall immediately

        // If there was already an interval running, clear it before starting a new one
        // if (intervalId) {
        //     clearInterval(intervalId);
        // }

        // Set up the interval to refresh room occupancy every 5 seconds
       setInterval(async () => {
            console.log('refreshes');
            await refreshRoomOccupancy(selectedHall);
        }, 3000);
    }

// Function to fetch hall names from the server and display them as buttons
async function fetchHallsAndDisplay() {
    const response = await fetch('/halls');
    const halls = await response.json();
    //console.log(halls);

    const hallListDiv = document.getElementById('hallList');
    hallListDiv.innerHTML = ''; // Clear previous content

    halls.forEach(hall => {
        const hallButton = document.createElement('button');
        hallButton.textContent = hall;
        hallButton.id = hall; // Set the id attribute to the hall name
        // hallButton.addEventListener('click', () => {
            // const parameter = hallButton.textContent; // Get the inner text of the hall button
            // refreshRoomOccupancy(parameter);
        // });
        hallButton.addEventListener('click', handleHallClick); // Attach event listener to each hall button

        hallListDiv.appendChild(hallButton);
    });
}
window.addEventListener('load', fetchHallsAndDisplay);

// async function fetchRoomOccupancy(parameter) {
//     try {
//         const credentials = await getCredentials(); // Moved the declaration here
//         const roomList = document.getElementById('roomList');
//         roomList.innerText = '';
//         const room_response = await fetch(`/getRoomOccupancy?hall_name=${parameter}`);
//         const rooms = await room_response.json();
//         const scheduled_room_response = await fetch(`/scheduledRoomPerHall?hall_name=${parameter}`);
//         const schedule_rooms = await scheduled_room_response.json();
//         console.log('Rooms for hall:', rooms);
//         console.log(schedule_rooms);

//         // Create a table and header row
//         const table = document.getElementById('roomList');
//         const headerRow = document.createElement('tr');
//         const headers = ['Hall', 'Room', 'Empty?'];
//         if (credentials.loggedInEmp) {
//             headers.push('Flagged?');
//         }
//         headers.forEach(headerText => {
//             const headerCell = document.createElement('th');
//             headerCell.textContent = headerText;
//             headerRow.appendChild(headerCell);
//         });
//         table.appendChild(headerRow);

//         // Loop through each room and add a row to the table
//         rooms.forEach(room => {
//             const row = document.createElement('tr');
//             const columns = [room.hall_name, room.room_num, room.occupied ? "&#10007;" : "&#10003;"];
//             if (credentials.loggedInEmp) {
//                 columns.push(room.flag ? "&#10003;" : "&#10007;");
//             }
//             columns.forEach((columnText, index) => {
//                 const cell = document.createElement('td');
//                 if (index === 2 && credentials.loggedInEmp) {
//                     let isScheduled = false;
//                     if (schedule_rooms != null) {
//                         for (let schedule_room of schedule_rooms) {
//                             if (schedule_room.room_hall === room.hall_name && schedule_room.room_num === room.room_num) {
//                                 console.log('The schedule room and room match');
//                                 isScheduled = true;
//                                 break;
//                             }
//                         }

//                         if (isScheduled) {
//                             cell.innerHTML = "&#10007;";
//                         } else {
//                             cell.innerHTML = "&#10003;";
//                         }
//                     } else {
//                         console.log('No scheduled rooms in this hall');
//                         console.log(columnText);
//                         cell.innerHTML = columnText;
//                     }
//                 } else {
//                     console.log('Not the occupied column');
//                     console.log(columnText);
//                     cell.innerHTML = columnText;
//                 }
//                 row.appendChild(cell);
//             });
//             let cell1 = document.createElement('td');
//             if (credentials.loggedInEmp) {
//                 cell1.innerHTML = `
//                     <form action="/updateRoom" method="POST">
//                         <input type="hidden" name="hallName" value="${room.hall_name}">
//                         <input type="hidden" name="roomNum" value="${room.room_num}">
//                         <button class='roomButton' onclick="updateOccupancy()">Update Occupancy</button>
//                         <div class="overlay" id="overlay">
//                         <div class="success-box">
//                             Success
//                         </div>
//                     </div>
//                     </form>
//                     <form action="/resetFlag" method="POST">
//                         <input type="hidden" name="hallName" value="${room.hall_name}">
//                         <input type="hidden" name="roomNum" value="${room.room_num}">
//                         <button class='roomButton' onclick="resetFlag()">Reset Flag</button>
//                         <div class="overlay" id="overlay">
//                         <div class="success-box">
//                             Success
//                         </div>
//                     </div>
//                     </form>
//                 `;
//             } else {
//                 cell1.innerHTML = `
//                     <form action="/updateFlag" method="POST">
//                         <input type="hidden" name="hallName" value="${room.hall_name}">
//                         <input type="hidden" name="roomNum" value="${room.room_num}">
//                         <button class='roomButton flagButton' onclick="reportRoom()">Report Room</button> 
//                         <div class="overlay" id="overlay">
//                         <div class="success-box">
//                             Success
//                         </div>
//                     </div>
//                     </form>
//                 `;
                
//             }
//             cell1.classList.add("forms");
//             row.appendChild(cell1);
//             table.appendChild(row);
//         });

//     } catch (error) {
//         // Handle errors if any
//         console.error('Error fetching room occupancy:', error);
//     }
// }

// Function to refresh the room occupancy table every 2 seconds
async function refreshRoomOccupancy(parameter) {
    try {
        const credentials = await getCredentials(); // Moved the declaration here
        const roomList = document.getElementById('roomList');

        const room_response = await fetch(`/getRoomOccupancy?hall_name=${parameter}`);
        const rooms = await room_response.json();
        const scheduled_room_response = await fetch(`/scheduledRoomPerHall?hall_name=${parameter}`);
        const schedule_rooms = await scheduled_room_response.json();

        // If there are no rooms, do nothing
        if (rooms.length === 0) {
            return;
        }

        // If the table already exists, update its content
        let table = roomList.querySelector('table');
        if (!table) {
            // Create a new table if it doesn't exist
            table = document.createElement('table');
            roomList.appendChild(table);
        } else {
            // Clear the existing rows
            table.innerHTML = '';
        }

        // Create a header row
        const headerRow = document.createElement('tr');
        const headers = ['Hall', 'Room', 'Empty?'];
        if (credentials.loggedInEmp) {
            headers.push('Flagged?');
        }
        headers.forEach(headerText => {
            const headerCell = document.createElement('th');
            headerCell.textContent = headerText;
            headerRow.appendChild(headerCell);
        });
        table.appendChild(headerRow);

        // Loop through each room and add a row to the table
        rooms.forEach(room => {
            const row = document.createElement('tr');
            const columns = [room.hall_name, room.room_num, room.occupied ? "&#10007;" : "&#10003;"];
            if (credentials.loggedInEmp) {
                columns.push(room.flag ? "&#10003;" : "&#10007;");
            }
            columns.forEach((columnText, index) => {
                const cell = document.createElement('td');
                if (index === 2 && credentials.loggedInEmp) {
                    let isScheduled = false;
                    if (schedule_rooms != null) {
                        for (let schedule_room of schedule_rooms) {
                            if (schedule_room.room_hall === room.hall_name && schedule_room.room_num === room.room_num) {
                                isScheduled = true;
                                break;
                            }
                        }

                        if (isScheduled) {
                            cell.innerHTML = "&#10007;";
                        } else {
                            cell.innerHTML = "&#10003;";
                        }
                    } else {
                        cell.innerHTML = columnText;
                    }
                } else {
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
                        <button class='roomButton updateButton' onclick="updateOccupancy()">Update Occupancy</button>
                        <div class="overlay" id="overlay">
                        <div class="success-box">
                            Success
                        </div>
                    </div>
                    </form>
                    <form action="/resetFlag" method="POST">
                        <input type="hidden" name="hallName" value="${room.hall_name}">
                        <input type="hidden" name="roomNum" value="${room.room_num}">
                        <button class='roomButton resetButton' onclick="resetFlag()">Reset Flag</button>
                        <div class="overlay" id="overlay">
                        <div class="success-box">
                            Success
                        </div>
                    </div>
                    </form>
                `;
            } else {
                cell1.innerHTML = `
                    <form action="/updateFlag" method="POST">
                        <input type="hidden" name="hallName" value="${room.hall_name}">
                        <input type="hidden" name="roomNum" value="${room.room_num}">
                        <button class='roomButton flagButton' onclick="reportRoom()">Report Room</button> 
                        <div class="overlay" id="overlay">
                        <div class="success-box">
                            Success
                        </div>
                    </div>
                    </form>
                `;
            }
            cell1.classList.add("forms");
            row.appendChild(cell1);
            table.appendChild(row);
        });

    } catch (error) {
        // Handle errors if any
        console.error('Error fetching room occupancy:', error);
    }
}


// window.addEventListener('load', () => {
//     console.log('test');
//     let selectedHall = null;
//     let intervalId = null; // Declare intervalId variable outside the event listener scope

//     const hallList = document.getElementById('hallList');
//     if (!hallList) {
//         console.error('Hall list element not found');
//         return;
//     }

//     const halls = hallList.querySelectorAll('button');
//     if (halls.length === 0) {
//         console.error('No hall buttons found');
//         return;
//     }

//     halls.forEach(hall => {
//         console.log(hall);
//     });

// });




function reportRoom() {
    var overlay = document.getElementById('overlay');
    overlay.style.display = 'flex';

    setTimeout(function() {
        overlay.style.display = 'none';
    }, 3000);
}

function resetFlag() {
    var overlay = document.getElementById('overlay');
    overlay.style.display = 'flex';

    setTimeout(function() {
        overlay.style.display = 'none';
    }, 3000);
}

function updateOccupancy() {
    var overlay = document.getElementById('overlay');
    overlay.style.display = 'flex';

    setTimeout(function() {
        overlay.style.display = 'none';
    }, 3000);
}


// Call the function to fetch halls and display them as buttons when the HTML is loaded


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
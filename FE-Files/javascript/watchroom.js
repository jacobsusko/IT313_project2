/*!
 * David Gray
 */
// Make an HTTP request to retrieve user data
// fetch('/userData')
//     .then(response => {
//         if (!response.ok) {
//             throw new Error('Failed to retrieve user data');
//         }
//         return response.json();
//     })
//     .then(userData => {
//         document.getElementById('userData').innerHTML = `Hello ${userData.first_name}!`;
//         console.log(userData);
//     })
//     .catch(error => console.error('Error:', error));
document.addEventListener('DOMContentLoaded', function() {
    // Add event listener for start and end time selects
    document.getElementById("timeSelectStart").addEventListener("change", checkButton);
    document.getElementById("timeSelectEnd").addEventListener("change", checkButton);

    // Add event listeners for room buttons
    document.querySelectorAll('.room-button').forEach(button => {
        button.addEventListener('click', checkButton);
    });
});

window.addEventListener('load', fetchHallsAndDisplay);
        // Function to fetch hall names from the server and display them as buttons
        const roomContainers = {};

        // Function to fetch hall names from the server and display them as buttons
        async function fetchHallsAndDisplay() {
            const response = await fetch('/halls');
            const halls = await response.json();

            const roomListDiv = document.getElementById('hallList');
            roomListDiv.innerHTML = ''; // Clear previous content

            halls.forEach(hall => {
                const hallButton = document.createElement('button');
                hallButton.textContent = hall;
                hallButton.id = hall; // Set the id attribute to the hall name
                hallButton.addEventListener('click', () => {
                    fetchRooms(hall); // Pass the hall name to fetchRooms function
                    const hallButtons = document.querySelectorAll('#hallList button');
                    hallButtons.forEach(button => {
                        button.classList.remove('active'); // Remove "active" class from all hall buttons
                    });
                    hallButton.classList.add('active'); // Add "active" class to the clicked hall button
                });
                roomListDiv.appendChild(hallButton);

                // Create a container for room buttons under each hall button
                const roomContainer = document.createElement('div');
                roomContainer.id = `${hall}-rooms`;
                roomListDiv.appendChild(roomContainer);

                // Store reference to the room container
                roomContainers[hall] = roomContainer;
            });
        }

         // Function to clear all room containers
         function clearRoomContainers() {
             Object.values(roomContainers).forEach(container => {
                 container.innerHTML = ''; // Clear container content
             });
         }
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
        function checkButton() {
            console.log('Using Function');
            let startTime = document.getElementById("timeSelectStart").value;
            let endTime = document.getElementById("timeSelectEnd").value;
            let activeRoomButton = document.querySelector('.room-button.active');

            if (!activeRoomButton) {
                document.getElementById("submit").disabled = true;
                document.getElementById("submit").classList.add("disabled");
                console.log('button locked');
                return;
            }
        
            if (startTime >= endTime) {
                document.getElementById("submit").disabled = true;
                document.getElementById("submit").classList.add("disabled");
                console.log('button locked');
                return;
            }
        
            document.getElementById("submit").disabled = false;
            document.getElementById("submit").classList.remove("disabled");
            console.log('button unlocked');
        }

        // Function to fetch rooms for a specific hall
        async function fetchRooms(hall) {
            try {
                clearRoomContainers(); // Clear all room containers
                const room_response = await fetch(`/getRoomOccupancy?hall_name=${hall}`);
                const rooms = await room_response.json();
                console.log('Rooms for hall:', rooms);

                const roomContainer = roomContainers[hall];

                // Loop through each room and create a button for each
                rooms.forEach(room => {
                    const roomButton = document.createElement('button');
                    roomButton.textContent = `${hall} - ${room.room_num}`; // Combine hall name and room number
                    roomButton.classList.add('room-button'); // Add a class to the room button
                    roomButton.addEventListener('click', () => {
                       // Handle room button click if needed
                       //  fetchTimes(hall, room.room_num);
                       const roomButtons = document.querySelectorAll('.room-button');
                       roomButtons.forEach(button => {
                           button.classList.remove('active'); // Remove "active" class from all room buttons
                        });
                        roomButton.classList.add('active'); // Add "active" class to the clicked room button
                        checkButton(); // Call checkButton function here
                    });
                    roomContainer.appendChild(roomButton);
                });
                const roomButton = document.createElement('button');
                roomButton.textContent = "All"; // Combine hall name and room number
                roomButton.classList.add('room-button'); // Add a class to the room button
                roomButton.addEventListener('click', () => {
                    // Handle room button click if needed
                    //  fetchTimes(hall, room.room_num);
                    const roomButtons = document.querySelectorAll('.room-button');
                    roomButtons.forEach(button => {
                        button.classList.remove('active'); // Remove "active" class from all room buttons
                    });
                    roomButton.classList.add('active'); // Add "active" class to the clicked room button
                    checkButton(); // Call checkButton function here
                });
                roomContainer.appendChild(roomButton);

            } catch (error) {
                // Handle errors if any
                console.error('Error fetching room occupancy:', error);
            }
        }
        function showNotification() {
            var notification = document.getElementById('notification');
            notification.style.display = 'block';
            setTimeout(function() {
              notification.style.display = 'none';
            }, 4000); // Notification will disappear after 3 seconds
          }
        // Function to actually submit the time to watch the Room
        async function submitWatchTime() {
            const hallName = document.getElementById('hallList').querySelector('.active').textContent;
            const roomNumText = document.getElementById(`${hallName}-rooms`).querySelector('.active').textContent;
            const startTime = document.getElementById('timeSelectStart').value;
            const endTime = document.getElementById('timeSelectEnd').value;
            const day = document.getElementById('daySelect').value;
            console.log(day);

            let roomNum;
            console.log(hallName);
            console.log(roomNumText);
            if (roomNumText !== "All") {
                roomNum = parseInt(roomNumText.match(/\d+$/)[0]);
                console.log(roomNum);
                try {
                    const response = await fetch('/submitWatchRoom', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        room_hall: hallName,
                        room_num: roomNum,
                        start_time: startTime,
                        end_time: endTime,
                        day: day
                    })
                });
            
                if (!response.ok) {
                    throw new Error('Failed to post data');
                }
            
                const responseData = await response.json();
            
                // Display the response message in an alert
                alert(responseData.message);
                } catch (error) {
                    console.error('Error Confirming Email Notifications:', error);
                    alert('Failed to submit time for email notifications. Please try again later.');
                }
            } else {
                try {
                    const response = await fetch('/submitWatchRoom', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        room_hall: hallName,
                        room_num: roomNumText,
                        start_time: startTime,
                        end_time: endTime,
                        day: day
                    })
                });
            
                if (!response.ok) {
                    throw new Error('Failed to post data');
                }
            
                const responseData = await response.json();
            
                // Display the response message in an alert
                alert(responseData.message);
                } catch (error) {
                    console.error('Error Confirming Email Notifications:', error);
                    alert('Failed to submit time for email notifications. Please try again later.');
                }
            }

        }
        function reportRoom() {
            var overlay = document.getElementById('overlay');
            overlay.style.display = 'flex';
        
            setTimeout(function() {
                overlay.style.display = 'none';
            }, 2000);
        }
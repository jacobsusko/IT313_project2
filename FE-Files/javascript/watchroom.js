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

        document.getElementById("timeSelectStart").addEventListener("change", checkButton);
        document.getElementById("timeSelectEnd").addEventListener("change", checkButton);

        function checkButton() {
            let startTime = document.getElementById("timeSelectStart").value;
            let endTime = document.getElementById("timeSelectEnd").value;
            if (startTime >= endTime) {
                document.getElementById("submit").disabled = true;
                document.getElementById("submit").classList.add("disabled");
                console.log('button locked');
            } else {
                document.getElementById("submit").disabled = false;
                document.getElementById("submit").classList.remove("disabled");
                console.log('button unlocked');
            }
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
                });
                roomContainer.appendChild(roomButton);

            } catch (error) {
                // Handle errors if any
                console.error('Error fetching room occupancy:', error);
            }
        }
        async function submitWatchTime() {
            const hallName = document.getElementById('hallList').querySelector('.active').textContent;
            const roomNumText = document.getElementById(`${hallName}-rooms`).querySelector('.active').textContent;
            let roomNum;
            if (roomNumText !== "All") {
                roomNum = parseInt(roomNumText.match(/\d+$/)[0]);
                console.log(roomNum);
            }
            console.log(hallName);
            console.log(roomNumText);

        }
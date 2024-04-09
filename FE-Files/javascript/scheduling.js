//Done by Holly and David

// Get current date
const currentDate = new Date();

// Format current date as YYYY-MM-DD
const year = currentDate.getFullYear();
const month = String(currentDate.getMonth() + 1).padStart(2, '0'); // Months are zero-based
const day = String(currentDate.getDate()).padStart(2, '0');
let formattedDate = `${year}-${month}-${day}`;
 // Global variable to store references to room containers
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
                 fetchTimes(hall, room.room_num);
                 const roomButtons = document.querySelectorAll('.room-button');
                 roomButtons.forEach(button => {
                     button.classList.remove('active'); // Remove "active" class from all room buttons
                 });
                 roomButton.classList.add('active'); // Add "active" class to the clicked room button
             });
             roomContainer.appendChild(roomButton);
        });

    } catch (error) {
        // Handle errors if any
        console.error('Error fetching room occupancy:', error);
    }
}

async function scheduleTime(time) {
    const hallName = document.getElementById('hallList').querySelector('.active').textContent;
    const roomNumText = document.getElementById(`${hallName}-rooms`).querySelector('.active').textContent;
    const roomNum = parseInt(roomNumText.match(/\d+$/)[0]);
    const date = document.getElementById('schedule').value;
    const unFormattedTime = time;
    let arr = unFormattedTime.split('-');

    // Format each time element in the array
    arr = arr.map(element => {
        // Check if the element contains 'PM'
        if (element.includes('PM')) {
            let formattedElement = element.trim(); // Remove leading and trailing spaces
            // Check if the element is '12:00 PM'
            if (formattedElement === '12:00 PM') {
                return '12:00:00'; // Return '12:00:00' directly
            } else {
                // Extract the hour and minute parts while removing AM/PM
                const [timePart, ampm] = formattedElement.split(' ');
                const [hour, minute] = timePart.split(':');
                // Add 12 to the hour (assuming 12-hour format)
                const formattedHour = parseInt(hour) + 12;
                // Return the formatted time string
                return `${formattedHour}:${minute}:00`;
            }
        } else {
            let formattedElement = element.trim(); // Remove leading and trailing spaces
            // Extract the hour and minute parts while removing AM/PM
            const [timePart, ampm] = formattedElement.split(' ');
            let [hour, minute] = timePart.split(':');
            if (hour.length == 1) {
                hour = '0' + hour;
            }
            // Return the formatted time string
            return `${hour}:${minute}:00`;
        }
    });

    // Combine date and time elements to form the timestamp
    const timestamps = arr.map(time => `${date} ${time}`);
    let timestamp = timestamps.join(', ');
    timestamp = '[' + timestamp + ']';



    console.log(hallName);
    console.log(roomNum);
    console.log(timestamp);
    // Make a POST request with the hall, room, date, and time information
    try {
        const response = await fetch('/scheduleRoom', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            room_hall: hallName,
            room_num: roomNum,
            scheduled_time: timestamp
        })
    });

    if (!response.ok) {
        throw new Error('Failed to post data');
    }

    const responseData = await response.json();

    // Display the response message in an alert
    // alert(responseData.message);

    // Refresh the page after a short delay (e.g., 1 second)
    // setTimeout(() => {
    //   window.location.reload();
    // }, 1000);
    fetchTimes(hallName,roomNum);

    } catch (error) {
        console.error('Error scheduling room:', error);
        alert('Failed to schedule room. Please try again later.');
    }
}

async function fetchTimes(hallName, roomNum) {
// Time Slots
const times = ["8:00 AM - 9:00 AM", "9:00 AM - 10:00 AM", "10:00 AM - 11:00 AM",
"11:00 AM - 12:00 PM", "12:00 PM - 1:00 PM", "1:00 PM - 2:00 PM",
"2:00 PM - 3:00 PM", "3:00 PM - 4:00 PM", "4:00 PM - 5:00 PM", "5:00 PM - 6:00 PM",
"6:00 PM - 7:00 PM", "7:00 PM - 8:00 PM"];

const timesDiv = document.getElementById('times');
timesDiv.innerHTML = '';

// Create label element
const label = document.createElement('label');
label.setAttribute('for', 'schedule');
label.textContent = 'Schedule a Day:';

// Create input element
const input = document.createElement('input');
input.setAttribute('type', 'date');
input.id = 'schedule';
input.name = 'schedule';
input.value = formattedDate;
input.setAttribute('min', formattedDate);
input.setAttribute('max', '2024-05-15');

// Append label and input to timesDiv
timesDiv.appendChild(label);
timesDiv.appendChild(input);

input.addEventListener('input', () => {
formattedDate = document.getElementById('schedule').value;
fetchTimes(hallName, roomNum); // Call fetchTimes function on any change in the input
});

try {
const date = document.getElementById('schedule').value;

const response = await fetch('/scheduledRooms', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({
        room_hall: hallName,
        room_num: roomNum,
        date: date
    })
});
const responseData = await response.json(); // Parse JSON response
console.log(responseData);

if (!response.ok) {
    throw new Error('Failed to post data');
}

times.forEach(time => {
    const timeButton = document.createElement("button");
    timeButton.innerHTML = time;
    timeButton.className = "time-slot-button";
    timeButton.onclick = function () {
        scheduleTime(timeButton.textContent);
    };
    let arr = time.split('-');

    // Format each time element in the array
    arr = arr.map(element => {
        // Check if the element contains 'PM'
        if (element.includes('PM')) {
            let formattedElement = element.trim(); // Remove leading and trailing spaces
            // Check if the element is '12:00 PM'
            if (formattedElement === '12:00 PM') {
                return '12:00:00'; // Return '12:00:00' directly
            } else {
                // Extract the hour and minute parts while removing AM/PM
                const [timePart, ampm] = formattedElement.split(' ');
                const [hour, minute] = timePart.split(':');
                // Add 12 to the hour (assuming 12-hour format)
                const formattedHour = parseInt(hour) + 12;
                // Return the formatted time string
                return `${formattedHour}:${minute}:00`;
            }
        } else {
            let formattedElement = element.trim(); // Remove leading and trailing spaces
            // Extract the hour and minute parts while removing AM/PM
            const [timePart, ampm] = formattedElement.split(' ');
            let [hour, minute] = timePart.split(':');
            if (hour.length == 1) {
                hour = '0' + hour;
            }
            // Return the formatted time string
            return `${hour}:${minute}:00`;
        }
    });

    // Combine date and time elements to form the timestamp
    const timestamps = arr.map(time => `${date} ${time}`);
    console.log(timestamps);
    if (responseData != null){
    for (let i = 0; i < responseData.length; i++) {
        console.log(JSON.parse(responseData[i].scheduled_time));
        // console.log(responseData[i].scheduled_time[0]); // Output: "2024-03-20 08:00:00"
        // console.log(responseData[i].scheduled_time[1]); // Output: "2024-03-20 09:00:00"
        console.log(JSON.parse(responseData[i].scheduled_time)[0]);
        console.log(JSON.parse(responseData[i].scheduled_time)[1]);
        if (timestamps[0] == JSON.parse(responseData[i].scheduled_time)[0] && timestamps[1] == JSON.parse(responseData[i].scheduled_time)[1]) {
            console.log('Yes');
            timeButton.disabled = true;
            timeButton.style.opacity = "0.5"; // Adjust opacity to make it grayed out
            timeButton.addEventListener('mouseover', function() {
                this.style.cursor = 'default';
                this.style.opacity = "0.5";
            });
        }
    }
}
    timesDiv.appendChild(timeButton);
});
} catch (error) {
console.error('Error scheduling room:', error);
alert('Failed to schedule room. Please try again later.');
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
function add12Hours(timeString) {
    // Split the time string into hours, minutes, and seconds
    var parts = timeString.split(':');
    
    // Extract hours, minutes, and seconds
    var hours = parseInt(parts[0], 10);
    var minutes = parseInt(parts[1], 10);
    var seconds = parseInt(parts[2], 10);

    // Add 12 to the hours (assuming 24-hour format)
    hours += 12;

    // Convert back to string and pad with zeros if necessary
    var paddedHours = hours < 10 ? '0' + hours : hours;
    var paddedMinutes = minutes < 10 ? '0' + minutes : minutes;
    var paddedSeconds = seconds < 10 ? '0' + seconds : seconds;

    // Return the new time string
    return paddedHours + ':' + paddedMinutes + ':' + paddedSeconds;
}
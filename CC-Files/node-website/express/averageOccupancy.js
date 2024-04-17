// const { hallAverageOccupancy } = require('../server-files/dataController');

//Done by David
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

//// Make an HTTP request to retrieve user data
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

// Function to fetch hall names from the server and display them as buttons
async function fetchHallsAndDisplay() {
    const response = await fetch('/halls');
    const halls = await response.json();
    console.log(halls);

    const hallListDiv = document.getElementById('hallList');
    hallListDiv.innerHTML = ''; // Clear previous content

    halls.forEach(hall => {
        const hallButton = document.createElement('button');
        hallButton.textContent = hall;
        hallButton.id = hall; // Set the id attribute to the hall name
        hallButton.addEventListener('click', () => {
            console.log('click');
            const parameter = hallButton.textContent; // Get the inner text of the hall button
            fetchRoomAverage(parameter);
        });
        hallListDiv.appendChild(hallButton);
    });
}

// Call the function to fetch halls and display them as buttons when the HTML is loaded
window.addEventListener('load', fetchHallsAndDisplay);

async function fetchRoomAverage(parameter) {
    try {
        const div = document.getElementById('AverageOccupancy');
        div.innerHTML = ''; // Clear previous content

        const response = await fetch(`/hallAverageOccupancy?hall=${parameter}`);
        const averageTimeResponse = await response.json();

        // Loop through each day
        Object.keys(averageTimeResponse).forEach(day => {
            // Create a div for each day's graph
            const dayDiv = document.createElement('div');
            dayDiv.classList.add('day-graph');
            div.appendChild(dayDiv);

            // Create a canvas element to draw the graph
            const canvas = document.createElement('canvas');
            canvas.classList.add('day-canvas');
            dayDiv.appendChild(canvas);

            // Prepare data for the chart
            const labels = [];
            const occupancyRatios = [];

            // Loop through each hour from 08:00:00 to 20:00:00
            for (let i = 8; i <= 20; i++) {
                const hour = i < 10 ? `0${i}` : `${i}`;
                const nextHour = i + 1 < 10 ? `0${i + 1}` : `${i + 1}`;
                const timeRange = `${hour}:00-${nextHour}:00`; // Assuming each hour range is represented as "HH:00-HH:00 + 1:00"
                const occupancyRatio = averageTimeResponse[day][timeRange] ? averageTimeResponse[day][timeRange].occupancyRatio : 0;

                labels.push(`${hour}:00`);
                occupancyRatios.push(occupancyRatio);
            }

            // Create the Chart.js instance for the current day's graph
            const ctx = canvas.getContext('2d');
            console.log(occupancyRatios);
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: `${day} Occupancy Ratio`,
                        data: occupancyRatios,
                        borderColor: 'rgb(75, 192, 192)',
                        tension: 0.1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            suggestedMax: 1 // Set maximum value for y-axis
                        }
                    }
                }
            });
        });
    } catch (error) {
        console.error('Error fetching room average occupancy:', error);
    }
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


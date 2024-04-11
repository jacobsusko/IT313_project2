// Robbie B & Austin H

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
            const parameter = hallButton.textContent; // Get the inner text of the hall button
            fetchRoomOccupancy(parameter);
        });
        hallListDiv.appendChild(hallButton);
    });
}
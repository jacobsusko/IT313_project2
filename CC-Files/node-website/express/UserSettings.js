// Done by Austin

// Make an HTTP request to retrieve user data
fetch('/userData')
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to retrieve user data');
        }
        return response.json();
    })
    .then(userData => {
        document.getElementById('userData').innerHTML = `${userData.first_name}'s Profile`;
        document.getElementById('userInfo').innerHTML = `<b>Username:</b> ${userData.username} <br>`; 
        document.getElementById('userInfo').innerHTML += `<b>Name:</b> ${userData.first_name} ${userData.last_name} <br>`;
        document.getElementById('userInfo').innerHTML += `<b>Email:</b> ${userData.email} <br>`;
        document.getElementById('userInfo').innerHTML += `<label for="password"> <b>Password:</b> </label> <input type="password" id="password1" value="${userData.password}" readonly> 
                                                            <div id="passwordContainer"> <br> <button type="button" onclick="showPassword()" id="passwordToggle">Show Password</button> </div>`;
    })
    .catch(error => console.error('Error:', error));
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

async function hidePages() {
    console.log("test")
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


function updateData(){
    fetch('/userData')
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to retrieve user data');
        }
        return response.json();
    })
    .then(userData => {
        document.getElementById('userData').innerHTML = `${userData.first_name}'s Profile`;
        document.getElementById('userInfo').innerHTML = `<b>Username:</b> ${userData.username} <br>`; 
        document.getElementById('userInfo').innerHTML += `<b>Name:</b> ${userData.first_name} ${userData.last_name} <br>`;
        document.getElementById('userInfo').innerHTML += `<b>Email:</b> ${userData.email} <br>`;
        document.getElementById('userInfo').innerHTML += `<label for="password"> <b>Password:</b> </label> <input type="password" id="password1" value="${userData.password}" readonly> 
                                                            <div id="passwordContainer"> <br> <button type="button" onclick="showPassword()" id="passwordToggle">Show Password</button> </div>`;
        emptyForm();
    })
    .catch(error => console.error('Error:', error));
}

function emptyForm() {
    // Your update logic here
    
    // Reset the form after submission
    document.getElementById("updateEmailForm").reset();
}

// The script shows the by default hidden password.
function showPassword() {
    var passwordField = document.getElementById("password1");
    var passwordToggle = document.getElementById("passwordToggle");
    
    if (passwordField.type === "password") {
        passwordField.type = "text";
        passwordToggle.textContent = "Hide Password";
    } else {
        passwordField.type = "password";
        passwordToggle.textContent = "Show Password";
    }
}


// The logout script same one as used on the buildings page.
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

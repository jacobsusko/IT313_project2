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

async function hidePages() {
    const credentials = await getCredentials();
    if (credentials.loggedInEmp) {
        var schedule = document.getElementById('schedule');
        schedule.style.display = 'none';
    }
}
window.addEventListener('load', hidePages);

<button onclick="logout()" id="logout">Log out</button>
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

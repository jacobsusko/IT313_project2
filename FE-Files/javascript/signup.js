// Done by Teo
function checkpasswords() {
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    if (password !== confirmPassword) {
        document.getElementById("register").disabled = true;
        document.getElementById("message").innerHTML = "Passwords do not match";
    } else {
        var passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{10,}$/;

        if (password.match(passwordRegex)) {
            document.getElementById("register").disabled = false;
            document.getElementById("message").innerHTML = "";
        } else {
            document.getElementById("register").disabled = true;
            document.getElementById("message").innerHTML = "Password must contain at least one special character, one capital letter, one lowercase letter, one number, and be at least 10 characters long.";
        }
    }
}

function validateForm() {
    var emailInput = document.getElementById("email");
    var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    
    if (!emailPattern.test(emailInput.value)) {
        alert("Please enter a valid email address.");
        return false; // Prevent form submission
    }
    return true; // Allow form submission
}

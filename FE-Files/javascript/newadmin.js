//Done by Robbie
function checkpasswords(){
    if (document.getElementById("password").value == document.getElementById("confirmPassword").value){
        document.getElementById("register").disabled = false;
        document.getElementById("message").innerHTML = "";

    } else {
        document.getElementById("register").disabled = true;
        document.getElementById("message").innerHTML = "Passwords do not match";
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
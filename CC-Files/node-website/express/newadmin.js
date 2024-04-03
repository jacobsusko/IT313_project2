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
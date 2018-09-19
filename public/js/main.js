
        function login()
        {
            var email = document.getElementById("email");
            var password =document.getElementById("password");
            var emailLabel = document.getElementById("email-label");
            var pwdLabel = document.getElementById("password-label");
            var successLabel = document.getElementById("success-label");

            if(isBlank(email.value))
            {
                emailLabel.style.display="initial";
                emailLabel.innerHTML = "Email cant be blank";
                emailLabel.style.color="red";
                emailLabel.style.fontSize="15px";
                emailLabel.style.marginTop="10px"; 
            }
            if(isBlank(password.value))
            {
                pwdLabel.style.display="initial";
                pwdLabel.innerHTML ="password cant be blank";
                pwdLabel.style.color="red";
                pwdLabel.style.fontSize="15px";
                pwdLabel.style.marginTop="10px";  
            }
            if(valid(email.value,password.value))
            {
                successLabel.style.display="initial";
                successLabel.innerHTML ="Incorrect Details";
                successLabel.style.color="red";
                successLabel.style.fontSize="15px"; 
                successLabel.style.marginTop="10px";  
                
            }
            return false;

            function isBlank(email)
            {
                if(email==""|| email==null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }

            function valid(email,pwd)
            {
                if(email=="admin" && pwd=="admin")
                {
                    successLabel.style.display="initial";
                    successLabel.innerHTML="Registered Successfully";
                    successLabel.style.display="block";
                    successLabel.style.color="green";
                    successLabel.style.fontSize="15px"; 
                    successLabel.style.marginTop="10px";

                    window.location = "dash_upload.html";
                    return false;
                }
                else{
                    return true;
                }
            }
        }

        function emailFocus()
        {
            var emailLabel = document.getElementById("email-label");
            var successLabel = document.getElementById("success-label");
            emailLabel.style.display="none";
            successLabel.style.display="none";
            
        }
        function passwordFocus()
        {
            var passwordLabel = document.getElementById("password-label");
            var successLabel = document.getElementById("success-label");
            passwordLabel.style.display="none";
            successLabel.style.display="none";
        }

        function logout(){
            console.log("Inside Logout");
            email = null;
            password = null;

            window.location = "login.html"
        }
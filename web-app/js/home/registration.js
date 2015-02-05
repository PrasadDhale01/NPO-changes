$(function() {
    console.log("registration.js initialized");

    $('form').validate({
        rules: {
            username: {
                minlength: 2,
                required: true,
                email: true
            },
            password: {
                required: true
            },
            confirmPassword: {
                required: true,
                isEqualToPassword: true
            },
            firstName: {
                minlength: 2,
                required: true
            },
            lastName: {
                minlength: 2,
                required: true
            },
            name : {
            	minlength: 2,
                required: true
            }
        }
    });
     $.validator.addMethod('isEqualToPassword', function (value, element) {
        var confirmpassword = value;
        var password = $("#password").val();
        if(confirmpassword != password) {
            return (confirmpassword == password) ? password : false;
        }
        return true;
    }, "Passwords do not match! Please enter a valid password.");
});

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
            },
            email: {
                minlength: 2,
                email: true
            },
            confirmPass: {
                isEqualToPass: true
            },
        },
        errorPlacement: function(error, element) {
            error.appendTo(element.parent());
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
     
     $.validator.addMethod('isEqualToPass', function (value, element) {
         var confirmpass = value;
         var pass= $("#pass").val();
         if(confirmpass != pass) {
             return (confirmpass== pass) ? pass : false;
         }
         return true;
     }, "Passwords do not match! Please enter a valid password.");
});

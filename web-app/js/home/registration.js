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
                required: true,
                minlength: 6
            },
            confirmPassword: {
                required: true,
                isEqualToPassword: true
            },
            firstName: {
                minlength: 2,
                maxlength: 20,
                required: true
            },
            lastName: {
                minlength: 2,
                maxlength: 20,
                required: true
            }
        },
        errorPlacement: function(error, element) {
            error.appendTo(element.parent());
        }
    });
    $('.regForm').submit(function() {
        if($(".regForm").valid()) {
            $('#btnSignUp').attr('disabled','disabled');
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

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
            firstName: {
                minlength: 2,
                required: true
            },
            lastName: {
                minlength: 2,
                required: true
            }
        }
    });
});

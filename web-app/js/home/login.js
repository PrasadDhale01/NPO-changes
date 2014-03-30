$(function() {
    console.log("login.js initialized");

    $('form').validate({
        rules: {
            j_username: {
                minlength: 2,
                required: true,
                email: true
            },
            j_password: {
                required: true
            }
        }
    });
});

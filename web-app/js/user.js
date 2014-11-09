$(function() {
    console.log("user.js initialized");

    $('form').validate({
        rules: {
            avatar: {
                required: true
            }
        }
    });
    
});

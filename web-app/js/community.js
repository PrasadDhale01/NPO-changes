$(function() {
    console.log('community.js initialized');

    var validator = $('form').validate({
        rules: {
            title: {
                required: true,
                minlength: 5
            },
            description: {
                required: true,
                minlength: 10
            }
        }
    });
});


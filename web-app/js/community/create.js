$(function() {
    console.log('create.js initialized');

    var validator = $('form').validate({
        rules: {
            title: {
                required: true,
                minlength: 5
            },
            description: {
                required: true,
                minlength: 10
            },
            suggestedCredit: {
                required: true,
                number: true
            }
        }
    });
});


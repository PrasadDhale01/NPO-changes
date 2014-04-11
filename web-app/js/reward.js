$(function() {
    console.log('reward.js initialized');

    $('form').validate({
        rules: {
            title: {
                minlength: 2,
                required: true
            },
            description: {
                required: true,
                minlength: 2
            },
            price: {
                required: true,
                number: true
            }
        }
    });

});


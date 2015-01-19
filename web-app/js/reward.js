$(function() {
    console.log('reward.js initialized');

    $('#createRewardModal').find('form').validate({
        rules: {
            title: {
                minlength: 2
            },
            description: {
                required: true,
                minlength: 2,
                maxlength: 140
            },
            price: {
                required: true,
                number: true,
                max : 50000,
                min: 0
            }
        }
    });

});

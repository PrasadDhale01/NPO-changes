$(function() {
    console.log('create.js initialized');

    var validator = $('#suggestedcreditamount').validate({
        rules: {
            suggestedCredit: {
                required: true,
                number: true
            }
        }
    });
});


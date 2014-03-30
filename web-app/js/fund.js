$(function() {
    console.log("fund.js initialized");

    function getSelectedReward() {
        return $('.list-group-item.active').data('rewardid');
    }

    /* Stripe initializations */
    var stripeResponseHandler = function(status, response) {
        var $form = $('#payment-form');

        if (response.error) {
            // Show the errors on the form
            $form.find('.payment-errors').text(response.error.message);
            $form.find('button').prop('disabled', false);
        } else {
            // token contains id, last4, and card type
            var token = response.id;
            // Insert the token into the form so it gets submitted to the server
            $form.append($('<input type="hidden" name="stripeToken" />').val(token));

            // Set the reward id as a hidden field.
            var rewardId = getSelectedReward();
            $form.append($('<input type="hidden" name="rewardId" />').val(rewardId));

            // and submit
            $form.get(0).submit();
        }
    };

    $('#payment-form').submit(function(event) {
        var $form = $(this);

        // Disable the submit button to prevent repeated clicks
        $form.find('button').prop('disabled', true);

        Stripe.card.createToken($form, stripeResponseHandler);

        // Prevent the form from submitting with the default action
        return false;
    });


    $('form').validate({
        rules: {
            amount: {
                required: true,
                number: true,
                min: 10
            }
        },
        highlight: function (element) {
            $(element).closest('.input-group').addClass('has-error');
        },
        unhighlight: function (element) {
            $(element).closest('.input-group').removeClass('has-error');
        },
        errorElement: 'span',
        errorClass: 'help-block',
        errorPlacement: function(error, element) {
            if (element.parent('.input-group').length) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        }
    });

    $('.list-group-item').click(function() {
        $(this).siblings().removeClass('active');
        $(this).addClass('active');
    });
});

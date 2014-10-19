$(function() {
    console.log("checkout.js initialized");

    /*var source   = $("#credit-error-template").html();
    var template = Handlebars.compile(source);*/

    /* Stripe initializations */
    /*var stripeResponseHandler = function(status, response) {
        var $form = $('#payment-form');

        if (response.error) {
            // Show the errors on the form
            $form.find('.payment-errors').html(template({message: response.error.message}));
            $form.find('button').prop('disabled', false);
        } else {
            // token contains id, last4, and card type
            var token = response.id;

            // Insert the token into the form so it gets submitted to the server
            $form.append($('<input type="hidden" name="stripeToken" />').val(token));

            // and submit
            $form.get(0).submit();
        }
    };*/

    /*$('#payment-form').submit(function(event) {
        var $form = $(this);

        // Disable the submit button to prevent repeated clicks
        $form.find('button').prop('disabled', true);

        //Stripe.card.createToken($form, stripeResponseHandler);

        // Prevent the form from submitting with the default action
        //return false;
    });*/

    $('form').validate({
        rules: {
            ccNumber: {
                required: true
            },
            ccType: {
                required: true
            },
            ccExpDateYear: {
                required: true
            },
            ccExpDateMonth: {
                required: true
            },
            ccCardValidationNum: {
                required: true
            },
            billToFirstName: {
                required: true
            },
            billToLastName: {
                required: true
            },
            billToAddressLine1: {
                required: true
            },
            billToCity: {
                required: true
            },
            billToEmail: {
                required: true
            },
            billToCountry: {
                required: true
            },
            description: {
                required: true
            },
            billToState: {
                required: true
            }
        }
    });

});

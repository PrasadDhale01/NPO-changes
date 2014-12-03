$(function() {
    console.log("checkout.js initialized");
    $("#otherState").hide();
    
    /* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });
    
    var optionChosen;
    
    $('#ccType').change(function(event) {
    	optionChosen = $(this).val();
    });
    
    $('#billToState').change(function(event) {
    	var option = $(this).val();
    	if(option == 'other'){
    		$("#otherState").show();
    	} else {
    		$("#otherState").hide();
    	}
    		
    });
    

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
                required: true,
                maxlength:4
            },
            ccExpDateMonth: {
                required: true,
                maxlength:2
            },
            ccCardValidationNum: {
                required: true,
                maxlength: function(){
                    if (optionChosen == 'AX') {
                        return 4;
                    } else {
                        return 3;
                    }
                }
            },
            billToTitle: {
            	required:true,
            	maxlength:10
            },
            billToFirstName: {
                required: true,
                maxlength:100
            },
            billToLastName: {
                required: true,
                maxlength:100
            },
            billToAddressLine1: {
                required: true,
                maxlength:255
            },
            billToAddressLine2: {
            	maxlength:255
            },
            billToAddressLine3: {
                maxlength:255
            },
            billToCity: {
                required: true,
                maxlength:35
            },
            billToPhone: {
            	 number: true,
            	 maxlength:20
            },
            billToEmail: {
                required: true,
                maxlength:100
            },
            billToCountry: {
                required: true
            },
            billToState: {
                required: true
            },
            billToZip: {
            	number: true,
            	required: true
            },
            agreetoTermsandUse: {
                required: true
            }
        },
        messages:{
            agreetoTermsandUse: "Kindly confirm and then proceed to contribute"
        },
        errorPlacement: function(error, element) {
            if ( element.is(":radio") || element.is(":checkbox")) {
                error.appendTo(element.parent().parent());
            } else if(element.parent('.input-group').length) {
                error.insertAfter(element.parent());
            } else{
                error.insertAfter(element);
            }
        }
    });
    
    $('form').submit(function() {
        if($("#payment-form").valid()) {
            $(this).find("button[type='submit']").prop('disabled',true);
        }
    });

});

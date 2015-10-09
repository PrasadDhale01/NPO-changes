$(function() {
    console.log("checkout.js initialized");
    $("#otherState").hide();
    $("#other").hide();

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

    $('#state').change(function(event) {
    	var option = $(this).val();
    	if(option == 'other'){
    		$("#other").show();
    	} else {
    		$("#other").hide();
    	}
    });

    $('.states').change(function(event) {
    	var option = $(this).val();
    	if(option == 'other'){
    		$(".ostate").show();
    	} else {
    		$(".ostate").hide();
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

    var validator = $('#checkoutgsp').find('form').validate({
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
                email: true,
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
            	required: true
            },
            agreetoTermsandUse: {
                required: true
            },
            addressLine1: {
            	required: true
            },
            city: {
            	required: true
            },
            zip: {
            	required: true
            },
            shippingEmail: {
            	required: true,
            	email: true
            },
            twitterHandle: {
            	required: true
            },
            shippingCustom: {
            	required: true
            },
            receiptName: {
            	required: true,
            	isFullName: true
            },
            receiptEmail: {
            	required: true,
            	email: true
            },
            firstname:{
            	required:true
            },
            lastname:{
               	required:true
            },
            email:{
             	required:true,
              	email:true
            },
            amount:{
              	required:true
            },
            productinfo:{
              	required:true
            },
            phone:{
              	required:true,
               	number:true
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
    
    $.validator.addMethod('isFullName', function(value, element){
     	  if(value && value.length !=0){
     		var fullname =$('#receiptName').val();
    		 var space= fullname.split(" ");
    		 if(space.length < 2){
    			return false;
    		 }else if(space[1]==''){
    			return false;
    		 }else{
    			var p=/^[A-Za-z]+([\sA-Za-z]+)*$/
    	   	 	return (value.match(p));
    		 }
     	  }
     	  return true;
     }, "Please enter a valid fullname");

    $('form').submit(function() {
        if($(".payment-form").valid()) {
            $('#btnPaypal').attr('disabled','disabled');
            return true;
        }
    });
    
    $('.checkoutsubmitbutton').click(function(event) {
        if(validator.form()){
        	needToConfirm = false;
        } 	
    });

    $('#countries').change(function(event) {
    	var option = $(this).val();
    	$('#payuCountry').val(option);
    });
    $('#states').change(function(event) {
    	var option = $(this).val();
    	$('#payuStates').val(option);
    });

    $('.payucheckoutsubmitbutton').click(function(event) {
        if(validator.form()) {
            needToConfirm = false;
            var redirect = $('.payment-form').attr('action');
            event.preventDefault();
            var formData = {
                'anonymous'     : $('input[name= anonymous]').val(),
                'userId'        : $('input[name= userId]').val(),
                'rewardId'      : $('input[name= rewardId]').val(),
                'fr'            : $('input[name= fr]').val(),
                'projectAmount' : $('input[name= projectAmount]').val(),
                'projectTitle'  : $('input[name= projectTitle]').val(),
                'tempValue'     : $('input[name= tempValue]').val(),
                'billToTitle'   : $('input[name= billToTitle]').val(),
                'firstname'     : $('input[name= firstname]').val(),
                'lastname'      : $('input[name= lastname]').val(),
                'email'         : $('input[name= email]').val(),
                'phone'         : $('input[name= phone]').val(),
                'productinfo'   : $('input[name= productinfo]').val(),
                'amount'        : $('input[name= amount]').val(),
                'campaignId'    : $('input[name= campaignId]').val(),
                'addressLine1'  : $('input[name= addressLine1]').val(),
                'addressLine2'  : $('input[name= addressLine2]').val(),
                'city'          : $('input[name= city]').val(),
                'zip'           : $('input[name= zip]').val(),
                'country'       : $('#payuCountry').val(),
                'state'         : $('#payuStates').val(),
                'otherstate'    : $('input[name= otherstate]').val(),
                'shippingEmail' : $('input[name= shippingEmail]').val(),
                'twitterHandle' : $('input[name= twitterHandle]').val(),
                'shippingCustom': $('input[name= shippingCustom]').val()
            };
           
             $.ajax({
                type    :'post',
                url     : $("#b_url").val()+'/fund/payupayment',
                data    : formData,
                dataType: 'json',
                success : function(response, statusText){
                	$('input[name = txnid]').val(response.txnid);
                    $('input[name = hash]').val(response.hash);
                    $('input[name = surl]').val(response.surl);
                    $('input[name = furl]').val(response.furl);
                    $("form[name = 'payuForm']").submit();
                }
            }).error(function(){
                alert('An error occured');
            });
        }
	});
    
/**********************************End of checkbox for anonymous user***************************************/
    
    $('#checkAddress').click(function(){
    	if($(this).prop("checked") == true){
    		var addressLine1 = $('#billToAddressLine1').val();
    		var addressLine2 = $('#billToAddressLine2').val();
    		var city = $('#billToCity').val();
    		var zip = $('#billToZip').val();
    		var state = $("#billToState").val();
    		var country = $("#billToCountry option:selected").val();
    		$('#addressLine1').val(addressLine1);
    		$('#addressLine2').val(addressLine2);
    		$('#city').val(city);
    		$('#zip').val(zip);
    		$('#state').val(state);
    		$("#state").selectpicker('refresh');
    		$('#country').val(country);
    		$("#country").selectpicker('refresh');
    		if (state == 'other'){
    			$("#other").show();
    			var otherState = $('#os').val();
    			$("#otherstate").val(otherState);
    		}
    	} else if($(this).prop("checked") == false){
    		$('#addressLine1').val("");
    		$('#addressLine2').val("");
    		$('#city').val("");
    		$('#zip').val("");
    		$('#state').val("AL");
    		$("#state").selectpicker('refresh');
    		$('#country').val("US");
    		$("#country").selectpicker('refresh');
    		$("#other").hide();
    		$("#otherstate").val("");
    	}
    });
    
    $(document).ready(function (){
        //called when key is pressed in textbox
        $("#payuAmount").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
           if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
              //display error message
              $("#errormsg").html("Digits Only").show().fadeOut("slow");
                  return false;
           } 
        });
    });
    
    var showPopover = function () {
        $(this).popover('show');
    },
    hidePopover = function () {
        $(this).popover('hide');
    };
    
    var custom = $('#customField').val();
    
    $('#customShippingInfo').popover({
        content: custom,
        trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);


});

/**********************End of checkbox on checkout page for physical address shipping details****************************/

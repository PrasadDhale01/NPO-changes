$(function() {
    $("#otherState").hide();
    $("#other").hide();

    /* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });

    $('#state').change(function() {
        var option = $(this).val();
        if(option === 'other') {
            $("#other").show();
        } else {
            $("#other").hide();
        }
    });


    var validator = $('#checkoutgsp').find('form').validate({
        rules: {
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
            citrusNumber: {
                required: true
            },
            citrusCardType: {
                required: true
            },
            citrusCvv: {
                required: true,
                maxlength: 4
            },
            citrusCardHolder: {
                required: true,
                minlength: 2,
                maxlength: 100
            },
            citrusFirstName: {
                required: true,
                maxlength:100
            },
            citrusLastName: {
                required: true,
                maxlength:100
            },
            citrusEmail: {
                required: true,
                email: true,
                maxlength: 100
            },
            citrusMobile: {
            	required: true,
                number: true,
                maxlength: 20
            },
            citrusStreet1: {
                required: true,
                maxlength:255
            },
            citrusStreet2: {
                maxlength:255
            },
            citrusCity: {
                required: true,
                maxlength:35
            },
            citrusZip: {
                required: true,
                maxlength: 20
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
    
    
    function dateValidator(value) {

		var today = new Date();
		var month = today.getMonth() + 1;
		
		var expiry = value.replace(/\s+/g, '').replace("/", "");
		var inputMonth = expiry.substr(0, 2);
		var inputYear=expiry.slice(-4);
		var len = expiry.length;
		var year = today.getFullYear().toString().slice(-4);
		
		 if (len == 6) {
			 if (!(((inputMonth < month && inputYear > year) || (inputMonth >= month && inputYear >= year)) && inputMonth <= 12 && inputYear<=(parseInt(year)+50).toString())) {            
				 $('.dateErrorMsg').show();
				 return false;
			 } else {
				 $('.dateErrorMsg').hide();
				 return true;
			 }
		 } else {
			 $('.dateErrorMsg').show();
		 	 return false;
		 }
	}
    

    $('form').submit(function() {
        if($(".payment-form").valid(event)) {
            event.preventDefault();
            needToConfirm = false;

            var formData = {
                'anonymous'     : $('input[name= anonymous]').val(),
                'userId'        : $('input[name= userId]').val(),
                'rewardId'      : $('input[name= rewardId]').val(),
                'fr'            : $('input[name= fr]').val(),
                'tempValue'     : $('input[name= tempValue]').val(),
                'email'         : $('input[name= email]').val(),
                'campaignId'    : $('input[name= campaignId]').val(),
                'addressLine1'  : $('input[name= addressLine1]').val(),
                'addressLine2'  : $('input[name= addressLine2]').val(),
                'city'          : $('input[name= city]').val(),
                'zip'           : $('input[name= zip]').val(),
                'country'       : $('input[name= country]').val(),
                'state'         : $('input[name= state]').val(),
                'otherstate'    : $('input[name= otherstate1]').val(),
                'shippingEmail' : $('input[name= shippingEmail]').val(),
                'twitterHandle' : $('input[name= twitterHandle]').val(),
                'shippingCustom': $('input[name= shippingCustom]').val(),
                'projectTitle'  : $('input[name= projectTitle]').val()
            };

            $.ajax({
                type    :'post',
                url     : $("#b_url").val()+'/fund/setCitrusInfo',
                data    : formData,
                success : function(){
                	$('#citrusCardPayButton').click();
                }
            }).error(function(){
            });

        }
    });

    $('.citruscheckoutsubmitbtn').click(function() {
        if(validator.form()) {
        	needToConfirm = false;
        }
    });

    $('#ccExpDateMonth').change(function() {
        var month = $(this).val();
        var year = $('#ccExpDateYear').val();
        var expiry = month + '/' + year;
        $('#citrusExpiry').val(expiry);
        var isValidDate = dateValidator(expiry);
        $('#isValidDate').val(isValidDate);
    });

    $('#ccExpDateYear').change(function() {
        var year = $(this).val();
        var month = $('#ccExpDateMonth').val();
        var expiry = month + '/' + year;
        $('#citrusExpiry').val(expiry);
        var isValidDate = dateValidator(expiry);
        $('#isValidDate').val(isValidDate);
    });

    $('#billToState').change(function() {
        var state = $(this).val();
        if (state === 'other') {
        	$('#otherState').show();
        } else {
        	$('#otherState').hide();
        	$('#otherState').val('');
        	$('#citrusState').val(state);
        }
    });

    $('#os').blur(function() {
    	var state = $(this).val();
    	$('#citrusState').val(state);
    });

    $('#checkAddress').click(function(){
    	if($(this).prop("checked") === true){
    		var addressLine1 = $('#citrusStreet1').val();
    		var addressLine2 = $('#citrusStreet2').val();
    		var city = $('#citrusCity').val();
    		var zip = $('#citrusZip').val();
    		var state = $("#billToState").val();
    		var country = $("#citrusCountry option:selected").val();
    		$('#addressLine1').val(addressLine1);
    		$('#addressLine2').val(addressLine2);
    		$('#city').val(city);
    		$('#zip').val(zip);
    		$('#state').val(state);
    		$("#state").selectpicker('refresh');
    		$('#country').val(country);
    		$("#country").selectpicker('refresh');
    		if (state === 'other'){
    			$("#other").show();
    			var otherState = $('#os').val();
    			$("#otherstate1").val(otherState);
    		}
    	} else if($(this).prop("checked") === false){
    		$('#addressLine1').val("");
    		$('#addressLine2').val("");
    		$('#city').val("");
    		$('#zip').val("");
    		$('#state').val("AL");
    		$("#state").selectpicker('refresh');
    		$('#country').val("US");
    		$("#country").selectpicker('refresh');
    		$("#other").hide();
    		$("#otherstate1").val("");
    	}
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

    $('.sendContributorEmail').popover({
    	content:'This will make non-registered contributor user and will send them email with their username and password',
    	trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);

});

$(function() {
    $("#otherState").hide();
    $("#other").hide();

    /* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });

    var optionChosen;

    $('#ccType').change(function() {
        optionChosen = $(this).val();
    });

    $('#billToState').change(function() {
        var option = $(this).val();
        if(option === 'other'){
            $("#otherState").show();
        } else {
            $("#otherState").hide();
        }
    });

    $('#state').change(function() {
        var option = $(this).val();
        if(option === 'other') {
            $("#other").show();
        } else {
            $("#other").hide();
        }
    });

    $('.states').change(function() {
        var option = $(this).val();
        if(option === 'other'){
            $(".ostate").show();
        } else {
            $(".ostate").hide();
        }
    });


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
                    if (optionChosen === 'AX') {
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
            },
            citrusNumber: {
                required: true
            },
            citrusCardType: {
                required: true
            },
            citrusCvv: {
                required: true,
                maxlength: 3
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


    $('#currencyconvertor').find('form').validate({
        rules: {
            currency: {
                required: true,
                number: true
            }
        }
    });

    $.validator.addMethod('isFullName', function(value){
        if(value && value.length !== 0) {
            var fullname =$('#receiptName').val();
            var space= fullname.split(" ");

            if(space.length < 2 || space[1] === ''){
                return false;
            } else{
                var p=/^[A-Za-z]+([\sA-Za-z]+)*$/ ;
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

    $('.checkoutsubmitbutton').click(function() {
        if(validator.form()){
        	needToConfirm = false;
        }
    });

    $('#citrusCardPayButton').click(function() {
        
    });

    $('#ccExpDateMonth').change(function() {
    	var month = $(this).val();
    	var year = $('#ccExpDateYear').val();
    	var expiry = month + '/' + year;
        $('#citrusExpiry').val(expiry);
    });

    $('#ccExpDateYear').change(function() {
    	var year = $(this).val();
    	var month = $('#ccExpDateMonth').val();
    	var expiry = month + '/' + year;
        $('#citrusExpiry').val(expiry);
    });

    $('#countries').change(function() {
    	var option = $(this).val();
    	$('#payuCountry').val(option);
    });

    $('#states').change(function() {
    	var option = $(this).val();
    	$('#payuStates').val(option);
    });


/**********************************start of checkbox for anonymous user***************************************/

    $('#checkAddress').click(function(){
    	if($(this).prop("checked") === true){
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
    		if (state === 'other'){
    			$("#other").show();
    			var otherState = $('#os').val();
    			$("#otherstate").val(otherState);
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
    		$("#otherstate").val("");
    	}
    });

    $(document).ready(function (){
        //called when key is pressed in textbox
        $("#payuAmount").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
           if (e.which !== 8 && e.which !== 0 && (e.which < 48 || e.which > 57)) {
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

    $('.sendContributorEmail').popover({
    	content:'This will make non-registered contributor user and will send them email with their username and password',
    	trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);

});

function showSortedTransaction(){
	var currency = $('#currency').val();
	var selectedSortValue = $('#transactionSort').val();
	var grid = $('#transactionInfo');
	$.ajax({
		type:'post',
		url:$('#url').val()+'/fund/getSortedContributions',
		data:'currency='+currency+'&selectedSortValue='+selectedSortValue,
		success: function(data){
			$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
		}
	}).error(function(){
	});
}

/**********************End of checkbox on checkout page for physical address shipping details****************************/

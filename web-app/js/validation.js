$(function(){

	$('.capsOnly').bind('keyup', function (event) {
		if (event.which >= 97 && event.which <= 122) {
	        var newKey = event.which - 32;
	        event.keyCode = newKey;
	        event.charCode = newKey;
	    }
		    
	    var oldVal = $(this).val();
	    var newVal = oldVal.toUpperCase();
	    
	    if(oldVal != newVal) {
	        $(this).val(newVal);
	    }
	});

	$('.initCapsOnly').bind('keyup', function (event) {
		var str = $(this).val();
		var getStr = str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();}); //$(this).val().charAt(0).toUpperCase() + $(this).val().slice(1);
	    if(str != getStr) {
	    	$(this).val(getStr);
	    }
	});

	$('.userNameOnly').bind('keypress', function (event) {
		var s = event.keyCode || event.which;
		var regex = new RegExp("^[a-z0-9_-]{4,15}+$");
		var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
		
		if (!regex.test(key)) {
			event.preventDefault();
			return false;
		} else{
			return true;
		}
	});

	jQuery.validator.addMethod('selectcheck', function(
			value) {
		return (value != '0' && value != '' && value != 0);
	}, "");
	
	//done for calculation listindex using list from session.
	jQuery.validator.addMethod('selectcheck1', function(value) {
		return (value != '-1' && value != '' && value != -1);
	}, "");

	
	$('.myForm').each(function() {
		$(this).validate({
			onfocusout: function(e) {
				this.element(e);
			},
			highlight: function(element) {
				$(element).removeClass('my-valid-class');
				$(element).addClass('my-error-cls');
				$(element).parent().prev().prev().prev('span').addClass("label-color");
			},
			unhighlight: function(element) {
				$(element).removeClass('my-error-cls');
				$(element).addClass('my-valid-class');
				$(element).parent().prev().prev().prev('span').removeClass("label-color");

			},
			submitHandler : function(form) {
				if ($('.myForm').valid()) {
					form.submit();
				}
			}
		});
	});

	//For mobileNo
	$.validator.addMethod("cNumber", $.validator.methods.number,
			$.format("Please enter Valid Phone Number in Numeric Format."));

	$.validator.addMethod("cMinlength", $.validator.methods.minlength, 
			// leverage parameter replacement for minlength, {0} gets replaced with 2
			$.format("Phone Number must have at least {0} characters"));

	$.validator.addClassRules("validateMobile", {
		cNumber : true, 
		cMinlength: 10
	});
	
	//For AlphaOnly		
	jQuery.validator.addMethod("alpha", function(value, element) {
		return this.optional(element) || /^[a-zA-Z _]+$/i.test(value); //
	}, "Please Enter Alphabets Only.");
	
	$.validator.addClassRules("alphaOnly", {
		alpha : true
	});
	
	//For Alphawith&Only		
	jQuery.validator.addMethod("alphawithampersand", function(value, element) {
		return this.optional(element) || /^[a-zA-Z \&]+$/i.test(value); //
	}, "Please Enter Alphabets And Ampersand Only.");
	
	$.validator.addClassRules("alphaAmpersandOnly", {
		alphawithampersand : true
	});
	
	//For Alpha and Dot
	jQuery.validator.addMethod("alphaDot", function(value, element) {
		return this.optional(element) || /^[a-zA-Z \.]+$/i.test(value); //
	}, "Please Enter Alphabets And Dot Only.");
	
	$.validator.addClassRules("alphaDotOnly", {
		alphaDot : true
	});
	
	//For AlphawithHyphenOnly		
	jQuery.validator.addMethod("alphawithhyphen", function(value, element) {
		return this.optional(element) || /^[a-zA-Z \-]+$/i.test(value); //
	}, "Please Enter Alphabets And Hyphen Only.");
	
	$.validator.addClassRules("alphaHyphenOnly", {
		alphawithhyphen : true
	});
	
	//For AlphawithUnderscoreOnly		
	jQuery.validator.addMethod("alphawithunderscore", function(value, element) {
		return this.optional(element) || /^[a-zA-Z \_]+$/i.test(value); //
	}, "Please Enter Alphabets And UnderScore Only.");
	
	$.validator.addClassRules("alphaUnderscoreOnly", {
		alphawithunderscore : true
	});
	
	//For AlphawithSpeOnly		
	jQuery.validator.addMethod("alphawithspe", function(value, element) {
		return this.optional(element) || /^[&a-zA-Z \_.-]+$/i.test(value); 
	}, "Please Enter AlphaNumric with Special Symbol Only.");
	
	$.validator.addClassRules("alphaSpeOnly", {
		alphawithspe : true
	});
	
	//For AlphawithSpeNumberOnly 		
	jQuery.validator.addMethod("alphawithspeNum", function(value, element) {
		return this.optional(element) || /^[&a-zA-Z\d \_.-]+$/i.test(value); 
	}, "Please Enter Alphabets - _ &Only.");
	
	$.validator.addClassRules("alphaSpeNumOnly", {
		alphawithspeNum : true
	});
	
	//For Roman letter		
	jQuery.validator.addMethod("romanletter", function(value, element) {
		return this.optional(element) || /^[\M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})]+$/i.test(value); //
	}, "Please Enter Alphabets And Roman Letter Only.");
	
	$.validator.addClassRules("romanLetterOnly", {
		romanletter : true
	});
	
	
	//For Number Only
	jQuery.validator.addMethod("num", function(value, element) {
		return this.optional(element) || /^[0-9]+$/i.test(value); 
	}, "Please Enter Numbers Only.");
	
	$.validator.addClassRules("numbersOnly", {
		num : true
	});
	
	//For Number Only for paperSetter
	jQuery.validator.addMethod("number", function(value, element) {
		return this.optional(element) || /^[0-9]+$/i.test(value); 
	}, "");
	
	$.validator.addClassRules("numbers1", {
	    number : true
	});
	
	// Number With Decimal
	jQuery.validator.addMethod("numwithDecimal", function(value, element) {
		return this.optional(element) || /^[0-9.]+$/i.test(value); 
	}, "Please Enter Numbers Only.");
	
	$.validator.addClassRules("numbersWithDecimal", {
		numwithDecimal : true
	});
	
	$('.numbersWithDecimal').blur(function() {
		var value = $(this).val();
		//alert(value.substring(0,value.length-3));
		if (value && (isNaN(value) == false) && !(value.indexOf('.') != -1)) {
			$(this).val(value+'.00');
		}
	});
	
	// Float Values
	jQuery.validator.addMethod("floatValue", function(value, element) {
		return this.optional(element) || /^\d{1,}$/i.test(value) || /^\d{1,}\.\d{1,}$/i.test(value); 
	}, "Please Enter Valid Numbers.");
	
	$.validator.addClassRules("floatValue", {
		floatValue : true
	});
	
	
   //For AlphaNumeric Only
	jQuery.validator.addMethod("alphanum", function(value, element) {
		return this.optional(element) || /^[a-z\d\-_\s]+$/i.test(value);
	}, "Please Enter Alphabets and Numbers Only.");
	$.validator.addClassRules("alphaNumericOnly", {
		alphanum : true
	});
	
   //For NumberLetterOnly
	jQuery.validator.addMethod("numletter", function(value, element) {
		return this.optional(element) || /^[0-9a-zA-Z _]+$/i.test(value);
	}, "Please Enter Number and Letter Only.");
	$.validator.addClassRules("numberLetterOnly", {
		numletter : true
	});
	
	//For Decimal Only
	jQuery.validator.addMethod("decimal", function(value, element) {
		return this.optional(element) || /^\d{1,14}(\.\d{0,2})+$/i.test(value);
	}, "Please Enter Decimal Only.");
	
	$.validator.addClassRules("decimalOnly", {
		decimal : true
	});
	
	
	//for checkbox mandatory fields
	$.validator.addMethod("isCheckboxSelected", function(value, elem, param) {
	    if($(".checkboxMandatory:checkbox:checked").length > 0){
	    	$(".checkBoxErrorPlacement").html("");
	       return true;
	   }else {
		   $(".checkBoxErrorPlacement").html("You must select at least one!");
	       return false;
	   }
	},"");
	
	$.validator.addClassRules("checkboxMandatory", {
		isCheckboxSelected : true
	});
	
	$('.mandatory').each(function() {
		$(this).rules('add', {
			required: true,
		});
	});

	$('.selectMandatory').each(function() {
		$(this).rules('add', {
			required: true,
			selectcheck: true
		});
	});
	
	$('.selectMandatory-1').each(function() {
		$(this).rules('add', {
			required: true,
			selectcheck1: true
		});
	});

	$.validator.addMethod('accept', function () { 
		return true; 
	});

	//For Comparison
	jQuery.validator.addMethod("validategreaterThan", function (value, element, param) {
		var mark = $(element).closest("tr").find(".tobeCompared").val();
		
		if(!isNaN(mark) && !isNaN(value)){
			if(parseInt(value) < parseInt(mark)){
				return false;
			} else {
				return true;
			}
		} else{
			return true;
		}
	}, "Out Of Marks Should Be Greater Than Marks");
	
	
	$.validator.addClassRules("comparison", {
		validategreaterThan : true
	});
	
	
	//for reset button
	var commonValidator = $('.myForm').validate();
	var formElements = $('.myForm');

	$(".cancel").click(function() {
		$('[name]',formElements).each(function() {
			$(this).removeClass('my-error-cls');
			$(this).parent().prev().prev().prev('span').removeClass("label-color");
		});
		commonValidator.resetForm();
	});
	
});

function validateGroup(groupId) {
	
    var group = ".group"+groupId;
    
    var isValidated = true;
	$(''+group+'').each(function() {
		var isValid = $(this).prop('disabled') || ($(this).val()== "" && !$(this).hasClass('mandatory')) || $(this).valid();
		if (!isValid) {
			isValidated = false;
		}
	});
	return isValidated;
}


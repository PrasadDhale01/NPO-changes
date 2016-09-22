$(function() {

	$.validator.addMethod("checkCity", function(value,element){
		var cityRegex= /^(?:[a-zA-Z]\s?)+$/;
		
		if(cityRegex.test(value)){
			return true;
		}
		
		return false;
	}, "Please enter valid city.");
	
	$.validator.addMethod("checkCardHolderName", function(value,element){
		var nameRegex= /^[a-zA-z]+\s[a-zA-z]+$/;
		
		if(nameRegex.test(value)){
			return true;
		}
		
		return false;
	}, "Please enter valid card holder name.");
	
	
	$.validator.addMethod("checkAddress", function(value, element){
		
		var addressRegex =/^(?:[a-zA-Z0-9]+(?:[.'\-,])?\s?)+$/;
		
		if(addressRegex.test(value)){
			return true;
		}
		
		return false;
		
	},"Please enter valid address.");
	
	$.validator.addMethod("checkFirstName", function(value,element){
		var cityRegex= /^(?:[a-zA-Z])+$/;
		
		if(cityRegex.test(value)){
			return true;
		}
		
		return false;
	}, "Please enter valid firstName.");
	
	$.validator.addMethod("checkLastName", function(value,element){
		var cityRegex= /^(?:[a-zA-Z])+$/;
		
		if(cityRegex.test(value)){
			return true;
		}
		
		return false;
	}, "Please enter valid lastName.");
	
	
   /* $("#citrusNumber").keyup(function(){

        $("#payment-form").validate();
        $("#citrusNumber").rules("add","checkCard");
        $.validator.addMethod("checkCard", function(value, element) {
			
            if(value[0]==="4" || value[0]==="5" || value[0]==="6"){
                return true;
            }else {
                return false;
            }
        }, "Please specify the correct card number.");
	
        if(/^4\d{14}/.test($(this).val())){
            $("#citrusScheme").val("visa");
            $("#cardType").attr("src","//s3.amazonaws.com/crowdera/assets/954456ca-1012-4d8d-86e8-f4979ff4b330.png");
        }else if(/^6\d{14}/.test($(this).val())){
            $("#citrusScheme").val("maestro");
            $("#cardType").attr("src","//s3.amazonaws.com/crowdera/assets/f0cf3a78-60b5-4224-9b93-092b4046c690.png");
        }else if(/^5\d{14}/.test($(this).val())){
            $("#citrusScheme").val("mastercard");
            $("#cardType").attr("src","//s3.amazonaws.com/crowdera/assets/34bfdb13-f40a-4e3f-bcf0-3a83625bda5c.png");
        }else{
            $("#citrusScheme").val("");
            $("#cardType").attr("src","//s3.amazonaws.com/crowdera/assets/2d87664b-d1c9-4fae-a015-fc02d3333dbb.png");
        }
	
    });*/
	
    function getSelectedRewardId() {
        return $('.list-group-item.active').attr('id');
    }

    function getSelectedRewardPrice() {
        return $('.list-group-item.active').data('rewardprice');
    }
    
    var optionChosen = 'visa';
    $('#citrusScheme').change(function() {
        optionChosen = $(this).val();
    });
    
    $('#myWizard').easyWizard({
        showButtons: false,
        submitButton: false
    });
    
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });
    
    $("form").on("change", ".states", function () {
    	var option = $(this).val();
    	$('#stateField').val(option);
    	if(option === 'other'){
    		$(".ostate").show();
    	} else {
    		$(".ostate").hide();
    	}
    });
    
    $("#isTaxreceipt").change(function() {
    	if ($(this).is(':checked')) {
    		$(".pannumberdiv").slideDown();
    		
    		$('[name="panNumber"]').rules( "add", {
                required: true,
                minlength: 10,
                maxlength: 10
            });
    	} else {
    		$(".pannumberdiv").slideUp();
    		$('[name="panNumber"]').rules('remove');
    	}
    });
    
    var validator = $('#fundindex').find('form').validate({
        rules: {
            amount: {
                required: true,
                number: true,
                min: function() {
                    var rewardPrice = getSelectedRewardPrice();
                    if (rewardPrice === undefined) {
                    	var isINR = $('#isINR').val();
                    	if(isINR === undefined) {
                    		return 1;
                    	} else {
                    		return 100;
                    	}
                    } else {
                    	var isINR = $('#isINR').val();
                    	if(isINR === undefined) {
                    		return _.max([1, Number(rewardPrice)]);
                    	} else {
                    		return _.max([100, Number(rewardPrice)]);
                    	}
                    }
                }
            },
            receiptName: {
            	required: true,
            	isFullName: true,
            	maxlength: 30
            },
            receiptEmail: {
            	required: true,
            	email: true,
            	maxlength: 30
            },
            agreetoTermsandUse: {
                required: true
            },
            addressLine1: {
            	required: true,
            	maxlength: 50
            },
            city: {
            	required: true,
            	minlength:3,
            	maxlength: 15,
            	checkCity:true
            },
            zip: {
            	required: true,
            	maxlength: 8,
            	minlength: 6
            },
            shippingEmail: {
            	required: true,
            	email: true,
            	maxlength: 30
            },
            twitterHandle: {
            	required: true,
            	 maxlength: 30
            },
            shippingCustom: {
            	required: true,
            	maxlength: 50 
            },
            firstname:{
            	required:true,
            	maxlength: 20
            },
            lastname:{
            	required:true,
            	maxlength: 20
            },
            email:{
            	required:true,
            	email:true,
            	maxlength: 30
            },
            citrusNumber: {
                required: true,
                minlength: 12
            },
            citrusCardType: {
                required: true
            },
            citrusCvv: {
            	required: true,
                maxlength: function(){
                    if (optionChosen == 'amex' || optionChosen == "maestro") {
                        return 4;
                    } else {
                        return 3;
                    }
                }
            },
            citrusCardHolder: {
                required: true,
                checkCardHolderName: true,
                minlength: 3,
                maxlength: 30
            },
            citrusFirstName: {
                required: true,
                checkFirstName: true,
                maxlength: 20
            },
            citrusLastName: {
                required: true,
                checkLastName: true,
                maxlength: 20
            },
            citrusEmail: {
                required: true,
                email: true,
                maxlength: 30
            },
            citrusMobile: {
            	required: true,
                number: true,
                maxlength: 14,
                minlength: 10
            },
            citrusStreet1: {
                required: true,
                checkAddress:true,
                maxlength: 50
            },
            citrusStreet2: {
                maxlength: 50
            },
            citrusCity: {
                required: true,
                checkCity:true,
                minlength:3,
                maxlength: 15
            },
            citrusZip: {
            	required: true,
            	number: true,
            	minlength: 6,
                maxlength: 8
            }
        },
        messages:{
            agreetoTermsandUse: "Kindly confirm and then proceed to contribute"
        },
        errorPlacement: function(error, element) {
            if ( element.is(":checkbox")) {
                error.appendTo(element.parent());
            } else if($(element).prop("id") === "amount"){
            	error.appendTo(document.getElementById("errormsg"));
            } else {
            	error.insertAfter(element);
            }
        }
    });

    $.validator.addMethod('isFullName', function(value){
        if(value && value.length !== 0){
            var fullname =$('#receiptName').val();
            var space= fullname.split(" ");
            if(space.length < 2 || space[1] === ''){
                return false;
            } else {
                var p=/^[A-Za-z]+([\sA-Za-z]+)*$/ ;
                return (value.match(p));
            }
        }
        return true;
    }, "Please enter a valid fullname");

    
    $(document).ready(function () {
    	
        $("#amount").keypress(function (e) {
            if (e.which != 8 && e.which != 0 && e.which !=13 && (e.which < 48 || e.which > 57)) {
                $("#errormsg").html("Digits Only").show().fadeOut("slow");
                return false;
            }
        });
        
        
        $('#btnCheckoutContinue').click(function() {
        	
            var amountStatus = checkAmount();
            var validatePanNumber = false;
             
            if ($('input[name= panNumber]').length > 0) {
           	    validatePanNumber = $("#panNumber").valid();
            } else {
                validatePanNumber = true;
            }
        	
            if(amountStatus == true && validatePanNumber) {
            	var rewardId = getSelectedRewardId();
            	if (rewardId === undefined) {
                	rewardId = 1;
                    $('form input[name="rewardId"]').val(rewardId);
                } else {
                    rewardId = getSelectedRewardId();
                    $('form input[name="rewardId"]').val(rewardId);
                }
            	
            	var anonymous = $('#anonymous').val();
        		var grid = $('#perkShippingInfo');
        		$.ajax({
        			type : 'post',
        			url  : $('#url').val()+'/fund/getBillingInfo',
        			data : 'rewardId='+rewardId+'&anonymous='+anonymous,
        			async: false,
        			success: function(data){
        				$(grid).html(data);
        				$('#myWizard').easyWizard('goToStep', 2);
        				$('#billingInformation').show();
        			}
        		}).error(function(){
        		});
            	
            }
        });
        
        $('#btnShippingContinue').click(function() {
        	if (validateshippingInfo()) {
        		$.ajax({
        			type : 'post',
        			url  : $('#url').val()+'/fund/getCitrusSignature',
        			data : 'amount=' + $('#amount').val(), 
        			async: false,
        			success: function(response){
        				var data;
                        data = response.replace(/^\[/, '');
                        data = response.replace(/\]$/, '');

                        var json;
                        try {
                            json = (typeof data === 'string' ? $.parseJSON(data) : data);
                        } catch(err) {
                            json = { error: true };
                        }
        				$('#citrusMerchantTxnId').val(json.txnID);
        				$('#citrusSignature').val(json.securitySignature);
        				$('#citrusAmount').val($('#amount').val());
        				$('#myWizard').easyWizard('goToStep', 3);
        				$('#citrusCardDetails').show();
        			}
        		}).error(function(){
        		});
        		
        	}
        });
        
        $('.easyWizardSteps li').click(function(e) {
        	var data = $(this).data('step');
        	var currentData = $('.easyWizardSteps').find('li.current').data('step');
        	
        	if (currentData == 3) {
        		$('#myWizard').easyWizard('goToStep', data);
        	} else if (currentData == 2 && data == 1) {
        		$('#myWizard').easyWizard('goToStep', data);
        	} 
        })
        
    });

    
    $('a.list-group-item').click(function() {
    	$('.choose-error').html('');
        $('.list-group.twitterHandler').find('a.list-group-item').removeClass('active');
        $(this).addClass('active');
        var rewardId = $('a.list-group-item.active').attr('id');
        showShippingDetails(rewardId);
    });
    
    $(".TW-perk-status").click(function(){
        var amount = $('.list-group-item.active').data('rewardprice');
        $(".amount").val(Math.round(amount));
    });

	function showShippingDetails(rewardId){
		var anonymous = $('#anonymous').val();
		var grid = $('#perkShippingInfo');
		$.ajax({
			type : 'post',
			url  : $('#url').val()+'/fund/getBillingInfo',
			data : 'rewardId='+rewardId+'&anonymous='+anonymous,
			async: false,
			success: function(data){
				$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
			}
		}).error(function(){
		});
	}
	
    $('#anonymousUser').click(function(){
    	var projectId = $('#projectId').val();
    	var selectedRewardId = getSelectedRewardId();
    	
    	if($(this).prop("checked") === true) {
    		$('#anonymous').val(true);
            $('#twitterPerk').hide();
            
    		$.ajax({
    			type : 'post',
    			url  : $('#url').val()+'/fund/getOnlyTwitterHandlerRewards',
    			data : 'projectId='+projectId,
    			async: false,
    			success: function(data) {
    				var list = data.split("[");
    				var list1 = list[1].split("]");
    				var list2 = list1[0].split(",");
    				var s= [];
    				for(var i=0;i<list2.length;i++) {
    		    		var a = '#'+list2[i].trim();
    		    		var x = $(a).attr("data-rewardprice");
    		    		s.push(x);
    		    		$(a).replaceWith(function() {
    		    			return $('<div/>', {
    		    				href:'#',
    		    				class:'list-group-item onlyTwitterReward',
    		    			    html: this.innerHTML
    		    			});
    		    		});
    		    		//$(a).attr('class','list-group-item');
    				}
    				for(var i=0;i<list2.length;i++) {
    					var idval = list2[i].trim();
					    var k = 0;
					    $('.onlyTwitterReward').each(function () {
					    	if(k === i) {
			                    $(this).attr('id',idval);
			                    $(this).attr('data-rewardprice',s[i]);
					    	}
					    	k++;
			            });
    				}

    				$('a.list-group-item').click(function() {
    	    	        $('.choose-error').html('');

    	    	        $('.list-group.twitterHandler').find('a.list-group-item').removeClass('active');
    	    	        $(this).addClass('active');
    	    	        $('#perkForAnonymousUser').hide();

                        var rewardId = $('a.list-group-item.active').attr('id');
                        showShippingDetails(rewardId);
    	    	    });

    				$('.onlyTwitterReward').each(function() {
    		            $(this).popover({
    		                content: 'As you are keeping your contribution anonymous, this perks which has only Twitter handler will be disabled for you',
    		                trigger: 'manual',
    		                placement: 'auto'
    		            })
    		            .focus(showPopover)
    		            .blur(hidePopover)
    		            .hover(showPopover, hidePopover);
    		        });

    				if($('#'+selectedRewardId).hasClass('onlyTwitterReward')) {
    	    			$('#perkForAnonymousUser').show();
    	    		}
    			}
    		}).error(function() {
    		});

    		$.ajax({
                type:'post',
                url:$("#url").val()+'/fund/getRewardsHavingTwitterHandler',
                data:'projectId='+projectId,
                async: false,
                success: function(data){
                	var list = data.split("[");
    				var list1 = list[1].split("]");
    				var list2 = list1[0].split(",");
    				for(var i=0;i<list2.length;i++){
    		    		var a = '#'+list2[i].trim();
    		    		$(a).addClass('twitterReward');
    				}

    				$('a.list-group-item').click(function() {
    	    	        $('.choose-error').html('');

    	    	        $('.list-group.twitterHandler').find('a.list-group-item').removeClass('active');
    	    	        $(this).addClass('active');
    	    	        $('#perkForAnonymousUser').hide();
    	    	        showShippingDetails(rewardId);
    	    	    });

    				$('#'+selectedRewardId).addClass('active');

    				$('.twitterReward').each(function() {
    		            $(this).popover({
    		                content: "As you are keeping your contribution anonymous, Twitter perks will be disabled for you",
    		                trigger: 'manual',
    		                placement: 'auto'
    		            })
    		            .focus(showPopover)
    		            .blur(hidePopover)
    		            .hover(showPopover, hidePopover);
    		        });
                }
            }).error(function(){
            });

        } else if ($(this).prop("checked") === false){
            $('#anonymous').val(false);
            $('#twitterPerk').show();
            $('#perkForAnonymousUser').hide();
            $('.twitterHandler').find('.onlyTwitterReward').each(function(){
                var price = $(this).attr('data-rewardprice');
                var idVal = $(this).attr('id');
                $(this).replaceWith(function() {
                    return $('<a/>', {
                        href:'#',
                        class: 'list-group-item',
                        id: idVal,
                        html: this.innerHTML
                    });
                });

                $('#'+idVal).attr('data-rewardprice', price);
            });

            $('.twitterHandler').find('.twitterReward').each(function(){
                var price = $(this).attr('data-rewardprice');
                var idVal = $(this).attr('id');
                $(this).replaceWith(function() {
                    return $('<a/>', {
                        href:'#',
                        class: 'list-group-item',
                        id: idVal,
                        html: this.innerHTML
                    });
                });

            $('#'+idVal).attr('data-rewardprice', price);
        });

        $('#'+selectedRewardId).addClass('active');

        $('a.list-group-item').click(function() {
            $('.choose-error').html('');

            $('.list-group.twitterHandler').find('a.list-group-item').removeClass('active');
            $(this).addClass('active');
            $('#perkForAnonymousUser').hide();

            var rewardId = $('a.list-group-item.active').attr('id');
            showShippingDetails(rewardId);
        });
    }
    });
    
    

    var beneficiaryName = $('#beneficiaryName').val();

    /* Show pop-over tooltip on hover for some fields. */
    var showPopover = function () {
            $(this).popover('show');
        },
        hidePopover = function () {
            $(this).popover('hide');
        };
        
        $('.customField').each(function(){
        	$(this).popover({
        	    trigger: 'manual',
        	    placement: 'auto'
        	})
        	.focus(showPopover)
        	.blur(hidePopover)
        	.hover(showPopover, hidePopover);
        });

        $('.onlyTwitterReward').each(function(){    
            $(this).popover({
                content: 'As you are keeping your contribution anonymous, this perks which has only Twitter handler will be disabled for you',
                trigger: 'manual',
                placement: 'auto'
            })
            .focus(showPopover)
            .blur(hidePopover)
            .hover(showPopover, hidePopover);
        });
            
        $('.twitterReward').each(function(){
            $(this).popover({
                content: "As you are keeping your contribution anonymous, Twitter perks will be disabled for you",
                trigger: 'manual',
                placement: 'auto'
            })
            .focus(showPopover)
            .blur(hidePopover)
            .hover(showPopover, hidePopover);
        });

        $("#anonymousUser").popover({
            content: 'If checked, your name will only be visible to campiagn owner, for public you will be anonymous contributor.',
            trigger: 'manual',
            placement: 'right'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);
        

        $('form').submit(function(event) {
            if($(".payment-form").valid(event)) {
            	
                event.preventDefault();
                needToConfirm = false;

                var formData;
                
                var formDataObj = new FormData();
                
                formDataObj.append("anonymous", $('input[name= anonymous]').val());
                if ($('input[name= userId]').length > 0) {
                	formDataObj.append("userId", $('input[name= userId]').val());
                }
                formDataObj.append("rewardId", $('input[name= rewardId]').val());
                formDataObj.append("fr", $('input[name= fr]').val());
                formDataObj.append("tempValue", $('input[name= tempValue]').val());
                formDataObj.append("email", $('input[name= email]').val());
                formDataObj.append("campaignId", $('input[name= projectId]').val());
                formDataObj.append("addressLine1", $('input[name= addressLine1]').val());
                formDataObj.append("addressLine2", $('input[name= addressLine2]').val());
                
                formDataObj.append("city", $('input[name= city]').val());
                formDataObj.append("zip", $('input[name= zip]').val());
                formDataObj.append("country", $('input[name= country]').val());
                formDataObj.append("state", $('input[name= state]').val());
                formDataObj.append("otherstate", $('input[name= otherstate1]').val());
                
                formDataObj.append("shippingEmail", $('input[name= shippingEmail]').val());
                formDataObj.append("twitterHandle", $('input[name= twitterHandle]').val());
                formDataObj.append("shippingCustom", $('input[name= shippingCustom]').val());
                formDataObj.append("projectTitle", $('input[name= projectTitle]').val());
                
                if ($('input[name= panNumber]').length > 0) {
                	formDataObj.append("panNumber", $('input[name= panNumber]').val());
                }
                
                /*formData = {
                    'anonymous'     : $('input[name= anonymous]').val(),
                    'userId'        : $('input[name= userId]').val(),
                    'rewardId'      : $('input[name= rewardId]').val(),
                    'fr'            : $('input[name= fr]').val(),
                    'tempValue'     : $('input[name= tempValue]').val(),
                    'email'         : $('input[name= email]').val(),
                    'campaignId'    : $('input[name= projectId]').val(),
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
                    'projectTitle'  : $('input[name= projectTitle]').val(),
                    'panNumber'     : $('input[name= panNumber]').val()
                };*/

                $.ajax({
                    type    :'post',
                    url     : $("#b_url").val()+'/fund/setCitrusInfo',
                    data    : formDataObj,
                    processData	: false,
                    contentType: false,
                    async: false,
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

        var showPopover = function () {
            $(this).popover('show');
        },
        hidePopover = function () {
            $(this).popover('hide');
        };

//        var custom = $('#customField').val();
//
//        $('#customShippingInfo').popover({
//            content: custom,
//            trigger: 'manual',
//            placement: 'bottom'
//        })
//        .focus(showPopover)
//        .blur(hidePopover)
//        .hover(showPopover, hidePopover);
        
     // setup card inputs;       
        $('#citrusExpiry').payment('formatCardExpiry');
        $('#citrusCvv').payment('formatCardCVC');
        
        $('#citrusNumber').keyup(function() {
            
	        var cardNum = $('#citrusNumber').val().replace(/\s+/g, '');        
	        var type = $.payment.cardType(cardNum);
	        
	       /* console.log(type);*/
	        if(type != 'amex')
	        	$("#citrusCvv").attr("maxlength","3");
	        else
	        	$("#citrusCvv").attr("maxlength","4");
	        
	        $('#citrusNumber').payment('formatCardNumber');                                            
	        $("#citrusScheme").val(type);
	        
	        $("#payment-form").validate();
	        $("#citrusNumber").rules("add","checkCard");
	        
	        $.validator.addMethod("checkCard", function() {
	            if(type === "visa" || type === "mastercard" || type === "amex" || type === "maestro" || type === "rupay") {
	                return true;
	            } else {
	                return false;
	            }
	        }, "Please specify the correct card number.");
		
	        if (type === "visa") {
	            $("#citrusScheme").val("visa").change();
	            $("#cardType").attr("src","//s3.amazonaws.com/crowdera/assets/954456ca-1012-4d8d-86e8-f4979ff4b330.png");
	        } else if(type === "amex" || type === "maestro") {
	            $("#citrusScheme").val("maestro").change();
	            $("#cardType").attr("src","//s3.amazonaws.com/crowdera/assets/f0cf3a78-60b5-4224-9b93-092b4046c690.png");
	        } else if(type === "mastercard") {
	            $("#citrusScheme").val("mastercard").change();
	            $("#cardType").attr("src","//s3.amazonaws.com/crowdera/assets/34bfdb13-f40a-4e3f-bcf0-3a83625bda5c.png");
	        }  else if(type === "rupay") {
	            $("#citrusScheme").val("rupay").change();
	            $("#cardType").attr("src","//s3.amazonaws.com/crowdera/assets/34bfdb13-f40a-4e3f-bcf0-3a83625bda5c.png");
	        } else {
	            $("#citrusScheme").val("");
	            $("#cardType").attr("src","//s3.amazonaws.com/crowdera/assets/2d87664b-d1c9-4fae-a015-fc02d3333dbb.png");
	        }
            
        });
        

});

function reloadjs() {
	
	$('.selectpicker').selectpicker({
	    style: 'btn btn-sm btn-default'
	});
	
	/* Show pop-over tooltip on hover for some fields. */
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
        placement: 'top'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
	
	$('#otherState').hide();
	$('#otherstate1').hide();
	
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
}

function validateshippingInfo() {
	var status = true;
	
	if ($('#addressLine1').length) {
		$('#addressLine1').valid() ? '' : status= false; 
	}
	if ($('#receiptName').length) {
		$('#receiptName').valid() ?  '' : status= false; 
	}
	if ($('#receiptEmail').length) {
		$('#receiptEmail').valid() ? '' : status= false; 
	}
	if ($('#city').length) {
		$('#city').valid() ? '' : status= false; 
	}
	if ($('#zip').length) {
		$('#zip').valid() ? '' : status= false;
	}
	if ($('#shippingEail').length) {
		$('#shippingmEmail').valid() ? '' : status= false;
	}
	if ($('#twitterHandle').length) {
		$('#twitterHandle').valid() ? '' : status= false;
	}
	if ($('#shippingCustom').length) {
		$('#shippingCustom').valid() ? ' ' : status= false;
	}
	if ($('#citrusFirstName').length) {
		$('#citrusFirstName	').valid() ? '' : status= false;
	}
	if ($('#citrusLastName').length) {
		$('#citrusLastName').valid() ? ' ': status= false;
	}
	if ($('#citrusEmail').length) {
		$('#citrusEmail').valid() ? ' ': status= false;
	}
	if ($('#shippingEmail').length) {
		$('#shippingEmail').valid() ? ' ': status= false;
	}
	if ($('#citrusMobile').length) {
		$('#citrusMobile').valid() ? ' ': status= false;
	}
	if ($('#citrusCity').length) {
		$('#citrusCity').valid() ? ' ': status= false;
	}
	if ($('#citrusStreet1').length) {
		$('#citrusStreet1').valid() ? ' ': status= false;
	}
	if ($('#citrusZip').length) {
		$('#citrusZip').valid() ? ' ': status= false;
	}
	return status;
}


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

function checkAmount(){
	
	$.validator.addMethod("checkAmount", function(value, element){
		var projectAmount = parseInt($("#projectAmount").val());
		
		if(parseInt(value) < projectAmount){
			return true;
		}
		
		return false;
	},"Please enter amount less than campaign amount.");
	
	$("#payment-form").validate();
	$("#amount").rules("add","checkAmount");
	
	if($("#amount").valid()){
		return true;
	}else{
		return false;
	}
}

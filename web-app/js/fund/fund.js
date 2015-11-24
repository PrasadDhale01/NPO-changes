$(function() {
	
    function getSelectedRewardId() {
        return $('.list-group-item.active').attr('id');
    }

    function getSelectedRewardPrice() {
        return $('.list-group-item.active').data('rewardprice');
    }

    $('#commentBox').find('form').validate({
        rules: {
        	comment: {
        		required: true
        	}
        }
    });

    $('.sendmailmodal').find('form').validate({
        rules: {
        	name: {
                required: true
            },
        	emails: {
        		required: true,
                validateMultipleEmailsCommaSeparated: true
            }
        }
    });
    
    $("form").on("change", ".states", function () {
    	var option = $(this).val();
    	$('#stateField').val(option);
    	if(option == 'other'){
    		$(".ostate").show();
    	} else {
    		$(".ostate").hide();
    	}
    });

    $.validator.addMethod('validateMultipleEmailsCommaSeparated', function (value, element) {
        var result = value.split(",");
        for(var i = 0;i < result.length;i++) 
            if(!validateEmail(result[i])) 
                return false;    		
        return true;
    },"Please add valid emails only");

    function validateEmail(field) {
        var regex=/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i;
        return (regex.test(field)) ? true : false;
    }
    
    $('#fundindex').find('form').validate({
        submitHandler: function(form) {
            if (getSelectedRewardId() == undefined) {
            	var rewardId = 1;
                $('form input[name="rewardId"]').val(rewardId);

                form.submit();
            } else {
                var rewardId = getSelectedRewardId();
                $('form input[name="rewardId"]').val(rewardId);

                form.submit();
            }
        },
        rules: {
            amount: {
                required: true,
                number: true,
                min: function() {
                    var rewardPrice = getSelectedRewardPrice();
                    if (rewardPrice == undefined) {
                    	var isINR = $('#isINR').val();
                    	if(isINR == undefined) {
                    		return 1;
                    	} else {
                    		return 100;
                    	}
                    } else {
                    	var isINR = $('#isINR').val();
                    	if(isINR == undefined) {
                    		return _.max([1, Number(rewardPrice)]);
                    	} else {
                    		return _.max([100, Number(rewardPrice)]);
                    	}
                    }
                }
            },
            receiptName: {
            	required: true,
            	isFullName: true
            },
            receiptEmail: {
            	required: true,
            	email: true
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
            }
        },
        messages:{
            agreetoTermsandUse: "Kindly confirm and then proceed to contribute"
        },
        errorPlacement: function(error, element) {
            if ( element.is(":checkbox")) {
                error.appendTo(element.parent());
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

    $(document).ready(function (){
        //called when key is pressed in textbox
        $("#amount").keypress(function (e) {
            //if the letter is not digit then display error and don't type anything
            if (e.which != 8 && e.which != 0 && e.which !=13 && (e.which < 48 || e.which > 57)) {
                //display error message
                $("#errormsg").html("Digits Only").show().fadeOut("slow");
            return false;
        } 
     });
   });

    $('a.list-group-item').click(function() {
    	$('.choose-error').html('');
        $('.list-group.twitterHandler').find('a.list-group-item').removeClass('active');
        $(this).addClass('active');
        var rewardId = $('a.list-group-item.active').attr('id');
        showShippingDetails(rewardId);
    });

	function showShippingDetails(rewardId){
		var anonymous = $('#anonymous').val();
		var grid = $('#perkShippingInfo, #perkShippingInfo-sm');
		$.ajax({
			type:'post',
			url:$('#url').val()+'/fund/getRewardShippingDetails',
			data:'rewardId='+rewardId+'&anonymous='+anonymous,
			success: function(data){
				$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
			}
		}).error(function(data){
			console.log('Error occured while fetching shipping info'+ data);
		});
	}

    $('#anonymousUser').click(function(){
    	var projectId = $('#projectId').val();
    	var selectedRewardId = getSelectedRewardId();
    	if($(this).prop("checked") == true){
    		$('#anonymous').val(true);
            $('#twitterPerk').hide();
    		$.ajax({
    			type:'post',
    			url:$('#url').val()+'/fund/getOnlyTwitterHandlerRewards',
    			data:'projectId='+projectId,
    			success: function(data){
    				$('#userId').val(3);
    				var list = data.split("[");
    				var list1 = list[1].split("]");
    				var list2 = list1[0].split(",");
    				var s= [];
    				for(var i=0;i<list2.length;i++){
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
    				for(var i=0;i<list2.length;i++){
    					var idval = list2[i].trim();
					    var k = 0;
					    $('.onlyTwitterReward').each(function () {
					    	if(k == i) {
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

    				$('.onlyTwitterReward').each(function(){    
    		            $(this).popover({
    		                content: 'As you are keeping your contribution anonymous, this perks which has only Twitter handler will be disabled for you',
    		                trigger: 'manual',
    		                placement: 'bottom'
    		            })
    		            .focus(showPopover)
    		            .blur(hidePopover)
    		            .hover(showPopover, hidePopover);
    		        });

    				if($('#'+selectedRewardId).hasClass('onlyTwitterReward')){
    	    			$('#perkForAnonymousUser').show();
    	    		}
    			}
    		}).error(function(data){
    			console.log('Error occured while changing the class'+ data);
    		});

    		$.ajax({
                type:'post',
                url:$("#url").val()+'/fund/getRewardsHavingTwitterHandler',
                data:'projectId='+projectId,
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

    				$('.twitterReward').each(function(){
    		            $(this).popover({
    		                content: "As you are keeping your contribution anonymous, Twitter perks will be disabled for you",
    		                trigger: 'manual',
    		                placement: 'bottom'
    		            })
    		            .focus(showPopover)
    		            .blur(hidePopover)
    		            .hover(showPopover, hidePopover);
    		        });
                }
            }).error(function(e){
            	console.log('Error occured while changing class of perk'+e);
            });

        } else if ($(this).prop("checked") == false){
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
    $("#fbshare").click(function(){
        var url = "http://www.facebook.com/sharer.php?p[url]="+ encodeURIComponent($('#fbShareUrl').val());
        window.open(url, "Share on FaceBook", 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
        return false;
    });

    $("#twitterShare").click(function(){
    	var campaignTitle = $('#campaignTitle').val();
    	var twitterShareUrl = $('#twitterShareUrl').val();
        var url = "https://twitter.com/intent/tweet?text="+campaignTitle+" on @gocrowdera&url="+twitterShareUrl;
        window.open(url, "Share on Twitter", 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
        return false;
    });

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
        	    placement: 'bottom'
        	})
        	.focus(showPopover)
        	.blur(hidePopover)
        	.hover(showPopover, hidePopover);
        });

        $('.onlyTwitterReward').each(function(){    
            $(this).popover({
                content: 'As you are keeping your contribution anonymous, this perks which has only Twitter handler will be disabled for you',
                trigger: 'manual',
                placement: 'bottom'
            })
            .focus(showPopover)
            .blur(hidePopover)
            .hover(showPopover, hidePopover);
        });
            
        $('.twitterReward').each(function(){
            $(this).popover({
                content: "As you are keeping your contribution anonymous, Twitter perks will be disabled for you",
                trigger: 'manual',
                placement: 'bottom'
            })
            .focus(showPopover)
            .blur(hidePopover)
            .hover(showPopover, hidePopover);
        });

        $("#anonymousUser").popover({
            content: 'If checked, your name will only be visible to campiagn owner, for public you will be anonymous contributor.',
            trigger: 'manual',
            placement: 'top'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);
        
        $('form').submit(function(){
            if($('.checkoutForm').valid()) {
                $('#btnCheckoutContinue').attr('disabled','disabled');
            }
            if($('.chargeForms').valid()) {
                $('#btnChargeContinue').attr('disabled','disabled');
            }
        });
       
        $("form").on("blur", ".addr1", function () {
        	var address1 = $(this).val();
        	$('#addr1').val(address1);
        });
        
        $("form").on("blur", ".addr2", function () {
        	var address2 = $(this).val();
        	$('#addr2').val(address2);
        });
        
        $("form").on("blur", ".cityField", function () {
        	var city = $(this).val();
        	$('#cityField').val(city);
        });
        
        $("form").on("blur", ".twitterField", function () {
        	var twitter = $(this).val();
        	$('#twitterField').val(twitter);
        });
        
        $("form").on("blur", ".customField", function () {
        	var custom = $(this).val();
        	$('#customField').val(custom);
        });
        
        $("form").on("blur", ".emailField", function () {
        	var email = $(this).val();
        	$('#emailField').val(email);
        });
        
        $("form").on("change", ".countryField", function () {
        	var country = $(this).val();
        	$('#countryField').val(country);
        });

        $("form").on("blur", ".zipField", function () {
        	var zip = $(this).val();
        	$('#zipField').val(zip);
        });

        $("form").on("blur", ".otherField", function () {
        	var other = $(this).val();
        	$('#otherField').val(other);
        });
});

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
    	if(option === 'other'){
    		$(".ostate").show();
    	} else {
    		$(".ostate").hide();
    	}
    });

    $.validator.addMethod('validateMultipleEmailsCommaSeparated', function (value) {
        var result = value.split(",");
        for(var i = 0;i < result.length; i++)
            if(!validateEmail(result[i]))
                return false;
        return true;
    },"Please add valid emails only");

    function validateEmail(field) {
        var regex=/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i;
        return (regex.test(field)) ? true : false;
    }

    var validator = $('#fundindex').find('form').validate({
        submitHandler: function(form) {
            if (getSelectedRewardId() === undefined) {
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

    $('.payucheckoutsubmitbutton').click(function(event) {
         if(validator.form()) {
             needToConfirm = false;
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
                 success : function(response){
                 	$('input[name = txnid]').val(response.txnid);
                     $('input[name = hash]').val(response.hash);
                     $('input[name = surl]').val(response.surl);
                     $('input[name = furl]').val(response.furl);
                     $("form[name = 'payuForm']").submit();
                 }
             }).error(function(){
             });
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
        $("#rewardId").val(rewardId);     
        showShippingDetails(rewardId);       
    });
    
    $(".TW-perk-status").click(function(){
        var amount = $('.list-group-item.active').data('rewardprice');
        $(".amount").val(Math.round(amount));
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
    			type:'post',
    			url:$('#url').val()+'/fund/getOnlyTwitterHandlerRewards',
    			data:'projectId='+projectId,
    			success: function(data){
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

    				if($('#'+selectedRewardId).hasClass('onlyTwitterReward')){
    	    			$('#perkForAnonymousUser').show();
    	    		}
    			}
    		}).error(function(){
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
            placement: 'top'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);
        
//        $('#btnChargeContinue').click(function(){
//            if($('.chargeForms').valid()) {
//                $('#btnChargeContinue').attr('disabled','disabled');
//            }
//        });
//        
//        $('#btnCheckoutContinue').click(function(){
//          if($('.checkoutForm').valid()) {
//              $('#btnCheckoutContinue').attr('disabled','disabled');
//          }
//        });
//       
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
        
        //load campaign tile in acknowledge page
        if($('#ackPage').val()=='ackPage'){
            loadAckCampaignTile();
        }
});

function loadAckCampaignTile(){
	
	var projectid= $('#projectId').val();
	var url = "/fund/loadAckCampaignTile";
	var contributionid = $('#contributionId').val();
	
	if(screen.width<768){
		
		$.post(url, {projectId:projectid, contributionId:contributionid}, function(res){
			$('#ackMobileView').html(res);
		});
		
	}else if(screen.width>767){
		
		$.post(url, {projectId:projectid, contributionId:contributionid}, function(res){
			$('#ackDesktopView').html(res);
		});
	}
}

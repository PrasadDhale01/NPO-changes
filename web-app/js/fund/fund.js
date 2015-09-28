$(function() {
    console.log("fund.js initialized");

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
            }
        }
    });

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

        $(this).siblings().removeClass('active');
        $(this).addClass('active');
    });

    $('#anonymousUser').click(function(){
    	var projectId = $('#projectId').val();
    	var selectedRewardId = getSelectedRewardId();
    	if($(this).prop("checked") == true){
    		$('#anonymous').val(true);
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

    	    	        $(this).siblings().removeClass('active');
    	    	        $(this).addClass('active');
    	    	        $('#perkForAnonymousUser').hide();
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

    	    	        $(this).siblings().removeClass('active');
    	    	        $(this).addClass('active');
    	    	        $('#perkForAnonymousUser').hide();
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

            $(this).siblings().removeClass('active');
            $(this).addClass('active');
            $('#perkForAnonymousUser').hide();
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
});

$(function() {
    console.log("fund.js initialized");

    function getSelectedRewardId() {
        return $('.list-group-item.active').data('rewardid');
    }

    function getSelectedRewardPrice() {
        return $('.list-group-item.active').data('rewardprice');
    }

    $('form').validate({
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
                        return 1;
                    } else {
                        return _.max([1, Number(rewardPrice)]);
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


    $('.list-group-item').click(function() {
        $('.choose-error').html('');

        $(this).siblings().removeClass('active');
        $(this).addClass('active');
    });
    
    $('#anonymousUser').click(function(){
    	
    	if($(this).prop("checked") == true){
    		$.ajax({
    			type:'post',
    			url:$('#url').val()+'/fund/makeUserAnonymous',
    			success: function(data){
    				$('#userId').val(data);
    			}
    		}).error(function(){
    			alert('An error occured');
    		});
    	} else if ($(this).prop("checked") == false){
    		var user = $('#tempValue').val();
    		$('#userId').val(user);
    	}
    });
    
    /* Show pop-over tooltip on hover for some fields. */
    var showPopover = function () {
            $(this).popover('show');
        },
        hidePopover = function () {
            $(this).popover('hide');
        };

    /* Initialize pop-overs (tooltips) */
    $("#onlyTwitterReward").popover({
        content: 'As you are anonymous, this perk which contains twitter handler is disabled for you',
        trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
    
    $("#twitterReward").popover({
        content: "As you are anonymous, only twitter handler information will be disabled for this perk",
        trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
    	
});

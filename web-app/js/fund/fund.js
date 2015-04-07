$(function() {
    console.log("fund.js initialized");

    function getSelectedRewardId() {
        return $('.list-group-item.active').attr('id');
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
    	var projectId = $('#projectId').val();
    	
    	if($(this).prop("checked") == true){
    		$.ajax({
    			type:'post',
    			url:$('#url').val()+'/fund/getOnlyTwitterHandlerRewards',
    			data:'projectId='+projectId,
    			success: function(data){
    				$('#userId').val(3);
    				$('#anonymous').val(true);
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
    		    			    html: this.innerHTML
    		    			});
    		    		});
    		    		//$(a).attr('class','list-group-item');
    		    		$('.twitterHandler').children('div').attr('class','list-group-item onlyTwitterReward');
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
    			}
    		}).error(function(data){
    			alert('An error occured');
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
    		    		$(a).attr('class','list-group-item twitterReward');
    				}
    				
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
            }).error(function(){
                alert('An error occured');
            });
    		
    	} else if ($(this).prop("checked") == false){
    		var user = $('#tempValue').val();
    		
    		$.ajax({
    			type:'post',
    			url:$('#url').val()+'/fund/getOnlyTwitterHandlerRewards',
    			data:'projectId='+projectId,
    			success: function(data){
    				$('#userId').val(user);
    				$('#anonymous').val(false);
    				var list = data.split("[");
    				var list1 = list[1].split("]");
    				var list2 = list1[0].split(",");
    				var s= [];
    				for(var i=0;i<list2.length;i++){
    		    		var a = '#'+list2[i].trim();
    		    		var x = $(a).attr("data-rewardprice");
    		    		s.push(x);
    		    		$(a).replaceWith(function() {
    		    			return $('<a/>', {
    		    			    html: this.innerHTML
    		    			});
    		    		});
    		    		//$(a).attr('class','list-group-item');
    		    		$('.twitterHandler').children('a').attr('href','#');
    		    		$('.twitterHandler').children('a').attr('class','list-group-item');
    				}
    				
    				for(var i=0;i<list2.length;i++){
    					var idval = list2[i].trim();
    					var k = 1;
					    $('.list-group-item').each(function () {
					    	var hasAttr = $(this).is("[id]");
					    	if (!hasAttr){
					    		if (k == 1) {
		                            $(this).attr('id',idval);
		                            $(this).attr('data-rewardprice',s[i]);
		                            k++;
					    		}
					    	}
			            });
					    
    				}
    				
    				$('.list-group-item').click(function() {
    			        $('.choose-error').html('');

    			        $(this).siblings().removeClass('active');
    			        $(this).addClass('active');
    			    });
    			}
    		}).error(function(data){
    			alert('An error occured');
    		});
    		
    		$.ajax({
                type:'post',
                url:$("#url").val()+'/fund/getRewardsHavingTwitterHandler',
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
    		    			return $('<a/>', {
    		    			    html: this.innerHTML
    		    			});
    		    		});
    		    		$('.twitterHandler').children('a').attr('href','#');
    		    		$('.twitterHandler').children('a').attr('class','list-group-item');
    				}
    				
    				for(var i=0;i<list2.length;i++){
    					var idval = list2[i].trim();
    					var k = 1;
					    $('.list-group-item').each(function () {
					    	var hasAttr = $(this).is("[id]");
					    	if (!hasAttr){
					    		if (k == 1) {
		                            $(this).attr('id',idval);
		                            $(this).attr('data-rewardprice',s[i]);
		                            k++;
					    		}
					    	}
			            });
    				}
    				
    				$('.list-group-item').click(function() {
    			        $('.choose-error').html('');

    			        $(this).siblings().removeClass('active');
    			        $(this).addClass('active');
    			    });
                }
            }).error(function(){
                alert('An error occured');
            });
    	}
    });
    
    $("#fbshare").click(function(){
        var url = 'http://www.facebook.com/sharer.php?p[url]='+ encodeURIComponent($('#fbShareUrl').val());
        window.open(url, 'Share on FaceBook', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
        return false;
    });
    
    $("#twitterShare").click(function(){
        var url = 'https://twitter.com/share?text=Check contribution at crowdera.co!';
        window.open(url, 'Share on Twitter', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
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
    	
});

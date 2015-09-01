$(function() {
    console.log("create.js initialized");
    
    $('#iconfile').val('');
    
    var rewardIteratorCount = $('#rewardCount').val();
    if (rewardIteratorCount > 0){
    	$('#rewardTemplate1').show();
    	$('#yesradio').prop('checked', true);
	    $("#updatereward").show();
    } else {
    	$('#rewardTemplate1').hide();
    }

    var count = $('#rewardCount').val();
     var projectId = $('#projectId').val();
    
    var storyContent
    var storyPlaceholder = "<p><h3>Introduce Your Campaign</h3></p>"+
    	"<p>Contributors want to know all about your cause and the details related to your organization, so think of this section as an executive summary to get your audience introduced to your campaign! Here are some essential components of a campaign introduction:</p>"+ 
    		"<ul>"+
    	    "<li>	Introduce yourself and your organization </li>"+
    		"<li>	Describe your campaign and why it's important to you </li>"+
    		"<li>	Convey the importance of a single contribution </li>"+
    		"</ul>"+
    		"<p>The key here is to keep your information brief and concise; this is the hook to getting the attention of your crowd! </p><br>"+

    		"<p><h3>Share details about your need and plan</h3><p>"+
    		"<p>Now that your audience is familiar with your mission, it's time to go more in-depth. In this section you should: </p>"+
    			"<ul>"+
    		    "<li>	Explain your funding goal and delineate precisely how the funds will be used</li>"+
    			"<li>	Describe your plan if your campaign doesn't reach it's goal</li>"+
    			"<li>	Share your plan for any risks or obstacles you may face</li>"+
    			"<li>	Outline the information for any rewards or perks programs! </li>"+
    			"</ul>"+
    			"<p>It is vital that you are straightforward and transparent in this section, be as detailed as possible. People value honesty - the more they believe in you and your cause, the more likely they are to contribute. </p><br>"+

    			"<p><h3>Make It Visual</h3></p>"+
    			"<p>Remember to include some images or videos so you can break the monotony of text and bring your campaign to life. </p>"+
    			"<ul>"+
    			"<li>	Use charts to show the breakdown of your costs and describe the full financial plan</li>"+
    			"<li>	Share any prototypes you have developed prior to the campaign</li>"+
    			"<li>	Add videos to better explain your cause and connect with your audience</li>"+
    			"</ul>"+
    			"<p>Contributors love to actually see and visualize your campaign progress so they can become more enthusiastic about your cause! </p><br>"+

    			"<p><h3>Talk about the impact</h3></p>"+
    			"<p>This section is a great opportunity to reiterate your passion for this cause and let people know how their contribution will make a difference! </p>"+
    			"<ul>"+
    			"<li>	Explain why this campaign will be beneficial to your audience and the community</li>"+
    			"<li>	Specify what makes you qualified to take on such an important cause</li>"+
    			"<li>	Call your audience to action and discuss any other ways they can get involved</li>"+
    			"<li>	Wear your enthusiasm loud and proud - get your crowd excited! </li>"+
    			"</ul>"+
    			"<p>Your mission is the heart of your campaign; it's what makes your fundraising efforts unique. Don't be shy in making your goal clear! Energize your crowd with your passion and get ready to make a difference! </p>";
    
    $('.redactorEditor').redactor({
        imageUpload:'/project/getRedactorImage',
        autosave: '/project/saveStory/?projectId='+projectId,
        imageResizable: true,
        initCallback: function(){
            var projectHasStory = $('#projectHasStory').val();
            if (projectHasStory && projectHasStory != ''){
                this.code.set(projectHasStory);
            } else {
                this.code.set(storyPlaceholder);
            }
        },
        plugins: ['video'],
        buttonsHide: ['indent', 'outdent', 'horizontalrule']
    });

    var currentEnv = $('#currentEnv').val();
    
    /********************* Create page Session timeout ***************************/
        var SessionTime = 60* 1000 * 60; //set for 60 minute
        var tickDuration = 1000;
        var myInterval = setInterval(function() {
        	SessionTimeout();
        }, 1000);
    
        function SessionTimeout() {
        	SessionTime = SessionTime - tickDuration;
        	if(SessionTime ==900000){
        		alert("15 minutes left for session timeout. Please save your data as draft or data will be lost.");
        	}else if (SessionTime <= 0) {
                alert("Your session has expired. Please login again.");
                $.ajax({
                    type:'post',
                    url:$("#b_url").val()+'/project/invalidateSession',
                    data:'status=true',
                    success: function(data){
                    	$('#test').html(data);
                    }
                }).error(function(){
                	alert('An error occured');
                });
                window.location.href =$("#b_url").val()+"/logout";   
             }   
       }
    /*********************************************************************/

    $("#payopt").show(); // paypal option
//    $("#paypalemail").hide(); // paypal button
    if ($('#payfir').val()) {
    	$("#paypalemail").hide();
    	$("#charitableId").show();
    }
    
    /* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });

    $('.multiselect').multiselect({
        numberDisplayed: 1,
        nonSelectedText: 'Choose multiple rewards'
    });

    /* Validate form on submit. */
    var validator = $('#campaigncreate').find('form').validate({
        rules: {
            firstName: {
                minlength: 2,
                required: true
            },
            lastName: {
                minlength: 2,
                required: true
            },
            email: {
                required: true,
                email: true
            },
            telephone: {
                required: false,
                isValidTelephoneNumber: true,
                maxlength: 20
            },
            country: {
                required: true
            },
            description : {
            	required: true,
                minlength: 10,
                maxlength: 140
        	},
            title: {
                required: true,
                minlength: 5,
                maxlength: 100
            },
            videoUrl: {
                isYoutubeVideo: true
            },
            email1: {
                email: true,
                iscampaigncreator: true
            },
            email2: {
                email: true,
                iscampaigncreator: true,
                isequaltofirstadmin: true,
                isequaltothirdadmin: true
            },
            email3: {
                email: true,
                iscampaigncreator: true,
                isequaltofirstadmin: true,
                isequaltosecondadmin: true
            },
            checkBox2:{
              required: true
            },
            amount: {
                required: true,
                number: true,
                min: 500,
                maxlength: function() {
                    if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
                        return 8;
                    } else {
                        return 6;
                    }
                },
                max: function() {
                    if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
                        return 99999999;
                    } else {
                        return 100000;
                    }
                }
            }
        },
        messages:{
            thumbnail: "Please upload a thumbnail image for campaign",
            textfile: "Please upload your Letter of Determination",
            iconfile: "Please upload your organization logo"
        },
        errorPlacement: function(error, element) {
        	if ( element.is(":radio") ) {
                error.appendTo(element.parent().parent());
            } else if(element.is(":checkbox")) {
                error.appendTo(element.parent());
            } else if($(element).prop("id") == "projectImageFile") {
                error.appendTo(element.parent().parent());
            }else if($(element).prop("id") == "iconfile") {
                error.appendTo(element.parent().parent());
            }else if($(element).prop("id") == "projectEditImageFile") {
                error.appendTo(element.parent().parent());
            }else if($(element).prop("id") == "editiconfile") {
                error.appendTo(element.parent().parent());
            }else{
                error.insertAfter(element);
            }
        },//end error Placement
        
        //ignore: []
    });
    
    $('.createsubmitbutton').click(function(event) {
        if(validator.form()){
        	needToConfirm = false;
        } 	
    });
    
    $.validator.addMethod('isPaypalEmailVerified', function (value, element) {
        var ack = $("#paypalEmailAck").val();
        var base_url = $("#b_url").val();
        if (base_url != 'https://crowdera.co'){
            if(ack == 'Failure') {
                return (ack == 'Success') ? ack : false;
            }
        }
        return true;
    }, "Please enter verified paypal email id");
    
    $('#campaigncreatebtn, #campaigncreatebtnXS').on('click', function(event) {
    	event.preventDefault();
   	
        if (validator.form()) {
            $('#campaigncreatebtn').attr('disabled','disabled');
            var url = $("#b_url").val()+"/project/createNow/?firstName="+$("#name").val()+'&amount='+$("#amount").val()+'&title='+$("#campaignTitle").val()+'&description='+$("#descarea").val()+'&usedFor='+$("#usedFor").val();
            window.location.href = url;
        }
    });
    
    $('#saveButton, #saveButtonXS').on('click', function() {
    	var storyValue = $('.redactorEditor').redactor('code.get');
        var storyEmpty = false;
        if (storyValue == '' || storyValue == undefined){
            $('#storyRequired').show();
            storyEmpty = true;
        } else {
        $('#storyRequired').hide();
            storyEmpty = false;
        }

    	$('.rewardNumberAvailable').each(function () {
            $(this).rules("add", {
                required: true,
                number: true,
                min: 0
            });
        });
    	
        $( '[name="answer"]' ).rules( "add", {
            required: true
        });

        $( '[name="webAddress"]' ).rules( "add", {
            required: true,
            isWebUrl:true
        });

        $( '[name="organizationName"]' ).rules( "add", {
            required: true
        });

        $( '[name="days"]' ).rules( "add", {
            required: true
        });
    	
    	var iconUrl = $('#imgIcon').attr('src');
    	
    	if (!iconUrl) {
    	    $('[name="iconfile"]').rules( "add", {
                required: true,
                messages: {
                    required: "Please upload your organization logo."
                }
            });
        }
    	if($('#campaignthumbnails').find('#imgdiv').length < 1) {
    		$("#projectEditImageFile").rules( "add", {
                required: true,
                messages: {
                    required: "Please upload at least one campaign image."
                }
            });
    	}
    	
    	if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
            $('.rewardPrice').each(function () {
                $(this).rules("add", {
                    required: true,
                    number: true,
                    maxlength: 8,
                    max: function() {
                    	var campaignAmount = $('#projectamount').val();
                        return Number(campaignAmount);
                    },
                    min: 100
                });
            });
            
            $( '[name="payuEmail"]' ).rules( "add", {
                required: true,
                email:true
            });
        } else {
        	$('.rewardPrice').each(function () {
                $(this).rules("add", {
                    required: true,
                    number: true,
                    maxlength: 6,
                    max: function() {
                    	var campaignAmount = $('#projectamount').val();
                        return Number(campaignAmount);
                    },
                    min: 1
                });
            });
        	
        	$( '[name="paypalEmail"]' ).rules( "add", {
                required: true,
                isPaypalEmailVerified : true,
                email:true
            });
        	
        	$( '[name="charitableId"]' ).rules( "add", {
                required: true
            });
        }

    	if (validator.form()) {
            if (!storyEmpty){
                $('#saveButton, #saveButtonXS').attr('disabled','disabled');
                $('#campaigncreate').find('form').submit();
            }
    	}
    });
    
    $('#submitProject').on('click', function() {
        var storyValue = $('.redactorEditor').redactor('code.get');
        var storyEmpty = false;
        if (storyValue == '' || storyValue == undefined){
            $('#storyRequired').show();
            storyEmpty = true;
        } else {
        $('#storyRequired').hide();
            storyEmpty = false;
        }
        
        if($('#campaignthumbnails').find('#imgdiv').length < 1) {
    		$("#projectImageFile").rules( "add", {
                required: true,
                messages: {
                    required: "Please upload at least one campaign image."
                }
            });
    	}
        
        $( '[name="checkBox"]' ).rules( "add", {
            required: true
        });

        $( '[name="answer"]' ).rules( "add", {
            required: true
        });

        $( '[name="webAddress"]' ).rules( "add", {
            required: true,
            isWebUrl:true
        });

        $( '[name="organizationName"]' ).rules( "add", {
            required: true
        });

        $( '[name="days"]' ).rules( "add", {
            required: true
        });

        $('.rewardNumberAvailable').each(function () {
            $(this).rules("add", {
                required: true,
                number: true,
                min: 0
            });
        });
        
        var iconUrl = $('#imgIcon').attr('src');
    	
    	if (!iconUrl) {
        
        $('#iconfile').rules("add", {
            required: true
        });
    	}
        
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
            $('.rewardPrice').each(function () {
                $(this).rules("add", {
                    required: true,
                    number: true,
                    maxlength: 8,
                    max: function() {
                    	var campaignAmount = $('#projectamount').val();
                        return Number(campaignAmount);
                    },
                    min: 100
                });
            });
            
            $( '[name="payuEmail"]' ).rules( "add", {
                required: true,
                email:true
            });
        } else {
        	$('.rewardPrice').each(function () {
                $(this).rules("add", {
                    required: true,
                    number: true,
                    maxlength: 6,
                    max: function() {
                    	var campaignAmount = $('#projectamount').val();
                        return Number(campaignAmount);
                    },
                    min: 1
                });
            });
        	
        	$( '[name="paypalEmail"]' ).rules( "add", {
                required: true,
                isPaypalEmailVerified : true,
                email:true
            });
        	
        	$( '[name="charitableId"]' ).rules( "add", {
                required: true
            });
        	
        	$('.rewardDescription').each(function () {
                $(this).rules("add", {
                    required: true,
                });
            });
           	
           	$('.rewardTitle').each(function () {
                $(this).rules("add", {
                    required: true,
                });
           	});
        }
        
    	if (validator.form()) {
            if (!storyEmpty){
                $('#campaigncreate').find('form').submit();
                $('#submitProject').attr('disabled','disabled');
                $('#previewButton').attr('disabled','disabled');
            }
    	}
    });
    
    $('#submitProjectXS').on('click', function() {
        var storyValue = $('.redactorEditor').redactor('code.get');
        var storyEmpty = false;
        if (storyValue == '' || storyValue == undefined){
            $('#storyRequired').show();
            storyEmpty = true;
        } else {
        $('#storyRequired').hide();
            storyEmpty = false;
        }

        $( "#projectImageFile" ).rules( "add", {
            required: true,
            messages: {
                required: "Please upload at least one campaign image"
            }
        });
        $('.rewardNumberAvailable').each(function () {
            $(this).rules("add", {
                required: true,
                number: true,
                min: 0
            });
        });
        
        
        
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
            $('.rewardPrice').each(function () {
                $(this).rules("add", {
                    required: true,
                    number: true,
                    maxlength: 8,
                    max: function() {
                    	var campaignAmount = $('#projectamount').val();
                        return Number(campaignAmount);
                    },
                    min: 100
                });
            });
        } else {
        	$('.rewardPrice').each(function () {
                $(this).rules("add", {
                    required: true,
                    number: true,
                    maxlength: 6,
                    max: function() {
                    	var campaignAmount = $('#projectamount').val();
                        return Number(campaignAmount);
                    },
                    min: 1
                });
            });
        }

        $( '[name="checkBox"]' ).rules( "add", {
            required: true
        });

        $('.rewardDescription').each(function () {
            $(this).rules("add", {
                required: true,
            });
        });
       	
       	$('.rewardTitle').each(function () {
            $(this).rules("add", {
                required: true,
            });
       	});
        
    	if (validator.form()) {
    		$('#isSubmitButton').attr('value',false);
            if (!storyEmpty){
                $('#campaigncreate').find('form').submit();
                $('#submitProjectXS').attr('disabled','disabled');
                $('#previewButtonXS').attr('disabled','disabled');
            }
    	}
    });
    
     $.validator.addMethod('isYoutubeVideo', function (value, element) {
        if(value && value.length !=0){
           var p = /^https?:\/\/(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
           var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
           var youtubematch = value.match(p);
           var vimeomatch = value.match(vimeo);
           var match
           if (youtubematch)
               match = youtubematch;
           else if (vimeomatch && vimeomatch[2].length == 9)
               match = vimeomatch;
           else 
               match = null;
           return (match) ? true : false;
        }
        return true;
     }, "Please upload a url of Youtube/Vimeo video");
     
     $.validator.addMethod('isValidTelephoneNumber', function (value, element) {
     	  
         if(value && value.length !=0){
             var reg = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;
             return (value.match(reg)) ? RegExp.$1 : false;
         }
         return true;
     }, "Please provide valid Telephone number");
     
     $.validator.addMethod('isWebUrl', function(value, element){
    	 if(value && value.length !=0){
          var p = /(https | http?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})/ig;;
  	    	return (value.match(p))
    	 }
    	 return true;
     }, "Please provide valid url");
     
     $("input[name='answer']").change(function(){
     	if($(this).val()=="yes") {
     		if($('#rewardCount').val() > 0){
     			count = rewardIteratorCount;
     		} else {
     			count = 1;
     		}
     		$('#rewardCount').attr('value',count);
     		$("#rewardTemplate1").show();
     	    $("#updatereward").show();
     	} else {
            if (count > 0){
                if (confirm('Are you sure you want to discard all the perks for this campaign?')){
                    removeAllPerks(); 
                    var rewardslength = $('#addNewRewards').find('.rewardsTemplate').length;
                    for (var i=rewardslength; i > 1; i--) {
                    	$('#addNewRewards').find('.rewardsTemplate').last().remove();
                    }
                    for (var i=rewardslength; i > 0; i--){
                    	$('#addNewRewards').find('.editDeleteReward').remove();
                    }
                    renameAndemptyRewardFields();
                    $("#updatereward").hide();
                    $('#addNewRewards').find('.rewardsTemplate').hide();
                    count = 0;
                    $('#rewardCount').attr('value',count);
                } else {
                	$('#noradio').prop('checked', false);
                	$('#yesradio').prop('checked', true);
                }
            }
        }
    });
     
    function renameAndemptyRewardFields(){
    	$('#addNewRewards').find('.rewardsTemplate').attr('id', 'rewardTemplate1');
    	$('#addNewRewards').find('.rewardsTemplate').attr('value', '1');
    	$('#addNewRewards').find('.rewardsTemplate').find('.rewardPrice').attr('id', 'rewardPrice1');
    	$('#addNewRewards').find('.rewardsTemplate').find('.rewardPrice').attr('name', 'rewardPrice1');
        $('#addNewRewards').find('.rewardsTemplate').find('.rewardTitle').attr('id', 'rewardTitle1');
        $('#addNewRewards').find('.rewardsTemplate').find('.rewardTitle').attr('name', 'rewardTitle1');
        $('#addNewRewards').find('.rewardsTemplate').find('.rewardNumberAvailable').attr('id', 'rewardNumberAvailable1');
        $('#addNewRewards').find('.rewardsTemplate').find('.rewardNumberAvailable').attr('name', 'rewardNumberAvailable1');
        $('#addNewRewards').find('.rewardsTemplate').find('.rewardDescription').attr('name', 'rewardDescription1');
        $('#addNewRewards').find('.rewardsTemplate').find('.rewardDescription').attr('id', 'rewardDesc1');
        $('#addNewRewards').find('.rewardsTemplate').find(".shippingAddress").attr('id', 'mailaddcheckbox1');
        $('#addNewRewards').find('.rewardsTemplate').find(".shippingAddress").attr('name', 'mailingAddress1');
        $('#addNewRewards').find('.rewardsTemplate').find(".shippingEmail").attr('id', 'emailcheckbox1');
        $('#addNewRewards').find('.rewardsTemplate').find(".shippingEmail").attr('name', 'emailAddress1');
        $('#addNewRewards').find('.rewardsTemplate').find(".shippingTwitter").attr('id', 'twittercheckbox1');
        $('#addNewRewards').find('.rewardsTemplate').find(".shippingTwitter").attr('name', 'twitter1');
        $('#addNewRewards').find('.rewardsTemplate').find('.customText').attr('id', 'customcheckbox1');
        $('#addNewRewards').find('.rewardsTemplate').find('.customText').attr('name', 'custom1');
        $('#addNewRewards').find('.rewardNum').attr('value', '1');
    	
    	$('#addNewRewards').find('.rewardsTemplate').find('#rewardPrice1').val('');
        $('#addNewRewards').find('.rewardsTemplate').find('#rewardDesc1').val('');
        $('#addNewRewards').find('.rewardsTemplate').find('#rewardTitle1').val('');
        $('#addNewRewards').find('.rewardsTemplate').find('#rewardNumberAvailable1').val('');
        $('#addNewRewards').find('.rewardsTemplate').find(".shippingAddress").attr('class', 'btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks cr-perks-back-color lblmail1');
        $('#addNewRewards').find('.rewardsTemplate').find(".shippingEmail").attr('class', 'btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks cr-perks-back-color lblemail1');
        $('#addNewRewards').find('.rewardsTemplate').find(".shippingTwitter").attr('class', 'btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks cr-perks-back-color lbltwitter1');
        $('#addNewRewards').find('.rewardsTemplate').find("#mailaddcheckbox1").prop('checked', false);
        $('#addNewRewards').find('.rewardsTemplate').find("#emailcheckbox1").prop('checked', false);
        $('#addNewRewards').find('.rewardsTemplate').find("#twittercheckbox1").prop('checked', false);
        $('#addNewRewards').find('.rewardsTemplate').find('#customcheckbox1').val('');
    }

     $("input[name='pay']").change(function(){
  	    if($(this).val()=="paypal") {
  	        $('#organizationName').find('input').val('');
  	       	$("#paypalemail").show();
  	        $("#charitableId").hide();
  	        $('#charitable').find('input').val('');
  	        $("#paypalcheckbox").show();
  	     } else if($(this).val()=="firstgiving") {
   	         $('#organizationName').find('input').val('');
  	       	 $("#charitableId").show(); 
  	         $("#paypalemail").hide();
  	         $("#paypalcheckbox").hide();
   	         $('#paypalemail').find('input').val('');
  	      }
  	 });

     $('#val3').change(function(){
        var c = $('#val3').val();
        if(c=='US'){
          $('#val1').show();
          $('#val2').hide();
        }
       else
        {
          $('#val1').hide();
          $('#val2').show();
        }  
    });
     
     $('.cr-img-start-icon').hover(function(){
     	$('.cr-start').attr('src',"//s3.amazonaws.com/crowdera/assets/start-Icon-White.png");
     	}).mouseleave(function(){
         $('.cr-start').attr('src',"//s3.amazonaws.com/crowdera/assets/start-Icon-Blue.png");
     });
     
     $('.cr-img-story-icon').hover(function(){
      	$('.cr-story').attr('src',"//s3.amazonaws.com/crowdera/assets/story-Icon-White.png");
      	}).mouseleave(function(){
          $('.cr-story').attr('src',"//s3.amazonaws.com/crowdera/assets/story-Icon-Blue.png");
      });
     
     $('.cr-img-admin-icon').hover(function(){
      	$('.cr-admin').attr('src',"//s3.amazonaws.com/crowdera/assets/admin-Icon---White.png");
      	}).mouseleave(function(){
          $('.cr-admin').attr('src',"//s3.amazonaws.com/crowdera/assets/admin-Icon---Blue.png");
      });
     
     $('.cr-img-perk-icon').hover(function(){
       	$('.cr-perk').attr('src',"//s3.amazonaws.com/crowdera/assets/perk-Icon-White.png");
       	}).mouseleave(function(){
           $('.cr-perk').attr('src',"//s3.amazonaws.com/crowdera/assets/perk-Icon-Blue.png");
       });
     
     $('.cr-img-payment-icon').hover(function(){
       	$('.cr-payment').attr('src',"//s3.amazonaws.com/crowdera/assets/payment-Icon-White.png");
       	}).mouseleave(function(){
           $('.cr-payment').attr('src',"//s3.amazonaws.com/crowdera/assets/payment-Icon-Blue.png");
       });
     
     $('.cr-img-launch-icon').hover(function(){
       	$('.cr-launch').attr('src',"//s3.amazonaws.com/crowdera/assets/launch-Icon--White.png");
       	}).mouseleave(function(){
           $('.cr-launch').attr('src',"//s3.amazonaws.com/crowdera/assets/launch-Icon--Blue.png");
       });
     
     $('.cr-img-save-icon').hover(function(){
        	$('.cr-launch').attr('src',"//s3.amazonaws.com/crowdera/assets/Save-Icon-White.png");
        	}).mouseleave(function(){
            $('.cr-launch').attr('src',"//s3.amazonaws.com/crowdera/assets/Save-Icon-Blue.png");
        });
     
     $('#paymentOpt').change(function(){
    	 var pay = $('#paymentOpt').val();
    	 if(pay=='FIR'){
    		 $('#paypalemail').hide();
    		 $('#charitableId').show();
    		 
    	 }else if(pay=='PAY'){
    		 $('#charitableId').hide();
    		 $('#paypalemail').show();
    	 }else if(pay=='PMT'){
    		 if(pay == 'selected'){
    			 $('#paypalemail').show();
    		 }
    		 $('#paypalemail').hide();
    		 $('#charitableId').hide();
    	 }
     });
     
     $('#paymentOpt').change(function(){
    	 var payind = $('#paymentOpt').val();
    	 if(payind=='PAYU'){
    		 $('#PayUMoney').show();
    	 }
     });
     
	$('#countryList').change(function(){
	    var c = $('#countryList').val();
	    if(c=='IN'){
	       	$('#stateList').show();
	       	$('#txtState').hide();
	    }else{
	       	$('#stateList').hide();
	       	$('#txtState').show();
	    }  
	});

      /******************************Video Thumbnail***************************************/
     
    if($('#addvideoUrl').val()) {
        var url= $('#videoUrl').val().trim();
        var youtube = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
        var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
        var match = (url.match(youtube) || url.match(vimeo));
        $('#ytVideo').show();
        $('#media').hide();
        $('#media-video').show();
        var vurl
        if (match[2].length == 11){
        	vurl=url.replace("watch?v=", "embed/");
            $('#ytVideo').html('<iframe class="youtubeVideoIframe" src="'+ vurl +'?wmode=transparent"></iframe>');
        } else {
        	vurl = url.replace("https://vimeo.com/", "https://player.vimeo.com/video/");
        	$('#ytVideo').html('<iframe class="youtubeVideoIframe" src='+ vurl +'></iframe>');
        }
    }

    $('#videoBox, #videoUrledit').on('click',function(){
    	$('#addVideo').modal('show');
    });

	$('#add').on('click',function(){
		var youtube = /^https?:\/\/.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
        var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
        var url= $('#videoUrl').val().trim();
        var match = (url.match(youtube) || url.match(vimeo));
        if (validator.element("#videoUrl")){
        	$('#addVideo').modal('hide');
        if (match && match[2].length == 11) {
            $('#ytVideo').show();
            $('#media').hide();
            $('#media-video').show();
            autoSave('videoUrl', url);
            $('#addvideoUrl').val(url);
            var vurl=url.replace("watch?v=", "embed/");
            $('#ytVideo').html('<iframe class="youtubeVideoIframe" src='+ vurl +'?wmode=transparent></iframe>');
        } else if (match && match[2].length == 9) {
        	$('#ytVideo').show();
            $('#media').hide();
            $('#media-video').show();
            autoSave('videoUrl', url);
            $('#addvideoUrl').val(url);
            $('#ytVideo').html('<iframe class="youtubeVideoIframe" src= https://player.vimeo.com/video/'+ match[2] +'></iframe>');
        } else if($(this)) {
        	if(!$('#addvideoUrl').val()) {
                $('#ytVideo').hide();
                $('#media').show();
                $('#media-video').hide();
        	}
        }
        }
    });

     /** ********************Organization Icon*************************** */

    $("#iconfile").change(function(event) {
        var file =this.files[0];
        if(validateExtension(file.name) == false){
	        $('#icondiv').hide();
	        $('#iconfilesize').hide();
	        $('#logomsg').show();
	        $('#logomsg').html("Add only PNG or JPG extension image");
	        this.value=null;
	        return;
	    }
	    if(!file.type.match('image')){
	        $('#icondiv').hide();
	        $('#iconfilesize').hide();
	        $('#logomsg').show();
	        this.value=null;
	    } else{
	        if (file.size > 1024 * 1024 * 3) {
	            $('#icondiv').hide();
	            $('#logomsg').hide();
	            $('#iconfilesize').show();
	            $('#iconfile').val('');
	        } else {
                $('#icondiv').show();
                $('#logomsg').hide();
                $('#iconfilesize').hide();
                $('.edit-logo-icon').show();
                $('#imgIcon').show();
                $('#logoDelete').show();
                var file = this.files[0];
                var fileName = file.name;
                var fileSize = file.size;
        
                var picReader = new FileReader();
                picReader.addEventListener("load",function(event) {
                    var picFile = event.target;
                    $('#imgIcon').attr('src',picFile.result);
                    $('#delIcon').attr('src',"//s3.amazonaws.com/crowdera/assets/delete.ico");
                    $('#logoDelete').attr('src',"//s3.amazonaws.com/crowdera/assets/delete.ico");
                    $('.createOrgIconDiv, .projectImageFilediv').find("span").remove();
                    $('.createOrgIconDiv, .projectImageFilediv').closest(".form-group").removeClass('has-error');
               });
               // Read the image
               picReader.readAsDataURL(file);
	        }
	    } 
    });


     /*******************************Description text length******************** */
    var counter = 1;
    $('#descarea').on('keydown', function(event) {
        event.altKey==true;
        var currentString = $('#descarea').val().length;
        if (currentString >= 9) {
        	$('.createDescDiv').find("span").remove();
            $('.createDescDiv').closest(".form-group").removeClass('has-error');
        }
        
        if(currentString <=140) {
        	if (currentString == 140) {
        		var text = currentString;
        	} else {
        		var text = currentString + 1;
        	}
        }
        if (event.keyCode > 31) {
            if(event.altKey==true){
                setDescriptionText();
            }
            else {
                if(currentString < 139)
                    currentString++;
                $('#desclength').text(text+'/140');
            }
        } else {
            currentString--;
            $('#desclength').text(text+'/140');
        }
    }).keyup(function(e) {
      
        if(e.altKey == true){
           setDescriptionText();
           return false;
        }

        switch (e.keyCode) {

            case 13:      //Enter
            case 8:       //backspace
            case 46:      //delete
            case 17:      
            case 27:      //escape
            case 10:      //new line
            case 20:      
            case 9:       //horizontal TAB
            case 11:      //vertical tab
            case 33:      //page up  
            case 34:      //page  down
            case 35:      //End 
            case 36:      //Home
            case 37:      //Left arrow
            case 38:      //up arrow
            case 39:      //Right arrow
            case 40:      //Down arrow
            case 45:      //Insert
            case 12:      //vertical tab
                setDescriptionText();
                break;
            case 16:      //shift
                setDescriptionText();
                break;
        }
    }).focus(function() {
        setDescriptionText();
    }).focusout(function() {
        setDescriptionText();
    });
  
    function setDescriptionText(){
        var currentString = $('#descarea').val().length;
        if (currentString == 0) {
            $('#desclength').text("0/140");
        } else {
            currentString = currentString;
            $('#desclength').text(currentString+'/140');
        }
    }

    /*******************************Title text length******************** */
    var counter = 1;
    $('#campaignTitle').on('keydown', function(event) {
    
        event.altKey==true;
        var currentstring = $('#campaignTitle').val().length;
        if (currentstring >= 4) {
        	$('.createTitleDiv').find("span").remove();
            $('.createTitleDiv').closest(".form-group").removeClass('has-error');
        }
        if(currentstring <=55) {
        	if (currentstring == 55) {
        		var text = currentstring ;
        	} else {
        		var text = currentstring + 1;
        	}
        }
        if (event.keyCode > 31) {
            if(event.altKey==true){
    	         setTitleText();
            }
            else{
  	             if(currentstring <54)
  		             currentstring++;
                 $('#titleLength').text(text+'/55');
            }

        } else {
	        currentstring--;
            $('#titleLength').text(text+'/55');
        }
    }).keyup(function(e) {
    
        if(e.altKey==true){
	        setTitleText();
            return false;
        }

        switch (e.keyCode) {
 
            case 13:      //Enter
            case 8:       //backspace
            case 46:      //delete
            case 17:      
            case 27:      //escape
            case 10:      //new line
            case 20:      
            case 9:       //horizontal TAB
            case 11:      //vertical tab
            case 33:      //page up  
            case 34:      //page  down
            case 35:      //End 
            case 36:      //Home
            case 37:      //Left arrow
            case 38:      //up arrow
            case 39:      //Right arrow
            case 40:      //Down arrow
            case 45:      //Insert
            case 12:      //vertical tab
    	        setTitleText();
                break;
            case 16:      //shift
    	        setTitleText();
                break;
        }
    }).focus(function(){
	    setTitleText();
    }).focusout(function(){
	    setTitleText();
    });

    function setTitleText() {
   
        var currentstring = $('#campaignTitle').val().length;
        if (currentstring == 0) {
            $('#titleLength').text("0/55");
        } else {
	        currentstring = currentstring;
            $('#titleLength').text(currentstring+'/55');
        }
    }
     
    /** *************************Multiple Image Selection*************** */
    var isvalidsize =  false;
    $('#projectImageFile, #projectEditImageFile').change(function(event) {
        var file =this.files[0];
        if(validateExtension(file.name) == false){
        	 $('.pr-thumbnail-div').hide();
        	 $('#imgmsg').show();
        	 $('#imgmsg').html("Add only PNG or JPG extension images");
             $('#campaignfilesize').hide();
             this.value=null;
             return;
        }
        if(!file.type.match('image')){
            $('.pr-thumbnail-div').hide();
            $('#imgmsg').show();
            $('#campaignfilesize').hide();
            this.value=null;
        } else{
            $('#imgmsg').hide();
            $('#campaignfilesize').hide();
            var files = event.target.files; // FileList object
            var output = document.getElementById("result");
            var fileName;
            var isFileSizeExceeds = false;
            for ( var i = 0; i < files.length; i++) {
                var file = files[i];
                var filename = file.name;
                if(file.size < 1024 * 1024 * 3) {
                	isvalidsize =  true;
                    var picReader = new FileReader();
                    picReader.addEventListener("load",function(event) {
                        var picFile = event.target;
                        var div = document.createElement("div");
                        div.innerHTML = "<div id=\"imgdiv\" class=\"pr-thumbnail-div\"><img  class='pr-thumbnail' src='"+ picFile.result+ "'"+ "title='"
                            + file.name + "'/><div class=\"deleteicon\"><img onClick=\"$(this).parents('#imgdiv').remove();\" src=\"//s3.amazonaws.com/crowdera/assets/delete.ico\" style=\"margin:2px;width:10px;height:10px;\"/></div>"+ "</div>";
                            output.insertBefore(div, null);
                            
                        $('#createthumbnail').find("span").remove();
                        $('#createthumbnail').closest(".form-group").removeClass('has-error');
                    });
                    // Read the image
                    picReader.readAsDataURL(file);
                } else {
                	if (fileName) {
                	    fileName = fileName +" "+ file.name;
                	} else {
                		fileName = file.name;
                	}
                	$('#campaignfilesize').show();
                	isFileSizeExceeds = true;
                }
                
            }
            document.getElementById("campaignfilesize").innerHTML= "The file " +fileName+ " you are attempting to upload is larger than the permitted size of 3MB.";
            if (isFileSizeExceeds && !isvalidsize) {
                $('#projectImageFile').val('');
            }
        }
    });
    
    function validateExtension(imgExt)
    {
          var allowedExtensions = new Array("jpg","JPG","png","PNG");
          for(var imgExtImg=0;imgExtImg<allowedExtensions.length;imgExtImg++)
          {
              imageFile = imgExt.lastIndexOf(allowedExtensions[imgExtImg]);
              if(imageFile != -1){
            	  return true;
              }
          }
          return false;
    }
    
    $('#createreward').click(function(){
        var rewardSaved = rewardValidationAndSaving(count);
        if (rewardSaved){
        var updateCount = $('#addNewRewards').find(".rewardsTemplate:last").attr('value');
        count++;
        $('#savereward').attr('value',count);
        var str ='<div class="col-sm-12 perk-css perk-padding editDeleteReward" id="editDeleteReward'+updateCount+'">'+
            '<div class="col-sm-12 perk-create-styls perk-top" align="right">'+
                 '<div class="btn btn-circle perks-created-remove intutive-glyphicon editreward" id="editreward'+updateCount+'" value="'+updateCount+'">'+
                     '<i class="glyphicon glyphicon-floppy-save"></i>'+
                 '</div>&nbsp;'+
                 '<div class="btn btn-circle perks-created-remove intutive-glyphicon deletereward" id="deletereward'+updateCount+'" value="'+updateCount+'">'+
                     '<i class="glyphicon glyphicon-trash"></i>'+
                 '</div>'+
             '</div>'+
         '</div>'+
    '<div class="rewardsTemplate" id="rewardTemplate'+count+'" value="'+count+'">'+
    '<div class="col-sm-2">'+
        '<div class="form-group">'+
            '<div class="col-sm-12">';
        
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
           	str = str + '<span class="cr2-currency-label fa fa-inr cr-perks-amts"></span>';
             }else{
           	str = str + '<span class="cr2-currency-label">$</span>' ;
             }
               
             str = str +  '<input type="text" placeholder="Amount"  name="rewardPrice'+count+'" id="rewardPrice'+count+
                       '" class="form-control cr-input-digit cr-tablat-padd form-control-no-border-amt rewardPrice">'+
           '</div>'+
       '</div>'+
    '</div>'+
       
    '<div class="col-sm-5">'+
       '<div class="form-group">'+
           '<div class="col-sm-12">'+
              '<input type="text" placeholder="Name of Perk" name="rewardTitle'+count+'" id="rewardTitle'+count+
                      '"  class="form-control cr-perk-title-number cr-tablet-left form-control-no-border cr-placeholder cr-chrome-place text-color rewardTitle">'+
           '</div>'+
       '</div>'+
    '</div>'+
    
    '<div class="col-sm-5">'+
       '<div class="form-group">'+
           '<div class="col-sm-12">'+
               '<input type="text" placeholder="Number available" name="rewardNumberAvailable'+count+'" id="rewardNumberAvailable'+count+'" class="form-control rewardNumberAvailable cr-perk-title-number text-color cr-placeholder cr-chrome-place form-control-no-border">'+
           '</div>'+
       '</div>'+
    '</div>'+
  
   '<div class="form-group row">'+
       '<div class="col-sm-12">'+
           '<div class="col-sm-12">'+
             '<textarea class="form-control rewardDescription form-control-no-border cr-placeholder cr-chrome-place text-color" name="rewardDescription'+count+
                '" id="rewardDesc'+count+'" rows="2" placeholder="Let your contributors feel special by rewarding them. Think out of the box and leave your contributors awestruck. Make sure you have calculated the costs associated with the perk; you do not want to lose money!" maxlength="250"></textarea>'+
                '<p class="cr-perk-des-font">Please refer to our <a href="/termsofuse" target="_blank">Terms  Of  Use</a> for more details on perks.</p>'+
           '</div>'+
       '</div>'+
   '</div>'+
   '<div class="col-sm-12">'+
       '<div class="form-group">'+
           '<div class="btn-group col-sm-12" data-toggle="buttons">'+
               '<label class="panel-body col-sm-2 col-xs-12 cr-check-btn-perks text-center">Mode of <br> Delivery</label>'+
               '<label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks cr-perks-back-color shippingAddress"><input type="checkbox" name="mailingAddress'+count+'" value="true" id="mailaddcheckbox'+count+'">Mailing <br> address</label>'+
               '<label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks cr-perks-back-color shippingEmail"><input type="checkbox" name="emailAddress'+count+'" value="true" id="emailcheckbox'+count+'">Email <br> address</label>'+
               '<label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks cr-perks-back-color shippingTwitter"><input type="checkbox" name="twitter'+count+'" value="true" id="twittercheckbox'+count+'">Twitter <br> handle</label>'+
               '<input type="text" name="custom'+count+'" id="customcheckbox'+count+'" class="customText form-control-no-border cr-custom-place cr-customchrome-place text-color cr-perks-back-color col-sm-4 col-xs-12" placeholder="Custom">'+
           '</div>'+
       '</div>'+
   '</div>'+
   '<g:hiddenField name="rewardNum" value="'+count+'" id="rewardNum'+count+'" class="rewardNum"/>'+
 '</div>';
        $('#addNewRewards').append(str);
        $('#rewardCount').attr('value',count);
        }
     });  
    
    $('#removereward').click(function(){
    	var rewardLength = $('#addNewRewards').find('.rewardsTemplate').length
        if (confirm('Are you sure you want to discard this perk?')){
            removeRewards(count);
            if (rewardLength == 1){
                $("#updatereward").hide();
                $('#addNewRewards').find('.rewardsTemplate').hide();
                renameAndemptyRewardFields();
                $('#noradio').prop('checked', true);
                $('#yesradio').prop('checked', false);
            } else {
                $('#addNewRewards').find('.rewardsTemplate').last().remove();
                $('#addNewRewards').find('.editDeleteReward:last').remove();
            }
        }
    });
    
    $('#savereward').click(function(){
    	var lastrewardcount = $(this).attr("value");
        rewardValidationAndSaving(lastrewardcount);
    });
    
    function rewardValidationAndSaving(rewardCount){
    	$('.rewardDescription').each(function () {
            $(this).rules("add", {
                required: true,
            });
        });
       	
       	$('.rewardTitle').each(function () {
            $(this).rules("add", {
                required: true,
            });
       	});
    	
        $('.rewardNumberAvailable').each(function () {
            $(this).rules("add", {
                required: true,
                number: true,
                min: 0
            });
        });
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
           $('.rewardPrice').each(function () {
               $(this).rules("add", {
                   required: true,
                   number: true,
                   maxlength: 8,
                   max: function() {
                   	   var campaignAmount = $('#projectamount').val();
                       return Number(campaignAmount);
                   },
                   min: 100
               });
           });
       } else {
           $('.rewardPrice').each(function () {
               $(this).rules("add", {
                   required: true,
                   number: true,
                   maxlength: 6,
                   max: function() {
                   	   var campaignAmount = $('#projectamount').val();
                       return Number(campaignAmount);
                   },
                   min: 1
               });
           });
        }
        if($('#rewardPrice'+rewardCount).length == 0){
            return true;
        } else if((validator.element( "#rewardPrice"+rewardCount)) && (validator.element( "#rewardTitle"+rewardCount)) && (validator.element( "#rewardNumberAvailable"+rewardCount)) && (validator.element( "#rewardDesc"+rewardCount))) {
        	var rewardPrice = $('#rewardPrice'+rewardCount).val();
            var rewardTitle = $('#rewardTitle'+rewardCount).val();
            var rewardNumberAvailable = $('#rewardNumberAvailable'+rewardCount).val();
            var rewardDesc = $('#rewardDesc'+rewardCount).val();
            var email = $('#emailcheckbox'+rewardCount).prop("checked");
            var address = $('#mailaddcheckbox'+rewardCount).prop("checked");
            var twitter = $('#twittercheckbox'+rewardCount).prop("checked");
            var custom = $('#customcheckbox'+rewardCount).val();
            saveRewards(rewardCount,rewardPrice,rewardTitle,rewardNumberAvailable,rewardDesc,email,address,twitter,custom);
            return true;
        } else {
            validator.element( "#rewardPrice"+count);
            validator.element( "#rewardTitle"+count);
            validator.element( "#rewardNumberAvailable"+count);
            validator.element( "#rewardDesc"+count);
            return false;
        }
    }

     $.validator.addMethod('isequaltofirstadmin', function(value, element){
    	 var emailId = $('#firstadmin').val();
 	     if(value.length != 0 && value == emailId) {
 	         return (!value == emailId)
 	     }
     	 return true;
     }, "This Co-creator is already added");
     
     $.validator.addMethod('isequaltosecondadmin', function(value, element){
    	 var emailId = $('#secondadmin').val();
     	 if(value.length != 0 && value == emailId) {
     	     return (!value == emailId)
     	 } 
     	 return true;
     }, "This Co-creator is already added");
     
     $.validator.addMethod('isequaltothirdadmin', function(value, element){
    	 var emailId = $('#thirdadmin').val();
 	     if(value.length != 0 && value == emailId) {
 	         return (!value == emailId)
 	     } 
     	 return true;
     }, "This Co-creator is already added");
     
     $.validator.addMethod('iscampaigncreator', function(value, element){
    	 var emailId = $('#email').val();
    	 if(value.length != 0 && value == emailId) {
    		 return (!value == emailId)
    	 }
    	 return true;
     }, "Campaign creator cannot be added as a Co-creator");

    /* Click handler for Myself/Someone I Know. */
    /*
    $('#fundRaisingFor').change(function(event) {
        var optionChosen = $(this).val(),
            nameEl = $('#name'),
            emailEl = $('#email');

        if (optionChosen == 'MYSELF') {
            validator.resetForm();

            nameEl.closest('.form-group').removeClass('has-error');
            nameEl.val(function() {
                return $(this).attr('value');
            });
            nameEl.prop('disabled', true);

            emailEl.closest('.form-group').removeClass('has-error');
            emailEl.val(function() {
                return $(this).attr('value');
            });
            emailEl.prop('disabled', true);
        } else if (optionChosen == 'OTHER') {
            nameEl.prop('disabled', false);
            emailEl.prop('disabled', false);
        }
    });
    */

    $(document).ready(function (){
        //called when key is pressed in textbox
        $("#amount, #amount1").keypress(function (e) {
            //if the letter is not digit then display error and don't type anything
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                //display error message
                $("#errormsg").html("Digits Only").show().fadeOut("slow");
                return false;
            } 
        });

        $("form").on("click", ".editreward", function () {
        	var editCount = $(this).attr('value');
        	rewardValidationAndSaving(editCount);
        });
        
        $("form").on("click", ".deletereward", function () {
        	var deleteCount = $(this).attr('value');
        	if (confirm('Are you sure you want to discard this perk?')){
        		var deleteRewardCount = $(this).attr('value');
                removeRewards(deleteCount);
                $('#rewardTemplate'+deleteCount).remove();
    		    $("#editDeleteReward"+deleteRewardCount).remove();
            }
        });

        $("form").on("click", ".rewardPrice", function () {
            $('.rewardPrice').each(function () {
                $(this).keypress(function (e) {
                  //if the letter is not digit then display error and don't type anything
                  if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                    //display error message
                    return false;
                  } 
                });
            });
            
          });
        
        var $win = $(window);
        $win.scroll(function () {
            if ($win.scrollTop() == 0){
                $('#start').css('padding-top','25px');
            	$('#story').css('padding-top','0px');
            	$('#admins').css('padding-top','0px');
            	$('#perk').css('padding-top','0px');
            	$('#payment').css('padding-top','0px');
            	$('#launch').css('padding-top','0px');
            }else if ($win.height() + $win.scrollTop()== $(document).height()) {
                $('#start').css('padding-top','0px');
            	$('#story').css('padding-top','0px');
            	$('#admins').css('padding-top','0px');
            	$('#perk').css('padding-top','0px');
            	$('#payment').css('padding-top','0px');
            	$('#launch').css('padding-top','30px');
            	$('#save').css('padding-top','25px');
            }
        });
   });
    
   $('#paypalEmailId').change(function(){
       var base_url = $("#b_url").val();
       if (base_url != 'https://crowdera.co'){
           var email =  $('#paypalEmailId').val();
           $.ajax({
               type:'post',
               url:$("#b_url").val()+'/project/paypalEmailVerification',
               data:'email='+email,
               success: function(data){
                   $('#paypalEmailAck').val(data);
                   if (data == 'Success') {
                       $('.paypalVerification').find("span").remove();
                       $('.paypalVerification').closest(".form-group").removeClass('has-error');
                   }
               }
           }).error(function(){
               alert('An error occured');
           });
        }
    });
   
    $('#category').change(function(){
        var selectedCategory = $(this).val();
        autoSave('category', selectedCategory);
    });
   
    $('#country').change(function(){
        var selectedCountry = $(this).val();
        autoSave('country', selectedCountry);
    });
    
    $('#firstadmin').blur(function(){
        var emailValue = $(this).val();
        if(validator.element( "#firstadmin")){
           autoSave('email1', emailValue);
        }
    });

    $('#secondadmin').blur(function(){
        var emailValue = $(this).val();
        if(validator.element( "#secondadmin")){
            autoSave('email2', emailValue);
        }
    });

    $('#thirdadmin').blur(function(){
        var emailValue = $(this).val();
        if(validator.element( "#thirdadmin")){
            autoSave('email3', emailValue);
        }
    });
    
    $('#organizationname').blur(function (){
    	var name = $(this).val();
    	autoSave('organizationname', name);
    });
    
    $('#webAddress').blur(function (){
    	var webAddress = $(this).val();
    	if (validator.element( "#webAddress")) {
            autoSave('webAddress', webAddress);
    	}
    });
    
    $('#telephone').blur(function (){
        var telephone = $(this).val();
        autoSave('telephone', telephone);
    });
    
    
    $('#payuemail').blur(function (){
        var payUEmailId = $(this).val();
        if (validator.element( "#payuemail")) {
            autoSave('payuEmail', payUEmailId);
        }
    });
    
    $('#secretKey').blur(function (){
        var secretKey = $(this).val();
        autoSave('secretKey', secretKey);
    });
    
    $('#facebookUrl').blur(function (){
        var facebookUrl = $(this).val();
        if (validator.element( "#facebookUrl")) {
            autoSave('facebookUrl', facebookUrl);
        }
    });
    
    $('#twitterUrl').blur(function (){
        var twitterUrl = $(this).val();
        autoSave('twitterUrl', twitterUrl);
    });
    
    $('#linkedinUrl').blur(function (){
        var linkedinUrl = $(this).val();
        autoSave('linkedinUrl', linkedinUrl);
    });
    
    function autoSave(variable, varValue) {
        $.ajax({
            type:'post',
            url:$("#b_url").val()+'/project/autoSave',
            data:'projectId='+projectId+'&variable='+variable+'&varValue='+varValue,
            success: function(data) {
                $('#test').val('test');
            }
        }).error(function() {
            console.log('Error occured while autosaving field'+ variable + 'value :'+ varValue);
        });
     }
    
    $('#saveCharitableId').click(function (){
    	var uuid = $('#uuid').val();
    	var charityName = $('#charity_name').val();
    	$('#charitable').find('input').val(uuid);
		$('#organizationName').find('input').val(charityName);
		$('#paypalemail').find('input').val('');
		autoSave('charitableId', uuid);
        var delay = 50; //delayed code to prevent error, time in milliseconds
        setTimeout(function() {
            autoSave('organizationname', charityName);
        }, delay);
    });
    
    $('#impact').click(function(){
        $('#usedFor').val('IMPACT');
    });

    $('#passion').click(function(){
        $('#usedFor').val('PASSION');
    });

    $('#innovating').click(function(){
        $('#usedFor').val('SOCIAL_NEEDS');
    });

    $('#personal').click(function(){
        $('#usedFor').val('PERSONAL_NEEDS');
    });
    
    $('#person').click(function(){
        autoSave('fundsRecievedBy', 'PERSON');
    });
    
    $('#non-profit').click(function(){
        autoSave('fundsRecievedBy', 'NON-PROFITS');
    });
    
    $('#ngo').click(function(){
        autoSave('fundsRecievedBy', 'NGO');
    });
    
    $('#others').click(function(){
        autoSave('fundsRecievedBy', 'OTHERS');
    });
    
    $('#name1').blur(function (){
        var name = $(this).val();
        autoSave('name', name);
    });
    
    $('#amount1').blur(function (){
        var amount = $(this).val();
        if(validator.element( "#amount1") && amount) {
            autoSave('amount', amount);
        }
    });
    
    $('#paypalEmailId').blur(function(){
    	var paypalEmail = $('#paypalEmailId').val();
    	$('#charitable').find('input').val('');
        autoSave('paypalEmailId', paypalEmail);
    });
    
    $('.campaignTitle1').blur(function (){
        var title = $(this).val();
        autoSave('campaignTitle', title);
    });
    
    $('.descarea1').blur(function (){
        var descarea = $(this).val();
        autoSave('descarea', descarea);
    });
    
    $('#impact1').click(function(){
    	autoSave('usedFor', 'IMPACT');
    });

    $('#passion1').click(function(){
    	autoSave('usedFor', 'PASSION');
    });

    $('#innovating1').click(function(){
    	autoSave('usedFor', 'SOCIAL_NEEDS');
    });

    $('#personal1').click(function(){
    	autoSave('usedFor', 'PERSONAL_NEEDS');
    });
    
    $('#deleteVideo').click(function(){
    	if (confirm('Are you sure you want to delete this video')){
    	    autoSave('videoUrl', '');
    	    $('#ytVideo').hide();
            $('#media').show();
            $('#media-video').hide();
            $('#videoUrl').val('');
    	}
    });
    
	$('.cr-img-start-icon').click(function(){
		$('#start').css('padding-top','125px');
		$('#story').css('padding-top','0px');
		$('#admins').css('padding-top','0px');
		$('#perk').css('padding-top','0px');
		$('#payment').css('padding-top','0px');
		$('#launch').css('padding-top','0px');
	});
	$('.cr-img-story-icon').click(function(){
		$('#story').css('padding-top','125px');
		$('#start').css('padding-top','25px');
		$('#admins').css('padding-top','0px');
		$('#perk').css('padding-top','0px');
		$('#payment').css('padding-top','0px');
		$('#launch').css('padding-top','0px');
	});
	$('.cr-img-admin-icon').click(function(){
		$('#admins').css('padding-top','140px');
		$('#story').css('padding-top','0px');
		$('#start').css('padding-top','25px');
		$('#perk').css('padding-top','0px');
		$('#payment').css('padding-top','0px');
		$('#launch').css('padding-top','0px');
	});
	$('.cr-img-perk-icon').click(function(){
		$('#perk').css('padding-top','125px');
		$('#story').css('padding-top','0px');
		$('#admins').css('padding-top','0px');
		$('#start').css('padding-top','25px');
		$('#payment').css('padding-top','0px');
		$('#launch').css('padding-top','0px');
	});
	$('.cr-img-payment-icon').click(function(){
		$('#payment').css('padding-top','125px');
		$('#story').css('padding-top','0px');
		$('#admins').css('padding-top','0px');
		$('#start').css('padding-top','25px');
		$('#perk').css('padding-top','0px');
		$('#launch').css('padding-top','0px');
	});
	$('.cr-img-launch-icon').click(function(){
		$('#launch').css('padding-top','125px');
		$('#story').css('padding-top','0px');
		$('#admins').css('padding-top','0px');
		$('#start').css('padding-top','25px');
		$('#payment').css('padding-top','0px');
		$('#perk').css('padding-top','0px');
	});
	$('.cr-img-save-icon').click(function(){
		$('#save').css('padding-top','125px');
		$('#story').css('padding-top','0px');
		$('#admins').css('padding-top','0px');
		$('#start').css('padding-top','25px');
		$('#payment').css('padding-top','0px');
		$('#perk').css('padding-top','0px');
	});

    function saveRewards(rewardNum,rewardPrice,rewardTitle,rewardNumberAvailable,rewardDesc,email,address,twitter,custom){
        $.ajax({
        	cache: true,
            type:'post',
            url:$("#b_url").val()+'/project/saveReward',
            data:'projectId='+projectId+'&rewardNum='+rewardNum+'&rewardPrice='+rewardPrice+'&rewardTitle='+rewardTitle+'&rewardNumberAvailable='+rewardNumberAvailable+'&rewardDesc='+rewardDesc+'&email='+email+'&address='+address+'&twitter='+twitter+'&custom='+custom,
            success: function(data) {
               $('#test').val('test');
            }
        }).error(function() {
            console.log('error occured saving'+rewardNum+'no. reward');
        });
     }

     function removeRewards(deleteCount){
         $.ajax({
             type:'post',
             url:$("#b_url").val()+'/project/deleteReward',
             data:'projectId='+projectId+'&rewardCount='+deleteCount,
             success: function(data) {
                 $('#test').val('test');
             }
         }).error(function() {
             console.log('error occured deleting'+deleteCount+'no. reward');
         });
     }

     function removeAllPerks(){
         $.ajax({
             type:'post',
             url:$("#b_url").val()+'/project/deleteAllRewards',
             data:'projectId='+projectId,
             success: function(data) {
                 $('#test').val('test');
             }
         }).error(function() {
             console.log('error occured while deleting all perks');
          });
    }
     
     $('#previewButton, #previewButtonXS').on('click', function(event){  // capture the click
      	event.preventDefault();
       	$('[name="pay"], [name="checkBox"], [name="iconfile"],[name="organizationName"], [name="thumbnail"],[name="answer"], [name="wel"],[name="charitableId"], [name="webAddress"], [name="paypalEmail"], [name = "payuEmail"], [name = "days"], [name = "telephone"], [name = "email1"], [name = "email2"], [name = "email3"]').each(function () {
             $(this).rules('remove');
         });
       	
       	$( "#projectImageFile" ).rules("remove");
 
       	$('[name="pay"], [name="checkBox"], [name="iconfile"],[name="organizationName"], [name="thumbnail"],[name="answer"], [name="wel"],[name="charitableId"], [name="webAddress"], [name="paypalEmail"], [name = "payuEmail"], [name = "days"], [name = "telephone"], [name = "email1"], [name = "email2"], [name = "email3"]').each(function () {
             $(this).closest('.form-group').removeClass('has-error');
         });
       	
       	$('.rewardNumberAvailable').each(function () {
            $(this).rules("remove");
        });
       	
       	$('.rewardPrice').each(function () {
            $(this).rules("remove");
        });
       	
       	$('.rewardDescription').each(function () {
            $(this).rules("remove");
        });
       	
       	$('.rewardTitle').each(function () {
            $(this).rules("remove");
        });
       	
       	$("#createthumbnail").removeClass('has-error');
       	$('#isSubmitButton').attr('value',false);
       	if (validator.form()) {
       		$('#campaigncreate').find('form').submit();
              $('#submitProject').attr('disabled','disabled');
              $('#previewButton').attr('disabled','disabled');
       	}
       });

/*Javascript error raised due to tooltip is resolved*/
    /* Show pop-over tooltip on hover for some fields. */
    var showPopover = function () {
            $(this).popover('show');
        },
        hidePopover = function () {
            $(this).popover('hide');
        };
        
        $('.editreward').each(function(){
            $(this).popover({
                content: 'Save Perk',
                trigger: 'manual',
                placement: 'left'
            })
            .focus(showPopover)
            .blur(hidePopover)
            .hover(showPopover, hidePopover);
        });
        
        $('#savereward').popover({
            content: 'Save Perk',
            trigger: 'manual',
            placement: 'bottom'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);
        
        $('.amountInfo-img').popover({
            content: 'Maximum $100,000, If you want to raise more contact our Crowdfunding Expert.',
            trigger: 'manual',
            placement: 'bottom'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);
        
        $('.amountInfoInd-img').popover({
            content: 'Maximum Rs.99,999,999, If you want to raise more contact our Crowdfunding Expert.',
            trigger: 'manual',
            placement: 'bottom'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);
        
        $('.deadlineInfo-img').popover({
            content: 'Campaign End Date - At Least 30 days and maximum 90 days.',
            trigger: 'manual',
            placement: 'bottom'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);
        
        $('.pictureInfo-img').popover({
            content: 'Pictures help contributors connect with you and your cause. Maximum 3MB.',
            trigger: 'manual',
            placement: 'bottom'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);
        
        $('.videoInfo-img').popover({
            content: 'Add a 3 minute video that can hold the attention of the viewer. It is your chance to pitch to your contributors, make it heartfelt.',
            trigger: 'manual',
            placement: 'bottom'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);
        
    /* Initialize pop-overs (tooltips) */
   /* $("input[name='days']").popover({
        content: 'Number of days to raise the funds by.',
        trigger: 'manual',
        placement: 'top'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);*/
});

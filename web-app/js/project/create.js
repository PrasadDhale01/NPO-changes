$(function() {
    $('#iconfile').val('');
    $('#iconfilesizeSmaller').hide();
    
    $("#video-error-msg").hide();

    $("#sendEmailButton").click(function(){
        $("#sendEmailButton").attr('disabled','disabled');
    });

    $('.text-date').keydown(function(e){
        e.preventDefault();
    });

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
    var isIndianCampaign = ($('#isIndianCampaign').val() === 'true') ? true : false;
    
    var currentEnv = $("#currentEnv").val();
    
    if ($('#citrusemail').val()) {
    	$('#CitrusPay').show();
    	$('#PayUMoney').hide();
    } else {
    	$('#CitrusPay').hide();
    	$('#PayUMoney').show();
    }

    var storyPlaceholder = "<p>Introduce Your Campaign</p>"+
	"<p>Contributors want to know all about your cause and the details related to your organization, so think of this section as an executive summary to get your audience introduced to your campaign! Here are some essential components of a campaign introduction:</p>"+ 
		"<ul>"+
	    "<li>	Introduce yourself and your organization </li>"+
		"<li>	Describe your campaign and why it's important to you </li>"+
		"<li>	Convey the importance of a single contribution </li>"+
		"</ul>"+
		"<p>The key here is to keep your information brief and concise; this is the hook to getting the attention of your crowd! </p>"+

		"<p>Share details about your need and plan<p>"+
		"<p>Now that your audience is familiar with your mission, it's time to go more in-depth. In this section you should: </p>"+
			"<ul>"+
		    "<li>	Explain your funding goal and delineate precisely how the funds will be used</li>"+
			"<li>	Describe your plan if your campaign doesn't reach it's goal</li>"+
			"<li>	Share your plan for any risks or obstacles you may face</li>"+
			"<li>	Outline the information for any rewards or perks programs! </li>"+
			"</ul>"+
			"<p>It is vital that you are straightforward and transparent in this section, be as detailed as possible. People value honesty - the more they believe in you and your cause, the more likely they are to contribute. </p>"+

			"<p>Make It Visual</p>"+
			"<p>Remember to include some images or videos so you can break the monotony of text and bring your campaign to life. </p>"+
			"<ul>"+
			"<li>	Use charts to show the breakdown of your costs and describe the full financial plan</li>"+
			"<li>	Share any prototypes you have developed prior to the campaign</li>"+
			"<li>	Add videos to better explain your cause and connect with your audience</li>"+
			"</ul>"+
			"<p>Contributors love to actually see and visualize your campaign progress so they can become more enthusiastic about your cause! </p>"+

			"<p>Talk about the impact</p>"+
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
//        autosave: '/project/saveStory/?projectId='+projectId,
        imageResizable: true,
        initCallback: function() {
            var projectHasStory = $('#projectHasStory').val();
            if (projectHasStory && projectHasStory !== '') {
                this.code.set(projectHasStory);
            } else {
                this.code.set(storyPlaceholder);
            }

            //var that = this;
            //setInterval(function() {
            // you get code from Redactor
            //var story = that.code.get();
            // autoSave('story', story);
            //}, 5000);
        },
        blurCallback: function() {
            autoSave('story', this.code.get());
        },
        plugins: ['video','fontsize','fontfamily','fontcolor'],
        buttonsHide: ['indent', 'outdent', 'horizontalrule', 'deleted', 'formatting']
    });


    /********************* Create page Session timeout ***************************/
        //set for 60 minute
        var SessionTime = 60* 1000 * 60;
        var tickDuration = 1000;
        setInterval(function() {
        	SessionTimeout();
        }, 1000);

        function SessionTimeout() {
        	SessionTime = SessionTime - tickDuration;
        	if(SessionTime === 900000){
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
                });
                window.location.href =$("#b_url").val()+"/logout";
             }
       }
    /*********************************************************************/

    $("#payopt").show();
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
                maxlength: 32,
                required: true
            },
            lastName: {
                minlength: 2,
                maxlength: 32,
                required: true
            },
            email: {
                required: true,
                email: true
            },
            telephone: {
                required: true,
                isValidTelephoneNumber: true,
                maxlength: 20
            },
            country: {
                required: true
            },
            payment: {
            	required:true
            },
            fundsRecievedBy: {
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
                maxlength: 100,
                isTitleUnique: true
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
            facebookUrl:{
            	isFacebookUrl: true
            },
            twitterUrl:{
            	isTwitterUrl: true
            },
            linkedinUrl:{
            	isLinkedInUrl: true
            },
            customVanityUrl:{
            	maxlength:55,
            	isVanityUrlUnique:true
            },
            amount: {
                required: true,
                number: true,
                min: function() {
                	if(isIndianCampaign){
                		return 100;
                	} else {
                		return 1;
                	}
                },
                maxlength: function() {
                    if(isIndianCampaign) {
                        return 8;
                    } else {
                        return 6;
                    }
                },
                max: function() {
                    if(isIndianCampaign) {
                        return 99999999;
                    } else {
                        return 200000;
                    }
                }
            },
            amount1: {
                required: true,
                number: true,
                min: function() {
                	if(isIndianCampaign){
                		return 100;
                	} else {
                		return 1;
                	}
                },
                maxlength: function() {
                    if(isIndianCampaign) {
                        return 8;
                    } else {
                        return 6;
                    }
                },
                max: function() {
                    if(isIndianCampaign) {
                        return 99999999;
                    } else {
                        return 200000;
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
            } else if($(element).prop("id") === "projectImageFile" || $(element).prop("id") === "projectEditImageFile") {
                error.appendTo(document.getElementById("col-error-placement"));
            }else if($(element).prop("id") === "iconfile" || $(element).prop("id") === "digitalSign" || $(element).prop("id") === "projectEditImageFile") {
                error.appendTo(element.parent().parent());
            }else if($(element).prop("id") === "editiconfile" || $(element).prop("id") === "customVanityUrl") {
                error.appendTo(element.parent().parent());
            }else{
                error.insertAfter(element);
            }
        }

    });
    
  //For Number Only
	jQuery.validator.addMethod("num", function(value, element) {
		return this.optional(element) || /^[0-9]+$/i.test(value); 
	}, "Please Enter Numbers Only.");
	
	$.validator.addClassRules("numbersOnly", {
		num : true
	});

    $.validator.addMethod('isFacebookUrl', function (value) {
        if(value && value.length !== 0){
           var p = /^https?:\/\/(?:www.)?facebook.com\/?.*$/;
           var facebookmatch = value.match(p);
           var match;
           if (facebookmatch)
               match = facebookmatch;
           else
               match = null;
           return (match) ? true : false;
        }
        return true;
     }, "Please enter valid Facebook url");

    $.validator.addMethod('isVanityUrlUnique', function (value) {
    	var status;
    	if(value && value.length !== 0){
    	    vanityUrlUniqueStatus(value.trim());
    	    status = $('#vanityUrlStatus').val();
    	    return (status === 'true') ? true : false;
        } else {
            $('#vanityUrlStatus').val('true');
            status = 'true';
        }

    	return true;
     }, "This Vanity Url is already in use");

    function vanityUrlUniqueStatus(vanityValue){
    	$.ajax({
            type:'post',
            url:$("#b_url").val()+'/project/isCustomVanityUrlUnique',
            data:'vanityUrl='+vanityValue+'&projectId='+projectId,
            success: function(data){
            	(data === 'true') ? $('#vanityUrlStatus').val('true') : $('#vanityUrlStatus').val('false');
            }
        }).error(function(){
        });
    }

    function titleUniqueStatus(title){
 		$.ajax({
 			type:'post',
 			url:$("#b_url").val()+'/project/isTitleUnique',
 			data:'title='+title+'&projectId='+projectId,
 			success: function(data){
 				(data === 'true') ? $('#titleUniqueStatus').val('true') : $('#titleUniqueStatus').val('false');
 			}
 		}).error(function(){
 		});
    }

    $.validator.addMethod('isTwitterUrl', function (value) {
        if(value && value.length !== 0){
           var p = /^https?:\/\/(?:www.)?twitter.com\/?.*$/;
           var twittermatch = value.match(p);
           var match;
           if (twittermatch)
               match = twittermatch;
           else
               match = null;
           return (match) ? true : false;
        }
        return true;
     }, "Please enter valid Twitter url");

    $.validator.addMethod('isLinkedInUrl', function (value) {
        if(value && value.length !== 0){
           var p = /^https?:\/\/(?:www.)?linkedin.com\/?.*$/;
           var linkedinmatch = value.match(p);
           var match;
           if (linkedinmatch)
               match = linkedinmatch;
           else
               match = null;
           return (match) ? true : false;
        }
        return true;
     }, "Please enter valid LinkedIn url");

    $('.createsubmitbutton').click(function() {
        if(validator.form()){
        	needToConfirm = false;
        }
    });

    $.validator.addMethod('isPaypalEmailVerified', function () {
        var ack = $("#paypalEmailAck").val();
        var base_url = $("#b_url").val();
        if (base_url !== 'https://gocrowdera.com' && ack === 'Failure'){
            return (ack === 'Success') ? ack : false;
        }
        return true;
    }, "Please enter verified paypal email id");

    $.validator.addMethod('isFullName', function(value){
        if(value && value.length !== 0){
            var space= value.split(" ");
            if(space.length < 2 || space[1] === ''){
                return false;
            } else{
                var p=/^[A-Za-z]+([\sA-Za-z]+)*$/ ;
                return (value.match(p));
            }
        }
        return true;
    }, "Please enter a valid fullname");

    $.validator.addMethod('isTotalSpendAmountGreaterThanProjectAmount', function () {
        var totalSpendAmount = 0;
        var projectAmount = $("#projectamount").val();
        $('.spendAmount').each(function(){
            if ($.isNumeric($(this).val())){
                totalSpendAmount = totalSpendAmount + parseInt($(this).val());
            }
        });
        if(totalSpendAmount <= parseInt(projectAmount)) {
            $('.spendAmount').each(function(){
                var id = $(this).attr('id');
                $('#'+id).parent('.form-group').removeClass('has-error');
                $('#'+id).siblings('.help-block').remove();
            });
            return  true;
        } else {
            return false;
        }
    }, "The total spend amount is exceeding campaign goal");

    $('#campaigncreatebtn, #campaigncreatebtnXS').on('click', function() {
        if (validator.form()) {
        	$('#campaigncreate').find('form').submit();
            $('#campaigncreatebtn, #campaigncreatebtnXS').attr('disabled','disabled');
        }
    });

    $.validator.addMethod('isTitleUnique', function (value) {
 		var status;
 		if(value && value.length !== 0){
 			titleUniqueStatus(value.trim());
 			status = $('#titleUniqueStatus').val();
 	        	return (status === 'true') ? true : false;
 		} else {
 			$('#titleUniqueStatus').val('true');
 			status = 'true';
 		}

 		return true;
 	 }, "This Project Title is already in use");



    $('#saveButton, #saveButtonXS').on('click', function(event) {
    	var storyValue = $('.redactorEditor').redactor('code.get');
        var storyEmpty = false;
        if (storyValue === '' || storyValue === undefined){
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
                min: 1
            });
        });

    	if (isIndianCampaign){
    	      $('.spendAmount').each(function () {
                  $(this).rules("add", {
                      required: true,
                      number:true,
                      maxlength: 9,
               	      min:101,
                      max: function() {
                    	  var campaignAmount = $('#projectamount').val();
                          return Number(campaignAmount);
                      },
                      isTotalSpendAmountGreaterThanProjectAmount : true,
                      messages: {
                  	     required: 'Required',
                  	     number: 'Digits only',
                  	     maxlength: 'max 9 digits',
                  	     min:'Please select a value greater than Rs.100'
                      }
                  });
              });
          } else {
              $('.spendAmount').each(function () {
                  $(this).rules("add", {
                      required: true,
                      number:true,
                      maxlength: 6,
                      max: function() {
                          var campaignAmount = $('#projectamount').val();
                          return Number(campaignAmount);
                      },
                      min: 51,
                      isTotalSpendAmountGreaterThanProjectAmount : true,
                      messages: {
                          required: 'Required',
                          number: 'Digits only',
                          maxlength: 'max 6 digits',
                          min:'Please select a value greater than $50'
                      }
                  });
              });
          }

          $('.spendCause').each(function () {
              $(this).rules("add", {
                  required: true,
                  minlength: 3,
                  maxlength:55,
                  messages: {
                  	required: 'Required',
                  	minlength: 'min 3 characters',
                    maxlength: 'max 55 characters'
                  }
              });
          });

          if($('[name="answer"]').length > 0){
		       $( '[name="answer"]' ).rules( "add", {
		            required: true
		       });
          }

          if($('[name="ans1"]').length > 0){
		        $('[name="ans1"]').rules( "add", {
		            required: true
		        });
          }

          if($('[name="ansText1"]').length > 0){
               $('[name="ansText1"]').rules( "add", {
                    required: true
               });
          }

          if($('[name="ansText2"]').length > 0){
	           $('[name="ansText2"]').rules( "add", {
	               required: true,
	               maxlength: 128
	           });
          }

          if($('[name="ansText3"]').length > 0) {
               $('[name="ansText3"]').rules( "add", {
                   required: true,
                   maxlength: 128
               });
          }

          if($('[name="ans3"]').length > 0) {
	          $('[name="ans3"]').rules( "add", {
	               required: true
	          });
          }

          if($('[name="ans4"]').length > 0) {
	          $('[name="ans4"]').rules( "add", {
	               required: true
	          });
          }

        $('[name="reason1"]').rules( "add", {
            required: true,
            minlength: 5,
            maxlength: 140
        });

        $('[name="reason2"]').rules( "add", {
            required: true,
            minlength: 5,
            maxlength: 140
        });

        $('[name="reason3"]').rules( "add", {
            required: true,
            minlength: 5,
            maxlength: 140
        });

        $( '[name="webAddress"]' ).rules( "add", {
            required: true,
            isWebUrl:true
        });

        $( '[name="city"]' ).rules( "add", {
            required: true,
            minlength:3,
            maxlength: 32
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

    	if(isIndianCampaign) {
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
                email:true,
                maxlength: 50
            });
            
            $( '[name="citrusEmail"]' ).rules( "add", {
                required: true,
                email:true,
                maxlength: 50
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
                /*isPaypalEmailVerified : true,*/
                email:true
            });

        	$( '[name="charitableId"]' ).rules( "add", {
                required: true
            });
        }

    	$('[name="impactNumber"]').rules( "add", {
            required: true,
            number:true,
            min:1,
            maxlength: 8
        });

        $('.rewardDescription').each(function () {
            $(this).rules("add", {
               required: true,
               minlength: 5
            });
        });

        $('.rewardTitle').each(function () {
            $(this).rules("add", {
                required: true,
                minlength: 5
            });
        });

        $( '[name="tax-reciept-holder-city"]' ).rules( "add", {
            required: true,
            maxlength: 32,
            minlength:2
        });

        $( '[name="tax-reciept-holder-name"]' ).rules( "add", {
            required: true,
            minlength:2,
            isFullName: true
        });

        if (isIndianCampaign){
        	$( '[name="reg-date"]' ).rules( "add", {
                required: true
            });

            $( '[name="tax-reciept-registration-num"]' ).rules( "add", {
                required: true
            });

            $( '[name="tax-reciept-holder-pan-card"]' ).rules( "add", {
                required: true,
                minlength:10
            });

            $( '[name="expiry-date"]' ).rules( "add", {
                required: true
            });

            $( '[name="fcra-reg-no"]' ).rules( "add", {
                required: true
            });

            $( '[name="fcra-reg-date"]' ).rules( "add", {
                required: true
            });
            
            $( '[name="tax-reciept-orgStatus"]' ).rules( "add", {
	            required: true,
	            minlength:2
	        });
	         
	        $( '[name="tax-reciept-exemptionPercentage"]' ).rules( "add", {
	            required: true,
	            min:0,
	            number: true
	        });

        } else {
        	$( '[name="ein"]' ).rules( "add", {
                required: true,
                minlength:9,
                maxlength:9
            });

            $( '[name="tax-reciept-deductible-status"]' ).rules( "add", {
                required: true,
                minlength:2
            });

            $( '[name="tax-reciept-holder-state"]' ).rules( "add", {
                required: true,
                minlength:2
            });
        }

        $( '[name="tax-reciept-holder-phone"]' ).rules( "add", {
            required: true,
            minlength:9,
            number:true
        });

        $( '[name="addressLine1"]' ).rules( "add", {
            required: true,
            minlength:5,
            maxlength: 50
        });

        $( '[name="addressLine2"]' ).rules( "add", {
            minlength: 5,
            maxlength: 50
        });

        $( '[name="zip"]' ).rules( "add", {
            required: true,
            maxlength: 30
        });

        var signImgUrl = $('#editsignatureIcon').attr('src');

        if (!signImgUrl) {
            $('[name="digitalSign"]').rules( "add", {
                required: true
            });
        }
        
        if ($("#paymentOpt option:selected").val() == "CITRUS") {
        	validateSellerDetails();
        } else {
        	removeSellersValidation();
        }

        if (validator.form() && !storyEmpty) {
            
            if ($("#paymentOpt option:selected").val() == "CITRUS") {
            	event.preventDefault();
            	generateSellerId(false);
            } else {
            	$('#saveButton, #saveButtonXS').attr('disabled','disabled');
            	$('#campaigncreate').find('form').submit();
            }
            
        }
        
    });
    

    $('#submitProject, #submitProjectXS').on('click', function(event) {
        var storyValue = $('.redactorEditor').redactor('code.get');
        var storyEmpty = false;
        if (storyValue === '' || storyValue === undefined){
            $('#storyRequired').show();
            storyEmpty = true;
        } else {
        	$('#storyRequired').hide();
            storyEmpty = false;
        }

        $('#isSubmitButton').val(true);

		if (isIndianCampaign){
			$('.spendAmount').each(function () {
				$(this).rules("add", {
					required: true,
					number:true,
					maxlength: 9,
					min: 101,
					max: function() {
						var campaignAmount = $('#projectamount').val();
						return Number(campaignAmount);
					},
					isTotalSpendAmountGreaterThanProjectAmount : true,
					messages: {
						required: 'Required',
						number: 'Digits only',
						maxlength: 'max 9 digits',
						min	:'Please select a value greater than Rs.100'
					}
				});
			});
		} else {
			$('.spendAmount').each(function () {
				$(this).rules("add", {
					required: true,
					number:true,
					maxlength: 6,
					max: function() {
						var campaignAmount = $('#projectamount').val();
						return Number(campaignAmount);
					},
					min:51,
					isTotalSpendAmountGreaterThanProjectAmount : true,
					messages: {
						required: 'Required',
						number: 'Digits only',
						maxlength: 'max 6 digits',
						min:'Please select a value greater than $50'
					}
				});
			});
		}

		$('.spendCause').each(function () {
			$(this).rules("add", {
				required: true,
				minlength: 3,
				maxlength: 55,
				messages: {
					required: 'Required',
					minlength: 'min 3 characters',
					maxlength: 'max 55 characters'
				}
			});
		});

        if($('#campaignthumbnails').find('#imgdiv').length < 1) {
    		$("#projectImageFile").rules( "add", {
                required: true,
                messages: {
                    required: "Please upload at least one campaign image."
                }
            });
    	}

        $( '[name="city"]' ).rules( "add", {
            required: true,
            maxlength: 32,
            minlength:3
        });

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

        if ($('[name="ans1"]').length > 0) {
	        $('[name="ans1"]').rules( "add", {
	            required: true
	        });
        }

        if ($('[name="ansText2"]').length > 0) {
	        $('[name="ansText2"]').rules( "add", {
	            required: true,
	            maxlength: 128
	        });
        }

        if ($('[name="ans3"]').length > 0) {
	        $('[name="ans3"]').rules( "add", {
	            required: true
	        });
        }

        if ($('[name="ans4"]').length > 0) {
	        $('[name="ans4"]').rules( "add", {
	            required: true
	        });
        }

        $('[name="reason1"]').rules( "add", {
            required: true,
            minlength: 5,
            maxlength: 140
        });

        $('[name="reason2"]').rules( "add", {
            required: true,
            minlength: 5,
            maxlength: 140
        });

        $('[name="reason3"]').rules( "add", {
            required: true,
            minlength: 5,
            maxlength: 140
        });

        $('.rewardNumberAvailable').each(function () {
            $(this).rules("add", {
                required: true,
                number: true,
                min: 1
            });
        });

        var iconUrl = $('#imgIcon').attr('src');

    	if (!iconUrl) {
            $('#iconfile').rules("add", {
                required: true
            });
    	}

        if(isIndianCampaign) {
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
                email:true,
                maxlength: 50
            });
            
            $( '[name="citrusEmail"]' ).rules( "add", {
                required: true,
                email:true,
                maxlength: 50
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
                /*isPaypalEmailVerified : true,*/
                email:true
            });

        	$( '[name="charitableId"]' ).rules( "add", {
                required: true
            });

        }

        $('[name="impactNumber"]').rules( "add", {
            required: true,
            number:true,
            min:1,
            maxlength: 8
        });

    	$('.rewardDescription').each(function () {
            $(this).rules("add", {
                required: true,
                minlength : 5
            });
        });

       	$('.rewardTitle').each(function () {
            $(this).rules("add", {
                required: true,
                minlength : 5
            });
       	});

        if ($('[name="ansText1"]').length > 0){
            $('[name="ansText1"]').rules( "add", {
               required: true
            });
        }

        if($('[name="ansText3"]').length > 0){
           $('[name="ansText3"]').rules( "add", {
              required: true,
              maxlength: 128
           });
        }

        $( '[name="tax-reciept-holder-city"]' ).rules( "add", {
            required: true,
            maxlength: 32,
            minlength:2
        });

        $( '[name="tax-reciept-holder-name"]' ).rules( "add", {
            required: true,
            minlength:2,
            isFullName: true
        });

        if (isIndianCampaign){
        	$( '[name="reg-date"]' ).rules( "add", {
                required: true
            });

            $( '[name="tax-reciept-registration-num"]' ).rules( "add", {
                required: true
            });

            $( '[name="tax-reciept-holder-pan-card"]' ).rules( "add", {
                required: true,
                minlength:10
            });

            $( '[name="expiry-date"]' ).rules( "add", {
                required: true
            });

            $( '[name="fcra-reg-no"]' ).rules( "add", {
                required: true
            });

            $( '[name="fcra-reg-date"]' ).rules( "add", {
                required: true
            });
            
            $( '[name="tax-reciept-orgStatus"]' ).rules( "add", {
                required: true,
                minlength:2
            });
            
            $( '[name="tax-reciept-exemptionPercentage"]' ).rules( "add", {
                required: true,
                min:0,
                number: true
            });
            	 
        } else {
        	$( '[name="ein"]' ).rules( "add", {
                required: true,
                minlength:9, 
                maxlength:9
            });

            $( '[name="tax-reciept-deductible-status"]' ).rules( "add", {
                required: true,
                minlength:2
            });

            $( '[name="tax-reciept-holder-state"]' ).rules( "add", {
                required: true,
                minlength:2
            });
        }
        
        $( '[name="tax-reciept-holder-phone"]' ).rules( "add", {
            required: true,
            minlength:9,
            number:true
        });

        $( '[name="addressLine1"]' ).rules( "add", {
            required: true,
            minlength:5,
            maxlength: 50
        });

        $( '[name="addressLine2"]' ).rules( "add", {
            minlength:5,
            maxlength: 50
        });

        $( '[name="zip"]' ).rules( "add", {
            required: true,
            maxlength: 30
        });

        var signImgUrl = $('#editsignatureIcon').attr('src');
        if (!signImgUrl) {
            $('[name="digitalSign"]').rules( "add", {
                required: true
            });
        }

        if ($("#paymentOpt option:selected").val() == "CITRUS") {
        	validateSellerDetails();
        } else {
        	removeSellersValidation();
        }

        if (validator.form() && !storyEmpty) {
    		
            if ($("#paymentOpt option:selected").val() == "CITRUS") {
            	event.preventDefault();
            	generateSellerId(true);
            } else {
            	$('#campaigncreate').find('form').submit();
            	
            	$('#submitProject').attr('disabled','disabled');
                $('#previewButton').attr('disabled','disabled');
                $('#submitProjectXS').attr('disabled','disabled');
                $('#previewButtonXS').attr('disabled','disabled');
            }
            
    	}
	    
    	if(!validator.form()){
    	    requiredFieldMessages();
    	}
    	  
    });
    
    function requiredFieldMessages(){
	      var str="{";
	      var messages='';
	      
	  	  $('.help-block:visible').each(function(i,e){
	  			if($(this).attr('for') !== undefined){
	  				str +='"'+$(this).attr('for')+'":'+ '"'+$(this).attr('for')+'", ';
	  			}
	  	  });
	  	  
	  	  
	  	  if($('[name="telephone"').val()==='' || $('[name="telephone"').val()===undefined){
	  		  str +='"telephone":"telephone"}';
	  	  }else{
	  		  str+="}";
	  	  }
	  	  
	  	  $.post( $("#b_url").val()+'/project/requiredFields',{data:str}, function(data) {
	  		  var messageJSON =$.parseJSON(data);
	  		  
	  		  $.each(messageJSON, function(index, value){
	  			  messages+=value +"<br>";
	  		  });
	  		  
	  		  $('#requiredFieldMessage').html(messages);
	  		  $('#requiredField').modal("show");
	  	  });
    }

     $.validator.addMethod('isYoutubeVideo', function (value) {
        if(value && value.length !== 0){
           var p = /^https?:\/\/(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
           var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
           var youtubematch = value.match(p);
           var vimeomatch = value.match(vimeo);
           var match;
           if (youtubematch)
               match = youtubematch;
           else if (vimeomatch && vimeomatch[2].length === 9)
               match = vimeomatch;
           else
               match = null;
           return (match) ? true : false;
        }
        return true;
     }, "Please upload a url of Youtube/Vimeo video");

     $.validator.addMethod('isValidTelephoneNumber', function (value) {

         if(value && value.length !== 0){
             var reg = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;
             return (value.match(reg)) ? RegExp.$1 : false;
         }
         return true;
     }, "Please provide valid contact number");

     $.validator.addMethod('isWebUrl', function(value){
    	 if(value && value.length !== 0){
          var p = /(https | http?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})/ig;;
  	    	return (value.match(p));
    	 }
    	 return true;
     }, "Please provide valid url");

     $("input[name='answer']").change(function(){
     	if($(this).val() === "yes") {
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

	$('.ans1').change(function(){
		if ($(this).val() === "yes"){
			$('.ansText1').removeClass('display-none-text1');
		} else {
			$('.ansText1').addClass('display-none-text1');
			if ($('.question-ans-1').find('.help-block').length > 0){
				$('.question-ans-1').find('.help-block').hide();
			}
			autoSave('ans1', 'NO');
		}
	});

	$('.ans3').change(function(){
		if ($(this).val() === "yes"){
			$('.ansText3').removeClass('display-none-text3');
		} else {
			$('.ansText3').addClass('display-none-text3');
			if($('.question-ans-3').find('.help-block').length > 0){
				$('.question-ans-3').find('.help-block').hide();
			}
			autoSave('ans3', 'NO');
		}
	});

	$('.ans4').change(function(){
		var ans4 = $(this).val();
		autoSave('ans4', ans4);
	});

	$('.reason1').blur(function(){
		var reason1 = $(this).val();
		autoSave('reason1', reason1);
	});

	$('.reason2').blur(function(){
		var reason2 = $(this).val();
		autoSave('reason2', reason2);
	});

	$('.reason3').blur(function(){
		var reason3 = $(this).val();
		autoSave('reason3', reason3);
	});

	$('.hashtags').blur(function(){
		var hashtags = $(this).val();
		autoSave('hashtags', hashtags);
	});

    $('.ein').blur(function(){
        var ein = $(this).val();
        autoSave('ein', ein);
    });

    $('.tax-reciept-holder-city').blur(function(){
        var taxRecieptHolderCity = $(this).val();
        autoSave('taxRecieptHolderCity', taxRecieptHolderCity);
    });

    $('.tax-reciept-holder-name').blur(function(){
        var taxRecieptHolderName = $(this).val();
        autoSave('taxRecieptHolderName', taxRecieptHolderName);
    });

    $('.addressLine1').blur(function(){
    	var addressLine1 = $(this).val();
    	autoSave('addressLine1', addressLine1);
    });

    $('.addressLine2').blur(function(){
    	var addressLine2 = $(this).val();
    	autoSave('addressLine2', addressLine2);
    });

    $('.zip').blur(function(){
    	var zip = $(this).val();
    	autoSave('zip', zip);
    });

    $('.tax-reciept-holder-pan-card').blur(function(){
    	var panCardNumber = $(this).val();
    	autoSave('panCardNumber', panCardNumber);
    });

    $( '.tax-reciept-holder-phone' ).blur(function(){
        var phoneNumber = $(this).val();
        autoSave('phoneNumber', phoneNumber);
    });

    $( '.fcra-reg-no' ).blur(function(){
        var fcraRegNum = $(this).val();
        autoSave('fcraRegNum', fcraRegNum);
    });

    $('.tax-reciept-registration-num').blur(function(){
    	var regNum = $('.tax-reciept-registration-num').val();
    	autoSave('regNum', regNum);
    });

    $('.tax-reciept-holder-state').blur(function(){
        var taxRecieptHolderState = $(this).val();
        autoSave('taxRecieptHolderState', taxRecieptHolderState);
    });

    $('.selectpicker-state').change(function(){
        var taxRecieptHolderState = $(this).val();
        autoSave('taxRecieptHolderState', taxRecieptHolderState);
    });

    $('.tax-reciept-deductible-status').change(function(){
        var deductibleStatus = $(this).val();
        autoSave('deductibleStatus', deductibleStatus);
    });

    $('.tax-reciept-holder-country').change(function(){
        var taxRecieptHolderCountry = $(this).val();
        autoSave('taxRecieptHolderCountry', taxRecieptHolderCountry);
    });
    
    $('.tax-reciept-orgStatus').blur(function(){
     	var orgStatus = $(this).val();
     	autoSave('deductibleStatus', orgStatus);
    });
     
    $('.tax-reciept-exemptionPercentage').blur(function(){
     	var exemptionPercentage = $(this).val();
     	if ($('.tax-reciept-exemptionPercentage').valid()) {
     		autoSave('exemptionPercentage', exemptionPercentage);
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
        $('#savereward').attr('value', '1');
        $('#addNewRewards').find('.rewardsTemplate').find("span.help-block").remove();
        $('#addNewRewards').find('.rewardsTemplate').find(".form-group").removeClass('has-error');

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
  	    if($(this).val() === "paypal") {
  	        $('#organizationName').find('input').val('');
  	       	$("#paypalemail").show();
  	        $("#charitableId").hide();
  	        $('#charitable').find('input').val('');
  	        $("#paypalcheckbox").show();
  	     } else if($(this).val() === "firstgiving") {
   	         $('#organizationName').find('input').val('');
  	       	 $("#charitableId").show();
  	         $("#paypalemail").hide();
  	         $("#paypalcheckbox").hide();
   	         $('#paypalemail').find('input').val('');
  	      }
  	 });

     $('#val3').change(function(){
        var c = $('#val3').val();
        if(c === 'US'){
          $('#val1').show();
          $('#val2').hide();
        }
       else {
          $('#val1').hide();
          $('#val2').show();
        }
    });

     $('.cr-img-start-icon').hover(function(){
     	$('.cr-start').attr('src',"//s3.amazonaws.com/crowdera/assets/start-Icon-White.png");
     	}).mouseleave(function(){
         $('.cr-start').attr('src',"//s3.amazonaws.com/crowdera/assets/start-Icon-White.png");
     });

     $('.cr-img-story-icon').hover(function(){
      	$('.cr-story').attr('src',"//s3.amazonaws.com/crowdera/assets/story-Icon-White.png");
      	}).mouseleave(function(){
          $('.cr-story').attr('src',"//s3.amazonaws.com/crowdera/assets/story-Icon-White.png");
      });

     $('.cr-img-admin-icon').hover(function(){
      	$('.cr-admin').attr('src',"//s3.amazonaws.com/crowdera/assets/admin-Icon---White.png");
      	}).mouseleave(function(){
          $('.cr-admin').attr('src',"//s3.amazonaws.com/crowdera/assets/admin-Icon---White.png");
      });

     $('.cr-img-perk-icon').hover(function(){
       	$('.cr-perk').attr('src',"//s3.amazonaws.com/crowdera/assets/perk-Icon-White.png");
       	}).mouseleave(function(){
           $('.cr-perk').attr('src',"//s3.amazonaws.com/crowdera/assets/perk-Icon-White.png");
       });

     $('.cr-img-payment-icon').hover(function(){
       	$('.cr-payment').attr('src',"//s3.amazonaws.com/crowdera/assets/payment-Icon-White.png");
       	}).mouseleave(function(){
           $('.cr-payment').attr('src',"//s3.amazonaws.com/crowdera/assets/payment-Icon-White.png");
       });

     $('.cr-img-launch-icon').hover(function(){
       	$('.cr-launch').attr('src',"//s3.amazonaws.com/crowdera/assets/launch-Icon--White.png");
       	}).mouseleave(function(){
           $('.cr-launch').attr('src',"//s3.amazonaws.com/crowdera/assets/launch-Icon--White.png");
       });

     $('.cr-img-save-icon').hover(function(){
        	$('.cr-launch').attr('src',"//s3.amazonaws.com/crowdera/assets/hdr-save-white.png");
        	}).mouseleave(function(){
            $('.cr-launch').attr('src',"//s3.amazonaws.com/crowdera/assets/hdr-save-white.png");
        });

     $('#paymentOpt').change(function(){
    	 var pay = $('#paymentOpt').val();
    	 if(pay === 'FIR'){
    		 $('#paypalemail').hide();
    		 $('#charitableId').show();

    	 }else if(pay === 'PAY'){
    		 $('#charitableId').hide();
    		 $('#paypalemail').show();
    	 }else if(pay === 'PMT'){
    		 if(pay === 'selected'){
    			 $('#paypalemail').show();
    		 }
    		 $('#paypalemail').hide();
    		 $('#charitableId').hide();
    	 }
     });

     $('#paymentOpt').change(function(){
    	 var payind = $('#paymentOpt').val();
    	 /*if (currentEnv == "testIndia") {*/
    	 if(payind === 'PAYU'){
    		 autoSave('payuEmail', $('#payuemail').val());
    		 $('#PayUMoney').show();
    		 $('#CitrusPay').hide();
    	 } else if (payind === 'CITRUS') {
    		 $('#CitrusPay').show();
    		 $('#PayUMoney').hide();
    		 
    		 resetCitrusDetails();
    	 }
    	
     });

	$('#countryList').change(function(){
	    var c = $('#countryList').val();
	    if(c === 'IN'){
	       	$('#stateList').show();
	       	$('#txtState').hide();
	    }else{
	       	$('#stateList').hide();
	       	$('#txtState').show();
	    }
	});

      /******************************Video Thumbnail***************************************/

    if($('#addvideoUrl').val()) {
        var url= $('#addvideoUrl').val().trim();
        var youtube = /^https?:\/\/.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
        var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
        var match = (url.match(youtube) || url.match(vimeo));
        $('#ytVideo').show();
        $('#media').hide();
        $('#media-video').show();
        var vurl;
        if (match[2].length === 11){
        	vurl=url.replace("watch?v=", "embed/");
            $('#ytVideo').html('<iframe class="youtubeVideoIframe" src="'+ vurl +'?wmode=transparent"></iframe>');
        } else {
        	vurl = url.replace("https://vimeo.com/", "https://player.vimeo.com/video/");
        	$('#ytVideo').html('<iframe class="youtubeVideoIframe" src='+ vurl +'></iframe>');
        }
    }

    $('#videoUrledit').on('click',function(){
    	$("#video-error-msg").hide();
    	$("#addVideoFromModal").closest(".form-group").removeClass("has-video-error");
    	$("#video-error-msg").removeClass("video-help-block");
    	$('#videoUrlTextModal').val($('#addvideoUrl').val());
    	$('#addVideo').modal('show');
    });
    
    $('#videoUrlTextModal').on('keydown', function(event) {
       validateVideoUrl();
    }).keyup(function(e) {
    	validateVideoUrl();
    })
    
    function validateVideoUrl() {
    	
    	if ($("#videoUrlTextModal").val().length > 0) {
    		$("#video-error-msg").hide();
    		$("#addVideoFromModal").closest(".form-group").removeClass("has-video-error");
        	$("#video-error-msg").removeClass("video-help-block");
    	} else {
    		$("#addVideoFromModal").closest(".form-group").addClass("has-video-error");
	    	$("#video-error-msg").addClass("video-help-block");
	    	$("#video-error-msg").show();
    	}
    }
    
    $('#addVideoFromModal').on('click',function(){
    	var youtube = /^https?:\/\/.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
        var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
        var url= $('#videoUrlTextModal').val().trim();
        var match = (url.match(youtube) || url.match(vimeo));
        if (validator.element("#videoUrlTextModal")){
        	
        	$(this).closest(".form-group").removeClass("has-video-error");
        	$("#video-error-msg").removeClass("video-help-block");
        	$("#video-error-msg").hide();
        	
            if (match && match[2].length === 11) {
            	$('#addVideo').modal('hide');
                $('#ytVideo').show();
                $('#media').hide();
                $('#media-video').show();
                $('#addvideoUrl').val(url);
                var vurl=url.replace("watch?v=", "embed/");
                autoSave('videoUrl', vurl);
                $('#ytVideo').html('<iframe class="youtubeVideoIframe" src='+ vurl +'?wmode=transparent></iframe>');
            } else if (match && match[2].length === 9) {
            	$('#addVideo').modal('hide');
                $('#ytVideo').show();
                $('#media').hide();
                $('#media-video').show();
                autoSave('videoUrl', url);
                $('#addvideoUrl').val(url);
                $('#ytVideo').html('<iframe class="youtubeVideoIframe" src= https://player.vimeo.com/video/'+ match[2] +'></iframe>');
            } else if($(this) && !$('#addvideoUrl').val()) {
            	$('#addVideo').modal('hide');
                $('#ytVideo').hide();
                $('#media').show();
                $('#media-video').hide();
            } else if ($("#videoUrlTextModal").val() == "") {
            	$(this).closest(".form-group").addClass("has-video-error");
            	$("#video-error-msg").addClass("video-help-block");
            	$("#video-error-msg").show();
            }
            
        }
    });

    $('#addVideoButton').on('click',function(){
        var youtube = /^https?:\/\/.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
        var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
        var url= $('#videoUrlText').val().trim();
        var match = (url.match(youtube) || url.match(vimeo));
        if (validator.element("#videoUrlText")){
            if (match && match[2].length === 11) {
                $('#ytVideo').show();
                $('#media').hide();
                $('#media-video').show();
                var vurl=url.replace("watch?v=", "embed/");
                $('#addvideoUrl').val(vurl);
                $('#videoUrlTextModal').val(vurl);
                autoSave('videoUrl', vurl);
                $('#ytVideo').html('<iframe class="youtubeVideoIframe" src='+ vurl +'?wmode=transparent></iframe>');
            } else if (match && match[2].length === 9) {
                $('#ytVideo').show();
                $('#media').hide();
                $('#media-video').show();
                autoSave('videoUrl', url);
                $('#addvideoUrl').val(url);
                $('#videoUrlTextModal').val(url);
                $('#ytVideo').html('<iframe class="youtubeVideoIframe" src= https://player.vimeo.com/video/'+ match[2] +'></iframe>');
            } else if($(this) && !$('#addvideoUrl').val()) {
                $('#ytVideo').hide();
                $('#media').show();
                $('#media-video').hide();
            }
        }
    });

     /** ********************Organization Icon*************************** */

    $("#iconfile").change(function() {
        var file =this.files[0];
        
        if(validateExtension(file.name) === false){
	        $('#icondiv').hide();
	        $('#iconfilesize').hide();
	        $('#iconfilesizeSmaller').hide();
	        $('#logomsg').show();
	        $('#logomsg').html("Add only PNG or JPG extension image");
	        this.value=null;
	        return;
	    }
	    if(!file.type.match('image')){
	        $('#icondiv').hide();
	        $('#iconfilesize').hide();
	        $('#iconfilesizeSmaller').hide();
	        $('#logomsg').show();
	        this.value=null;
	    } else{
	        if (file.size > 1024 * 1024 * 3) {
	        	
	            $('#icondiv').hide();
	            $('#logomsg').hide();
	            if($('#iconfilesize')){
	                $('#iconfilesize').show();
	                $('#iconfilesizeSmaller').hide();
	            }
	            $('#iconfile').val('');
	        } else if (file.size < 1024 * 10) {
	        	 $('#icondiv').hide();
		         $('#logomsg').hide();
		         if($('#iconfilesizeSmaller')){
		             $('#iconfilesizeSmaller').show();
		             $('#iconfilesize').hide();
		          }
		          $('#iconfile').val('');
	        } else {
	        	$('#iconfilesize').hide();
	        	$('#iconfilesizeSmaller').hide();
                $('#loading-gif').show();

               var formData = !!window.FormData ? new FormData() : null;
               var name = 'file';
               var projectId = $('[name="projectId"]').val();
               formData.append(name, file);
               formData.append('projectId', projectId);

               var xhr = new XMLHttpRequest();
               xhr.open('POST', $("#b_url").val()+'/project/uploadOrganizationIcon');
               xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");

               // complete
               xhr.onreadystatechange = $.proxy(function() {
                   if (xhr.readyState === 4) {
                       var data = xhr.responseText;
                       data = data.replace(/^\[/, '');
                       data = data.replace(/\]$/, '');

                       var json;
                       try {
                           json = (typeof data === 'string' ? $.parseJSON(data) : data);
                       } catch(err) {
                           json = { error: true };
                       }

                       $('#icondiv').show();
                       $('#logomsg').hide();

                       $('.edit-logo-icon').show();
                       $('#imgIcon').show();
                       $('#logoDelete').show();

                       $('#imgIcon').attr('src',json.filelink);
                       $('#delIcon').attr('src',"//s3.amazonaws.com/crowdera/assets/delete.ico");
                       $('#logoDelete').attr('src',"//s3.amazonaws.com/crowdera/assets/delete.ico");
                       $('#loading-gif').hide();
                   }
               }, this);
               xhr.send(formData);
               $('.createOrgIconDiv, .projectImageFilediv').find("span").remove();
               $('.createOrgIconDiv, .projectImageFilediv').closest(".form-group").removeClass('has-error');
	        }
	    }
    });

    $("#digitalSign").change(function() {
        var file = this.files[0];
        if(validateExtension(file.name) === false){
	        $('#signaturediv').hide();
	        $('#signaturemsgsize').hide();
	        $('#signaturemsg').show();
	        this.value=null;
	        return;
	    }

	    if(!file.type.match('image')){
	        $('#signaturediv').hide();
	        $('#signaturemsgsize').hide();
	        $('#signaturemsg').show();
	        this.value=null;
	    } else {
	        if (file.size > 1024 * 1024 * 3) {
	            $('#signaturediv').hide();
	            $('#signaturemsg').hide();
	            $('#signaturemsgsize').show();
	            $('#digitalSign').val('');
	        } else {
	        	$('#signaturemsgsize').hide();

                $('#loading-gif').show();

               var formData = !!window.FormData ? new FormData() : null;
               var name = 'file';
               var projectId = $('[name="projectId"]').val();
               formData.append(name, file);
               formData.append('projectId', projectId);

               var xhr = new XMLHttpRequest();
               xhr.open('POST', $("#b_url").val()+'/project/uploadDigitalSignature');
               xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");

               // complete
               xhr.onreadystatechange = $.proxy(function() {
                   if (xhr.readyState === 4) {
                       var data = xhr.responseText;

                       data = data.replace(/^\[/, '');
                       data = data.replace(/\]$/, '');

                       var json;
                       try {
                           json = (typeof data === 'string' ? $.parseJSON(data) : data);
                       } catch(err) {
                           json = { error: true };
                       }

                       $('#signatureIcon').attr('src',json.imageUrl);
                       $('#editsignatureIcon').attr('src', json.imageUrl);
                       $('#signaturediv').show();

                       $('#signaturemsg').hide();

                       $('#editsignatureIcon').show();
                       $('#signatureIcon').show();

                       $('#delsignature').show();
                       $('#deleditsignature').show();
                       $('#loading-gif').hide();
                   }

               }, this);
               xhr.send(formData);
               $('.createOrgIconDiv, .projectImageFilediv').find("span").remove();
               $('.createOrgIconDiv, .projectImageFilediv').closest(".form-group").removeClass('has-error');
	        }
	    }
    });

    $('#delsignature, #deleditsignature').click(function(){
        var projectId = $('[name="projectId"]').val();
        $.ajax({
            type:'post',
            url:$("#b_url").val()+'/project/deleteDigitalSign',
            data:'projectId='+projectId,
            success: function(){
                $('#signaturediv').hide();
                $('#delsignature').hide();
                $('#deleditsignature').hide();
                $('#signatureIcon').hide();
                $('#editsignatureIcon').hide();
                $('#signatureIcon').attr('src',"");
                $('#editsignatureIcon').attr('src', "");
                $("#digitalSign").val('');
            }
        }).error(function(){
        });
    });


     /*******************************Description text length******************** */
    $('#descarea, #descarea1').on('keydown', function(event) {
        event.altKey == true;
        var currentString = $('#descarea, #descarea1').val().length;
        if (currentString >= 9) {
        	$('.createDescDiv').find("span").remove();
            $('.createDescDiv').closest(".form-group").removeClass('has-error');
        }

        if(currentString <=140) {
        	if (currentString === 140) {
        		var text = currentString;
        	} else {
        		var text = currentString + 1;
        	}
        }
        if (event.keyCode > 31) {
            if(event.altKey === true){
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

        if(e.altKey === true){
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
        var currentString = $('#descarea, #descarea1').val().length;
        if (currentString === 0) {
            $('#desclength').text("0/140");
        } else {
            $('#desclength').text(currentString+'/140');
        }
    }

    /*******************************Title text length******************** */
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

    var isvalidFilesize =  false;
    $('.taxRecieptFiles').change(function(event) {
    	var file = this.files[0];
        $('.filesize').hide();
        $('.fileempty').hide();

        var fileName;
        var isFileSizeExceeds = false;

    	if($('#taxRecieptId').val() === undefined || $('#taxRecieptId').val() === '' || $('#taxRecieptId').val() === null){
            $('.fileempty').show();
            $('.taxRecieptFiles').val('');
            document.getElementById("fileempty").innerHTML= "Please fill above fields and then upload files.";
    	} else {
        if (file.size === 0){
        	if (fileName) {
                fileName = fileName +" "+ file.name;
            } else {
                fileName = file.name;
            }
            $('.fileempty').show();
            document.getElementById("fileempty").innerHTML= "The file " +fileName+ " you are attempting to upload is empty. Please upload another file";
        } else {
        if(file.size < 1024 * 1024 * 3) {
            isvalidFilesize =  true;
            $('#loading-gif').show();

            var formData = !!window.FormData ? new FormData() : null;
            var name = 'file';
            var taxRecieptId = $('#taxRecieptId').val();
            formData.append(name, file);
            formData.append('projectId', projectId);
            formData.append('taxRecieptId', taxRecieptId);

            var xhr = new XMLHttpRequest();
            xhr.open('POST', $("#b_url").val()+'/project/uploadTaxRecieptFiles');
            xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");

            // complete
            xhr.onreadystatechange = $.proxy(function() {
                if (xhr.readyState === 4) {
                    var data = xhr.responseText;
                    data = data.replace(/^\[/, '');
                    data = data.replace(/\]$/, '');

                    var json;
                    try {
                       json = (typeof data === 'string' ? $.parseJSON(data) : data);
                    } catch(err) {
                       json = { error: true };
                    }
                    var output = document.getElementById("col-tax-file-show");
                    var div = document.createElement("div");
                    div.className = "col-sm-3 col-sm-tax-reciept";
                    div.innerHTML = "<div class=\"cr-tax-files\"><div class=\"col-file-name\">"+file.name +"</div><div class=\"deleteicon\"><button type=\"button\" class=\"close\" onClick=\"deleteTaxRecieptFiles(this,'"+json.fileId+"','"+taxRecieptId+"');\">&times;</button></div></div>";

                    output.insertBefore(div, null);
                    $('#loading-gif').hide();
                }
            }, this);
            xhr.send(formData);
        } else {
            if (fileName) {
                fileName = fileName +" "+ file.name;
            } else {
                fileName = file.name;
            }
            $('.filesize').show();
            isFileSizeExceeds = true;
        }
        }

        document.getElementById("filesize").innerHTML= "The file " +fileName+ " you are attempting to upload is larger than the permitted size of 3MB.";
        if (isFileSizeExceeds && !isvalidFilesize) {
            $('.taxRecieptFiles').val('');
        }
    	}
    	//delayed code, time in milliseconds
        var delay = 9999;
        setTimeout(function() {
        	$('.filesize').hide();
        	$('.fileempty').hide();
        }, delay);
    });

    function setTitleText() {

        var currentstring = $('#campaignTitle').val().length;
        if (currentstring === 0) {
            $('#titleLength').text("0/55");
        } else {
            $('#titleLength').text(currentstring+'/55');
        }
    }

    $('#customVanityUrl').on('keydown', function(event) {

        event.altKey === true;
        var currentstring = $('#customVanityUrl').val().length;

        if(currentstring <= 55) {
            if (currentstring === 55) {
                var text = currentstring ;
            } else {
                var text = currentstring + 1;
            }
        }
        if (event.keyCode > 31) {
            if(event.altKey === true){
                setTitleText();
            }
            else{
                if(currentstring <54)
                    currentstring++;
                $('#vanityUrlLength').text(text+'/55');
            }

        } else {
            currentstring--;
            $('#vanityUrlLength').text(text+'/55');
        }
    }).keyup(function(e) {

        if(e.altKey === true){
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

        var currentstring = $('#customVanityUrl').val().length;
        if (currentstring === 0) {
            $('#vanityUrlLength').text("0/55");
        } else {
            $('#vanityUrlLength').text(currentstring+'/55');
        }
    }

    /***************************Multiple Image Selection*************** */
    var isvalidsize =  false;
    $('#projectImageFile, #projectEditImageFile, #campaignImage').change(function(event) {

        var file = this.files[0];
        if(validateExtension(file.name) === false) {
            $('.pr-thumbnail-div').hide();
            $('.imgmsg').css("display","block");
            $('.imgmsg').html("Add only PNG or JPG extension images");
            $('.campaignfilesize').hide();
            this.value=null;
            return;
        }
        if(!file.type.match('image')){
            $('.pr-thumbnail-div').hide();
            $('.imgmsg').show();
            $('.campaignfilesize').hide();
            this.value=null;
        } else{
            $('.imgmsg').hide();
            $('.campaignfilesize').hide();
            var fileName;
            var isFileSizeExceeds = false;

            if(file.size < 1024 * 1024 * 3) {
            	if($('#campaignthumbnails').find('.pr-thumb-div').length === 0){
                    $('.panel-no-image').hide();
                    $('.panel-pic-uploaded').show();
                }
            	if ($('#campaignthumbnails').find('.pr-thumb-div').length <= 4){
                    isvalidsize =  true;
                    $('#loading-gif').show();

                    var formData = !!window.FormData ? new FormData() : null;
                    var name = 'file';
                    var projectId = $('[name="projectId"]').val();
                    formData.append(name, file);
                    formData.append('projectId', projectId);

                    var xhr = new XMLHttpRequest();
                    xhr.open('POST', $("#b_url").val()+'/project/uploadImage');
                    xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");

                    // complete
                    xhr.onreadystatechange = $.proxy(function() {
                        if (xhr.readyState === 4) {
                            var data = xhr.responseText;
                            data = data.replace(/^\[/, '');
                            data = data.replace(/\]$/, '');

                            var json;
                            try {
                               json = (typeof data === 'string' ? $.parseJSON(data) : data);
                            } catch(err) {
                               json = { error: true };
                            }
                            var output = document.getElementById("campaignthumbnails");
                            var div = document.createElement("div");
                            div.id = "imgdiv";
                            div.className = "pr-thumb-div";
                            div.innerHTML = "<img  class='pr-thumbnail' src='"+ json.filelink + "'"+ "title='"
                                        + file.name + "'/><div class=\"deleteicon\"><img onClick=\"deleteProjectImage(this,'"+json.imageId+"','"+projectId+"');\" src=\"//s3.amazonaws.com/crowdera/assets/delete.ico\" style=\"margin:2px;width:10px;height:10px;\"/></div>";

                            output.insertBefore(div, null);
                            $('#loading-gif').hide();
                        }
                    }, this);
                    xhr.send(formData);

                    $('#createthumbnail').find("span").remove();
                    $('#createthumbnail').closest(".form-group").removeClass('has-error');
                } else {
            	    $('.imageNumValidation').show();
            	    var delay = 5000;
                    setTimeout(function() {
                    	$('.imageNumValidation').hide();
                    }, delay);
                }
            } else {
                if (fileName) {
                    fileName = fileName +" "+ file.name;
                } else {
                    fileName = file.name;
                }
                $('.campaignfilesize').show();
                isFileSizeExceeds = true;
            }

            document.getElementById("campaignFilesizeID").innerHTML= "The file " +fileName+ " you are attempting to upload is larger than the permitted size of 3MB.";
            document.getElementById("campaignFilesizeID1").innerHTML= "The file " +fileName+ " you are attempting to upload is larger than the permitted size of 3MB.";
            if (isFileSizeExceeds && !isvalidsize) {
                $('#campaignImage').val('');
            }
            $('#projectImageFile, #projectEditImageFile').val('');
            var delay = 9999;
            setTimeout(function() {
            	$('.campaignfilesize').hide();
            }, delay);
        }
    });

    function validateExtension(imgExt){
          var allowedExtensions = new Array("jpg","JPG","png","PNG");
          for(var imgExtImg=0;imgExtImg<allowedExtensions.length;imgExtImg++)
          {
              imageFile = imgExt.lastIndexOf(allowedExtensions[imgExtImg]);
              if(imageFile !== -1){
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
            '<div class="col-sm-12 perk-create-styls perk-top perkEditDeleteAlign">'+
                 '<span class="perkSaveMessage" id="perkSaveMessage'+updateCount+'">Perk Saved</span>'+
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

        if(isIndianCampaign){
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
    	var rewardLength = $('#addNewRewards').find('.rewardsTemplate').length;
        if (confirm('Are you sure you want to discard this perk?')){
            removeRewards(count);
            if (rewardLength === 1){
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
        var savedStatus = rewardValidationAndSaving(lastrewardcount);
        if (savedStatus){
        	$('#perkSaveMessage').show();
        	$('#perkSaveMessage').fadeOut(3000);
        }
    });

    function rewardValidationAndSaving(rewardCount){
    	$('.rewardDescription').each(function () {
            $(this).rules("add", {
                required: true,
                minlength : 5
            });
        });

       	$('.rewardTitle').each(function () {
            $(this).rules("add", {
                required: true,
                minlength : 5
            });
       	});

        $('.rewardNumberAvailable').each(function () {
            $(this).rules("add", {
                required: true,
                number: true,
                min: 1
            });
        });
        if(isIndianCampaign) {
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
        if($('#rewardPrice'+rewardCount).length === 0){
            return true;
        } else if((validator.element("#rewardPrice"+rewardCount)) && (validator.element("#rewardTitle"+rewardCount)) && (validator.element( "#rewardNumberAvailable"+rewardCount)) && (validator.element( "#rewardDesc"+rewardCount))) {
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

     $.validator.addMethod('isequaltofirstadmin', function(value){
    	 var emailId = $('#firstadmin').val();
 	     if(value.length !== 0 && value === emailId) {
 	         return (!value === emailId);
 	     }
     	 return true;
     }, "This Co-creator is already added");

     $.validator.addMethod('isequaltosecondadmin', function(value){
    	 var emailId = $('#secondadmin').val();
     	 if(value.length !== 0 && value === emailId) {
     	     return (!value === emailId);
     	 }
     	 return true;
     }, "This Co-creator is already added");

     $.validator.addMethod('isequaltothirdadmin', function(value){
    	 var emailId = $('#thirdadmin').val();
 	     if(value.length !== 0 && value === emailId) {
 	         return (!value === emailId);
 	     }
     	 return true;
     }, "This Co-creator is already added");

     $.validator.addMethod('iscampaigncreator', function(value){
    	 var emailId = $('#email').val();
    	 if(value.length !== 0 && value === emailId) {
    		 return (!value === emailId);
    	 }
    	 return true;
     }, "Campaign creator cannot be added as a Co-creator");


    $(document).ready(function (){
        //called when key is pressed in textbox
        $("#amount").keypress(function (e) {
            //if the letter is not digit then display error and don't type anything
            if (e.which !== 8 && e.which !== 0 && (e.which < 48 || e.which > 57)) {
                //display error message
                $("#errormsg").html("Digits Only").show().fadeOut("slow");
                return false;
            }
        });

        $("form").on("click", ".spendAmount", function () {
            $('.spendAmount').each(function () {
                $(this).keypress(function (e) {
                  //if the letter is not digit then display error and don't type anything
                  if (e.which !== 8 && e.which !== 0 && (e.which < 48 || e.which > 57)) {
                    //display error message
                	$(this).siblings(".digitsError").html("Digits Only").show().fadeOut(1000);
                    return false;
                  }
                });
            });

          });

        $("#amount2,#amount3,#amount1").keypress(function (e) {
            //if the letter is not digit then display error and don't type anything
            if (e.which !== 8 && e.which !== 0 && (e.which < 48 || e.which > 57)) {
                //display error message
                $("#errormsg1,#errormsg2").html("Digits Only").show().fadeOut("slow");
                return false;
            }
        });

        $("#customVanityUrl").keypress(function (e) {
             return /[a-z0-9-]/i.test(
                String.fromCharCode(e.charCode || e.keyCode)
             ) || !e.charCode && e.keyCode  < 48;
        });

        $("form").on("click", ".editreward", function () {
        	var editCount = $(this).attr('value');
        	var savedStatus = rewardValidationAndSaving(editCount);
        	if (savedStatus){
            	$('#perkSaveMessage'+editCount).show();
            	$('#perkSaveMessage'+editCount).fadeOut(3000);
            }
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
                  if (e.which !== 8 && e.which !== 0 && (e.which < 48 || e.which > 57)) {
                    //display error message
                    return false;
                  }
                });
            });

          });

		$("form").on("click", ".spendMatrixTemplateAdd", function () {
			var shippingMatrixCount = $('.spend-matrix').find('.spenMatrixNumberAvailable:last').val();
			var spendMatrixSaved = validateSpendMatrix(shippingMatrixCount);
			if (spendMatrixSaved){
				$('.spend-matrix').find('.spendMatrixTemplateAdd:last').addClass('display-none');
				var nextCount = ++shippingMatrixCount;
				var template = '<div class="spend-matrix-template" id="spend-matrix-template'+nextCount+'">'+
					'<br><br class="hidden-xs"><br class="hidden-xs">'+
					'<div class="col-sm-amt col-sm-12">'+
						'<span class="cr-label-spend-matrix col-sm-2 col-xs-12">I require</span>'+
						'<div class="form-group col-sm-3 col-xs-4 col-sm-input-group">';
							if (isIndianCampaign){
								template = template +'<span class="fa fa-inr cr-currency"></span>';
							} else {
								template = template +'<span class="fa fa-usd cr-currency"></span>';
							}
							template = template +'<input type="text" class="form-control form-control-no-border-amt form-control-input-width spendAmount" id="spendAmount'+nextCount+'" name="spendAmount'+nextCount+'">'+
							'<span class="digitsError"></span>'+
						'</div>&nbsp;&nbsp;&nbsp;'+
						'<span class="cr-label-spend-matrix-for col-sm-1 col-xs-1">for</span>'+
						'<div class="form-group col-sm-5 col-xs-7 col-input-for">'+
						'	<input type="text" class="form-control form-control-input-for spendCause" maxlength="64" id="spendCause'+nextCount+'" name="spendCause'+nextCount+'">'+
						'</div>'+
						'<div class="clear visible-xs"></div>'+
						'<div class="btn btn-circle spend-matrix-icons spendMatrixTemplateSave">'+
							'<input type="hidden" name="spendFieldSave" value="'+nextCount+'" class="spendFieldSave" id="spendFieldSave'+nextCount+'">'+
							'<i class="glyphicon glyphicon-floppy-save glyphicon-size glyphicon-save"></i>'+
						'</div>&nbsp;'+
						'<div class="btn btn-circle spend-matrix-icons spendMatrixTemplateDelete">'+
							'<input type="hidden" name="spendFieldDelete" value="'+nextCount+'" class="spendFieldDelete">'+
							'<i class="glyphicon glyphicon-trash glyphicon-size"></i>'+
						'</div>&nbsp;'+
						'<div class="btn btn-circle spend-matrix-icons spendMatrixTemplateAdd" id="spendMatrixTemplateAdd'+nextCount+'">'+
							'<i class="glyphicon glyphicon-plus glyphicon-size"></i>'+
						'</div>'+
					'</div>'+
					'<input type="hidden" name="spenMatrixNumberAvailable" class="spenMatrixNumberAvailable" value="'+nextCount+'" id="spenMatrixNumberAvailable'+nextCount+'">'+
				'</div>';
				$('.spend-matrix').append(template);
				var lastSpendField = $('.spenMatrixNumberAvailable:last').val();
				$('#lastSpendField').val(lastSpendField);
			}
		});

          function validateSpendMatrix(shippingMatrixCount){
        	  if (isIndianCampaign){
        	      $('.spendAmount').each(function () {
                      $(this).rules("add", {
                          required: true,
                          number:true,
                          maxlength: 9,
                   	      min:101,
                          max: function() {
                              var campaignAmount = $('#projectamount').val();
                              return Number(campaignAmount);
                          },
                          isTotalSpendAmountGreaterThanProjectAmount : true,
                          messages: {
                      	     required: 'Required',
                      	     number: 'Digits only',
                      	     maxlength: 'max 9 digit',
                      	     min:'Please select a value greater than Rs.100'
                          }
                      });
                  });
              } else {
                  $('.spendAmount').each(function () {
                      $(this).rules("add", {
                          required: true,
                          number:true,
                          maxlength: 6,
                          max: function() {
                              var campaignAmount = $('#projectamount').val();
                              return Number(campaignAmount);
                          },
                          min:51,
                          isTotalSpendAmountGreaterThanProjectAmount : true,
                          messages: {
                              required: 'Required',
                              number: 'Digits only',
                              maxlength: 'max 6 digit',
                              min:'Please select a value greater than $51'
                          }
                      });
                  });
              }

        	  $('.spendCause').each(function () {
                  $(this).rules("add", {
                      required: true,
                      minlength:3,
                      maxlength:55,
                      messages: {
                      	required: 'Required',
                      	minlength: 'min 3 characters',
                      	maxlength: 'max 55 characters'
                      }
                  });
              });

        	  if((validator.element("#spendAmount"+shippingMatrixCount)) && (validator.element("#spendCause"+shippingMatrixCount))) {
        		  saveSpendMatrixField(shippingMatrixCount);
        		  return true;
              } else {
                  validator.element( "#spendAmount"+shippingMatrixCount);
                  validator.element( "#spendCause"+shippingMatrixCount);
                  return false;
              }
          }

          function saveSpendMatrixField(savingCount){
        	  var amount = $('#spendAmount'+savingCount).val();
        	  var cause = $('#spendCause'+savingCount).val();
        	  var grid = $('.pieChart');
        	  $.ajax({
              	  cache: true,
                  type:'post',
                  url:$("#b_url").val()+'/project/saveSpendMatrix',
                  data:'amount='+amount+'&cause='+cause+'&savingCount='+savingCount+'&projectId='+projectId,
                  success: function(data) {
                	  $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                  }
              }).error(function() {
              });
          }

          $("form").on("click", ".spendMatrixTemplateDelete", function () {
        	  if (confirm('Are you sure you want to delete this spend field?')){
                  var deleteCount = $(this).find('.spendFieldDelete').val();
                  var shippingMatrixCount = $('.spend-matrix').find('.spenMatrixNumberAvailable:last').val();

                  if (deleteCount === shippingMatrixCount){
            	      $('.spendMatrixTemplateAdd:last').remove();
            	      var id = $('.spendMatrixTemplateAdd:last').attr('id');
            	      $('#'+id).removeClass('display-none');
                  }

                  deleteSpendMatrix(deleteCount);
        	  }
          });

          function deleteSpendMatrix(deleteCount){
        	  var amount = $('#spendAmount'+deleteCount).val();
        	  var cause = $('#spendCause'+deleteCount).val();
        	  var grid = $('.pieChart');
        	  $.ajax({
              	  cache: true,
                  type:'post',
                  url:$("#b_url").val()+'/project/deleteSpendMatrix',
                  data:'amount='+amount+'&cause='+cause+'&deleteCount='+deleteCount+'&projectId='+projectId,
                  success: function(data) {
                	  $('.spend-matrix').find('#spend-matrix-template'+deleteCount).remove();
                	  var lastSpendField = $('.spenMatrixNumberAvailable:last').val();
                      $('#lastSpendField').val(lastSpendField);
                      $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                  }
              }).error(function() {
              });
          }

          $("form").on("click", ".spendMatrixTemplateSave", function () {
              var saveCount = $(this).find('.spendFieldSave').val();
              var isSpendMatrixSaved = validateSpendMatrix(saveCount);
              if (isSpendMatrixSaved){
            	  $('.saved-message').show().fadeOut(3000);
              }
          });


        $('.cr-img-start-icon').click(function(){

        	var target = this.hash,
                $target = $(target);

            $('html, body').stop().animate({
                'scrollTop': $target.offset().top-160
            }, 90, 'swing', function () {
            });

            return false;
    	});
    	$('.cr-img-story-icon').click(function(){
    		var target = this.hash,
                $target = $(target);

            $('html, body').stop().animate({
                'scrollTop': $target.offset().top-170
            }, 90, 'swing', function () {
            });

            return false;
    	});
    	$('.cr-img-admin-icon').click(function(){
    		var target = this.hash,
                $target = $(target);

            $('html, body').stop().animate({
                'scrollTop': $target.offset().top-180
            }, 90, 'swing', function () {
            });

            return false;
    	});
    	$('.cr-img-perk-icon').click(function(){
    		var target = this.hash,
                $target = $(target);

            $('html, body').stop().animate({
                'scrollTop': $target.offset().top-170
            }, 90, 'swing', function () {
            });

            return false;
    	});
    	$('.cr-img-payment-icon').click(function(){
    		var target = this.hash,
                $target = $(target);

            $('html, body').stop().animate({
                'scrollTop': $target.offset().top-205
            }, 90, 'swing', function () {
            });

            return false;
    	});
    	$('.cr-img-launch-icon').click(function(){
    		var target = this.hash,
                $target = $(target);

            $('html, body').stop().animate({
                'scrollTop': $target.offset().top-180
            }, 90, 'swing', function () {
            });

            return false;
    	});
    	$('.cr-img-save-icon').click(function(){
    		var target = this.hash,
            $target = $(target);
    		
            $('html, body').stop().animate({
                'scrollTop': $target.offset().top-180
            }, 90, 'swing', function () {
            });

            return false;
    	});

   });

   /*$('#paypalEmailId').change(function(){
       var base_url = $("#b_url").val();
       if (base_url !== 'https://gocrowdera.com'){
           var email =  $('#paypalEmailId').val();
           $.ajax({
               type:'post',
               url:$("#b_url").val()+'/project/paypalEmailVerification',
               data:'email='+email,
               success: function(data){
                   $('#paypalEmailAck').val(data);
                   if (data === 'Success') {
                       $('.paypalVerification').find("span").remove();
                       $('.paypalVerification').closest(".form-group").removeClass('has-error');
                   }
               }
           }).error(function(){
           });
        }
    });*/

   $('.form-control-impact-num').blur(function (){
	   var impactNumber = $(this).val();
	   if (validator.element( ".form-control-impact-num")){
		   autoSave('impactNumber', impactNumber);
	   }
   });

    $('#category').change(function(){

	autoSave('category', $(this).val());
        changeHashTags();
    });

    $('#country').change(function(){
        var selectedCountry = $(this).val();
        if (isIndianCampaign){
        	if (selectedCountry === 'null') {
                autoSave('country', 'IN');
            } else {
                autoSave('country', selectedCountry);
            }
        } else {
        	$.ajax({
                type:'post',
                url:$("#b_url").val()+'/project/getCountryVal',
                data:'country='+selectedCountry+'&projectId='+projectId,
                success: function(data) {
                   $('#selectedCountry').val(data);
                   changeHashTags();
                }
            }).error(function(){
            });
        }
    });

    $('.recipient').change(function() {

        var recipient = $(this).val();
        if (isIndianCampaign){
            if (recipient === 'NGO'){
                $('#tax-reciept').show();
            } else {
                $('#tax-reciept').hide();
                if ($('#offeringTaxReciept').val() === 'true' || $('#offeringTaxReciept').val() === true){
                    if (confirm("If you will change the recipient of fund you will not be liable to offer tax reciept. \n Are you sure you don't want to offer tax reciept to your contributors.It may delete all tax reciept data")){
                        $('.col-tax-reciept-panel').hide();
                        $('#taxRecieptId').val(null);
                        deleteTaxReciept();
                    } else {
                        $(this).val('NGO');
                        $('#tax-reciept').show();
                        $('.recipient li').removeClass('selected');
                        $(".recipient li:eq('1')").addClass('selected');
                        $('.recipient ').find('span.filter-option').text('NGO');
                    }
                }
            }
        } else {
            if (recipient === 'NON-PROFIT'){
                 $('#tax-reciept').show();
            } else {
                $('#tax-reciept').hide();
                if ($('#offeringTaxReciept').val() === 'true' || $('#offeringTaxReciept').val() === true){
                    if (confirm("If you will change the recipient of fund you will not be liable to offer tax reciept. \nAre you sure you don't want to offer tax reciept to your contributors.It may delete all tax reciept data")){
                        $('.tax-reciept-checkbox').attr('checked', false);
                        $('.col-tax-reciept-panel').hide();
                        $('#taxRecieptId').val(null);
                        deleteTaxReciept();
                    } else {
                        $(this).val('NON-PROFIT');
                        $('#tax-reciept').show();
                        $('.recipient li').removeClass('selected');
                        $(".recipient li:eq('1')").addClass('selected');
                        $('.recipient ').find('span.filter-option').text('Non-Profit');
                    }
                }
            }
        }


        $.ajax({
            type:'post',
            url:$('#b_url').val()+'/project/saveRecipientAndHashTags',
            data:'recipient='+recipient+'&projectId='+projectId,
            success: function(){
                changeHashTags();
            }
        }).error(function(){
        });
    });

    function deleteTaxReciept(){
        $.ajax({
            type:'post',
            url:$("#b_url").val()+'/project/deleteTaxReciept',
            data:'projectId='+projectId,
            success: function() {
               $('#offeringTaxReciept').val(false);
               $('.tax-reciept-checkbox').attr('checked', false);
               $('.fcra-details').hide();
               $('.fcra-reg-no').val('');
               $('.tax-reciept-holder-city').val('');
               $('.tax-reciept-holder-name').val('');
               $('.tax-reciept-holder-state').val('');

               $('.addressLine1').val('');
               $('.addressLine2').val('');
               $('.zip').val('');
               $('.tax-reciept-holder-phone').val('');

               if (isIndianCampaign){
                   $('.tax-reciept-registration-num').val('');
                   $('.tax-reciept-holder-pan-card').val('');
                   $('.fcra-reg-no').val('');
                   $('.text-date').val('');
                   $('#taxRecieptFiles').val('');
                   $('.col-tax-file-show').find('.cr-tax-files').remove();
               } else {
            	   $('.ein').val('');
                   $('.tax-reciept-holder-country').val('');
                   $('.tax-reciept-deductible-status').val('');
               }
           }
       }).error(function() {
       });
    }

    $('.tax-reciept-checkbox').click(function (){
        if ($('input[name="tax-reciept-checkbox"]:checked').length > 0){
            $('.col-tax-reciept-panel').show();
            $('#offeringTaxReciept').val(true);
            autoSave('offeringTaxReciept', true);
        } else {
            if (confirm("Are you sure you don't want to offer tax reciept to your contributors.It may delete all tax reciept data")){
                $('.col-tax-reciept-panel').hide();
                $('#taxRecieptId').val(null);
                deleteTaxReciept();
            } else {
                $('#tax-reciept-checkbox').prop('checked', true);
            }
        }
    });
    
    if($('.col-tax-reciept-panel').css('display') == 'none')
	{	$('#tax-reciept').show();
		$('.tax-reciept-checkbox').attr('checked', false);
        $('#taxRecieptId').val(null);
	}else{
		$('#tax-reciept').show();
		$('.tax-reciept-checkbox').attr('checked', true);
        $('#taxRecieptId').val(true);
	}
    
    $(document).ready(function(){
        $('input[id="crowdera-email"]').click(function(){
            if($(this).prop("checked") == true){
               $('#paypalEmailId').val("international@crowdera.co");
            }
            else if($(this).prop("checked") == false){
                $('#paypalEmailId').val(null);
            }
        });
    });

    $('#crowdera-email').change(function(){
        if($("#crowdera-email").prop('checked') == false)
        {
            var confirmMsg = window.confirm("Are you sure, you don't want to receive foreign contribution?");
            if(confirmMsg == true)
            {
                $("#crowdera-email").prop('checked', false);
                $('#paypalEmailId').val(null);
            }
            else
            {
                $("#crowdera-email").prop('checked', true);
                $('#paypalEmailId').val("international@crowdera.co");
            }
        }
    });

    $('.fcra-checkbox').click(function(){
        if ($('input[name="fcra-checkbox"]:checked').length > 0){
            $('.fcra-details').show();
        } else {
            $('.fcra-details').hide();
            autoSave('fcraRegNum', "");
            $('.fcra-reg-no').val('');
            $('.fcra-reg-date').val('');
        }
    });

	$('.days').change(function(){
		var days = $(this).val();
		autoSave('days', days);
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

    $('.customVanityUrl').blur(function (){
        var customUrl = $(this).val();
       //delayed code to prevent error, time in milliseconds
        var delay = 50;
        setTimeout(function() {
                var customUrlStatus = $('#vanityUrlStatus').val();
                if(validator.element(".customVanityUrl") && customUrlStatus === 'true')
                    autoSave('customVanityUrl', customUrl.trim());
            }, delay);
    });

    $('#customVanityUrl').bind("paste",function(e) {
        e.preventDefault();
    });

    $('#organizationname').blur(function (){
    	var name = $(this).val();
    	autoSave('organizationname', name);
    });

    $('#webAddress').blur(function (){
    	var webAddress = $(this).val();
    	if (validator.element( "#webAddress") && webAddress != undefined && webAddress != "") {
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
    
    $('#citrusemail').blur(function (){
        var citrusEmail = $(this).val();
        if (validator.element( "#citrusemail")) {
            autoSave('citrusEmail', citrusEmail);
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
                if (data !== 'null'){
                    $('#taxRecieptId').val(data);
                }
            }
        }).error(function() {
        });
    }

    $('#saveCharitableId').click(function (){
        var uuid = $('#uuid').val();
        var charityName = $('#charity_name').val();
        $('#charitable').find('input').val(uuid);
        $('#organizationName').find('input').val(charityName);
        $('#paypalemail').find('input').val('');

        $.ajax({
           type:'post',
           url:$("#b_url").val()+'/project/autoSaveCharitableIdAndOrganisationName',
           data:'projectId='+projectId+'&charitableId='+uuid+'&organizationname='+charityName,
           success: function(data) {
               if (data !== 'null'){
                   $('#taxRecieptId').val(data);
               }
           }
       }).error(function() {
       });
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

    $('#name1').blur(function (){
        var name = $(this).val();
        autoSave('name', name);
    });

    $('#amount1').blur(function (){
        var amount = $(this).val();
        $('#projectamount').val(amount);
        if(validator.element("#amount1") && amount) {
            autoSave('amount', amount);
        }
    });

    $('#amount2').blur(function (){
        var amount = $(this).val();
        $('#projectamount').val(amount);
        if(validator.element("#amount2") && amount) {
            autoSave('amount', amount);
        }
    });

    $('#paypalEmailId').blur(function(){
    	var paypalEmail = $('#paypalEmailId').val();
    	$('#charitable').find('input').val('');
    	$('#fgSearchForm').find('#fgNameStart').val('');
        autoSave('paypalEmailId', paypalEmail);
    });

    $('#campaignTitle1').blur(function (){
        var title = $(this).val();
        autoSave('campaignTitle', title);
    });

    $('#descarea1').blur(function (){
        var descarea = $(this).val();
        autoSave('descarea', descarea);
    });

    $('.city').blur(function (){
    	var city = $(this).val();
    	$.ajax({
            type:'post',
            url:$("#b_url").val()+'/project/autoSaveCityAndHashTags',
            data:'projectId='+projectId+'&city='+city,
            success: function() {
            	changeHashTags();
            }
        }).error(function() {
        });
    });

    $('#impact1').click(function(){
    	$('#usedFor').val('IMPACT');
    	$.ajax({
            type:'post',
            url:$("#b_url").val()+'/project/autoSaveUsedForAndHashTags',
            data:'projectId='+projectId+'&usedFor=IMPACT',
            success: function() {
            	changeHashTags();
            }
        }).error(function() {
        });
    });

    $('#passion1').click(function(){
    	$('#usedFor').val('PASSION');
    	$.ajax({
            type:'post',
            url:$("#b_url").val()+'/project/autoSaveUsedForAndHashTags',
            data:'projectId='+projectId+'&usedFor=PASSION',
            success: function() {
            	changeHashTags();
            }
        }).error(function() {
        });
    });

    $('#innovating1').click(function(){
    	$('#usedFor').val('SOCIAL-INNOVATION');
    	$.ajax({
            type:'post',
            url:$("#b_url").val()+'/project/autoSaveUsedForAndHashTags',
            data:'projectId='+projectId+'&usedFor=SOCIAL_NEEDS',
            success: function() {
            	changeHashTags();
            }
        }).error(function() {
        });
    });

    $('#personal1').click(function(){
    	$('#usedFor').val('PERSONAL-NEEDS');
    	$.ajax({
            type:'post',
            url:$("#b_url").val()+'/project/autoSaveUsedForAndHashTags',
            data:'projectId='+projectId+'&usedFor=PERSONAL_NEEDS',
            success: function() {
            	changeHashTags();
            }
        }).error(function() {
        });
    });

    function changeHashTags(){
        var category = $('#category').val();
        var country = $('#selectedCountry').val();
        var usedFor = ($('#usedFor').val() === undefined) ? $('#usedForCreate').val() : $('#usedFor').val();
        var fundRaisedBy = $('.recipient').val();
        var city = $('.city').val();
        var list = "";
        if (usedFor === 'SOCIAL_NEEDS') {
            list = '#Social-Innovation';
        } else if (usedFor === 'PERSONAL_NEEDS') {
            list = '#Personal-Needs';
        } else if (usedFor === 'IMPACT'){
            list = '#Impact';
        } else if (usedFor === 'PASSION'){
            list = '#Passion';
        }

        (fundRaisedBy && fundRaisedBy !== 'null') ? list = ( list + ((list == "") ? "" : ",") + '#'+getStringCaptalised(fundRaisedBy)) : ' ' ;
        (category && category !== 'null') ? list = ( list + ((list == "") ? "" : ",") + '#'+getStringCaptalised(category)) : ' ' ;

        if (!isIndianCampaign){
            (country !== 'null' && country !== null && country !== '') ? list = ( list + ((list == "") ? "" : ",") + '#'+country) : ' ';
        }

        (city && city !== '') ? list = ( list + ((list == "") ? "" : ",") + '#'+city) : ' ' ;

        if ($('.hashtags').val()){
            var remainingList;
            var hashtagsList = $('.hashtags').val().split(',');
            if (hashtagsList.length > 5){
                for (var i=5; i<hashtagsList.length; i++){
                    remainingList = (i === 5) ? hashtagsList[i].trim() : remainingList + ', ' + hashtagsList[i].trim();
                }
                list = list + ', ' + remainingList;
            }
        }

        $('.hashtags').val(list);
    }

    function getStringCaptalised(string){
        if (string === 'CIVIC_NEEDS'){
            return 'Civic-Needs';
        } else if (string === 'NON_PROFITS'){
            return 'Non-Profits';
        } else if (string === 'SOCIAL_INNOVATION'){
            return 'Social-Innovation';
        } else if (string === 'NON-PROFIT'){
            return 'Non-Profit';
        } else if (string === 'NGO'){
            return 'NGO';
        } else {
            return string.charAt(0).toUpperCase() + string.toLowerCase().slice(1);
        }
    }

    $('.ansText1').blur(function(){
    	var ansText1 = $(this).val();
    	autoSave('ans1', ansText1);
    });

    $('.ansText2').blur(function(){
    	var ansText2 = $(this).val();
    	autoSave('ans2', ansText2);
    });

    $('.ansText3').blur(function(){
    	var ansText3 = $(this).val();
    	autoSave('ans3', ansText3);
    });

    $('.ansText5').blur(function(){
    	var ansText5 = $(this).val();
    	autoSave('ans5', ansText5);
    });

    $('.ansText6').blur(function(){
    	var ansText6 = $(this).val();
    	autoSave('ans6', ansText6);
    });

    $('.ansText7').blur(function(){
    	var ansText7 = $(this).val();
    	autoSave('ans7', ansText7);
    });

    $('.ansText8').blur(function(){
    	var ansText8 = $(this).val();
    	autoSave('ans8', ansText8);
    });

    $('#deleteVideo').click(function(){
    	if (confirm('Are you sure you want to delete this video')){
    	    autoSave('videoUrl', '');
    	    $('#ytVideo').hide();
            $('#media').show();
            $('#media-video').hide();
            $('.videoUrl').val('');
    	}
    });


    function saveRewards(rewardNum,rewardPrice,rewardTitle,rewardNumberAvailable,rewardDesc,email,address,twitter,custom){
        $.ajax({
        	cache: true,
            type:'post',
            url:$("#b_url").val()+'/project/saveReward',
            data:'projectId='+projectId+'&rewardNum='+rewardNum+'&rewardPrice='+rewardPrice+'&rewardTitle='+rewardTitle+'&rewardNumberAvailable='+rewardNumberAvailable+'&rewardDesc='+rewardDesc+'&email='+email+'&address='+address+'&twitter='+twitter+'&custom='+custom,
            success: function() {
               $('#test').val('test');
            }
        }).error(function() {
        });
     }

     function removeRewards(deleteCount){
         $.ajax({
             type:'post',
             url:$("#b_url").val()+'/project/deleteReward',
             data:'projectId='+projectId+'&rewardCount='+deleteCount,
             success: function() {
                 $('#test').val('test');
             }
         }).error(function() {
         });
     }

     function removeAllPerks(){
         $.ajax({
             type:'post',
             url:$("#b_url").val()+'/project/deleteAllRewards',
             data:'projectId='+projectId,
             success: function() {
                 $('#test').val('test');
             }
         }).error(function() {
         });
    }
    
    function generateSellerId(isCreate) {
    	$('#loading-gif').show();
    	
    	var formDataObj = new FormData();
    	
    	formDataObj.append('projectId', projectId);
    	formDataObj.append('fullName', $("#citrusBeneficiaryname").val());
    	formDataObj.append('email', $("#citrusemail").val());
    	formDataObj.append('branch', $("#citrusBankBranch").val());
    	formDataObj.append('ifscCode', $("#citrusIfscCode").val());
    	formDataObj.append('accountType', $("#citrusAccountType").val());
    	formDataObj.append('accountNumber', $("#citrusAccountNumber").val());
    	formDataObj.append('payoutmode', $("#payoutmode").val());
    	formDataObj.append('mobile', $("#citrusMobile").val());
    	formDataObj.append('address1', $("#citrusAddress1").val());
    	formDataObj.append('address2', $("#citrusAddress2").val());
    	formDataObj.append('city', $("#citrusCity").val());
    	formDataObj.append('zip', $("#citrusZip").val());
    	formDataObj.append("state", $("#citrusState").val())
    	formDataObj.append("country", $("#citrusCountry").val())
        
    	$.ajax({
	    	type    :'post',
	        url     : $("#b_url").val()+'/project/generateSellerId',
	        data    : formDataObj,
	        processData	: false,
	        contentType: false,
	        async: true,
	        success : function(response) {
	        	var jsonObj = JSON.parse(response);
	        	$('#loading-gif').hide();
	        	
	        	// 231 -- valida IfSC code
	        	// 225 -- Seller Mobile already present in the system!!!
	        	
	        	if (jsonObj != undefined && jsonObj.status == "SUCCESS") {
	        		if (isCreate) {
	        			$('#submitProject').attr('disabled','disabled');
		                $('#previewButton').attr('disabled','disabled');
		                $('#submitProjectXS').attr('disabled','disabled');
		                $('#previewButtonXS').attr('disabled','disabled');
	        		} else {
	        			$('#saveButton, #saveButtonXS').attr('disabled','disabled');
	        		}
	        		
	        		$('#campaigncreate').find('form').submit();
	        	
	        	} else {
	        		$('#requiredFieldMessage').html(jsonObj.errorDescription);
	  	  		  	$('#requiredField').modal("show");
	        	}
	        	
	        }
        }).error(function() {
        	$('#loading-gif').hide();
        });
    	
    } 
    
    
    function validateSellerDetails() {
    	$('[name="citrusBeneficiaryname"]').rules( "add", {
            required: true,
            minlength: 5,
            maxlength: 64
        });
    	$('[name="citrusAccountNumber"]').rules( "add", {
            required: true,
            minlength: 10,
            maxlength: 35
        });
    	$('[name="citrusIfscCode"]').rules( "add", {
            required: true,
            minlength: 3,
            maxlength: 11
        });
    	$('[name="payoutmode"]').rules( "add", {
            required: true,
            minlength: 5,
            maxlength: 140
        });
    	$('[name="citrusMobile"]').rules( "add", {
            required: true,
            minlength: 10,
            maxlength: 10
        });
    	$('[name="citrusAddress1"]').rules( "add", {
            required: true,
            minlength: 6,
            maxlength: 64
        });
    	$('[name="citrusAddress2"]').rules( "add", {
            required: true,
            minlength: 6,
            maxlength: 64
        });
    	$('[name="citrusCity"]').rules( "add", {
            required: true,
            minlength: 2,
            maxlength: 64
        });
    	$('[name="citrusZip"]').rules( "add", {
            required: true,
            minlength: 6,
            maxlength: 8
        });
    }
    
    
    function removeSellersValidation() {
    	$('[name="citrusBeneficiaryname"], [name="citrusAccountNumber"],  [name="citrusIfscCode"], [name="payoutmode"], [name="citrusMobile"], [name="citrusAddress1"],[name="citrusAddress2"], [name="citrusCity"],[name="citrusZip"]').each(function () {
            $(this).rules('remove');
            $(this).closest('.form-group').removeClass('has-error');
       });
    }
    
	function resetCitrusDetails() {
		$("#citrusBeneficiaryname").val('');
		$("#citrusemail").val('');
		$("#citrusBankBranch").val('');
		$("#citrusIfscCode").val('');
		$("#citrusAccountType").val('');
		$("#citrusAccountNumber").val('');
		$("#citrusMobile").val('');
		$("#citrusAddress1").val('');
		$("#citrusAddress2").val('');
		$("#citrusCity").val('');
		$("#citrusZip").val('');
	}

     $('#previewButton, #previewButtonXS').on('click', function(){
      	$('#isSubmitButton').val(false);
      	if (isIndianCampaign) {
	       	$('[name="pay"], [name="digitalSign"],  [name="tax-reciept-orgStatus"], [name="tax-reciept-exemptionPercentage"], [name="checkBox"], [name="iconfile"],[name="organizationName"], [name="thumbnail"],[name="answer"], [name="wel"],[name="charitableId"], [name="webAddress"], [name="paypalEmail"], [name = "payuEmail"], [name="citrusEmail"], [name = "days"], [name = "telephone"], [name = "email1"], [name = "email2"], [name = "email3"], [name = "customVanityUrl"],[name="city"],[name="ans1"],[name="ans3"],[name="ans4"],[name="ansText1"],[name="ansText2"],[name="ansText3"],[name="reason1"],[name="reason2"],[name="reason3"],[name="impactNumber"],[name="ein"],[name="tax-reciept-holder-city"],[name="tax-reciept-holder-name"],[name="tax-reciept-holder-state"],[name="tax-reciept-holder-country"],[name="tax-reciept-deductible-status"],[name="reg-date"],[name="addressLine1"],[name="zip"],[name="tax-reciept-registration-num"],[name="expiry-date"],[name="tax-reciept-holder-pan-card"],[name="tax-reciept-holder-phone"],[name="fcra-reg-no"],[name="fcra-reg-date"]').each(function () {
	             $(this).rules('remove');
	             $(this).closest('.form-group').removeClass('has-error');
	        });
      	} else {
      		$('[name="pay"], [name="digitalSign"], [name="checkBox"], [name="iconfile"],[name="organizationName"], [name="thumbnail"],[name="answer"], [name="wel"],[name="charitableId"], [name="webAddress"], [name="paypalEmail"], [name = "payuEmail"], [name = "days"], [name = "telephone"], [name = "email1"], [name = "email2"], [name = "email3"], [name = "customVanityUrl"],[name="city"],[name="ans1"],[name="ans3"],[name="ans4"],[name="ansText1"],[name="ansText2"],[name="ansText3"],[name="reason1"],[name="reason2"],[name="reason3"],[name="impactNumber"],[name="ein"],[name="tax-reciept-holder-city"],[name="tax-reciept-holder-name"],[name="tax-reciept-holder-state"],[name="tax-reciept-holder-country"],[name="tax-reciept-deductible-status"],[name="reg-date"],[name="addressLine1"],[name="zip"],[name="tax-reciept-registration-num"],[name="expiry-date"],[name="tax-reciept-holder-pan-card"],[name="tax-reciept-holder-phone"],[name="fcra-reg-no"],[name="fcra-reg-date"]').each(function () {
	             $(this).rules('remove');
	             $(this).closest('.form-group').removeClass('has-error');
	        });
      	}


        $('.spendAmount').each(function () {
            $(this).rules("remove");
        });

        $('.spendCause').each(function () {
            $(this).rules("remove");
        });

       	$( "#projectImageFile" ).rules("remove");
       	
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
       	
       	if ($("#paymentOpt option:selected").val() == "CITRUS") {
       		removeSellersValidation();
       	}

       	$("#createthumbnail").removeClass('has-error');
       	if (validator.form()) {
       		$('#campaigncreate').find('form').submit();
              $('#submitProject').attr('disabled','disabled');
              $('#previewButton').attr('disabled','disabled');
              $('#submitProjectXS').attr('disabled','disabled');
              $('#previewButtonXS').attr('disabled','disabled');
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
                placement: 'bottom'
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
            content: 'Maximum $200,000, If you want to raise more contact our Crowdfunding Expert.',
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

        $('.cr1-guidence-us').popover({
            content: 'Maximum $100,000, If you want to raise more contact our Crowdfunding Expert.',
            trigger: 'manual',
            placement: 'bottom'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);

        $('.cr1-guidence-indo').popover({
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

});

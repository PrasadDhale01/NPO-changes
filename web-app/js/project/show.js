$(function() {
    console.log('show.js initialized');
    /***************Hide/Show label******************************/
    hideShowLabel();
    changeTeamStatus();
    $('#editimg').hide();
    $('#editTeamImg').hide();

    var currentEnv=$('#currentEnv').val();

    var hash = window.location.hash;
    hash && $('ul.nav a[href="' + hash + '"]').tab('show');
    
    var videoVal = $('#youtubeVideoUrl').val();
    if(videoVal && videoVal.length > 0) {
    	$('.carousel').carousel({
            interval: false
        });
    }

    $('.nav a').click(function (e) {
        $(this).tab('show');
        var scrollmem = $('body').scrollTop();
        window.location.hash = this.hash;
        $('html,body').scrollTop(scrollmem);
    });

    $('#sendmailmodal').find('form').validate({
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
    
    $('.submitForApprovalSection').find('form').validate({
        rules: {
        	submitForApprovalcheckbox : {
        		required: true
        	}
        },
        errorPlacement: function(error, element) {
        	if(element.is(":checkbox")) {
                error.appendTo(element.parent());
            }
        }
    });
    
    $('#submitForApprovalSectionbtm').find('form').validate({
        rules: {
        	submitForApprovalcheckbox1 : {
        		required: true
        	}
        },
        errorPlacement: function(error, element) {
        	if(element.is(":checkbox")) {
                error.appendTo(element.parent());
            }
        }
    });

    /*************************Image upload on tinymce made working ***************************/
    
    $(document).on('focusin', function(e) {
        if ($(e.target).closest(".mce-window").length) {
            e.stopImmediatePropagation();
        }
    });
    
    /**********End***************************************************************************/
    
    $('#inviteTeamMember').find('form').validate({
        rules: {
            username: {
                required: true
            },
            emailIds: {
                required: true,
                validateMultipleEmailsCommaSeparated: true
            },
            socialcontact:{
            	required:true,
            	email:true
            }
        }
    });
    
    $('#commentForm').find('form').validate({
    	rules: {
    		comment: {
    			required: true,
    			maxlength: 5000
    		}
    	}
    });
    
    $('#comments').find('#commentBox').find('form').validate({
    	rules: {
    		comment: {
    			required: true,
    			maxlength: 5000
    		}
    	}
    });
    
    $('#comment-mobile').find('#commentBox').find('form').validate({
    	rules: {
    		comment: {
    			required: true,
    			maxlength: 5000
    		}
    	}
    });
    
    $('#offlineContributionModal').find('form').validate({
        rules: {
            contributorName1: {
                required: true,
                minlength: 3
            },
            amount1: {
                required: true,
                number: true,
                maxlength: 6,
                min: 1
            }
        }
    });
    
    $('.contributionedit').each(function () {
        $(this).find('form').validate({
        	rules: {
        		contributorName: {
                    required: true,
                    minlength: 3
                },
                amount: {
                    required: true,
                    number: true,
                    maxlength: 6,
                    min: 1
                }
        	}
        });
    });
    
    $('#paymentInfo').find('form').validate({
        rules: {
            beneficiaryName: {
                required: true
            },
            branch: {
                required: true
            },
            ifscCode: {
            	required: true,
                minlength: 2
            },
            accountType: {
            	required: true,
                minlength: 2
            },
            accountNumber: {
            	required: true,
                minlength: 2
            }
        }
    });
    
    $('.approvebtn-md, .approvebtn-sm').click(function(event) {
        event.preventDefault();
        var redirectUrl = $(this).attr('href');
        var length = $('input[name="approveChk[]"]:checked').length;
        if (length >= 12) {
            window.location.href = redirectUrl;
        } else {
        	$('#validateChecklistmsg').show();
        	$('#validateChecklistmsg').fadeOut(3000);
        }
    });
    
    $('.redirectCampaign, .redirectCampaignOnPerk a').click(function(event) {
        event.preventDefault();
        var url = $('.redirectUrl a').attr('href');
        var redirectUrl;
        if (currentEnv == 'testIndia') {
            redirectUrl = 'http://test.crowdera.co'+url;
            if (confirm('You are being redirected to our global site www.test.crowdera.co')) {
                window.location.href = redirectUrl;
            }
        } else if(currentEnv == 'stagingIndia') {
            redirectUrl = 'http://staging.crowdera.co'+url;
            if (confirm('You are being redirected to our global site www.staging.crowdera.co')) {
                window.location.href = redirectUrl;
            }
        } else if(currentEnv == 'prodIndia') {
            redirectUrl = 'https://crowdera.co'+url;
            if (confirm('You are being redirected to our global site www.crowdera.co')) {
                window.location.href = redirectUrl;
            }
        }
    });
    
    $('#loadTeamPage').click(function() {
        location.reload(true);
    });
    
    $('.offlineAmount').each(function () {
        $(this).keypress(function (e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $(".contributionerrormsg").html("Digits Only").show().fadeOut("slow");
                return false;
             }
        });
    });
    
    $("#offlineAmount1").keypress(function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            $("#errormsg1").html("Digits Only").show().fadeOut("slow");
            return false;
        }
    });
    
    function validateEmail(field) {
        var regex=/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i;
        return (regex.test(field)) ? true : false;
    }

    $.validator.addMethod('validateMultipleEmailsCommaSeparated', function (value, element) {
        var result = value.split(",");
        for(var i = 0;i < result.length;i++)
        if(!validateEmail(result[i])) 
                return false;    		
        return true;
    },"Please add valid emails only");
    

    /************************Hide/Show comments********************/ 
    $("#uniqueId input[type='checkbox']").click(function(){
       
       if($(this).prop("checked") == true){
            hideShow(this,true);
            hideShowLabel();
        }                        
        else if($(this).prop("checked") == false){
            hideShow(this,false);
            hideShowLabel();
        }
    });
    function hideShowLabel() {
        $('#uniqueId input[type="checkbox"]').each(function(index, value) {
            if ($(this).prop("checked") == true) {
                $('#check'+(index+1)).text(' Show');
            } else {
                $('#check'+(index+1)).text(' Hide');
            }
        });
    }
    function hideShow(checkstat,statusValue)
    {
        var checkId=$(checkstat).val();
        $.ajax({
                type:'post',
                url:$("#b_url").val()+'/project/updatecomment',
                data:'status='+statusValue+'&checkID='+checkId,
                success: function(data){
                $('#test').html(data);
                }
        }).error(function(){
            alert('An error occured');
        });
    }
    
    /***********************Enable or Disable a Team********************************/
    
    $("#teamStatusButton input[type='checkbox']").click(function(){
        
        if($(this).prop("checked") == true){
             enableOrDisableTeam(this,true);
             changeTeamStatus();
         }                        
         else if($(this).prop("checked") == false){
             enableOrDisableTeam(this,false);
             changeTeamStatus();
         }
     });
    
     function changeTeamStatus() {
         $('#teamStatusButton input[type="checkbox"]').each(function(index, value) {
             if ($(this).prop("checked") == true) {
                 $('#checkteam'+(index+1)).text(' Enable');
             } else {
                 $('#checkteam'+(index+1)).text(' Disable');
             }
         });
     }
     
     function enableOrDisableTeam(checkstat,statusValue) {
         var teamId=$(checkstat).val();
         $.ajax({
                 type:'post',
                 url:$("#b_url").val()+'/project/enableOrDisableTeam',
                 data:'teamId='+teamId,
                 success: function(data){
                 $('#test').html(data);
                 }
         }).error(function(){
             alert('An error occured');
         });
     }

    /***********************Youtube url********************************/
     
    $('#youtubeVideoUrl').html(function(i, html) {
    	
    	var regExp = /^https?\/\/.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
    	var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
    	var url= html.trim();
    	var match = (url.match(regExp) || url.match(vimeo));
    	$("#youtubeVideoUrl").hide();
    	if (match && match[2].length == 11) {
            var value = match[2];
            $('#youtube').html('<iframe width="560" height="315" src="//www.youtube.com/embed/' + value + '" frameborder="0" allowfullscreen></iframe>');
        } else if (match && match[2].length == 9){
        	var value = match[2];
            $('#youtube').html('<iframe width="560" height="315" src="https://player.vimeo.com/video/' + value + '" frameborder="0" allowfullscreen></iframe>');
        }
    });
    
    /**************************************Edit team*******************************************/
    
    var validator = $('#editFundraiser').find('form').validate({
        rules: {
            amount: {
                required: true,
                maxlength: 6,
                islessThanProjectAmount : true
            },
            description: {
                required: true,
                minlength: 10,
                maxlength: 140
            },
            story: {
                required: true,
                minlength:10
            },
            videoUrl: {
                isYoutubeVideo: true
            }
        },
        errorPlacement: function(error, element) {
        	if($(element).prop("id") == "projectImageFile") {
        		error.appendTo(document.getElementById("cols-error-placement-team"));
            } else {
        		error.insertAfter(element);
        	}
        }
    });
    
    $('#teamSaveButton').on('click', function() {
        if($('#teamImages').find('#imgdiv').length < 1) {
            $("#projectImageFile").rules( "add", {
                required: true,
                messages: {
                    required: "Please upload at least one team image."
                }
            });
        }

        if (validator.form()) {
            $('#editFundraiser').find('form').submit();
        }
    });
    
    $.validator.addMethod('islessThanProjectAmount', function (value, element) {
    	var amountRaised = value;
        var projectAmount = $("#projectAmount").val();
        if (parseFloat(amountRaised) > parseFloat(projectAmount)) {
        	 return (parseFloat(amountRaised) <= parseFloat(projectAmount)) ? amountRaised : false;
        }
        return true;
    },"Team goal can not be greater than project goal.");
    
    //called when key is pressed in textbox
    $("#teamamount").keypress(function (e) {
           //if the letter is not digit then display error and don't type anything
           if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
               //display error message
               $("#errormsg").html("Digits Only").show().fadeOut("slow");
           return false;
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
    
    /***************************Multiple Image Selection*************** */

    var isvalidsize = false;
    $('#projectImageFile').change(function(event) {
        var file =this.files[0];
        if(validateExtension(file.name) == false){
        	$('.pr-thumbnail-div').hide();
            $('#editimg').show();
            $('#editimg').html("Add only PNG or JPG extension images");
            $('#editTeamImg').hide();
            this.value=null;
            return;
       }
        if(!file.type.match('image')){
            $('.pr-thumbnail-div').hide();
            $('#imgmsg').show();
            $('#editTeamImg').hide();
            this.value=null;
        }else{
            $('#editimg').hide();
            $('#editTeamImg').hide();
            var files = event.target.files; // FileList object
            var fileName;
            var isFileSizeExceeds = false;
            
            var file = this.files[0];
            var filename = file.name;
                
            if(file.size < 1024 * 1024 * 3) {
                if ($('#teamImages').find('.pr-thumb-div').length <= 4){
                isvalidsize =  true;
                $('#uploadingCampaignUpdateEditImage').show();

                var formData = !!window.FormData ? new FormData() : null;
                var name = 'file';
                var teamId = $('[name="teamId"]').val();
                formData.append(name, file);
                formData.append('teamId', teamId);

                var xhr = new XMLHttpRequest();
                xhr.open('POST', $("#b_url").val()+'/project/uploadTeamImage');
                xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
                 
                // complete
                xhr.onreadystatechange = $.proxy(function() {
                    if (xhr.readyState == 4) {
                        var data = xhr.responseText;
                        data = data.replace(/^\[/, '');
                        data = data.replace(/\]$/, '');

                        var json;
                        try {
                            json = (typeof data === 'string' ? $.parseJSON(data) : data);
                        } catch(err) {
                            json = { error: true };
                        }
                        var output = document.getElementById("teamImages");
                        var div = document.createElement("div");
                        div.id = "imgdiv";
                        div.className = "pr-thumb-div"
                        div.innerHTML = "<img  class='pr-thumbnail' src='"+ json.filelink + "'"+ "title='"
                                        + file.name + "'/><div class=\"deleteicon\"><img onClick=\"deleteTeamImage(this,'"+json.imageId+"','"+teamId+"');\" src=\"//s3.amazonaws.com/crowdera/assets/delete.ico\" style=\"margin:2px;width:10px;height:10px;\"/></div>";

                        output.insertBefore(div, null);
                        $('#uploadingCampaignUpdateEditImage').hide();
                    }
                }, this);
                xhr.send(formData);
                
                $('#cols-error-placement-team').find("span").remove();
                $('#cols-error-placement-team').closest(".form-group").removeClass('has-error');
                } else {
                	$('.imageNumValidation').show();
            	    var delay = 5000; //delayed code, time in milliseconds
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
            	$('#editTeamImg').show();
            	isFileSizeExceeds = true;
            }
            
            document.getElementById("editTeamImg").innerHTML= "The file " +fileName+ " you are attempting to upload is larger than the permitted size of 3MB.";
            if (isFileSizeExceeds && !isvalidsize) {
                $('#projectImageFile').val('');
            }
        }
    });
    
    function validateExtension(imgExt) {
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
    
    /*************************Edit video for team*************************/
    
    $('#videoUrl').blur(function(){
    	if (validator.element("#videoUrl")){
           var regExp = /^https?:\/\/.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
           var url= $('#videoUrl').val().trim();
           var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
           var match = (url.match(regExp) || url.match(vimeo));
           if (match && match[2].length == 11) {
               $('#ytVideo').show();
               if (url.indexOf("embed/") > -1){
            	   $('#ytVideo').attr('src',url);
               } else {
                   var vurl=url.replace("watch?v=", "embed/");
                   $('#ytVideo').attr('src',vurl);
               }
           } else if (match && match[2].length == 9){
        	   $('#ytVideo').show();
               var vurl=url.replace("https://vimeo.com/", "https://player.vimeo.com/video/");
               $('#ytVideo').attr('src',vurl);
           }
    	}
      });
    
    /*******************************Show-page-share icons hover***************************/
    $('.show-email').hover(function(){
    	$(this).attr('src',"//s3.amazonaws.com/crowdera/assets/show-original-email-color.png");
    	}).mouseleave(function(){
        $(this).attr('src',"//s3.amazonaws.com/crowdera/assets/show-e-mail-light-gray.png");
    });
    
    $('.show-twitter').hover(function(){
    	$(this).attr('src',"//s3.amazonaws.com/crowdera/assets/show-original-twitter-color.png");
    	}).mouseleave(function(){
        $(this).attr('src',"//s3.amazonaws.com/crowdera/assets/show-twitter-gray.png");
    });
    
    $('.show-like').hover(function(){
    	$(this).attr('src',"//s3.amazonaws.com/crowdera/assets/show-original-like-color.png");
    	}).mouseleave(function(){
        $(this).attr('src',"//s3.amazonaws.com/crowdera/assets/show-like-gray.png");
    });
    
    $('.show-linkedin').hover(function(){
    	$(this).attr('src',"//s3.amazonaws.com/crowdera/assets/show-original-linkedin-color.png");
    	}).mouseleave(function(){
        $(this).attr('src',"//s3.amazonaws.com/crowdera/assets/show-linkedin-gray.png");
    });
    
    $('.show-google').hover(function(){
    	$(this).attr('src',"//s3.amazonaws.com/crowdera/assets/show-original-google-color.png");
    	}).mouseleave(function(){
        $(this).attr('src',"//s3.amazonaws.com/crowdera/assets/show-google-gray.png");
    });
    
    $('.show-embedIcon').hover(function(){
    	$(this).attr('src',"//s3.amazonaws.com/crowdera/user-images/embedicon.png");
    	}).mouseleave(function(){
        $(this).attr('src',"//s3.amazonaws.com/crowdera/assets/embedicon-grey.png");
    });
    
    /*******************************Description text length*********************/
        var counter = 1;
        $('#descarea').on('keydown', function(event) {
            event.altKey==true;
            var currentString = $('#descarea').val().length;
            if (currentString <= 140) {
            	if (currentString == 140) {
            		var text = currentString;
            	} else {
            		var text = currentString + 1;
            	}
            }
            if(currentString >= 4){
                $('.createDescDiv').find("span").remove();
                $('.createDescDiv').closest(".form-group").removeClass('has-error');
            }
            
            if (event.keyCode > 31) {
               if (event.altKey == true) {
                   setDescriptionText();
               } else {
                   currentString++;
                   $('#desclength').text(text+'/140');
               } 
            } else {
               currentString--;
                $('#desclength').text(text+'/140');
            }
        }).keyup(function(e) {
        
            if(e.altKey==true) {
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
        }).focus(function(){
            setDescriptionText();
        }).focusout(function(){
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
        
        /**************************************End of Edit team*******************************************/

    $("#fbshare").click(function(){
        var url = 'http://www.facebook.com/sharer.php?p[url]='+ encodeURIComponent($('#fbShareUrl').val());
        window.open(url, 'Share on FaceBook', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
        return false;
    });
    
    $("#fbshare-mobile, .fbshare-header").click(function(){
        var url = 'http://www.facebook.com/sharer.php?p[url]='+ encodeURIComponent($('#fbShareUrl').val());
        window.open(url, 'Share on FaceBook', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
        return false;
    });
    
    $("a.show-tabs-text").click(function(){
    	$('.choose-error').html('');
    	$(".sh-tabs").find("a.show-tabs-text").removeClass('sh-selected');
    	if ($(this).hasClass('essentials')){
    		$('.essentials').addClass('sh-selected');
    	}
    	if ($(this).hasClass('projectupdates')){
    		$('.projectupdates').addClass('sh-selected');
    	}
    	if ($(this).hasClass('manageTeam')){
    		$('.manageTeam').addClass('sh-selected');
    	}
    	if ($(this).hasClass('contributions')){
    		$('.contributions').addClass('sh-selected');
    	}
    	if ($(this).hasClass('comments')){
    		$('.comments').addClass('sh-selected');
    	}
    	
    	/****manage page*****/
    	if ($(this).hasClass('rewards')){
    		$('.rewards').addClass('sh-selected');
    	}
    	if ($(this).hasClass('payments')){
    		$('.payments').addClass('sh-selected');
    	}
    	if ($(this).hasClass('manageTeams')){
    		$('.manageTeams').addClass('sh-selected');
    	}
    });
    
    $(".twitter-share").click(function(){
        var shareUrl = $('#shareUrl').val();
        if(currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'production' || currentEnv == 'staging'){
            var url = 'https://twitter.com/intent/tweet?text="Check campaign at crowdera.co!"&url='+shareUrl;
        } else {
            var url = 'https://twitter.com/intent/tweet?text="Check campaign at crowdera.in!"&url='+shareUrl;
        }
        window.open(url, 'Share on Twitter', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
        return false;
    });

    /***********************Social contacts******************************************/
    $('.constantContact').click(function(){
        $('.socialProvider').val("constant");
        $('.divSocialContact').show();
        $('#socialContact').val('');
    });
    
	$('.constantContact').hover(function(){
	    $('.constantContact').attr('src', "https://s3.amazonaws.com/crowdera/assets/show-original-email-color.png");
	}).mouseleave(function(){
	    $('.constantContact').attr('src',"https://s3.amazonaws.com/crowdera/assets/show-e-mail-light-gray.png");
	});
	
	$('.gmailContact').hover(function(){
	    $('.gmailContact').attr('src',"https://s3.amazonaws.com/crowdera/assets/show-original-google-color.png");
	}).mouseleave(function(){
	    $('.gmailContact').attr('src',"https://s3.amazonaws.com/crowdera/assets/show-google-gray.png");
	});
    
    
    $('.gmailContact').click(function(){
        $('.socialProvider').val("google");
        $('.divSocialContact').show();
        $('#socialContact').val('');
    });
    $('.mailchimpContact').click(function(){
        $('.socialProvider').val("mailchimp");
        $('.divSocialContact').show();
        $('#socialContact').val('');
    });
    
    $('.socialContact').change(function(){
        var regex=/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i;
        var socialContact= $('.socialContact').val();
        var status =(socialContact.match(regex)) ? true : false;
        if(status==true){
            $('.socialContactDiv').removeClass("has-error");
        }else{
            return false;
        }
    });
    
    $('.btnSocialContacts').click(function(){
        var socialProvider=$('.socialProvider').val();
        var socialContact= $('.socialContact').val();
        if(socialContact==null || socialContact==""){
            $('.socialContactDiv').addClass("has-error");
            $('.socialContact').focus();
        }
        if($('.socialContactDiv').hasClass("has-error")){
            return false;
        }else{
            $.ajax({
                 type:'post',
                 url:$("#b_url").val()+'/project/importSocialContacts',
                 data:'socialProvider='+socialProvider+'&socialContact='+socialContact,
                 success: function(data){
	                 if(data){
		                 $(location).attr("href",data);
    	             }
                 }
            });
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
    $("button[name='contributeButton']").popover({
        content: 'Contributions are not possible to this campaign at this time.',
        trigger: 'manual',
        placement: 'top'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
    
    $('.show-like').popover({
        content: 'Follow this Campaign',
        trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
    
    $('#submitForApprovalBtn, #submitForApprovalBtnMobile').popover({
        content: 'Sorry, you will not be able to submit your campaign for approval, as you have not filled all the required details. Please fill the details and then proceed with the approval.',
        trigger: 'manual',
        placement: 'top'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
    
    $('#submitForApprovalBtnright').popover({
        content: 'Sorry, you will not be able to submit your campaign for approval, as you have not filled all the required details. Please fill the details and then proceed with the approval.',
        trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
    
    $('#endedOfflineContribution').popover({
        content: 'Sine the campaign has been ended, you cannot contribute offline',
        trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);

    $('.shortUrlglyphicon, .shortUrlglyphiconheader').popover({
        html: true,
        placement: 'bottom',
        content: $("#popoverConent,.popoverConent").html()
    });
    
    $('.shortUrlglyphiconMob').popover({
        html: true,
        placement: 'left',
        content: $('#popoverConentMob').html()
    });

    $('.glyphicon-show-link-color').click(function(){
    	if ($(this).hasClass('glyphicon-show-link-color-hover')){
        	$(this).removeClass('glyphicon-show-link-color-hover');
        } else {
        	$(this).addClass('glyphicon-show-link-color-hover');
        }
    });

    $('.shortUrlglyphicon').on('shown.bs.popover', function () {
        var popover = $('.shortUrlglyphicon').data('bs.popover');
        if (typeof popover !== "undefined") {
            var $tip = popover.tip();
          
            $tip.find('.close').bind('click', function () {
            	$('.glyphicon-show-link-color').removeClass('glyphicon-show-link-color-hover');
                popover.hide();
               
            });
        }
    });
    
    $('.shortUrlglyphiconheader').on('shown.bs.popover', function () {
        var popover = $('.shortUrlglyphiconheader').data('bs.popover');
        if (typeof popover !== "undefined") {
            var $tip = popover.tip();
          
            $tip.find('.close').bind('click', function () {
            	$('.glyphicon-show-link-color').removeClass('glyphicon-show-link-color-hover');
                popover.hide();
               
            });
        }
    });
  
    $('.show-mobilejs').find(function(){
        $('.show-mobilejs').css("margin-bottom","20px");
    });
    
    /***Show-details-page-tabs-scroll-code****/
    $('.show-all-icons-header-tabs').click(function(){
    	 var toptabs = $(".show-ids-header").offset().top;
    	 window.scrollTo(toptabs,toptabs);
    });
    
    $( document ).ready(function() {
        function sticky_relocate() {
            var window_top = $(window).scrollTop();
            
            if($("#show-headeridA").length){
            	var div_top = $("#show-headeridA").offset().top; 
            }
            if($(".show-A-fund").length){
            	 var top_fund = $(".show-A-fund").offset().top; 
            }
            if($('.showfacebooksAA').length){
            	 var topFb = $('.showfacebooksAA').offset().top;
            }
            if($('.show-socials-iconsA').length){
            	var topicons = $('.show-socials-iconsA').offset().top;
            }
            
		   
//		    Top header code
            if (window_top > div_top) {
                $('.show1-Primary').addClass('sh-primery-header-padding');
                $('.main-header-gsp').hide();
		        
            } else if(window_top < div_top ){
                $('.show1-Primary').removeClass('sh-primery-header-padding');
                $('.main-header-gsp').show();
            }
            if( window_top > top_fund) {
                $('.show-btn-js').show();
                $('.sh-aproval-btn').show();
            }else if(window_top < top_fund){
                $('.show-btn-js').hide();
                $('.sh-aproval-btn').hide();
            }
//          End Top header
		    
            if(window_top > topFb){
                $('.sh-shareicons-Fixedtophead').show();
            }else  if(window_top < topFb){
                $('.sh-shareicons-Fixedtophead').hide();
            }

//            if( window_top > topicons) {
//                $('.show-headers-icons').show();
//            }else if(window_top < topicons){
//                $('.show-headers-icons').hide();
//            }
        }
        $(window).scroll(sticky_relocate);
        sticky_relocate();
    });
    
    $('.shortUrlglyphiconMob').on('shown.bs.popover', function () {
        var popover = $('.shortUrlglyphiconMob').data('bs.popover');
        if (typeof popover !== "undefined") {
            var $tip = popover.tip();
            zindex = $tip.css('z-index');

            $tip.find('.close').bind('click', function () {
                popover.hide();
            });

            $tip.mouseover(function () {
                $tip.css('z-index', function () {
                    return zindex + 1;
                });
            })
                .mouseout(function () {
                $tip.css('z-index', function () {
                    return zindex;
                });
            });
        }
    });

    $(document).ready(function (){
    	
    	var classActive
    	$('.tab-pane-active').each(function(){
    		if (screen.width >767){
    	        if($(this).hasClass('active')){
    	    	    classActive = $(this).attr('id');
    	    	    $('.'+classActive).addClass('sh-selected');
    	        }
    		} else {
    			if($(this).hasClass('active')){
    	    	    classActive = $(this).attr('id');
    	    	    $('.tab-pane-active').siblings().removeClass('active');
    	    	    if (classActive == 'contributions'){
    	    	    	$('.contributionsMob').addClass('sh-selected');
    	    	    	$('#contributions').addClass('active');
    	    	    } else {
    	    	    	$('.manageTeamMob').addClass('sh-selected');
    	    	    	$('#manageTeam').addClass('active');
    	    	    }
    	        }
    		}
    	});
    	
    	var activeClass
    	$('.mange-pane-active').each(function(){
    		if($(this).hasClass('active')){
    			activeClass = $(this).attr('id');
	    	    $('.'+activeClass).addClass('sh-selected');
	        }
    	});
    	
     /*************************Edit video for team*************************/
        $('.perk-tile').hover(function() {
            $(this).find('.campaignEditDeleteIcon').show();
        });
        $('.perk-tile').mouseleave(function() {
            $(this).find('.campaignEditDeleteIcon').hide();
        });
        
       if(screen.width > 1024 && screen.width < 992)
           $('#screen').val('true');

       if($('#videoUrl').val()){
        	var regExp = /^https?:\/\/.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
        	var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
    	    var url= $('#videoUrl').val().trim();
    	    var match = (url.match(regExp) || url.match(vimeo));
            var vurl
            if (match && match[2].length == 11) {
                vurl=url.replace("watch?v=", "embed/");
                $('#ytVideo').attr('src',vurl);
            } else if (match && match[2].length == 9) {
                vurl=url.replace("https://vimeo.com/", "https://player.vimeo.com/video/");
                $('#ytVideo').attr('src',vurl);
            }
    	    $('#ytVideo').show();
       }else{
          	$('#ytVideo').hide();
       }
       
   	$.ajax( { 
   		url: 'http://ipinfo.io/json', 
   		type: 'POST', 
   		dataType: 'jsonp',
   		success: function(location) {
   			// If the visitor is browsing from India.
   			if (location.country == 'IN' && currentEnv == 'test') {
				$('.info-banner').css('display','block');
				$('.banner-link').text('test.crowdera.in');
				$('.banner-link').attr('href','http://test.crowdera.in');
   			} else if(location.country == 'IN' && currentEnv == 'staging'){
   				$('.info-banner').css('display','block');
   				$('.banner-link').text('staging.crowdera.in');
   				$('.banner-link').attr('href','http://staging.crowdera.in');
   			} else if(location.country == 'IN' && currentEnv == 'production'){
   				$('.info-banner').css('display','block');
   				$('.banner-link').text('www.crowdera.in');
   				$('.banner-link').attr('href','http://crowdera.in');
   			} else if(location.country == 'IN' && currentEnv == 'development'){
   				$('.info-banner').css('display','block');
   				$('.banner-link').text('www.crowdera.in');
   				$('.banner-link').attr('href','http://localhost:8080');
   				if($(window).width() < 768){
   					$('#preview-banner').css('margin-top','-33px');
   				}
   			}
   		}
   	});
   	$('.banner-close').click(function(){
   		$('.info-banner').css('display','none');
   		$('.home-header-section').removeClass('banner-nav');
   		$('#preview-banner').attr('class','preview-banner-margin');
   	});
       

    $('.video-play').click(function() {
    	$('.choose-error').html('');
        $('.video-play').siblings().removeClass('selected');
        $(this).addClass('selected');
    });

    var embedTileUrl = $('#embedTileUrl').val();

    $('.video-play-sm').click(function (){
    	var embedCode = '<iframe src="'+embedTileUrl+'" width="480px" height="360px" frameborder="0" scrolling="no"></iframe>'
    	$('.textarea-embed-video').val(embedCode);
    	$('.video-play-width').val('480');
    	$('.video-play-height').val('360');
    });

    $('.video-play-md').click(function (){
    	var embedCode = '<iframe src="'+embedTileUrl+'" width="640px" height="480px" frameborder="0" scrolling="no"></iframe>'
    	$('.textarea-embed-video').val(embedCode);
    	$('.video-play-width').val('640');
    	$('.video-play-height').val('480');
    });

    $('.video-play-lg').click(function (){
    	var embedCode = '<iframe src="'+embedTileUrl+'" width="800px" height="600px" frameborder="0" scrolling="no"></iframe>'
    	$('.textarea-embed-video').val(embedCode);
    	$('.video-play-width').val('800');
    	$('.video-play-height').val('600');
    });

    $('.video-play-width').change(function (){
    	var width = $(this).val();
    	var height = $('.video-play-height').val();
    	var embedCode = '<iframe src="'+embedTileUrl+'" width="'+width+'" height="'+height+'" frameborder="0" scrolling="no"></iframe>'
    	$('.textarea-embed-video').val(embedCode);
    });

	$('.video-play-height').change(function (){
		var width = $('.video-play-width').val();
		var height = $(this).val();
    	var embedCode = '<iframe src="'+embedTileUrl+'" width="'+width+'" height="'+height+'" frameborder="0" scrolling="no"></iframe>'
    	$('.textarea-embed-video').val(embedCode);
	});

       
   });
});

function showNavigation(){
	var indicator = document.getElementById('indicators');
	var nav= document.getElementById('navigators');
	var updateIndicator = document.getElementById('updateindicators');
	var updateNav= document.getElementById('updatenavigators');
	
	if(indicator!=null && nav!=null){
		document.getElementById('indicators').style.display = 'block';
		document.getElementById('navigators').style.display = 'block';
	}
	if(updateIndicator!=null && updateNav!=null){
		document.getElementById('updateindicators').style.display = 'block';
		document.getElementById('updatenavigators').style.display = 'block';
	}
}

function hideNavigation(){
	var indicator = document.getElementById('indicators');
	var nav= document.getElementById('navigators');
	var updateIndicator = document.getElementById('updateindicators');
	var updateNav= document.getElementById('updatenavigators');
	
	if(indicator!=null && nav!=null){
		document.getElementById('indicators').style.display = 'none';
		document.getElementById('navigators').style.display = 'none';
	}
	
	if(updateIndicator!=null && updateNav!=null){
		document.getElementById('updateindicators').style.display = 'none';
		document.getElementById('updatenavigators').style.display = 'none';
	}	
}

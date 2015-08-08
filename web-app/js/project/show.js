  $(function() {
    console.log('show.js initialized');
    /***************Hide/Show label******************************/
    hideShowLabel();
    changeTeamStatus();
    $('#editimg').hide();
    $('#editTeamImg').hide();

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
    
    $('#commentBox').find('form').validate({
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
    
    $('.redirectCampaign a').click(function(event) {
        event.preventDefault();
        var url = $('.redirectUrl a').attr('href');
        var redirectUrl;
        var currentEnv = $('#currentEnv').val();
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
    	
    	var regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
    	var url= html.trim();
    	var match = url.match(regExp);
    	$("#youtubeVideoUrl").hide();
    	
    	if (match && match[2].length == 11) {
            var value = match[2];
            $('#youtube').html('<iframe width="560" height="315" src="//www.youtube.com/embed/' + value + '" frameborder="0" allowfullscreen></iframe>');
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
                minlength:10,
                maxlength: 5000
            },
            videoUrl: {
                isYoutubeVideo: true
            }
        },
        errorPlacement: function(error, element) {
        	if($(element).prop("id") == "projectImageFile") {
                error.appendTo(element.parent().parent());
            } else{
        		error.insertAfter(element);
        	}
        }
    });
    
    $('#teamSaveButton').on('click', function() {
    	var storyValue = $('.redactorEditor').redactor('code.get');
        var storyEmpty = false;
        if (storyValue == '' || storyValue == undefined){
            $('#storyRequired').show();
            storyEmpty = true;
        } else {
            $('#storyRequired').hide();
            storyEmpty = false;
        }
        
        if($('#teamImages').find('#imgdiv').length < 1) {
            $("#projectImageFile").rules( "add", {
                required: true,
                messages: {
                    required: "Please upload at least one team image."
                }
            });
        }

        if (validator.form() && !storyEmpty) {
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
           var p = /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
           return (value.match(p)) ? RegExp.$1 : false;
        }
        return true;
     }, "Please upload a url of Youtube video");
    
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
                        });
                    // Read the image
                    picReader.readAsDataURL(file);
                } else {
                	if (fileName) {
                	    fileName = fileName +" "+ file.name;
                	} else {
                		fileName = file.name;
                	}
                	$('#editTeamImg').show();
                	isFileSizeExceeds = true;
                }
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
    
    $('#videoUrl').change(function(){
           var regExp = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
           var url= $('#videoUrl').val().trim();
           var match = url.match(regExp);
         
           if (match && match[2].length == 11) {
               $('#ytVideo').show();
               var vurl=url.replace("watch?v=", "embed/");
               $('#ytVideo').attr('src',vurl);
           }else if($(this)){
               $('#ytVideo').hide();
           }
      });
    
    /*******************************Description text length*********************/
        var counter = 1;
        $('#descarea').on('keydown', function(event) {
            event.altKey==true;
            var currentString = $('#descarea').val().length;
            if(currentString <=139) {
                var text = currentString + 1;
            }
            if (event.keyCode > 31) {
               if(event.altKey==true){
                   setDescriptionText();
               } else {
                   currentString++;
                   $('#desclength').text(text);
               } 
            } else {
               currentString--;
                $('#desclength').text(text);
            }
        }).keyup(function(e) {
        
            if(e.altKey==true){
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
                $('#desclength').text("0");
            } else {
                currentString = currentString;
                $('#desclength').text(currentString);
            }
        }
        
        /**************************************End of Edit team*******************************************/
    
    $("#fbshare").click(function(){
        var url = 'http://www.facebook.com/sharer.php?p[url]='+ encodeURIComponent($('#fbShareUrl').val());
        window.open(url, 'Share on FaceBook', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
        return false;
    });
    
    $("#twitterShare").click(function(){
        var url = 'https://twitter.com/share?text=Check campaign at crowdera.co!';
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

    /* Initialize pop-overs (tooltips) */
    $("button[name='contributeButton']").popover({
        content: 'Contributions are not possible to this campaign at this time.',
        trigger: 'manual',
        placement: 'top'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
    
    $('#add-campaign-supporter').popover({
        content: 'Follow this Campaign',
        trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
    
    
    $(document).ready(function (){
     /*************************Edit video for team*************************/
       var videoStatus=$('#videoUrl').val();
       if(videoStatus){
        	var regExp = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
    	    var url= $('#videoUrl').val().trim();
    	    var match = url.match(regExp);
    	    if (match && match[2].length == 11) {
    	       $('#ytVideo').show();
    	       var vurl=url.replace("watch?v=", "embed/");
    	       $('#ytVideo').attr('src',vurl);
    	    }else if($(this)){
    	       $('#ytVideo').hide();
    	    }
       }else{
          	$('#ytVideo').hide();
       }
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

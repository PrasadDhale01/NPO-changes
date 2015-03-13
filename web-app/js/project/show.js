$(function() {
    console.log('show.js initialized');
    /***************Hide/Show label******************************/
    hideShowLabel();
    changeTeamStatus();
    $('#editimg').hide();
    $('#ytVideo').hide();

    var hash = window.location.hash;
    hash && $('ul.nav a[href="' + hash + '"]').tab('show');

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
    
    $('#inviteTeamMember').find('form').validate({
    	rules: {
    		userName: {
    			required: true
    		},
   		emailIds: {
    			required: true,
    			validateMultipleEmailsCommaSeparated: true
    		}
    	}
    });
    
    $('#editFundraiser').find('form').validate({
    	rules: {
    		amount: {
    			required: true,
    			maxlength: 5,
    			islessThanProjectAmount : true
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
                number: true
            },
            amount2: {
                number: true
            },
            amount3: {
                number: true
            }
        }
    });
    
    $('.contributionedit').find('form').validate({
    	rules: {
    		contributorName: {
                required: true,
                minlength: 3
            },
            amount: {
                required: true,
                number: true
            }
    	}
    });

    $("#offlineAmount").keypress(function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            $("#errormsg").html("Digits Only").show().fadeOut("slow");
            return false;
        }
    });
    $("#offlineAmount1").keypress(function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            $("#errormsg1").html("Digits Only").show().fadeOut("slow");
            return false;
        }
    });
    $("#offlineAmount2").keypress(function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            $("#errormsg2").html("Digits Only").show().fadeOut("slow");
            return false;
        }
    });
    $("#offlineAmount3").keypress(function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            $("#errormsg3").html("Digits Only").show().fadeOut("slow");
            return false;
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
    },"please add valid emails only");

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
                 $('#check'+(index+1)).text(' Enable');
             } else {
                 $('#check'+(index+1)).text(' Disable');
             }
         });
     }
     
     function enableOrDisableTeam(checkstat,statusValue)
     {
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
    
    /** *************************Multiple Image Selection*************** */

    $('#projectImageFile').change(function(event) {
        var file =this.files[0];
        if(!file.type.match('image')){
            $('.pr-thumbnail-div').hide();
            $('#imgmsg').show();
            this.value=null;
        }else{
            $('#imgmsg').hide();
            var files = event.target.files; // FileList object
            var output = document.getElementById("result");
            for ( var i = 0; i < files.length; i++) {
                var file = files[i];
                var filename = file.name;
                var picReader = new FileReader();
                picReader.addEventListener("load",function(event) {
                    var picFile = event.target;
                    var div = document.createElement("div");
                    div.innerHTML = "<div id=\"imgdiv\" class=\"pr-thumbnail-div\"><img  class='pr-thumbnail' src='"+ picFile.result+ "'"+ "title='"
                        + file.name + "'/><div class=\"deleteicon\"><img onClick=\"$(this).parents('#imgdiv').remove();\" src=\"/images/delete.ico\" style=\"margin:2px;width:10px;height:10px;\"/></div>"+ "</div>";
                        output.insertBefore(div, null);
                    });
                // Read the image
                picReader.readAsDataURL(file);
            }
        }
    });
    
    /*************************Edit video for team*************************/
    
    $('#videoUrl').focus(function(){
        var regExp = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
           var url= $('#videoUrl').val().trim();
           var match = url.match(regExp);
         
           if (match && match[2].length == 11) {
               $('#ytVideo').show();
               var vurl=url.replace("watch?v=", "v/");
               $('#ytVideo').attr('src',vurl);
           }else if($(this).val('')){
               $('#ytVideo').hide();
           }
      }).change(function(){
           var regExp = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
           var url= $('#videoUrl').val().trim();
           var match = url.match(regExp);
         
           if (match && match[2].length == 11) {
               $('#ytVideo').show();
               var vurl=url.replace("watch?v=", "v/");
               $('#ytVideo').attr('src',vurl);
           }else if($(this).val('')){
               $('#ytVideo').hide();
           }
      });

});

function showNavigation(){
	document.getElementById('indicators').style.display = 'block';
	document.getElementById('navigators').style.display = 'block';
}

function hideNavigation(){
	document.getElementById('indicators').style.display = 'none';
	document.getElementById('navigators').style.display = 'none';
}

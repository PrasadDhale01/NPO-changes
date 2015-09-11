$(function() {
	console.log("create.js initialized");

    $('#paypalemail').hide();
    $('#charitableId').hide();

	/* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });

    /* Validate form on submit. */
    var validator = $('#campaignedit').find('form').validate({
        rules: {
            days: {
                required: true
            },
            title: {
                required: true,
                minlength: 5,
                maxlength: 140
            },
            description: {
                required: true,
                minlength: 10,
                maxlength: 140
            },
            videoUrl: {
                isYoutubeVideo: true
            },
            organizationName: {
                required: true
            },
            webAddress: {
            	isWebUrl: true,
            	required: true
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
            paypalEmail: {
            	required: true,
            	email:true,
                isPaypalEmailVerified : true
            },
            charitableId: {
            	required: true
            },
            pay: {
            	required: true
            }
        },
        messages:{
            thumbnail: "Please upload a thumbnail image for project",
        },
        errorPlacement: function(error, element) {
        	if ( element.is(":radio") || element.is(":checkbox")) {
        		error.appendTo(element.parent().parent());
        	} else if($(element).prop("id") == "projectImageFile" || $(element).prop("id") == "amount") {
                error.appendTo(element.parent().parent());
            } else if($(element).prop("id") == "orgediticonfile") {
                error.appendTo(element.parent().parent());
            } else{
        		error.insertAfter(element);
        	}
        }//end error Placement
    });
    
    $('.editUpdateForm').find('form').validate({
        rules: {
        	title: {
        		required: true
        	}
        }
    });

    $('#editsubmitbutton').on('click', function() {
        var storyValue = $('.redactorEditor').redactor('code.get');
        var storyEmpty = false;
        if (storyValue == '' || storyValue == undefined){
            $('#storyRequired').show();
            storyEmpty = true;
        } else {
            $('#storyRequired').hide();
            storyEmpty = false;
        }

    	var currentEnv = $('#currentEnv').val();
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
    		$("#projectImageFile").rules( "add", {
                required: true,
                messages: {
                    required: "Please upload at least one campaign image."
                }
            });
    	}
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
            $("[name='amount']").rules("add", {
                required: true,
                number: true,
                min: 5000,
                maxlength: 6,
                max: 999999
            });
        }else {
            $("[name='amount']").rules("add", {
                required: true,
                number: true,
                maxlength: 6,
                max: 999999
            });
        }
    	if (validator.form()) {
    		needToConfirm = false;
            if (!storyEmpty){
                $('#campaignedit').find('form').submit();
            }
    	}
    });
    
    $.validator.addMethod('isPaypalEmailVerified', function (value, element) {
        var ack = $("#paypalEmailAck").val();
        if(ack == 'Failure') {
            return (ack == 'Success') ? ack : false;
        }
        return true;
    }, "Please enter verified paypal email id");

    $('form').submit(function(){
    	if($('.editForm').valid()){
    		$('#editsubmitbutton').attr('disabled','disabled');
    	}
    });
    
    $('.updatesubmitbutton, .updatesubmitbuttonXS').click(function(event) {
        needToConfirm = false;
    });
    
    $.validator.addMethod('isYoutubeVideo', function (value, element) {
        if(value && value.length !=0){
           var p = /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
           return (value.match(p)) ? RegExp.$1 : false;
        }
        return true;
    }, "Please upload a url of Youtube video");

    /** ********************Organization Icon*************************** */

    $("#orgediticonfile").on("change", function() {
        var file =this.files[0];
        if(validateExtension(file.name) == false){
            this.value=null;
            $('#editlogo').show();
            $('#editlogo').html("Add only PNG or JPG extension image");
            $('#iconfilesize').hide();
            return;
        }
        if(!file.type.match('image')){
           this.value=null;
           $('#editlogo').show();
           $('#iconfilesize').hide();
        }else{
            if (file.size > 1024 * 1024 * 3) {
                $('#editlogo').hide();
                $('#iconfilesize').show();
                $('#imgIcon').hide();
                $('#logoDelete').hide();
                $('#orgediticonfile').val('');
            } else {
                $('#editlogo').hide();
                $('#iconfilesize').hide();
                var file = this.files[0];
                var fileName = file.name;
                var fileSize = file.size;

                var picReader = new FileReader();
                picReader.addEventListener("load", function(event) {
                    var picFile = event.target;
                    $('#imgIcon').attr('src', picFile.result);
                    $('#logoDelete').attr('src', "//s3.amazonaws.com/crowdera/assets/delete.ico");
                    $('#imgIcon').show();
                    $('#logoDelete').show();

                });
                // Read the image
                picReader.readAsDataURL(file);
            }
        }
    });
    
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

    $('#videoUrl').focus(function(){
       var regExp = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
          var url= $('#videoUrl').val().trim();
          var match = url.match(regExp);
        
          if (match && match[2].length == 11) {
              $('#ytVideo').show();
              var vurl=url.replace("watch?v=", "v/");
              $('#ytVideo').attr('src',vurl);
          }else if($(this)){
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
          }else if($(this)){
              $('#ytVideo').hide();
          }
     });

     //called when key is pressed in textbox
     $("#amount").keypress(function (e) {
            //if the letter is not digit then display error and don't type anything
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                //display error message
                $("#errormsg").html("Digits Only").show().fadeOut("slow");
            return false;
        } 
     });
     $.validator.addMethod('isWebUrl', function(value, element){
         if(value && value.length !=0){
            var p= /(?:(?:www):\/\/)?(?:www.)\/?/;
            return (value.match(p))
         }
         return true;
     }, "Please provide valid url");
     
    /***************************Multiple Image Selection*************** */
    var isvalidsize =  false;
    $('#projectImageFile').change(function(event) {
        var file =this.files[0];
        if(validateExtension(file.name) == false){
          	$('.pr-thumbnail-div').hide();
            $('#editimg').show();
            $('#editimg').html("Add only PNG or JPG extension images");
            $('#campaignfilesize').hide();
            this.value=null;
            return;
        }
        if(!file.type.match('image')){
            $('.pr-thumbnail-div').hide();
            $('#editimg').show();
            $('#campaignfilesize').hide();
            this.value=null;
        }else{
        	$('#editimg').hide();
        	$('#campaignfilesize').hide();
        	var fileName;
            var isFileSizeExceeds = false;
            var files = event.target.files; // FileList object
            var output = document.getElementById("result");
            for ( var i = 0; i < files.length; i++) {
                var file = files[i];
                var filename = file.name;
                if (file.size < 1024 * 1024 * 3) {
                	isvalidsize =  true;
                    var picReader = new FileReader();
                    picReader.addEventListener("load",function(event) {
                        var picFile = event.target;
                        var div = document.createElement("div");
                        div.innerHTML = "<div id=\"imgdiv\" class=\"pr-thumbnail-div\"><img  class='pr-thumbnail' src='"+ picFile.result + "'" + "title='" + file.name
                                      + "'/><div class=\"deleteicon\"><img onClick=\"$(this).parents('#imgdiv').remove();\" src=\"//s3.amazonaws.com/crowdera/assets/delete.ico\" style=\"margin:2px;width:10px;height:10px;\"/></div>"
                                      + "</div>";
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
    
    $("#addProjectImage").click(function() {
        $("#updateImageFile").click();
    });
    
    var isvalidsizefile =  false;
    $('#updateImageFile').change( function(event) {
        var file= this.files[0];
        if(validateExtension(file.name) == false){
        	$('#imgupdatemsg').show();
        	$('#imgupdatemsg').html("Add only PNG or JPG extension images");
            $('.pr-thumbnail-div').hide();
            $('#updatefilesize').hide();
            this.value=null;
            return;
        }
        if(!file.type.match('image')){
            $('#imgupdatemsg').show();
            $('.pr-thumbnail-div').hide();
            $('#updatefilesize').hide();
            this.value=null;
        }else{
            $('#imgupdatemsg').hide();
            $('#updatefilesize').hide();
            var files = event.target.files;
            var output = document.getElementById("result");
            var fileName;
            var isFileSizeExceeds = false;
            
            for ( var i = 0; i < files.length; i++) {
                var file = files[i];
                var filename = file.name;
    
                if(file.size < 1024 * 1024 * 3) {
                    if (!file.type.match('image'))
                        continue;
                    isvalidsizefile = true;
                    var picReader = new FileReader();
                    picReader.addEventListener("load",function(event) {
                        var picFile = event.target;
                        var div = document.createElement("div");
                        div.innerHTML = "<div id=\"imgdiv\" class=\"pr-thumbnail-div pull-left\"><img  class='pr-thumbnail' src='"+ picFile.result+ "'"+ "title='"+ file.name
                                         + "'/><div class=\"deleteicon\"><img onClick=\"$(this).parents('#imgdiv').remove();\" src=\"//s3.amazonaws.com/crowdera/assets/delete.ico\" style=\"width:10px;height:10px;\"/></div>"
                                         + "</div>";

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
                	$('#updatefilesize').show();
                	isFileSizeExceeds = true;
                }
            }
            document.getElementById("updatefilesize").innerHTML= "The file " +fileName+ " you are attempting to upload is larger than the permitted size of 3MB.";
            if (isFileSizeExceeds && !isvalidsizefile) {
                $('#updateImageFile').val('');
            }
        }
    });
    
    $('#paypalEmailId').change(function(){
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
    });
    
    /***************************Multiple Image Selection for Edit Campaign Updates*************** */
    var isvalidsize =  false;
    $('#projectUpdateImageFile').change(function(event) {
        var file =this.files[0];
        if(!file.type.match('image')){
            $('.pr-thumbnail-div').hide();
            $('#editUpdateimg').show();
            $('#campaignUpdatefilesize').hide();
            this.value=null;
        }else{
        	$('#editUpdateimg').hide();
        	$('#campaignUpdatefilesize').hide();
        	var fileName;
            var isFileSizeExceeds = false;
            var files = event.target.files; // FileList object
            for ( var i = 0; i < files.length; i++) {
                var file = files[i];
                var filename = file.name;
                if (file.size < 1024 * 1024 * 3) {
                	isvalidsize =  true;
                	$('#uploadingUpdateEditImage').show();

                    var formData = !!window.FormData ? new FormData() : null;
                    var name = 'file';
                    var projectUpdateId = $('[name="projectUpdateId"]').val();
                    formData.append(name, file);
                    formData.append('projectUpdateId', projectUpdateId);

                    var xhr = new XMLHttpRequest();
                    xhr.open('POST', $("#b_url").val()+'/project/uploadUpdateEditImage');
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
                            var output = document.getElementById("projectUpdateImageDiv");
                            var div = document.createElement("div");
                            div.id = "imgdiv";
                            div.className = "pr-thumb-div"
                            div.innerHTML = "<img  class='pr-thumbnail' src='"+ json.filelink + "'"+ "title='"
                                            + file.name + "'><div class=\"deleteicon\"><img onClick=\"deleteProjectImage(this,'"+json.imageId+"','"+projectUpdateId+"');\" src=\"//s3.amazonaws.com/crowdera/assets/delete.ico\" style=\"margin:2px;width:10px;height:10px;\"></div>";

                            output.insertBefore(div, null);
                            $('#uploadingUpdateEditImage').hide();
                        }
                    }, this);
                    xhr.send(formData);
                	
                } else {
                	if (fileName) {
                	    fileName = fileName +" "+ file.name;
                	} else {
                		fileName = file.name;
                	}
                	$('#campaignUpdatefilesize').show();
                	isFileSizeExceeds = true;
                }
            }
            document.getElementById("campaignUpdatefilesize").innerHTML= "The file " +fileName+ " you are attempting to upload is larger than the permitted size of 3MB.";
            if (isFileSizeExceeds && !isvalidsize) {
                $('#projectUpdateImageFile').val('');
            }
        }
    });
    
    /*Validation for campaign admin*/
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
    
    /*******************************Description text length******************** */
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
    }
    else{
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
  } 
  else {
    currentString = currentString;
    $('#desclength').text(currentString);
  }
}

/*******************************Title text length******************** */
var counter = 1;
$('#campaignTitle').on('keydown', function(event) {

event.altKey==true;
var currentstring = $('#campaignTitle').val().length;
if(currentstring <=99) {
    var text = currentstring + 1;
}
if (event.keyCode > 31) {
  if(event.altKey==true){
  	setTitleText();
  }
  else{
	  if(currentstring <99)
		currentstring++;
      $('#titleLength').text(text);
  }

} else {
	  currentstring--;
      $('#titleLength').text(text);
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

function setTitleText(){
 
var currentstring = $('#campaignTitle').val().length;
if (currentstring == 0) {
  $('#titleLength').text("0");
} 
else {
	  currentstring = currentstring;
  $('#titleLength').text(currentstring);
}
}
  

});

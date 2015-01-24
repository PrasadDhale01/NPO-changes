$(function() {
	console.log("create.js initialized");
	
    $('#ytVideo').hide();
    $('#imgmsg').hide();
    $('#imgupdatemsg').hide();
	/* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });
    
    /* Validate form on submit. */
    var validator = $('form').validate({
        rules: {
            amount: {
                required: true,
                number: true,
                maxlength: 5,
                max: 50000
            },
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
            /*story: {
                required: true,
                minlength: 10,
                maxlength: 5000
            },*/
            /*videoUrl: {
                isYoutubeVideo: true
            },*/
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
            }
        },
        messages:{
            thumbnail: "Please upload a thumbnail image for project",
            iconfile: "Please upload your organization logo"
        },
        errorPlacement: function(error, element) {
        	if ( element.is(":radio") || element.is(":checkbox")) {
        		error.appendTo(element.parent().parent());
        	}else{
        		error.insertAfter(element);
        	}
        }//end error Placement
    });

    /** ********************Organization Icon*************************** */

    $('#chooseFile').click(function(event) {
        event.preventDefault();
        $('#iconfile').trigger('click');
    });

    $("#iconfile").on("change", function() {
        var file =this.files[0];
        if(!file.type.match('image')){
           this.value=null;
        }else{
        var file = this.files[0];
        var fileName = file.name;
        var fileSize = file.size;

        var picReader = new FileReader();
        picReader.addEventListener("load", function(event) {
            var picFile = event.target;
            $('#imgIcon').attr('src', picFile.result);
            $('#delIcon').attr('src', "/images/delete.ico");
            $('#imgIcon').show();
            $('#logoDelete').show();

        });
        // Read the image
        picReader.readAsDataURL(file);
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

     $.validator.addMethod('isWebUrl', function(value, element){
         if(value && value.length !=0){
            var p= /(?:(?:www):\/\/)?(?:www.)\/?/;
            return (value.match(p))
         }
         return true;
     }, "Please provide valid url");

    /***************************Multiple Image Selection*************** */

    $("#add_img_btn").click(function() {
        $("#projectImageFile").click()
    });

    $('#projectImageFile').change(function(event) {
                        var file =this.files[0];
                        if(!file.type.match('image')){
                            $('#imgmsg').show();
                            $('.pr-thumbnail-div').hide();
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

                                                var div = document
                                                        .createElement("div");
                                                div.innerHTML = "<div id=\"imgdiv\" class=\"pr-thumbnail-div\"><img  class='pr-thumbnail' src='"
                                                        + picFile.result
                                                        + "'"
                                                        + "title='"
                                                        + file.name
                                                        + "'/><div class=\"deleteicon\"><img onClick=\"$(this).parents('#imgdiv').remove();\" src=\"/images/delete.ico\" style=\"margin:2px;width:10px;height:10px;\"/></div>"
                                                        + "</div>";

                                                output.insertBefore(div, null);
                            });
                            // Read the image
                            picReader.readAsDataURL(file);
                          }
                        }
    });
    
    $("#addProjectImage").click(function() {
        $("#updateImageFile").click()
    });
    
    $('#updateImageFile').change( function(event) {
      var file= this.files[0];
      if(!file.type.match('image')){
        $('#imgupdatemsg').show();
        $('.pr-thumbnail-div').hide();
        this.value=null;
      }else{
        $('#imgupdatemsg').hide();
        var files = event.target.files;
        var output = document.getElementById("result");
        for ( var i = 0; i < files.length; i++) {
            var file = files[i];
            var filename = file.name;

            if (!file.type.match('image'))
              continue;
            var picReader = new FileReader();
            picReader.addEventListener("load",function(event) {
                var picFile = event.target;
                var div = document.createElement("div");
               div.innerHTML = "<div id=\"imgdiv\" class=\"pr-thumbnail-div pull-left\"><img  class='pr-thumbnail' src='"+ picFile.result+ "'"+ "title='"+ file.name
                    + "'/><div class=\"deleteicon\"><img onClick=\"$(this).parents('#imgdiv').remove();\" src=\"/images/delete.ico\" style=\"width:10px;height:10px;\"/></div>"
                    + "</div>";

                output.insertBefore(div, null);
            });
            // Read the image
            picReader.readAsDataURL(file);
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
  

});

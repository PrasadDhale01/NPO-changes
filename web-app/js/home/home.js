$(function() {
	$('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });
	$('#attachmentfilesize').hide();
	
	var validator = $('#contactUs').find('form').validate({
        rules: {
        	subject: {
        		required: true,
                minlength: 5
            },
            helpDescription: {
                required: true,
                minlength: 10
            },
            firstAndLastName: {
                required: true
            },
            emailAddress: {
            	required: true,
            	email: true
            }
        }
    });
	
	$('#imageCarouselForm').find('form').validate({
	    rules: {
	        name: {
	    	    required: true,
	            minlength: 2
             },
             username: {
            	 required: true,
                 minlength: 2,
                 email: true
             },
             password: {
                 required: true
             },
             confirmPassword: {
            	 required: true,
                 isEqualToPassword: true
              }
	    },
	    messages: {
	    	 name: {
	    		required: ""
             },
             username: {
            	 required: ""
             },
             password: {
            	 required: ""
             },
             confirmPassword: {
            	 required: ""
             }
	    },
	    showErrors: function(errorMap, errorList) {
	        $(".form-signin").find("input").each(function() {
	            $(this).closest('.imageCoureselFormGroup').removeClass('has-error');
	            $(".errormessage").empty();
	        });
	        if(errorList.length) {
	        	if (screen.width > 640)
	                $(".errormessage").html(errorList[0]['message']);
	            $(errorList[0]['element']).closest('.imageCoureselFormGroup').addClass('has-error');
	        }
	    }
    });
	
	$.validator.addMethod('isEqualToPassword', function (value, element) {
            var confirmpassword = value;
            var password = $("#password").val();
            if(confirmpassword != password) {
                return (confirmpassword == password) ? password : false;
            }
            return true;
        }, "Passwords do not match! Please enter a valid password.");
	
	$('#contactsubmitbutton').click(function(event) {
	    if(validator.form()){
	    	needToConfirm = false;
	    }
	});
	
	var isvalidsize =  false;
	$('#attachments').change(function(event) {
        var files = event.target.files; // FileList object
        var output = document.getElementById("result");
        var fileName;
        var isFileSizeExceeds = false;
        $('#attachmentfilesize').hide();
        
        var x = document.querySelectorAll("#attachmentId");
        for (var i = 0; i < x.length; i++) {
        	$("#attachmentId").remove();
        }
        for ( var i = 0; i < files.length; i++) {
            var file = files[i];
            var filename = file.name;
            if(file.size < 1024 * 1024 * 3) {
            	isvalidsize =  true;
                var div = document.createElement("div");
                div.id = 'attachmentId';
                div.innerHTML = "<div class='attachment-div'>"+filename+"</div><div class='clear'></div>";
                output.insertBefore(div, null);
            } else {
            	if (fileName) {
            	    fileName = fileName +" "+ file.name;
            	} else {
            		fileName = file.name;
            	}
            	$('#attachmentfilesize').show();
            	isFileSizeExceeds = true;
            }
        }
        document.getElementById("attachmentfilesize").innerHTML= "The file " +fileName+ " you are attempting to upload is larger than the permitted size of 3MB.";
        if (isFileSizeExceeds && !isvalidsize) {
            $('#attachments').val('');
        }
    });
	
});

$(window).load(function() {
    /*
    $('.blacknwhite').BlackAndWhite({
        hoverEffect: true, // default true
        // set the path to BnWWorker.js for a superfast implementation
        webworkerPath: false,
        // for the images with a fluid width and height
        responsive: false,
        // to invert the hover effect
        invertHoverEffect: false,
        // this option works only on the modern browsers ( on IE lower than 9 it remains always 1)
        intensity: 1,
        speed: { // this property could also be just speed: value for both fadeIn and fadeOut
            fadeIn: 100, // 200ms for fadeIn animations
            fadeOut: 100 // 800ms for fadeOut animations
        },
        onImageReady: function(img) {
            // this callback gets executed anytime an image is converted
        }
    });
    */
});

//$('#carousel-example').carousel({
//    interval: 5000
//});

function showNavigation(){
	document.getElementById('indicators').style.display = 'block';
	document.getElementById('navigators').style.display = 'block';
}

function hideNavigation(){
	document.getElementById('indicators').style.display = 'none';
	document.getElementById('navigators').style.display = 'none';
}

$( document ).ready(function() {
	var fb = $('#fbUser-login').val();
	if (fb) {
	    if (confirm('It looks like you already have another account with same email. Would you like to merge the accounts?')) {
		    window.location.href =$("#b_url").val()+"/login/facebook_login/?userResponse=yes";
	    } else {
		    window.location.href =$("#b_url").val()+"/logout";
	    }
	}
});

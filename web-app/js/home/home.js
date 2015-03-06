$(function() {
	$('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });
	
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
	
	$('form').validate({
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

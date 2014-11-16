$(function() {
	console.log("create.js initialized");
	
	/* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });
	
	if($('input[id="firstadmin"]').val()) {
    	$('input[id="firstadmin"]').prop('disabled', true);
    };
    
    if($('input[id="secondadmin"]').val()) {
    	$('input[id="secondadmin"]').prop('disabled', true);
    };
    
    if($('input[id="thirdadmin"]').val()) {
    	$('input[id="thirdadmin"]').prop('disabled', true);
    };
    
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
                required: true,
                number: true,
                max: 365
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
            story: {
                required: true,
                minlength: 10,
                maxlength: 5000
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
            	validateMultipleEmailsCommaSeparated: true
            },
            email2: {
            	validateMultipleEmailsCommaSeparated: true
            },
            email3: {
            	validateMultipleEmailsCommaSeparated: true
            }
        },
        messages:{
            thumbnail: "Please upload a thumbnail image for project",
            textfile: "Please upload your Letter of Determination",
            iconfile: "Please upload your Organization icon"
        },
        errorPlacement: function(error, element) {
        	if ( element.is(":radio") || element.is(":checkbox")) {
        		error.appendTo(element.parent().parent());
        	}else{
        		error.insertAfter(element);
        	}
        }//end error Placement
    });
    
    $.validator.addMethod('validateMultipleEmailsCommaSeparated', function (value, element) {
    	  
        if(value && value.length !=0){
       	 var reg=/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i;
            return (value.match(reg))
        }
        return true;
    }, "Please provide valid Email Id");
    
});

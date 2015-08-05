$(function() {
    console.log("user.js initialized");
    $('#uploadProfilesize').hide();
    $('#uploadProfileImg').hide();
    
    $('#editProfilesize').hide();
    $('#editProfileImg').hide();
    
    var validator = $('#validpass').find('form').validate({
        rules: {
        	firstName: {
        		maxlength: 20
        	},
        	lastName: {
        		maxlength: 20
        	},
        	password: {
                minlength: 6
            },
    		confirmPassword: {
		        isEqualToPassword: true
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
    
    $("#uploadavatar").click(function() {
        $("#avatar").click();
    });
    
    $('#avatar').change( function(event) {
    	var file =this.files[0];
	    if(!file.type.match('image')){
	        $('#uploadProfilesize').hide();
	        $('#uploadProfileImg').show();
	        this.value=null;
	    } else{
	        if (file.size > 1024 * 1024 * 3) {
	        	$('#uploadProfilesize').show();
		        $('#uploadProfileImg').hide();
	            $('#avatar').val('');
	        } else {
	        	$('#uploadProfilesize').hide();
		        $('#uploadProfileImg').hide();
                        $("#uploadbutton").click();
	        }
	    } 
    });
    
    $("#editavatarbutton").click(function() {
        $("#editavatar").click();
    });
    
    $('#editavatar').change( function(event) {
    	var file =this.files[0];
	    if(!file.type.match('image')){
	        $('#editProfilesize').hide();
	        $('#editProfileImg').show();
	        this.value=null;
	    } else{
	        if (file.size > 1024 * 1024 * 3) {
	        	$('#editProfilesize').show();
		        $('#editProfileImg').hide();
	                $('#editavatar').val('');
	        } else {
	        	$('#editProfilesize').hide();
		        $('#editProfileImg').hide();
		        $("#editbutton").click();
	        }
	    } 
    });
    
    $("#applicantfile").change(function(event) {
        var file =this.files[0];
        if(validateExtension(file.name) == false){
	        $('#applicantOutput').hide();
	        $("#applicantfilesize").show();
        	$("#applicantfilesize").html("Only text,docx and pdf files are allowed.");
	        this.value=null;
	        return;
	    }
	    else{
	        if (file.size > 1024 * 1024 * 3) {
	            $('#applicantOutput').hide();
	            $('#applicantfilesize').show();
	            $("#applicantfilesize").html("The file \"" +file.name+ "\" you are attempting to upload is larger than the permitted size of 3MB.");
	            $('#applicantfile').val('');
	        } else {
                $('#applicantOutput').show();
                $('#applicantfilesize').hide();
                $("#applicantOutput").html(""+file.name);
                
	        }
	    } 
    });
    
    $('#redirectCampaign a, #redirectCampaignTitle a').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var redirectUrl;
        var currentEnv = $('#currentEnv').val();
        if (currentEnv == 'testIndia') {
            redirectUrl = 'http://test.crowdera.co'+url;
        } else if(currentEnv == 'stagingIndia') {
            redirectUrl = 'http://staging.crowdera.co'+url;
        } else if(currentEnv == 'prodIndia') {
            redirectUrl = 'https://crowdera.co'+url;
        } else {
            redirectUrl = url;
        }
        if (confirm('You are being redirected to global site www.crowdera.co')) {
            window.location.href = redirectUrl;
        } else {
            window.location.href = url;
        }
    });
    
	function validateExtension(imgExt) {
        var allowedExtensions = new Array("txt","docx","doc","pdf");
        for(var imgExtImg=0;imgExtImg<allowedExtensions.length;imgExtImg++)
        {
            imageFile = imgExt.lastIndexOf(allowedExtensions[imgExtImg]);
            if(imageFile != -1){
    	        return true;
            }
        }
        return false;
	}

    /* Show pop-over tooltip on hover for some fields. */
    var showPopover = function () {
        $(this).popover('show');
    },
    hidePopover = function () {
        $(this).popover('hide');
    };

    /* Initialize pop-overs (tooltips) */
    $("button[name='editproject']").popover({
        content: 'ACCESS DENIED',
        trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);

    /* Initialize pop-overs (tooltips) */
    $("button[name='projectpreview']").popover({
        content: 'ACCESS DENIED',
        trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
});

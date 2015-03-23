$(function() {
    console.log("user.js initialized");
    
    var validator = $('#validpass').find('form').validate({
        rules: {
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
    	$("#uploadbutton").click();
    });
    
    $("#editavatarbutton").click(function() {
        $("#editavatar").click();
    });
    
    $('#editavatar').change( function(event) {
    	$("#editbutton").click();
    });

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

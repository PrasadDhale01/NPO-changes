$(function() {
    console.log("user.js initialized");
    $('#uploadProfilesize').hide();
    $('#uploadProfileImg').hide();
    
    $('#editProfilesize').hide();
    $('#editProfileImg').hide();
    
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

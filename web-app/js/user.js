$(function() {
    console.log("user.js initialized");
    
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
});

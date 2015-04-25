$(function() {
    console.log("Crowdera is up");

    // Decode the blog post HTML so that <p></p> gets recognized.
    var text = $('.blogpost h4').html();
    var decoded = $('<div/>').html(text).text();
    $('.blogpost h4').html(decoded);

    // override jquery validate plugin defaults to suit Twitter Bootstrap
    $.validator.setDefaults({
        highlight: function(element) {
            $(element).closest('.form-group').addClass('has-error');
        },
        unhighlight: function(element) {
            $(element).closest('.form-group').removeClass('has-error');
        },
        errorElement: 'span',
        errorClass: 'help-block',
        errorPlacement: function(error, element) {
            if(element.parent('.input-group').length) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        }
    });
    
//    $('#projectDetailsImage'+$('#id').val()).click(function (e) {
//    	$('.projectDetailsForm'+$('#id').val()).submit();
//    });
    
  /*  $('.twittersocialicon').hover(function(){
    	$(this).attr('src',"/images/twitter-over.png");
    	}).mouseleave(function(){
        $(this).attr('src',"/images/s3.png");
    });
    $('.facebooklink').hover(function(){
    	$(this).attr('src',"/images/Facebook-over.png");
    	}).mouseleave(function(){
        $(this).attr('src',"/images/s2.png");
    });
    $('.insta').hover(function(){
    	$(this).attr('src',"/images/instagram-over.png");
    	}).mouseleave(function(){
        $(this).attr('src',"/images/s5.png");
    });
    $('.blog').hover(function(){
    	$(this).attr('src',"/images/Blog-over.png");
    	}).mouseleave(function(){
        $(this).attr('src',"/images/s1.png");
    });
    $('.inlink').hover(function(){
    	$(this).attr('src',"/images/Linked-in-over.png");
    	}).mouseleave(function(){
        $(this).attr('src',"/images/s4.png");
    }); */
});

function clickableImage(image) {
	$(image).closest('.projectDetailsForm').submit();
}

function clickableTitle(title){
	$(title).closest('.projectTitleDetailsForm').submit();
}

function manageProjectImageClickable(element){
	$(element).closest('.manageProjectForm').submit();
}

function teamsClickableImage(images){
	$(images).closest('.teamsMangageForm').submit();
}

function teamsManageProjectTitleClickable(element1){
	$(element1).closest('.teamsManageProjectForm').submit();
}

function manageProjectTitleClickable(element2){
	$(element2).closest('.manageProjectTitleForm').submit();
}

function showTitleClickable(titleShow){
	$(titleShow).closest('.showTitleForm').submit();
}

function manageProjectTitleClickable(titlemanageProject){
	$(titlemanageProject).closest('.manageProjectTitleForm').submit();
}

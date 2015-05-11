$(function() {
    console.log("Crowdera is up");
    
    $(document).ready(function() { 
    	$("#mc-embedded-subscribe-form-lg").validate({ 
    	   rules: { 
    	    EMAIL: {// compound rule 
    		          required: true, 
    		          email: true 
    	    		} 
    	   }, 
    	   messages: { 
    	    email: "" 
    	   } 
    	});
    	$("#mc-embedded-subscribe-form-md").validate({ 
     	   rules: { 
     	    EMAIL: {// compound rule 
     		          required: true, 
     		          email: true 
     	    		} 
     	   }, 
     	   messages: { 
     	    email: "" 
     	   } 
     	}); 
    	$("#mc-embedded-subscribe-form-sm").validate({ 
     	   rules: { 
     	    EMAIL: {// compound rule 
     		          required: true, 
     		          email: true 
     	    		} 
     	   }, 
     	   messages: { 
     	    email: "" 
     	   } 
     	}); 
    		      
    }); 
    
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

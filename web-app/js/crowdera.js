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
    	
    	var validator = $('form').validate({
            rules: {
                firstName: {
                    minlength: 2,
                    required: true
                },
                lastName: {
                    minlength: 2,
                    required: true
                },
                resume: {
                	required: true
                },
                email: {
                    required: true,
                    email: true
                },
                letterDescriptions: {
                	required: true
                },
                crewDescriptions: {
                	required: true
                }
            },
            messages:{
            	resume: "Please upload your Resume"
            },
            errorPlacement: function(error, element) {
                if($(element).prop("id") == "resumefile") {
                    error.appendTo(element.parent().parent());
                }else{ 
                    error.insertAfter(element);
                }
            },
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
    
    $(document).ready(function(){
        
        $('#hover-cap-4col .the-crews').hover(
            function(){
                $(this).find('.crew-icons').fadeIn(250); 
            },
            function(){
                $(this).find('.crew-icons').fadeOut(205);
            }
        );    
     
    });    
    
    var isvalidsize =  false;
	$('#resumefile').change(function(event) {
        var files = event.target.files; // FileList object
        var output = document.getElementById("result");
        var fileName;
        var isFileSizeExceeds = false;
        $('#resumefilesize').hide();
        
        var x = document.querySelectorAll("#resumefileId");
        for (var i = 0; i < x.length; i++) {
        	$("#resumefileId").remove();
        }
        for ( var i = 0; i < files.length; i++) {
            var file = files[i];
            var filename = file.name;
            if(file.size < 1024 * 1024 * 3) {
            	isvalidsize =  true;
                var div = document.createElement("div");
                div.id = 'resumefileId';
                div.innerHTML = "<div class='resumefile-div'>"+filename+"</div><div class='clear'></div>";
                output.insertBefore(div, null);
            } else {
            	if (fileName) {
            	    fileName = fileName +" "+ file.name;
            	} else {
            		fileName = file.name;
            	}
            	$('#resumefilesize').show();
            	isFileSizeExceeds = true;
            }
        }
        document.getElementById("resumefilesize").innerHTML= "The file " +fileName+ " you are attempting to upload is larger than the permitted size of 3MB.";
        if (isFileSizeExceeds && !isvalidsize) {
            $('#resumefile').val('');
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

$(function() {
    console.log("Crowdera is up");
    
    $('#resumefilesize').hide();
    $('#resultOutput').hide();
    $('.search-box').hide();
    
    $('.trigger').click(function() {
    	var slider_width = $('#hiddensearch').width();
    	var isAnimated = $(".search-box").is(':animated');
    	if (isAnimated) {
            $(".search-box").animate({width: "0px"});
            var delay = 300;
            setTimeout(function() {
                $('.search-box').hide();
                $('.discover').show();
                $('.learn').show();
            }, delay);
            $('.search-image-header').css('paddingRight', '40px');
        } else {
            $('.search-box').show();
            $('.discover').hide();
            $('.learn').hide();
            $(".search-box").animate({width: slider_width},function(){
                $(this).focus(); // For bonus, the input will now get autofocus
            });
            $('.search-image-header').css('paddingRight', '20px');
        }
    });
    
    $('.trigger-mob').click(function() {
    	var slider_width = $('#hiddensearch').width();
    	var isAnimated = $(".search-box").is(':animated');
    	if (isAnimated) {
//            $(".search-box").animate({width: "0px"});
            var delay = 300;
            setTimeout(function() {
                $('.search-box').hide();
                if($(window).width() < 430){
                	$('.scrollHeaderLogo').fadeIn();
                }
            }, delay);
        } else {
            $('.search-box').show();
            if($(window).width() < 430){
            	$('.scrollHeaderLogo').hide();
            }
            
            $(".search-box").animate({"width": "174px","z-index":"10000","right":"40px"}, function(){
                $(this).focus(); // For bonus, the input will now get autofocus
            });
        }
    });
    
    $('.search-box').blur(function() {
         $(this).animate({width: "0px"});
         var delay = 300;
         setTimeout(function() {
        	 $('.search-box').hide();
        	 $('.discover').show();
             $('.learn').show();
             if($(window).width() < 430){
             	$('.scrollHeaderLogo').fadeIn();
             }
         }, delay);
//         $('.search-image-header').css('paddingRight', '40px');
    });
    
    $(document).ready(function() { 
	    
    	$("#mvc-embedded-subscribe-form-lg").validate({ 
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
    	
    	var validator = $('#myCrewDetails').find('form').validate({
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
                phone: {
                    required: true,
                    isValidTelephoneNumber: true,
                    maxlength: 20,
                    minlength: 8
                },
                letterDescriptions: {
                    required: true,
                    maxlength: 250
                },
                crewDescriptions: {
                    required: true,
                    maxlength: 140
                }
            },
            messages:{
            	resume: "Please upload your Resume"
            },
            errorPlacement: function(error, element) {
                if($(element).prop("id") == "resumefile") {
                    error.appendTo(element.parent().parent());
                }else if($(element).prop("id") == "resumefilesize") {
                    error.appendTo(element.parent().parent());
                }else{ 
                    error.insertAfter(element);
                }
            },
        });
    	
//    	var images = ['//s3.amazonaws.com/crowdera/assets/create-Button-blue.jpg', '//s3.amazonaws.com/crowdera/assets/create-Button-Green-desk.jpg', '//s3.amazonaws.com/crowdera/assets/create-Button-yellow-desk.jpg'];
//    	var imagessm = ['//s3.amazonaws.com/crowdera/assets/create-Button-blue-tab.jpg', '//s3.amazonaws.com/crowdera/assets/create-Button-Green-tab.jpg', '//s3.amazonaws.com/crowdera/assets/create-Button-yellow-tab.jpg'];
    	
//    	var time = setInterval(function() {
//    	          var newImage = images[Math.floor(Math.random()*images.length)];
//    	          var newSmImage = imagessm[Math.floor(Math.random()*imagessm.length)];
//    	          $('#createButton').attr('src', newImage);
//    	          $('#createButton-sm').attr('src', newSmImage);
//    	   },7000);
    	
   /************************On search click ScrollHeader******************************************/
    	$('.scrolltrigger').click(function(){
    	    $(this).css("display","block");
    	    var slider_width = $('.search-barr').width();
    	    if(slider_width > 0 ){
    	        $('.scrolltrigger').attr("src","https://s3.amazonaws.com/crowdera/assets/header-search-icon.png");
    	    }
    	});

    	$(document).mousemove(function(){
    		searchBoxStatus();
    	});
	    
    	function searchBoxStatus(){
    	    var scrollHdr_status = $('.search-barr').width();
    	    var noScrollHdr_status = $('.search-bar').width();
    	    if(noScrollHdr_status > 0){
                $('.scrolltrigger').attr("src","https://s3.amazonaws.com/crowdera/assets/search-icon.png");
    	    }
    	    if(scrollHdr_status > 0){
    	        $('.scrolltrigger').attr("src","https://s3.amazonaws.com/crowdera/assets/header-search-icon.png");
    	    }
    	}
        
    	/*****************On dropdown hover*************************/
    	$('.toggleImages').hover(function(){
    	    $('.user-cl-scrollHeader').css("background","url(https://s3.amazonaws.com/crowdera/assets/dropdown-arrow-White.png)");
    	    $('.user-cl-scrollHeader').css("background-repeat","no-repeat");
    	}).mouseleave(function(){
    	    $('.user-cl-scrollHeader').css("background","url(https://s3.amazonaws.com/crowdera/assets/dropdown-arrow-White.png)");
    	    $('.user-cl-scrollHeader').css("background-repeat","no-repeat");
    	});
    	
		var $win = $(window);
        $win.scroll(function () {
        	if($(window).width() > 767){
			    if ($win.scrollTop() == 0){
				    $('.noScrollHeader').fadeIn("slow");
				    $('.scrollHeader').fadeOut("slow");
				    $('.search-bar').css("width","0");
			    }else{
				    $('.noScrollHeader').fadeOut("slow");
				    $('.scrollHeader').fadeIn("slow");
				    $('.search-barr').css("width","0");
			    }
        	}
        	
        	if($(window).width() < 767){
		    	 if ($win.scrollTop() == 0){
				    //$('.noScrollHeader').css("display","none");
				    $('.mobile-fixedHeader').css("display","block");
				    $('.scrollHeader').css("display","none");
				    $('.search-bar').css("width","0");
				    $('.feduoutercontent').css('margin-top','120px');
				 }else{
				    //$('.noScrollHeader').css("display","none");
					$('.mobile-fixedHeader').css("display","none");
				    $('.scrollHeader').css("display","block");
				    $('.search-barr').css("width","0");
				    $('.feduoutercontent').css('margin-top','40px');
				 }
		    }
        });
        
        /**************On hamburger click**********************************/
		$('.toggle-MobileHeader').click(function(){
		    $('.mobile-fixedHeader').css("display","none");
		    $('.scrollHeader').css("display","block");
		    $('#TW-navbar-collapse').fadeIn();
		    $('.feduoutercontent').css('margin-top','50px');
		});

        $('.user-cl-scrollHeader').css("background","url(https://s3.amazonaws.com/crowdera/assets/dropdown-arrow-White.png)");
        $('.user-cl-scrollHeader').css("background-repeat","no-repeat");
        
        /************************************************************************************************************************/
  	
    }); 
    
    $.validator.addMethod('isValidTelephoneNumber', function (value, element) {
        if(value && value.length !=0){
            var reg = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;
            return (value.match(reg)) ? RegExp.$1 : false;
        }
        return true;
    }, "Please provide valid phone number");
    
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
        
        $('.hover-cap-4col .the-crews').hover(
            function(){
                $(this).find('.crew-icons').fadeIn(250); 
            },
            function(){
                $(this).find('.crew-icons').fadeOut(205);
            }
        );
        
        if($(window).width() < 767){
		  $('.feduoutercontent').css('margin-top','120px');
	    }
     
    });    
	
	$("#resumefile").change(function(event) {
        var file =this.files[0];
        if(validateExtension(file.name) == false){
	        $('#resultOutput').hide();
	        $("#resumefilesize").show();
        	$("#resumefilesize").html("Only text,docx and pdf files are allowed.");
	        this.value=null;
	        return;
	    }
	    else{
	        if (file.size > 1024 * 1024 * 3) {
	            $('#resultOutput').hide();
	            $('#resumefilesize').show();
	            $("#resumefilesize").html("The file \"" +file.name+ "\" you are attempting to upload is larger than the permitted size of 3MB.");
	            $('#resumefile').val('');
	        } else {
                $('#resultOutput').show();
                $('#resumefilesize').hide();
                $("#resultOutput").html(""+file.name);
                
	        }
	    } 
    });
    
	$('#hamburger-toggle').click(function(){
		$('#TW-navbar-collapse').toggle();
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
	
    $('.display-footer-text').hover(function(){
		var url=$('#b_url').val();
		$('.footer-start-cmpg-img').attr('src','https://s3.amazonaws.com/crowdera/assets/Start-a-Campaign---Button-Over.jpg');
		$('.display-footer-text').attr('href',url+'/campaign/create');
	}).mouseleave(function(){
		$('.footer-start-cmpg-img').attr('src','https://s3.amazonaws.com/crowdera/assets/Hands-up-for-a-better - button.jpg');
		$('.display-footer-text').attr('href','#');
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

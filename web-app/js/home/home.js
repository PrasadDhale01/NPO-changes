$(function() {
	$('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });
	$('#attachmentfilesize').hide();
	
	$('#icon-bar-1').removeClass('icon-bar')
	$('#icon-bar-2').removeClass('icon-bar')
	$('#icon-bar-3').removeClass('icon-bar')
	$('#icon-bar-1').addClass('icon-bar-home')
	$('#icon-bar-2').addClass('icon-bar-home')
	$('#icon-bar-3').addClass('icon-bar-home')
	
	if(screen.width < 768){
		$('#scrolltrigger').attr('src','//s3.amazonaws.com/crowdera/assets/search-icon-white-1a.png');
		
        $.post("/mobile_campaigns", function(data){
            $('#campaignsId').html(data);
        });
	}
	
    if(screen.width > 768){
        $.post("/desktop_campaigns", function(data){
            $('#campaignsId').html(data);
        });
    }
	
	
	
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
	
	$('#imageCarouselForm').find('form').validate({
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
	
	var isvalidsize =  false;
	$('#attachments').change(function(event) {
        var files = event.target.files; // FileList object
        var output = document.getElementById("result");
        var fileName;
        var isFileSizeExceeds = false;
        $('#attachmentfilesize').hide();
        
        var x = document.querySelectorAll("#attachmentId");
        for (var i = 0; i < x.length; i++) {
        	$("#attachmentId").remove();
        }
        for ( var i = 0; i < files.length; i++) {
            var file = files[i];
            var filename = file.name;
            if(file.size < 1024 * 1024 * 3) {
            	isvalidsize =  true;
                var div = document.createElement("div");
                div.id = 'attachmentId';
                div.innerHTML = "<div class='attachment-div'>"+filename+"</div><div class='clear'></div>";
                output.insertBefore(div, null);
            } else {
            	if (fileName) {
            	    fileName = fileName +" "+ file.name;
            	} else {
            		fileName = file.name;
            	}
            	$('#attachmentfilesize').show();
            	isFileSizeExceeds = true;
            }
        }
        document.getElementById("attachmentfilesize").innerHTML= "The file " +fileName+ " you are attempting to upload is larger than the permitted size of 3MB.";
        if (isFileSizeExceeds && !isvalidsize) {
            $('#attachments').val('');
        }
    });
	
	$('.mobile-header-onmain').css("margin-top","-52px");
	
    $('#customer-support-btn').click(function() {
    	var slider_width = $('#support').width();//get width automaticly
        //check if slider is collapsed
        var is_collapsed = $(this).css("margin-right") == slider_width+"px" && !$(this).is(':animated');
        //minus margin or positive margin
        var sign = (is_collapsed) ? '-' : '+'; 
        if(!$(this).is('')) { //prevent double margin on double click
            $('.willSlide').animate({"margin-right": sign+'='+slider_width},"slow","linear");
        }
    
    });
    
    $( document ).ready(function() {
    	
    	/*********************Call loadwhycrowderacallback function***************************************/
    	loadWhyCrowderaCallback();
    	
    	/*************call loadMediaStrip function***********************/
    	loadMediaStrip();
    	
        function sticky_relocate() {
        	var window_top = $(window).scrollTop();
        	if($('.hm-image-header').length){
        		var image_header = $('.hm-image-header').offset().top;
        	}
        	
        	var _opened = $("#TW-navbar-collapsed").hasClass("collapse in");
            if (_opened == true) {
                $("button.navbar-toggle").click();
            }
        	
        	if (window_top < image_header) {
        		$('#opacityremove').removeClass('TW-scrollHeaderBackColor');
        		$('#opacityremove').removeClass('navbar-default');
        		$('.navbar-toggle.TW-scrollHeader-hamBurger .icon-bar').css('background-color','#fff !important');
        		
        		if ($('#icon-bar-1').hasClass('icon-bar-xs')) {
        			$('#icon-bar-1').addClass('icon-bar-home')
        			$('#icon-bar-2').addClass('icon-bar-home')
        			$('#icon-bar-3').addClass('icon-bar-home')
        			$('#icon-bar-1').removeClass('icon-bar-xs')
        			$('#icon-bar-2').removeClass('icon-bar-xs')
        			$('#icon-bar-3').removeClass('icon-bar-xs')
        			$('#scrolltrigger').attr('src','//s3.amazonaws.com/crowdera/assets/search-icon-white-1a.png');
        		}
               
        	}else if (window_top > image_header) {
        		$('#opacityremove').addClass('TW-scrollHeaderBackColor','navbar-default');
        		$('#opacityremove').addClass('navbar-default');
        		$('.navbar-toggle.TW-scrollHeader-hamBurger .icon-bar').css('background-color','#000 !important');
        		
        		if ($('#icon-bar-1').hasClass('icon-bar-home')) {
        			$('#icon-bar-1').removeClass('icon-bar-home')
        			$('#icon-bar-2').removeClass('icon-bar-home')
        			$('#icon-bar-3').removeClass('icon-bar-home')
        			$('#icon-bar-1').addClass('icon-bar-xs')
        			$('#icon-bar-2').addClass('icon-bar-xs')
        			$('#icon-bar-3').addClass('icon-bar-xs')
        			$('#scrolltrigger').attr('src','//s3.amazonaws.com/crowdera/assets/search-icon.png');
        		}
        	}
        	
        }
        $(window).scroll(sticky_relocate);
        sticky_relocate();
        
        $(document).click(function (event) {
            var clickover = $(event.target);
            var _opened = $("#TW-navbar-collapsed").hasClass("collapse in");
            if (_opened == true && !clickover.hasClass("navbar-toggle")) {
                $("button.navbar-toggle").click();
            }
        });
        
    });
    
});

$('.hm-js-hover1').hover(function(){
    $('.hm-media-1').attr('src',"//s3.amazonaws.com/crowdera/assets/times-of-india-1-gray.png");
    }).mouseleave(function(){
    $('.hm-media-1').attr('src',"//s3.amazonaws.com/crowdera/assets/times-of-india-2-colour.png");
});
$('.hm-js-hover2').hover(function(){
    $('.hm-media-2').attr('src',"//s3.amazonaws.com/crowdera/assets/canada-govt-colour.png");
 	}).mouseleave(function(){
    $('.hm-media-2').attr('src',"//s3.amazonaws.com/crowdera/assets/canada-govt-white.png");
});
$('.hm-js-hover3').hover(function(){
    $('.hm-media-3').attr('src',"//s3.amazonaws.com/crowdera/assets/yahoo-finance-colour-samll-2.png");
    }).mouseleave(function(){
    $('.hm-media-3').attr('src',"//s3.amazonaws.com/crowdera/assets/yahoo-finance-white-samll-1.png");
});
$('.hm-js-hover4').hover(function(){
    $('.hm-media-4').attr('src',"//s3.amazonaws.com/crowdera/assets/crowdfund-insider-colour-samll-2.png");
    }).mouseleave(function(){
    $('.hm-media-4').attr('src',"//s3.amazonaws.com/crowdera/assets/crowdfund-insider-white-samll-1.png");
});
$('.hm-js-hover5').hover(function(){
    $('.hm-media-5').attr('src',"//s3.amazonaws.com/crowdera/assets/broadway2-colour.png");
    }).mouseleave(function(){
    $('.hm-media-5').attr('src',"//s3.amazonaws.com/crowdera/assets/broadway1-gray.png");
});
$('.hm-js-hover6').hover(function(){
    $('.hm-media-6').attr('src',"//s3.amazonaws.com/crowdera/assets/crowdfund-beat-colour-samll-2.png");
    }).mouseleave(function(){
    $('.hm-media-6').attr('src',"//s3.amazonaws.com/crowdera/assets/crowdfund-beat-white-samll-1.png");
});
$('.hm-js-hover7').hover(function(){
    $('.hm-media-7').attr('src',"//s3.amazonaws.com/crowdera/assets/midday-colour-samll-2.png");
    }).mouseleave(function(){
    $('.hm-media-7').attr('src',"//s3.amazonaws.com/crowdera/assets/midday-white-samll-1.png");
});
$('.hm-js-hover8').hover(function(){
    $('.hm-media-8').attr('src',"//s3.amazonaws.com/crowdera/assets/media-your-story-colour-small-size.png");
    }).mouseleave(function(){
    $('.hm-media-8').attr('src',"//s3.amazonaws.com/crowdera/assets/media-your-story-gray-small-size.png");
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
    var indi = document.getElementById('indicators');
    var navi = document.getElementById('navigators');
    var home_indi = document.getElementById('home_indicators');
    var home_navi = document.getElementById('home_navigators');
    
    if(indi !=null && navi !=null){
        document.getElementById('indicators').style.display = 'block';
        document.getElementById('navigators').style.display = 'block';
    }
    
    if(home_indi !=null && home_navi !=null){
        document.getElementById('home_indicators').style.display = 'block';
        document.getElementById('home_navigators').style.display = 'block';
    }
}

function hideNavigation(){
    var indi = document.getElementById('indicators');
    var navi = document.getElementById('navigators');
    var home_indi = document.getElementById('home_indicators');
    var home_navi = document.getElementById('home_navigators');
    
    if(indi !=null && navi !=null){
        document.getElementById('indicators').style.display = 'none';
        document.getElementById('navigators').style.display = 'none';
    }
    
    if(home_indi !=null && home_navi !=null){
        document.getElementById('home_indicators').style.display = 'none';
        document.getElementById('home_navigators').style.display = 'none';
    }
}

$( document ).ready(function() {
	var fb = $('#fbUser-login').val();
	if (fb) {
	    if (confirm('It looks like you already have another account with same email. Would you like to merge the accounts?')) {
		    window.location.href =$("#b_url").val()+"/login/facebook_login/?userResponse=yes";
	    } else {
		    window.location.href =$("#b_url").val()+"/user/logout";
	    }
	}

	var googlePlus = $('#googlPlusUser-login').val();
    var email = $('#userEmail').val();
	if (googlePlus) {
	    if (confirm('It looks like you already have another account with same email. Would you like to merge the accounts?')) {
		    window.location.href =$("#b_url").val()+"/login/googlePlusAccountsMerge/?userResponse=yes&email="+email;
	    } else {
		    window.location.href =$("#b_url").val()+"/user/logout";
	    }
	}

	var contributorEmail = $('#contributorEmail').val();
	if(contributorEmail){
		alert('Receipt has been sent over email to '+contributorEmail);
	}

	var currentEnv=$('#currentEnv').val();
	$.ajax( { 
		url: 'http://ipinfo.io/json', 
		type: 'POST', 
		dataType: 'jsonp',
		success: function(location) {
			// If the visitor is browsing from India.
			if (location.country== 'IN' && currentEnv == 'test') {
			// Tell him about the India.
					$('.info-banner').css('display','block');
					$('.banner-link').text('test.crowdera.in');
					$('.banner-link').attr('href','http://test.crowdera.in');
					$('.home-header-section').addClass('banner-nav');
			}else if(location.country == 'IN' && currentEnv == 'staging'){
				$('.info-banner').css('display','block');
				$('.banner-link').text('staging.crowdera.in');
				$('.banner-link').attr('href','http://staging.crowdera.in');
				$('.home-header-section').addClass('banner-nav');
			}else if(location.country== 'IN' && currentEnv == 'production'){
				$('.info-banner').css('display','block');
				$('.banner-link').text('www.crowdera.in');
				$('.banner-link').attr('href','http://crowdera.in');
				$('.home-header-section').addClass('banner-nav');
			}else if(location.country== 'IN' && currentEnv == 'development'){
				$('.info-banner').css('display','block');
				$('.banner-link').text('www.crowdera.in');
				$('.banner-link').attr('href','http://localhost:8080');
				$('.home-header-section').addClass('banner-nav');
			}
		}
	});
	$('.banner-close').click(function(){
		$('.info-banner').css('display','none');
		$('.home-header-section').removeClass('banner-nav');
	});
	
	$("#homepage-carousel").load('/us/carousel_images');
	
});

/*******************Load whycrowdera template**********************************************/
function loadWhyCrowderaCallback(){
    var device = '';

    if(screen.width >=768 && screen.width <1025){
        device="tab";
    }else{
        device="desktop";
    }

    $.ajax({
        url:$('#b_url').val()+ "/home/loadWhyCrowderaCallback",
        type:"post",
        data:"device="+device,
        success:function(res){
            $("#loadWhyCrowdera").html(res);
        }
   });
}

/******************Load media strip**********************************/
function loadMediaStrip(){
	$.ajax({
        url:$('#b_url').val()+ "/home/loadMediaStrip",
        type:"post",
        data:"device=desktop",
        success:function(res){
            $("#loadMediaStrip").html(res);
        }
   });
}

$(function() {
    console.log("list.js initialized");
    
    /* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });

});
function selectedCategory(){
	document.categoryForm.submit();
}

function selectedCampaigns(){
	document.sortsForm.submit();
}

$(document).ready(function(){
	var currentEnv=$('#currentEnv').val();
	$.ajax( { 
		url: 'https://freegeoip.net/json/', 
		type: 'POST', 
		dataType: 'jsonp',
		success: function(location) {
			// If the visitor is browsing from India.
			if (location.country_code == 'IN' && currentEnv == 'test') {
			// Tell him about the India store.
					$('.info-banner').css('display','block');
					$('.banner-link').text('test.crowdera.in');
					$('.banner-link').attr('href','http://test.crowdera.in');
			}else if(location.country_code == 'IN' && currentEnv == 'staging'){
				$('.info-banner').css('display','block');
				$('.banner-link').text('staging.crowdera.in');
				$('.banner-link').attr('href','http://staging.crowdera.in');
			}else if(location.country_code == 'IN' && currentEnv == 'production'){
				$('.info-banner').css('display','block');
				$('.banner-link').text('crowdera.in');
				$('.banner-link').attr('href','http://crowdera.in');
			}
		}
	});
	$('.banner-close').click(function(){
		$('.info-banner').css('display','none');
	});
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

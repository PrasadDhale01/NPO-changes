$(function() {
    console.log("list.js initialized");
    
    /* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
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
    
});
function selectedCategory(){
	document.categoryForm.submit();
}

function selectedCampaigns(){
	document.sortsForm.submit();
}

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

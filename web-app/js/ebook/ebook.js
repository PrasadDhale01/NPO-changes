$(function() {
	$( document ).ready(function() {
		function sticky_relocate() {
		    var window_top = $(window).scrollTop();
		    var div_top = $('#sticky-header').offset().top;
		    if (window_top > div_top) {
		        $('.TW-ebook-header').addClass('TW-fixed-header');
		    } else if(window_top > 0){
		        $('.TW-ebook-header').removeClass('TW-fixed-header');
		    }
		}
		$(window).scroll(sticky_relocate);
		sticky_relocate();
	});

    $("#fbshare").click(function(){
        var url = 'http://www.facebook.com/sharer.php?p[url]='+ encodeURIComponent($('#fbShareUrl').val());
        window.open(url, 'Share on FaceBook', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
        return false;
    });

    $("#twitterShare").click(function(){
        var url = 'https://twitter.com/share?text=The crowdfunding ebook for success :';
        window.open(url, 'Share on Twitter', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
        return false;
    });
	
});

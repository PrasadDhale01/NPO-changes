$(function() {
    console.log('show.js initialized');
    var hash = window.location.hash;
    hash && $('ul.nav a[href="' + hash + '"]').tab('show');

    $('.nav a').click(function (e) {
        $(this).tab('show');
        var scrollmem = $('body').scrollTop();
        window.location.hash = this.hash;
        $('html,body').scrollTop(scrollmem);
    });

    $('form').validate({
        rules: {
            comment: {
                required: true,
                maxlength: 5000
            }
        }
    });

});

function showNavigation(){
	document.getElementById('indicators').style.display = 'block';
	document.getElementById('navigators').style.display = 'block';
}

function hideNavigation(){
	document.getElementById('indicators').style.display = 'none';
	document.getElementById('navigators').style.display = 'none';
}
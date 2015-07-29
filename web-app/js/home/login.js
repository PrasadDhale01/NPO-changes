$(function() {
    console.log("login.js initialized");

    $('.login-form').find('form').validate({
        rules: {
            j_username: {
                minlength: 2,
                required: true,
                email: true
            },
            j_password: {
                required: true
            }
        }
    });
    
    $('form').submit(function() {
		if($("#loginForm").valid()) {
			$('#submit').attr('disabled','disabled');
		}
	});
    
});

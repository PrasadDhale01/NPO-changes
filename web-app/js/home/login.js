$(function() {
    console.log("login.js initialized");

    $('[name="loginForm"]').validate({
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
    
    $('#submit').click(function() {
    	if($('[name="loginForm"]').valid()) {
    		$('[name="loginForm"]').submit();
//			$('#submit').attr('disabled','disabled');
		}
    });

    
});

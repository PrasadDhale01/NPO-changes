$(function() {
    console.log("registration.js initialized");

    $('form').validate({
        rules: {
            username: {
                minlength: 2,
                required: true,
                email: true
            },
            password: {
                required: true,
                minlength: 6
            },
            confirmPassword: {
                required: true,
                isEqualToPassword: true
            },
            firstName: {
                minlength: 2,
                maxlength: 20,
                required: true
            },
            lastName: {
                minlength: 2,
                maxlength: 20,
                required: true
            }
        },
        errorPlacement: function(error, element) {
            error.appendTo(element.parent());
        }
    });
    $("#newsletterDiv input[type='checkbox']").click(function(){
    	      
        if($(this).prop("checked") == true){
        	$(this).attr("value",1);
        }else if($(this).prop("checked") == false){
    	   	$(this).attr("value",0);
        }
    });
    $('.regForm').submit(function() {
    	var email=$(".subscriberEmail").val();
        if($(".regForm").valid()) {
            $('#btnSignUp').attr('disabled','disabled');
            var subscribe=$('#subscribeReg').val();
            if(subscribe==1){
               $.ajax({
                 type:'post',
                 url:$("#b_url").val()+'/user/subscribeNewsLetter',
                 data:'email='+email,
                 success: function(data){
                	 $('#test').html(data);
                 }
               }).error(function(){
                   	$('#test').html("");
               })
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
    
});

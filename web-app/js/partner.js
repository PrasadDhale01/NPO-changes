$(function() {
    $('#invitePartnerModal').find('form').validate({
    	rules: {
    		email : {
    			required: true
    		},
    		firstName: {
    			required: true
    		},
    		lastName : {
    			required: true
    		}
    	}
    });
    
});

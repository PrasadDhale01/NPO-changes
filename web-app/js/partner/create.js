$(function() {
	
	var partnerId = $('#partnerId').val();
	
	$('.redactorEditor').redactor({
        imageUpload:'/project/getRedactorImage',
        autosave: '/user/savedescription/?partnerId='+partnerId,
        imageResizable: true,
        plugins: ['video','fontsize','fontfamily','fontcolor'],
        buttonsHide: ['indent', 'outdent', 'horizontalrule', 'deleted','formatting']
    });
	
	$('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });
	
	var validator = $('#partner-create-page').find('form').validate({
		rules: {
			orgName : {
    			required: true,
    			minlength: 3
    		},
    		answer : {
    			required: true,
    		},
    		facebookUrl: {
    		    required: true,
    		    isFacebookUrl: true
    		},
    		website: {
    			isWebUrl:true
    		},
    		partnerEmail: {
    		    required: true
    		},
    		checkBox: {
    		    required: true
    		},
    		city: {
    		    required: true,
    		    minlength: 3
    		},
    		state: {
    		    required: true,
    		    minlength: 3
    		},
    		zipCode: {
    		    required: true
    		},
    		name: {
    			required: true,
    			minlength: 2
    		},
    		email: {
    			required: true
    		},
    		telephone: {
    			number: true
    		},
    		addressLine1: {
    			required: true,
    			minlength: 5
    		},
    		youtubeUrl: {
    			isYoutubeVideo: true
    		},
    		twitterUrl: {
            	isTwitterUrl: true
            },
            linkedinUrl: {
            	isLinkedInUrl: true
            },
            customUrl: {
            	maxlength: 55,
            	minlength: 5,
            	isCustomUrlUnique:true
            }
    	},
		errorPlacement: function(error, element) {
			if ( element.is(":radio") ) {
				error.appendTo(element.parent().parent());
			} else if(element.is(":checkbox")) {
				error.appendTo(element.parent());
			} else if($(element).prop("id") == "customUrl") {
				error.appendTo(element.parent());
			} else{
			    error.insertAfter(element);
			}
		}
	});
	
	$.validator.addMethod('isYoutubeVideo', function (value, element) {
        if(value && value.length !=0){
           var p = /^https?:\/\/(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
           var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
           var youtubematch = value.match(p);
           var vimeomatch = value.match(vimeo);
           var match
           if (youtubematch)
               match = youtubematch;
           else if (vimeomatch && vimeomatch[2].length == 9)
               match = vimeomatch;
           else 
               match = null;
           return (match) ? true : false;
        }
        return true;
    }, "Please upload a url of Youtube/Vimeo video");
	
    $.validator.addMethod('isWebUrl', function(value, element){
        if(value && value.length !=0){
            var p = /(https | http?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})/ig;;
            return (value.match(p))
        }
        return true;
    }, "Please provide valid url");
    
    $.validator.addMethod('isTwitterUrl', function (value, element) {
        if(value && value.length !=0){
           var p = /^https?:\/\/(?:www.)?twitter.com\/?.*$/;
           var twittermatch = value.match(p);
           var match
           if (twittermatch)
               match = twittermatch;
           else 
               match = null;
           return (match) ? true : false;
        }
        return true;
    }, "Please enter valid Twitter url");
    
    $.validator.addMethod('isLinkedInUrl', function (value, element) {
        if(value && value.length !=0){
           var p = /^https?:\/\/(?:www.)?linkedin.com\/?.*$/;
           var linkedinmatch = value.match(p);
           var match
           if (linkedinmatch)
               match = linkedinmatch;
           else 
               match = null;
           return (match) ? true : false;
        }
        return true;
    }, "Please enter valid LinkedIn url");
    
    $.validator.addMethod('isFacebookUrl', function (value, element) {
        if(value && value.length !=0){
           var p = /^https?:\/\/(?:www.)?facebook.com\/?.*$/;
           var facebookmatch = value.match(p);
           var match
           if (facebookmatch)
               match = facebookmatch;
           else 
               match = null;
           return (match) ? true : false;
        }
        return true;
    }, "Please enter valid Facebook url");
	
	$('#orgName').blur(function(){
		if (validator.element("#orgName")) {
    	    var orgName = $(this).val();
    	    autoSave('orgName', orgName);
		}
    });
	
	$('#customUrl').blur(function() {
		var customUrlStatus = $('#customUrlStatus').val();
		if(validator.element("#customUrl") && customUrlStatus == 'true') {
    	    var customUrl = $(this).val();
    	    var delay = 50;
    	    setTimeout(function() {
                autoSave('customUrl', customUrl.trim());
            }, delay);
    	    
	    }
    });
	
	$('#customUrl').bind("paste",function(e) {
        e.preventDefault();
    });
	
	$('#youtubeUrl').blur(function(){
		if (validator.element("#youtubeUrl")) {
    	    var youtubeUrl = $(this).val();
    	    autoSave('youtubeUrl', youtubeUrl);
		}
    });
	
	$('#linkedinUrl').blur(function(){
		if (validator.element("#linkedinUrl")) {
    	    var linkedinUrl = $(this).val();
    	    autoSave('linkedinUrl', linkedinUrl);
		}
    });
	
	$('#twitterUrl').blur(function(){
		if (validator.element("#twitterUrl")) {
    	    var twitterUrl = $(this).val();
    	    autoSave('twitterUrl', twitterUrl);
		}
    });
	
	$('#facebookUrl').blur(function(){
		if (validator.element("#facebookUrl")) {
    	    var facebookUrl = $(this).val();
    	    autoSave('facebookUrl', facebookUrl);
		}
    });
	$('#website').blur(function(){
		if (validator.element("#website")) {
    	    var website = $(this).val();
    	    autoSave('website', website);
		}
    });
	$('#name').blur(function(){
		if (validator.element("#name")) {
    	    var name = $(this).val();
    	    autoSave('name', name);
		}
    });
	$('#email').blur(function(){
		if (validator.element("#email")) {
    	    var email = $(this).val();
    	    autoSave('email', email);
		}
    });
	$('#telephone').blur(function(){
		if (validator.element("#telephone")) {
    	    var telephone = $(this).val();
    	    autoSave('telephone', telephone);
		}
    });
	$('#addressLine1').blur(function(){
		if (validator.element("#addressLine1")) {
    	    var addressLine1 = $(this).val();
    	    autoSave('addressLine1', addressLine1);
		}
    });
	$('#addressLine2').blur(function(){
		if (validator.element("#addressLine2")) {
    	    var addressLine2 = $(this).val();
    	    autoSave('addressLine2', addressLine2);
		}
    });
	$('#city').blur(function(){
		if (validator.element("#city")) {
    	    var city = $(this).val();
    	    autoSave('city', city);
		}
    });
	$('#state').blur(function(){
		if (validator.element("#state")) {
    	    var state = $(this).val();
    	    autoSave('state', state);
		}
    });
	$('#zipCode').blur(function(){
		if (validator.element("#zipCode")) {
    	    var zipCode = $(this).val();
    	    autoSave('zipCode', zipCode);
		}
    });
	
	$('#country').change(function(){
		var country = $(this).val();
    	autoSave('country', country);
	});
	
	$('#category').change(function(){
		var category = $(this).val();
    	autoSave('category', category);
	});
	
	function autoSave(variable, varValue) {
        $.ajax({
            type: 'post',
            url : $("#b_url").val()+'/user/partnerautosave',
            data: 'partnerId='+partnerId+'&variable='+variable+'&varValue='+varValue,
            success: function(data) {
            }
        }).error(function() {
            console.log('Error occured while autosaving field'+ variable + 'value :'+ varValue);
        });
    }
	
    $("#category").find('.dropdown-menu li').click(function(event){
        var $target = $( event.currentTarget );
        
        $("#category").find('.dropdown-menu li').removeClass('active');
        $target.addClass('active');
        
        $target.closest('.btn-group')
            .find('[data-bind="label"]').text( $target.text() )
            .end()
            .children('.dropdown-toggle').dropdown('toggle');
        
        autoSave('category', $target.text());

        return false;
    });
    
    /*******************************Title text length******************** */
    var counter = 1;
    $('#customUrl').on('keydown', function(event) {
    
        event.altKey==true;
        var currentstring = $('#customUrl').val().length;

        if(currentstring <=55) {
        	if (currentstring == 55) {
        		var text = currentstring ;
        	} else {
        		var text = currentstring + 1;
        	}
        }
        if (event.keyCode > 31) {
            if(event.altKey==true){
    	         setTitleText();
            }
            else{
  	             if(currentstring <54)
  		             currentstring++;
                 $('#titleLength').text(text+'/55');
            }

        } else {
	        currentstring--;
            $('#titleLength').text(text+'/55');
        }
    }).keyup(function(e) {
    
        if(e.altKey==true){
	        setTitleText();
            return false;
        }

        switch (e.keyCode) {
 
            case 13:      //Enter
            case 8:       //backspace
            case 46:      //delete
            case 17:      
            case 27:      //escape
            case 10:      //new line
            case 20:      
            case 9:       //horizontal TAB
            case 11:      //vertical tab
            case 33:      //page up  
            case 34:      //page  down
            case 35:      //End 
            case 36:      //Home
            case 37:      //Left arrow
            case 38:      //up arrow
            case 39:      //Right arrow
            case 40:      //Down arrow
            case 45:      //Insert
            case 12:      //vertical tab
    	        setTitleText();
                break;
            case 16:      //shift
    	        setTitleText();
                break;
        }
    }).focus(function(){
	    setTitleText();
    }).focusout(function(){
	    setTitleText();
    });
    
    function setTitleText() {
        
        var currentstring = $('#customUrl').val().length;
        if (currentstring == 0) {
            $('#customUrl').text("0/55");
        } else {
	        currentstring = currentstring;
            $('#customUrl').text(currentstring+'/55');
        }
    }
    
    $.validator.addMethod('isCustomUrlUnique', function (value, element) {
    	var status;
    	if(value && value.length !=0){
    		customUrlUniqueStatus(value.trim());
    	    status = $('#customUrlStatus').val();
    	    return (status == 'true') ? true : false;
        } else {
            $('#customUrlStatus').val('true');
            status = 'true';
        }

    	return true;
     }, "This partner page url is already in use");

    function customUrlUniqueStatus(customUrl){
    	$.ajax({
            type:'post',
            url:$("#b_url").val()+'/user/isCustomUrlUnique',
            data:'customUrl='+customUrl+'&partnerId='+partnerId,
            success: function(data){
            	(data == 'true') ? $('#customUrlStatus').val('true') : $('#customUrlStatus').val('false');
            }
        }).error(function(e){
     	   console.log('Error occured while checking Custom Url Uniqueness'+e);
        });
    }
    
    $("#customUrl").keypress(function (e) {
        return /[a-z0-9-]/i.test(
           String.fromCharCode(e.charCode || e.keyCode)
        ) || !e.charCode && e.keyCode  < 48;
   });
    
});

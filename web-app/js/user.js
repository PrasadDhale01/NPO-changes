$(function() {
    console.log("user.js initialized");
    $('#uploadProfilesize').hide();
    $('#uploadProfileImg').hide();
    
    $('#editProfilesize').hide();
    $('#editProfileImg').hide();
    
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });
    
    $('#state').change(function(event) {
        var option = $(this).val();
        if(option == 'other') {
            $("#ostate").show();
            $("#dashboard_otherstate").show();
        } else {
            $("#ostate").hide();
            $("#dashboard_otherstate").hide();
        }
    });
    
    $('#side-menu').find('.li').click(function() {
        $('#side-menu').find('.li').removeClass('active');
        $(this).addClass('active');
    });
    
    var validator = $('#validpass').find('form').validate({
        rules: {
        	firstName: {
        		minlength: 2,
        		maxlength: 20
        	},
        	lastName: {
        		minlength: 2,
        		maxlength: 20
        	},
        	password: {
                minlength: 6,
                maxlength: 30
            },
    		confirmPassword: {
		        isEqualToPassword: true
            }
        }
    });
    
    $('.dashboarduserprofile').find('form').validate({
        rules: {
            firstName: {
            	minlength: 2,
                maxlength: 20
            },
            lastName: {
            	minlength: 2,
                maxlength: 20
            },
            password: {
                minlength: 6,
                maxlength: 30
            },
            confirmPassword: {
                isEqualToPassword: true
            },
            biography: {
                minlength: 10,
                maxlength: 140
            },
            city: {
            	minlength: 2,
                maxlength: 20
            },
            state: {
            	minlength: 2,
                maxlength: 20
            },
            country: {
                minlength: 6
            },
            otherstate: {
            	required: true,
            	minlength: 3
            }
        },
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        }
    });
    
    $('#invitePartnerModal').find('form').validate({
        rules: {
            email : {
                required: true,
                maxlength: 30
            },
            firstName: {
                required: true,
                maxlength: 20
            },
            lastName : {
                required: true,
                maxlength: 20
            }
        }
    });
    
    $('#partner-sec-header .span-space').click(function() {
   	    var toptabs = $("#partner-tab-content").offset().top;
   	    window.scrollTo(toptabs,toptabs - 170);
    });
    
    var currentEnvironment = $('#currentEnv').val();
    
    $(".amountsectionfbicon").click(function(){
    	var url;
    	if (currentEnvironment == 'prodIndia') {
            url = 'http://www.facebook.com/sharer.php?p[url]=http://crowdera.in/campaign/create'
    	}
        else if (currentEnvironment == 'testIndia') {
        	url = 'http://www.facebook.com/sharer.php?p[url]=http://test.crowdera.in/campaign/create'
        }
        else if (currentEnvironment == 'stagingIndia') {
        	url = 'http://www.facebook.com/sharer.php?p[url]=http://staging.crowdera.in/campaign/create'
        }
        else if (currentEnvironment == 'test') {
        	url = 'http://www.facebook.com/sharer.php?p[url]=http://test.crowdera.co/campaign/create'
        }
        else if (currentEnvironment == 'staging') {
        	url = 'http://www.facebook.com/sharer.php?p[url]=http://staging.crowdera.co/campaign/create'
        }
        else if (currentEnvironment == 'production') {
        	url = 'http://www.facebook.com/sharer.php?p[url]=http://crowdera.co/campaign/create'
        }
    	else {
    		url = 'http://www.facebook.com/sharer.php?p[url]=http://localhost:8080/campaign/create'
    	}
        window.open(url, 'Share on FaceBook', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
        return false;
    });
    
    $.validator.addMethod('isEqualToPassword', function (value, element) {
        var confirmpassword = value;
        var password = $("#password").val();
        if(confirmpassword != password) {
            return (confirmpassword == password) ? password : false;
        }
        return true;
    }, "Passwords do not match! Please enter a valid password.");
    
    $("#uploadavatar").click(function() {
        $("#avatar").click();
    });
    
    $('#avatar').change( function(event) {
    	var file =this.files[0];
	    if(!file.type.match('image')){
	        $('#uploadProfilesize').hide();
	        $('#uploadProfileImg').show();
	        this.value=null;
	    } else{
	        if (file.size > 1024 * 1024 * 3) {
	        	$('#uploadProfilesize').show();
		        $('#uploadProfileImg').hide();
	            $('#avatar').val('');
	        } else {
	        	$('#uploadProfilesize').hide();
		        $('#uploadProfileImg').hide();
                        $("#uploadbutton").click();
	        }
	    } 
    });
    
    $("#editavatarbutton").click(function() {
        $("#editavatar").click();
    });
    
    $('#editavatar').change( function(event) {
    	var file =this.files[0];
	    if(!file.type.match('image')){
	        $('#editProfilesize').hide();
	        $('#editProfileImg').show();
	        this.value=null;
	    } else{
	        if (file.size > 1024 * 1024 * 3) {
	        	$('#editProfilesize').show();
		        $('#editProfileImg').hide();
	                $('#editavatar').val('');
	        } else {
	        	$('#editProfilesize').hide();
		        $('#editProfileImg').hide();
		        $("#editbutton").click();
	        }
	    } 
    });
    
    $("#applicantfile").change(function(event) {
        var file =this.files[0];
        if(validateExtension(file.name) == false){
	        $('#applicantOutput').hide();
	        $("#applicantfilesize").show();
        	$("#applicantfilesize").html("Only text,docx and pdf files are allowed.");
	        this.value=null;
	        return;
	    }
	    else{
	        if (file.size > 1024 * 1024 * 3) {
	            $('#applicantOutput').hide();
	            $('#applicantfilesize').show();
	            $("#applicantfilesize").html("The file \"" +file.name+ "\" you are attempting to upload is larger than the permitted size of 3MB.");
	            $('#applicantfile').val('');
	        } else {
                $('#applicantOutput').show();
                $('#applicantfilesize').hide();
                $("#applicantOutput").html(""+file.name);
                
	        }
	    } 
    });
    
    $('#userAvatarUploadIcon').hover(function() {
        $('.partneruploadprofileimage').show();
    });
    $('#userAvatarUploadIcon').mouseleave(function() {
        $('.partneruploadprofileimage').hide();
    });
    $('#userAvatarUploadIcon').click(function(event) {
        event.preventDefault();
        $("#avatar").click();
    });
    $('#partnerImageEditDeleteIcon').hover(function() {
        $('.partnerprofileeditimage').show();
    });
    $('#partnerImageEditDeleteIcon').mouseleave(function() {
        $('.partnerprofileeditimage').hide();
    });
    $('.partnerprofileeditimage').click(function(event) {
        event.preventDefault();
        $("#editavatar").click();
    });
    
    
    var elem1 = '<div class="well"><a href="google.com">Message one, From someone.</a></div>'+
    '<button id="close-popover" data-toggle="clickover" class="btn btn-small btn-primary pull-right" onclick="$(&quot;#contributionshare1&quot;).popover(&quot;hide&quot;);">Close please!</button>';
    
    var elem2 = '<div class="well"><a href="google.com">Message one, From someone.</a></div>'+
    '<button id="close-popover" data-toggle="clickover" class="btn btn-small btn-primary pull-right" onclick="$(&quot;#contributionshare2&quot;).popover(&quot;hide&quot;);">Close please!</button>';

    
	function validateExtension(imgExt) {
        var allowedExtensions = new Array("txt","docx","doc","pdf");
        for(var imgExtImg=0;imgExtImg<allowedExtensions.length;imgExtImg++)
        {
            imageFile = imgExt.lastIndexOf(allowedExtensions[imgExtImg]);
            if(imageFile != -1){
    	        return true;
            }
        }
        return false;
	}
	
    /* Show pop-over tooltip on hover for some fields. */
    var showPopover = function () {
        $(this).popover('show');
    },
    hidePopover = function () {
        $(this).popover('hide');
    };

    /* Initialize pop-overs (tooltips) */
    $("button[name='editproject']").popover({
        content: 'ACCESS DENIED',
        trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);

    /* Initialize pop-overs (tooltips) */
    $("button[name='projectpreview']").popover({
        content: 'ACCESS DENIED',
        trigger: 'manual',
        placement: 'bottom'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
    
});

function campaignsort(){
	var currency = $('#currency').val();
	var selectedSortValue = $('#sortByOptions').val();
	var selectedCountry = $('#countryOpts').val();
	var grid = $('#adminCampaignGrid');
	
	$.ajax({
		type: 'post',
		url: $('#baseUrl').val()+'/user/getSortedCampaigns',
		data: 'selectedSortValue='+selectedSortValue+'&country='+selectedCountry,
		success: function(data){
			$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
		}
	}).error(function(data){
		console.log('Error occured while fetching campaigns');
	});
}

function campaignsortByCountry(){
	var currency = $('#currency').val();
	var selectedSortValue = $('#sortByOptions').val();
	var selectedCountry = $('#countryOpts').val();
	var grid = $('#adminCampaignGrid');
	
	$.ajax({
		type: 'post',
		url: $('#baseUrl').val()+'/user/getSortedCampaigns',
		data: 'selectedSortValue='+selectedSortValue+'&country='+selectedCountry,
		success: function(data){
			$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
		}
	}).error(function(data){
		console.log('Error occured while fetching campaigns');
	});
}

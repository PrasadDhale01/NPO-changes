$(function() {
    $('#uploadProfilesize').hide();
    $('#uploadProfileImg').hide();

    $('#editProfilesize').hide();
    $('#editProfileImg').hide();

    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });

    $('.success-message').fadeOut(6000);

    $('#state').change(function() {
        var option = $(this).val();
        if(option === 'other') {
            $("#ostate").show();
            $("#dashboard_otherstate").show();
        } else {
            $("#ostate").hide();
            $("#dashboard_otherstate").hide();
        }
    });

    $('.contributorsSort').change(function (){
        var vanityTitle = $('.vanityTitle').val();
        var isBackRequired = $('#isBackRequired').val();
        
        var formData;
        if ($(this).val() == 3) {
        	$('#customDateSelect').modal('show');
        	/**/
        } else {
        	formData = 'vanityTitle='+vanityTitle+'&sort='+$(this).val()+'&isBackRequired='+isBackRequired;
        	loadTaxReceiptData(formData);
        }
        
    });
    
    
    $(document).on("click", "#selectDateBtn", function() {
    	 var vanityTitle = $('.vanityTitle').val();
         var isBackRequired = $('#isBackRequired').val();
         
         var fromDate = $("#fromDate").val();
         var toDate = $("#toDate").val();
         
         var formData = 'vanityTitle='+vanityTitle+'&sort=3&isBackRequired='+isBackRequired+'&fromDate='+fromDate+'&toDate='+toDate;
         $('#customDateSelect').modal('hide');
         $("#fromDate").val('');
         $("#toDate").val('');
         
         loadTaxReceiptData(formData);
    });
    

    $('#side-menu').find('.li').click(function() {
        $('#side-menu').find('.li').removeClass('active');
        $(this).addClass('active');
    });

    $('.nav-tab-doc').find('.tab-data-toggle').click(function() {
        $('.nav-tab-doc').find('.tab-data-toggle').removeClass('active');
        $(this).addClass('active');
        $('.file-thumbnail-container').removeClass('active');
    });

    $('#validpass').find('form').validate({
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

    $('#partnersOpts').change(function(){
        var opts = $(this).val();
        if (opts === 'Verified') {
            $('#partners-list').find('.tab-pane').removeClass('active');
            $('#verified').addClass('active');
        } else if(opts === 'Non-Verified') {
            $('#partners-list').find('.tab-pane').removeClass('active');
            $('#nonVerified').addClass('active');
        } else if(opts === 'Pending') {
            $('#partners-list').find('.tab-pane').removeClass('active');
            $('#pending').addClass('active');
        } else if(opts === 'Draft') {
            $('#partners-list').find('.tab-pane').removeClass('active');
            $('#draft').addClass('active');
        }
    });

    var currentEnvironment = $('#currentEnv').val();

    $(".amountsectionfbicon").click(function(){
    	var url;
    	if (currentEnvironment === 'prodIndia') {
            url = 'http://www.facebook.com/sharer.php?p[url]=http://crowdera.in/campaign/create';
    	}
        else if (currentEnvironment === 'testIndia') {
        	url = 'http://www.facebook.com/sharer.php?p[url]=http://test.crowdera.in/campaign/create';
        }
        else if (currentEnvironment === 'stagingIndia') {
        	url = 'http://www.facebook.com/sharer.php?p[url]=http://staging.crowdera.in/campaign/create';
        }
        else if (currentEnvironment === 'test') {
        	url = 'http://www.facebook.com/sharer.php?p[url]=http://test.gocrowdera.com/campaign/create';
        }
        else if (currentEnvironment === 'staging') {
        	url = 'http://www.facebook.com/sharer.php?p[url]=https://staging.gocrowdera.com/campaign/create';
        }
        else if (currentEnvironment === 'production') {
        	url = 'http://www.facebook.com/sharer.php?p[url]=https://gocrowdera.com/campaign/create';
        }
    	else {
    		url = 'http://www.facebook.com/sharer.php?p[url]=http://localhost:8080/campaign/create';
    	}
        window.open(url, 'Share on FaceBook', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
        return false;
    });

    $.validator.addMethod('isEqualToPassword', function (value) {
        var confirmpassword = value;
        var password = $("#password").val();
        if(confirmpassword !== password) {
            return (confirmpassword === password) ? password : false;
        }
        return true;
    }, "Passwords do not match! Please enter a valid password.");

    $("#uploadavatar").click(function() {
        $("#avatar").click();
    });

    $('#avatar').change( function() {
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

    $('#editavatar').change( function() {
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

    $("#applicantfile").change(function() {
        var file =this.files[0];
        if(validateExtension(file.name) === false){
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


	function validateExtension(imgExt) {
        var allowedExtensions = new Array("txt","docx","doc","pdf");
        for(var imgExtImg=0;imgExtImg<allowedExtensions.length;imgExtImg++)
        {
            imageFile = imgExt.lastIndexOf(allowedExtensions[imgExtImg]);
            if(imageFile !== -1){
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
    
    /***Load campaign admin dashboard*****/
    var option = $('#settingList').val();
    if(option==''){
        campaignsortByCountry();
    }
    
});

function settingOption(){
	var option = $('#settingList').val();
	var grid = $('#adminCampaignGrid');
	if(option){
		$.ajax({
			url:$('#baseUrl').val()+'/user/settingOption',
			type:'post',
			data:"option="+option,
			success:function(data){
				
				$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
			}
		});
	}else{
		campaignsortByCountry();
	}
}

function campaignsort(){
	var selectedSortValue = $('#sortByOptions').val();
	var selectedCountry = $('#countryOpts').val();
	var grid = $('#adminCampaignGrid');
	$('#loading-gif').show();

	$.ajax({
		type: 'post',
		url: $('#baseUrl').val()+'/user/getSortedCampaigns',
		data: 'selectedSortValue='+selectedSortValue+'&country='+selectedCountry,
		success: function(data){
			$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
			$('#loading-gif').hide();
		}
	}).error(function(){
		$('#loading-gif').hide();
	});
}

function setCampaignCurrentDays(){
    var campaign = $('#campaignSelection').val();
    $('#loading-gif').show();

    $.ajax({
        type: 'post',
        url: $('#baseUrl').val()+'/project/setCampaignCurrentDays',
        data: 'campaign='+campaign,
        success: function(data){
            if(data){
                $('#deadline').val(data.days);
                $('#daysLeft').val(data.daysLeft);
                $('#loading-gif').hide();
            }
        }
    }).error(function(){
        $('#loading-gif').hide();
    });
}

function campaignsortByCountry(){
	var selectedSortValue = $('#sortByOptions').val();
	var selectedCountry = $('#countryOpts').val();
	var grid = $('#adminCampaignGrid');
	$('#loading-gif').show();

	$.ajax({
		type: 'post',
		url: $('#baseUrl').val()+'/user/getSortedCampaigns',
		data: 'selectedSortValue='+selectedSortValue+'&country='+selectedCountry,
		success: function(data){
			$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
			$('#loading-gif').hide();
		}
	}).error(function(){
		$('#loading-gif').hide();
	});
}

function getcampaignsort(){
	var selectedSortValue = $('#sortByOptions').val();
	var selectedCountry = $('#countryOpts').val();
	var grid = $('#adminCampaignGrid');
	$('#loading-gif').show();

	$.ajax({
		type: 'post',
		url: $('#baseUrl').val()+'/project/getCampaignsByFilter',
		data: 'selectedSortValue='+selectedSortValue+'&country='+selectedCountry,
		success: function(data){
			$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
			$('#loading-gif').hide();
		}
	}).error(function(){
		$('#loading-gif').hide();
	});
}

function getcampaignsortByCountry(){
	var selectedSortValue = $('#sortByOptions').val();
	var selectedCountry = $('#countryOpts').val();
	var grid = $('#adminCampaignGrid');
	$('#loading-gif').show();

	$.ajax({
		type: 'post',
		url: $('#baseUrl').val()+'/project/getCampaignsByFilter',
		data: 'selectedSortValue='+selectedSortValue+'&country='+selectedCountry,
		success: function(data){
			$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
			$('#loading-gif').hide();
		}
	}).error(function(){
		$('#loading-gif').hide();
	});
}

function uploadCarouselImage(){
	
	var form = $('.homeCarouselForm').valid();
	if(form){	
	    var formData = new FormData();
	    formData.append('uploadFile', $('#uploadCarouselFile')[0].files[0]);
	    formData.append('country', $("#countryOpts").val());
	    formData.append('carouselOption','upload');
	    
	    $('.homeCarouselForm').submit(function(){
	    	return false;
	    });
	    
	    $.ajax({
	        url:'/home/manageHomePageCarousel',
	        type:'POST',
	        data:formData,
	        cache:true,
	        processData: false,  
	        contentType: false,
	        beforeSend:function(){
	        	 $('#loading-gif').show();
	        },
	        mimeType:'multipart/form-data',
	        success:function(data){
	        	$('#loading-gif').hide();
	        }
	    });
	}
}

function deleteCarouselImage(){

	var form = $('.homeCarouselForm').valid();
	if(form){
		var formData = $('.homeCarouselForm').serialize();
	    var country =$("#countryOpts").val();
	      
	    $('.homeCarouselForm').submit(function(){
	    	return false;
	    });
	      $.ajax({
	          url:'/home/manageHomePageCarousel',
	          type:'POST',
	          cache:true,
	          data:formData+"&country="+country,
	          beforeSend: function(){
	        	  $('#loading-gif').show();
	          },
	          success:function(data){
	        	  $('#loading-gif').hide();
	        	  $('#carouselTemplate').load('/carouseltemplate #deleteTemplate');
	        	  loadDropDownData("deleteImage");
	        	  
	          }
	      });
	}
}

function updateCarouselImage(){
	
	var form = $('.homeCarouselForm').valid();
	if(form){	
		var formData = new FormData();
	    formData.append('uploadFile', $('#uploadCarouselFile')[0].files[0]);
	    formData.append('country', $("#countryOpts").val());
	    formData.append('carouselImage',$('#updateImage').val());
	    formData.append('carouselOption','update');
	    
	    $('.homeCarouselForm').submit(function(){
	    	return false;
	    });
	    
	   $.ajax({
	       url:'/home/manageHomePageCarousel',
	       type:'POST',
	       data:formData,
	       cache:true,
	       processData: false,  
	       contentType: false,
	       mimeType:'multipart/form-data',
           beforeSend: function(){
               $('#loading-gif').show();
           },
	       success:function(data){
	    	   $('#loading-gif').hide();
	    	   $('#carouselTemplate').load('/carouseltemplate #updateTemplate');
	    	   loadDropDownData("updateImage");
	       }
	   });
	}
 }

function loadDropDownData(tag){
    var country = $('#countryOpts').val();
    $.ajax({
        url:'/home/getHomePageCarouselImage',
        type:'POST',
        cache:true,
        data:"country="+country+"&data=name",
        beforeSend: function(){
        	 $('#loading-gif').show();
        },
        success:function(data){
            $('#loading-gif').hide();
            var jsonData = jQuery.parseJSON(JSON.stringify(data));
            
             if($('#'+tag).length > 0) {
                 $('#'+tag+' option:gt(0)').remove();
             }
             
             $.each(jsonData, function(index, value){
                 $('#'+tag).append('<option value="'+value+'">'+value+'</option>');
             });
        }
    });
}

function setSelectedFileName(){

	/**************************Sets text on file selection*************************/
	
	$(document).on('change', '.btn-file :file', function() {
            var filename =this.files[0].name;
            var input = $(this),
                        fileExt = filename.substr(filename.lastIndexOf('.') + 1),
                        label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                        input.trigger('fileselect', [fileExt, label]);
        });

      
        $('.btn-file :file').on('fileselect', function(event, fileExt, label) {
        	
            var input = $(this).parents('.input-group').find(':text'),
                        log = ( (fileExt == 'jpg') || (fileExt =='png')) ? label : 'Select image file';
            
            if(fileExt=='jpg' || fileExt == 'png'){
                $('.upload').removeClass('has-error');
            }else{
                $('.upload').addClass('has-error');
                input.val('');
                return false;
            }
            
            if(input.length ) {
                input.val(log);
            } 
       });
}

function loadTaxReceiptData(formData) {
	var grid = $(".send-tax-receipt-to-contributors");
    var baseUrl = $('#baseUrl').val();
    
	 $.ajax({
        type: 'post',
        url :   baseUrl+'/user/sortContributorsList',
        data:  formData,
        success: function(data) {
            $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
        }
    }).error(function(){
    });
}

function sendEmailToContributors(vanityTitle, list) {
	$.ajax({
		type: 'post',
		url:baseUrl+'/user/sendTaxReceiptToContributors',
		data:'vanityTitle='+vanityTitle+'&list='+list,
		beforeSend: function(data){
			if(list.length > 0){
	            $('.sendemailtocontributors').show();
	        }else{
	             $('#email-send-confirmation').text("Please, select atleast one.").show().fadeOut(9000);
	        }
		},
		success: function(data) {
			if(data==="true"){
			    $('.sendemailtocontributors').hide();
		        $('#email-send-confirmation').text("Email has been sent successfully!").show().fadeOut(9000);
			}
			
			$.each(list, function(index, value) {
				$("#sendEmailBtn"+value).text("Resend");
			})
		}
	}).error(function() {
		$('.sendemailtocontributors').hide();
	});
}


function sendOrResendEmailToContributor(id) {
	var list =[];
	var vanityTitle = $('.vanityTitle').val();
	list.push(id);
	
	sendEmailToContributors(vanityTitle, list);
}

$(function() {

    var baseUrl = $('#baseUrl').val();
	
    function getSelectedCampaignUrl() {
        return $('#promote-campaigns').find('.list-group-item.active').data('campaignurl');
    }
    
    function getSelectedCampaignTwitterUrl() {
        return $('#promote-campaigns').find('.list-group-item.active').attr('id');
    }
    
    $('#promote-campaigns').find('.list-group-item').click(function() {
        $('#promote-campaigns').find('div.list-group-item').removeClass('active');
        $(this).addClass('active');
        $('#campaign-select-msg').show();
		$('#campaign-select-msg').fadeOut(3500);
    });
	
    $('#side-menu').find('.li').click(function() {
        $('#side-menu').find('.li').removeClass('active');
        $(this).addClass('active');
    });
    $('#partner-sec-header').find('span').click(function() {
        $('#partner-sec-header').find('span').removeClass('active');
        $(this).addClass('active');
    });
    
    $('.nav-tab-doc').find('.tab-data-toggle').click(function() {
        $('.nav-tab-doc').find('.tab-data-toggle').removeClass('active');
        $(this).addClass('active');
        $('#viewfolder').hide();
        $('#folderId').val('');
        $('#remove-folder').val('');
        $('.trash-docs-fixed-btn').hide();
        $('.trash-file-fixed-btn').hide();
        $('.trash-drivefile-fixed-btn').hide();
        $('.folderlist').find('.folder').removeClass('active');
        $('.file-thumbnail-container').removeClass('active');
    });

    $('.partner-confirmation').fadeOut(30000);
    $('.success-message').fadeOut(10000);

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
	
    var currentEnv = $('#currentEnv').val();

    $('#invite-campaign-owner').find('form').validate({
        rules: {
            emails : {
                required: true,
                validateMultipleEmailsCommaSeparated: true
            },
            name: {
                required: true
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
                minlength: 6
            },
            confirmPassword: {
                isEqualToPassword: true
            },
            biography: {
                minlength: 10,
                maxlength: 140
            },
            city: {
            	required: true,
            	minlength: 2,
                maxlength: 20
            },
            state: {
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
    
    $('#createNewFolder').find('form').validate({
    	rules: {
    		title : {
    			required: true,
    			minlength: 3
    		}
    	}
    });
    
    $('#sendReceiptModal').find('form').validate({
        rules: {
            email : {
                required: true
            },
            name: {
                required: true
            }
        }
    });
    
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
    
    $("#insertfile").change(function(event) {
        var file = this.files[0];
        if (file.size > 0) {
        	$('#files').find('form').submit();
        } else {
        	
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
    
    $("#fbshare").click(function(){
    	var selectedUrl = getSelectedCampaignUrl();
    	if (selectedUrl == undefined) {
    		$('#campaign-select-alert').show();
    		$('#campaign-select-alert').fadeOut(3000);
    	} else {
            var url = 'http://www.facebook.com/sharer.php?p[url]='+ encodeURIComponent(selectedUrl);
            window.open(url, 'Share on FaceBook', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
            return false;
    	}
    });
    $("#twitterShare").click(function(){
        var selectedUrl = getSelectedCampaignTwitterUrl();
        if (selectedUrl == undefined) {
        	$('#campaign-select-alert').show();
    		$('#campaign-select-alert').fadeOut(3000);
    	} else {
            if(currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'production' || currentEnv == 'staging'){
                var url = 'https://twitter.com/intent/tweet?text="Check campaign at crowdera.co!"&url='+encodeURIComponent(selectedUrl);
            } else {
                var url = 'https://twitter.com/intent/tweet?text="Check campaign at crowdera.in!"&url='+encodeURIComponent(selectedUrl);
            }
            window.open(url, 'Share on Twitter', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
            return false;
    	}
    });
    $("#linkedinShareUrl").click(function(){
    	var selectedUrl = getSelectedCampaignTwitterUrl();
        if (selectedUrl == undefined) {
    		$('#campaign-select-alert').show();
    		$('#campaign-select-alert').fadeOut(3000);
    	} else {
            var url = 'https://www.linkedin.com/cws/share?url='+ selectedUrl;
            window.open(url, 'Share on Linkedin', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
            return false;
    	}
    });
    $("#googlePlusShareUrl").click(function(){
    	var selectedUrl = getSelectedCampaignTwitterUrl();
        if (selectedUrl == undefined) {
        	$('#campaign-select-alert').show();
    		$('#campaign-select-alert').fadeOut(3000);
    	} else {
            var url = 'https://plus.google.com/share?url='+ selectedUrl;
            window.open(url, 'Share on Google Plus', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
            return false;
    	}
    });
    
    $.validator.addMethod('validateMultipleEmailsCommaSeparated', function (value, element) {
        var result = value.split(",");
        for(var i = 0;i < result.length;i++)
        if(!validateEmail(result[i])) 
                return false;    		
        return true;
    },"Please add valid emails only");
    
    function validateEmail(field) {
        var regex=/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i;
        return (regex.test(field)) ? true : false;
    }
    
    var partnerId = $('#partnerId').val();
    
    var validategrid = $('#validatecampaignpaginate');
    var loadValidateCampaignUrl = baseUrl+'/user/validatecampaigns?partnerId='+partnerId;
    loadValidateCampaigns(loadValidateCampaignUrl, validategrid);
    
    function loadValidateCampaigns(url, grid) {
        $.ajax({
            type: 'GET',
            url: url,
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
            }
        });
    }
    
    $('#partner-sec-header .span-space').click(function() {
   	    var toptabs = $("#partner-tab-content").offset().top;
   	    window.scrollTo(toptabs,toptabs - 170);
    });
    
    var userId = $('#userId').val();
    var driveFileGrid = $('#driveFiles');
    var loadFilesUrl = baseUrl+'/user/loadDriveFiles?userId='+userId;
    $.ajax({
        type: 'GET',
        url: loadFilesUrl,
        success: function(data) {
            $(driveFileGrid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
        }
    });
    
    $('#savenewfolderbtn').click(function(event){
    	event.preventDefault();
    	if($('#createNewFolder').find('form').valid()){
    		$('#createNewFolder').modal("hide");
    		
    		var userId = $('#userId').val();
    	    var driveFileGrid = $('#docFolders');
    	    var loadFilesUrl = baseUrl+'/user/newfolder?userId='+userId+'&title='+$('#folderName').val();
    	    $.ajax({
    	        type: 'GET',
    	        url: loadFilesUrl,
    	        success: function(data) {
    	            $(driveFileGrid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
    	            
    	            $('.nav-tab-doc').find('.tab-data-toggle').removeClass('active');
    	            $('.doc-tab-files').addClass('active');
    	            
    	            $('#partner-doc-content').find('.tab-pane').removeClass('active');
    	            $('#files').addClass('active');
    	            $('#folderName').val('');
    	            $('#folderId').val('');
    	        }
    	    });
        }
    });
    
    $("#remove-folder").click(function(event) {
        if (confirm('Are you sure you want to discard this folder?')) {
            var folderId = $(this).val();
            var partnerId = $('#partnerId').val();
            var grid = $('#docFolders');
            
            $.ajax({
                type: 'GET',
                url: baseUrl+'/user/trashFolder?partnerId='+partnerId+'&folderId='+folderId,
                success: function(data) {
                    $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                    $('.nav-tab-doc').find('.tab-data-toggle').removeClass('active');
                    $('.doc-tab-files').addClass('active');
                    $('#viewfolder').hide();
                    $('#partner-doc-content').find('.tab-pane').removeClass('active');
                    $('#files').addClass('active');
                    $('#folderId').val('');
                    $('#remove-folder').val('');
                    $('.trash-docs-fixed-btn').hide();
                }
            });
        }
    });
    
    $("#remove-file").click(function(event) {
    	if (confirm('Are you sure you want to discard this file?')) {
            var url = $("#remove-file").val();
            var folderId = $('#folderId').val();

            $.ajax({
                type: 'GET',
                url: url,
                success: function(data) {
                    if (folderId) {
                        var driveFileGrid = $('#viewfolder');
                        $(driveFileGrid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                        $('.trash-file-fixed-btn').hide();
                        $('#remove-file').val('');
                    } else {
                        var driveFileGrid = $('#docFiles');
                        $(driveFileGrid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                        $('.trash-file-fixed-btn').hide();
                        $('#remove-file').val('');
                    }
                }
            });
        }
    });
    
    $("#remove-drive-file").click(function(event) {
    	if (confirm('Are you sure you want to discard this file?')) {
            var url = $("#remove-drive-file").val();
            var grid = $('#driveFiles');
            $.ajax({
                type: 'GET',
                url: url,
                success: function(data) {
                    $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                    $('.trash-drivefile-fixed-btn').hide();
                    $('#remove-drive-file').val('');
                }
            });
        }
    });
    
    $("#deletePartner").click(function(event) {
    	event.preventDefault();
        if (confirm('Are you sure you want to discard this partner?')) {
        	var deleteUrl = $(this).attr('href');
        	window.location.href = deleteUrl;
        }
    });
    
    $("#newDocFile").change(function(event) {
        var file =this.files[0];
        if (file.size > 0) {
            var file = this.files[0];
            var fileName = file.name;
            var formData = !!window.FormData ? new FormData() : null;
            var partnerId = $('#partnerId').val();
            var folderId = $('#folderId').val();
            formData.append('file', file);
            formData.append('partnerId', partnerId);
            formData.append('folderId', folderId);
            $('#loading-gif').show();
            var xhr = new XMLHttpRequest();
            xhr.open('POST', $("#b_url").val()+'/user/uploadDocument');
            xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
            
            // complete
            xhr.onreadystatechange = $.proxy(function() {
                if (xhr.readyState == 4) {
                    var data = xhr.responseText;
                    data = data.replace(/^\[/, '');
                    data = data.replace(/\]$/, '');

                    var json;
                    try {
                        json = (typeof data === 'string' ? $.parseJSON(data) : data);
                    } catch(err) {
                        json = { error: true };
                    }
                    
                    if (folderId) {
                    	var driveFileGrid = $('#viewfolder');
                        $(driveFileGrid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                        $('.nav-tab-doc').find('.tab-data-toggle').removeClass('active');
        	            
        	            $('#partner-doc-content').find('.tab-pane').removeClass('active');
        	            $('#viewfolder').addClass('active');
        	            $('#newDocFile').val('');
                    } else {
                    	var driveFileGrid = $('#docFiles');
                        $(driveFileGrid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                        $('.nav-tab-doc').find('.tab-data-toggle').removeClass('active');
        	            $('.doc-tab-files').addClass('active');
        	            
        	            $('#partner-doc-content').find('.tab-pane').removeClass('active');
        	            $('#files').addClass('active');
        	            $('#newDocFile').val('');
                    }
                    $('#loading-gif').hide();
                }
            }, this);
            xhr.send(formData);
        }
    });
    
    $('#add-docs-fixed-btn').find('.dropdown-menu .dropdown-doc-padding').click(function() {
    	var opts = $(this).attr('id');
    	if(opts == 'first') {
    		$('#newDocFile').click();
    	}
    });
    
    $( document ).ready(function() {
        function sticky_relocate() {
            var div_top = $('#footermarker').offset().top;
            var marker = $('#add-docs-fixed-btn').offset().top;
            if ((marker + 20) >= div_top) {
                $('#dropupbtn').hide();
                $('#remove-folder').hide();
                $('#remove-file').hide();
                $('#remove-drive-file').hide();
                $("#add-docs-fixed-btn.dropup.open").removeClass("open");
            } else if(marker  < div_top){
                $('#dropupbtn').show();
                $('#remove-folder').show();
                $('#remove-file').show();
                $('#remove-drive-file').show();
            }
        }
        $(window).scroll(sticky_relocate);
        sticky_relocate();
    });
    
});

$(function() {
    console.log("create.js initialized");
    
    $('#rewardTemplate').hide();
    
    $('.redactorEditor').redactor({
        imageUpload:'/project/getRedactorImage',
        focus: true,
        autosave: '/project/saveStory',
        autosaveInterval: 15, // seconds
        autosaveCallback: function(){
        	autoSave('story', this.code.get());
        },
        plugins: ['fontsize','fontfamily','fontcolor','video']
    });
    
    var currentEnv = $('#currentEnv').val();
    
    /********************* Create page Session timeout ***************************/
        var SessionTime = 60* 1000 * 60; //set for 60 minute
        var tickDuration = 1000;
        var myInterval = setInterval(function() {
        	SessionTimeout();
        }, 1000);
    
        function SessionTimeout() {
        	SessionTime = SessionTime - tickDuration;
        	if(SessionTime ==900000){
        		alert("15 minutes left for session timeout. Please save your data as draft or data will be lost.");
        	}else if (SessionTime <= 0) {
                alert("Your session has expired. Please login again.");
                $.ajax({
                    type:'post',
                    url:$("#b_url").val()+'/project/invalidateSession',
                    data:'status=true',
                    success: function(data){
                    	$('#test').html(data);
                    }
                }).error(function(){
                	alert('An error occured');
                });
                window.location.href =$("#b_url").val()+"/logout";   
             }   
       }
    /*********************************************************************/

    $("#payopt").show(); // paypal option
//    $("#paypalemail").hide(); // paypal button
    if ($('#payfir').val()) {
    	$("#paypalemail").hide();
    	$("#charitableId").show();
    }
    
    /* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });

    $('.multiselect').multiselect({
        numberDisplayed: 1,
        nonSelectedText: 'Choose multiple rewards'
    });

    /* Validate form on submit. */
    var validator = $('#campaigncreate').find('form').validate({
        rules: {
            firstName: {
                minlength: 2,
                required: true
            },
            lastName: {
                minlength: 2,
                required: true
            },
            email: {
                required: true,
                email: true
            },
            telephone: {
                required: false,
                isValidTelephoneNumber: true,
                maxlength: 20
            },
            addressLine1: {
                required: false
            },
            addressLine2: {
                required: false
            },
            city: {
                required: true
            },
            stateOrProvince: {
                required: true
            },
            postalCode: {
                required: true,
                maxlength: 10,
                minlength: 4
            },
            country: {
                required: true
            },
            description : {
            	required: true,
                minlength: 10,
                maxlength: 140
        	},
            days: {
                required: true
            },
            title: {
                required: true,
                minlength: 5,
                maxlength: 100
            },
            story: {
                required: true,
                minlength: 10,
                maxlength: 5000
            },
            videoUrl: {
                isYoutubeVideo: true
            },
            email1: {
                email: true,
                iscampaigncreator: true
            },
            email2: {
                email: true,
                iscampaigncreator: true,
                isequaltofirstadmin: true,
                isequaltothirdadmin: true
            },
            email3: {
                email: true,
                iscampaigncreator: true,
                isequaltofirstadmin: true,
                isequaltosecondadmin: true
            },
            checkBox:{
              required: true
            },
            checkBox2:{
              required: true
            },
            paypalEmail:{
              email:true,
              isPaypalEmailVerified : true,
              required: true
            },
            payuEmail:{
            	required:true,
            	email:true
            },
//            secretKey: {
//            	required:true,
//            },
            pay: {
            	required:true
            },
            charitableId: {
            	required:true
            },
            organizationName: {
            	required:true
            },
            webAddress: {
            	required:true,
            	isWebUrl:true
            },
            iconfile: {
            	required:true
            },
            answer: {
            	required:true
            }
        },
        messages:{
            thumbnail: "Please upload a thumbnail image for campaign",
            textfile: "Please upload your Letter of Determination",
            iconfile: "Please upload your organization logo"
        },
        errorPlacement: function(error, element) {
        	if ( element.is(":radio") ) {
                error.appendTo(element.parent().parent());
            } else if(element.is(":checkbox")) {
                error.appendTo(element.parent());
            } else if($(element).prop("id") == "projectImageFile") {
                error.appendTo(element.parent().parent());
            }else if($(element).prop("id") == "iconfile") {
                error.appendTo(element.parent().parent());
            }else{
                error.insertAfter(element);
            }
        },//end error Placement
        
        //ignore: []
    });
    
    $('.createsubmitbutton').click(function(event) {
        if(validator.form()){
        	needToConfirm = false;
        } 	
    });
    
    $.validator.addMethod('isPaypalEmailVerified', function (value, element) {
        var ack = $("#paypalEmailAck").val();
        var base_url = $("#b_url").val();
        if (base_url != 'https://crowdera.co'){
            if(ack == 'Failure') {
                return (ack == 'Success') ? ack : false;
            }
        }
        return true;
    }, "Please enter verified paypal email id");
    
    $('#campaigncreatebtn').on('click', function() {
    	if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
        	$("[name='amount']").rules("add", {
                required: true,
                number: true,
                min: 5000,
                maxlength: 6,
                max: 999999
            });
        } else {
        	$("[name='amount']").rules("add", {
                required: true,
                number: true,
                min: 500,
                maxlength: 6,
                max: 999999
            });
        }
    	if (validator.form()) {
    		$('#campaigncreatebtn').attr('disabled','disabled');
    		$('#campaigncreate').find('form').submit();
    	}
    });
    
    $('#submitProject').on('click', function() {
        var storyValue = $('.redactorEditor').redactor('code.get');
        var storyEmpty = false;
        if (storyValue == '' || storyValue == undefined){
            $('#storyRequired').show();
            storyEmpty = true;
        } else {
        $('#storyRequired').hide();
            storyEmpty = false;
        }

        $( "#projectImageFile" ).rules( "add", {
            required: true,
            messages: {
                required: "Please upload at least one campaign image"
            }
        });
        $('.rewardNumberAvailable').each(function () {
            $(this).rules("add", {
                required: true,
                number: true,
                min: 0
            });
        });
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
            $('.rewardPrice').each(function () {
                $(this).rules("add", {
                    required: true,
                    number: true,
                    maxlength: 6,
                    max: 999999,
                    min: 250
                });
            });
        } else {
        	$('.rewardPrice').each(function () {
                $(this).rules("add", {
                    required: true,
                    number: true,
                    maxlength: 6,
                    max: 999999,
                    min: 1
                });
            });
        }
        
    	if (validator.form()) {
    		$('#isSubmitButton').attr('value',false);
            if (!storyEmpty){
                $('#campaigncreate').find('form').submit();
                $('#submitProject').attr('disabled','disabled');
                $('#saveasdraft').attr('disabled','disabled');
            }
    	}
    });
    
    $('#saveasdraft').on('click', function(){  // capture the click
    	$('[name="pay"], [name="iconfile"],[name="organizationName"], [name="thumbnail"],[name="answer"], [name="wel"],[name="charitableId"], [name="webAddress"], [name="paypalEmail"]').each(function () {
            $(this).rules('remove');
        });
    	
    	$( "#projectImageFile" ).rules("remove");
    	
    	$('[name="pay"], [name="iconfile"],[name="organizationName"], [name="thumbnail"],[name="answer"], [name="wel"],[name="charitableId"], [name="webAddress"], [name="paypalEmail"]').each(function () {
            $(this).closest('.form-group').removeClass('has-error');
        });
    	
    	$("#createthumbnail").removeClass('has-error');
    	if (validator.form()) {
    		$('#isSubmitButton').attr('value',true);
    		$('#campaigncreate').find('form').submit();
    		$('#saveasdraft').attr('disabled','disabled');
    		$('#submitProject').attr('disabled','disabled');
    	}
    });

     $.validator.addMethod('isYoutubeVideo', function (value, element) {
        if(value && value.length !=0){
           var p = /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
           return (value.match(p)) ? RegExp.$1 : false;
        }
        return true;
     }, "Please upload a url of Youtube video");
     
     $.validator.addMethod('isValidTelephoneNumber', function (value, element) {
     	  
         if(value && value.length !=0){
             var reg = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;
             return (value.match(reg)) ? RegExp.$1 : false;
         }
         return true;
     }, "Please provide valid Telephone number");
     
     $.validator.addMethod('isWebUrl', function(value, element){
    	 if(value && value.length !=0){
          var p= /(?:(?:www):\/\/)?(?:www.)\/?/;
  	    	return (value.match(p))
    	 }
    	 return true;
     }, "Please provide valid url");
     
     $("input[name='answer']").change(function(){
     	if($(this).val()=="yes") {
     		count = 1;
     		$('#rewardCount').attr('value',count);
     		$("#rewardTemplate").show();
     	    $("#updatereward").show();
     	} else {
     		count = 0;
     		$('#rewardCount').attr('value',count);
     		$('#addNewRewards').find('.rewardsTemplate').find('input').val('');
     		$('#addNewRewards').find('.rewardsTemplate').find('#rewardDescription').val('');
     		$('#addNewRewards').find('.rewardsTemplate').find("input[type='checkbox']").attr('checked', false);
     	    $("#updatereward").hide();
          $('#addNewRewards').find('.rewardsTemplate').hide();
     	}
     });

     $("input[name='pay']").change(function(){
  	    if($(this).val()=="paypal") {
  	        $('#organizationName').find('input').val('');
  	       	$("#paypalemail").show();
  	        $("#charitableId").hide();
  	        $('#charitable').find('input').val('');
  	        $("#paypalcheckbox").show();
  	     } else if($(this).val()=="firstgiving") {
   	         $('#organizationName').find('input').val('');
  	       	 $("#charitableId").show(); 
  	         $("#paypalemail").hide();
  	         $("#paypalcheckbox").hide();
   	         $('#paypalemail').find('input').val('');
  	      }
  	 });

     $('#val3').change(function(){
        var c = $('#val3').val();
        if(c=='US'){
          $('#val1').show();
          $('#val2').hide();
        }
       else
        {
          $('#val1').hide();
          $('#val2').show();
        }  
    });
     
     $('.cr-img-start-icon').hover(function(){
     	$('.cr-start').attr('src',"//s3.amazonaws.com/crowdera/assets/start-Icon-White.png");
     	}).mouseleave(function(){
         $('.cr-start').attr('src',"//s3.amazonaws.com/crowdera/assets/start-Icon-Blue.png");
     });
     
     $('.cr-img-story-icon').hover(function(){
      	$('.cr-story').attr('src',"//s3.amazonaws.com/crowdera/assets/story-Icon-White.png");
      	}).mouseleave(function(){
          $('.cr-story').attr('src',"//s3.amazonaws.com/crowdera/assets/story-Icon-Blue.png");
      });
     
     $('.cr-img-admin-icon').hover(function(){
      	$('.cr-admin').attr('src',"//s3.amazonaws.com/crowdera/assets/admin-Icon---White.png");
      	}).mouseleave(function(){
          $('.cr-admin').attr('src',"//s3.amazonaws.com/crowdera/assets/admin-Icon---Blue.png");
      });
     
     $('.cr-img-perk-icon').hover(function(){
       	$('.cr-perk').attr('src',"//s3.amazonaws.com/crowdera/assets/perk-Icon-White.png");
       	}).mouseleave(function(){
           $('.cr-perk').attr('src',"//s3.amazonaws.com/crowdera/assets/perk-Icon-Blue.png");
       });
     
     $('.cr-img-payment-icon').hover(function(){
       	$('.cr-payment').attr('src',"//s3.amazonaws.com/crowdera/assets/payment-Icon-White.png");
       	}).mouseleave(function(){
           $('.cr-payment').attr('src',"//s3.amazonaws.com/crowdera/assets/payment-Icon-Blue.png");
       });
     
     $('.cr-img-launch-icon').hover(function(){
       	$('.cr-launch').attr('src',"//s3.amazonaws.com/crowdera/assets/launch-Icon--White.png");
       	}).mouseleave(function(){
           $('.cr-launch').attr('src',"//s3.amazonaws.com/crowdera/assets/launch-Icon--Blue.png");
       });
     
     $('#payment').change(function(){
    	 var pay = $('#payment').val();
    	 if(pay=='FIR'){
    		 $('#paypalemail').hide();
    		 $('#charitableId').show();
    		 
    	 }else if(pay=='PAY'){
    		 $('#charitableId').hide();
    		 $('#paypalemail').show();
    	 }else if(pay=='PMT'){
    		 if(pay == 'selected'){
    			 $('#paypalemail').show();
    		 }
    		 $('#paypalemail').hide();
    		 $('#charitableId').hide();
    	 }
     });
     
     $('#payment').change(function(){
    	 var payind = $('#payment').val();
    	 if(payind=='PAYU'){
    		 $('#PayUMoney').show();
    	 }
     });
     
	$('#countryList').change(function(){
	    var c = $('#countryList').val();
	    if(c=='IN'){
	       	$('#stateList').show();
	       	$('#txtState').hide();
	    }else{
	       	$('#stateList').hide();
	       	$('#txtState').show();
	    }  
	});

      /******************************Video Thumbnail***************************************/
     
    if($('#addvideoUrl').val()) {
        var url= $('#videoUrl').val().trim();
        $('#ytVideo').show();
        $('#media').hide();
        $('#media-video').show();
        var vurl=url.replace("watch?v=", "v/");
        $('#ytVideo').html('<iframe style="width:192%;height:194px; display:block;" src='+ vurl +'></iframe>');
    }
	$('#add').on('click',function(){
        $( "#videoUrl" ).rules( "add", {
            isYoutubeVideo: true
        });
        var youtube = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
        //var vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/
        var url= $('#videoUrl').val().trim();
        var match = url.match(youtube);
        if (match && match[2].length == 11) {
            $('#ytVideo').show();
            $('#media').hide();
            $('#media-video').show();
            var vurl=url.replace("watch?v=", "v/");
            $('#ytVideo').html('<iframe style="width:192%;height:194px; display:block;" src='+ vurl +'></iframe>');
        } else if($(this)){
            $('#ytVideo').hide();
            $('#media').show();
            $('#media-video').hide();
        }
    });
    $('#videoUrl').change(function(){
        $('#ytVideo').hide();
        var selectedVideoUrl = $(this).val();
        autoSave('videoUrl', selectedVideoUrl);
    });

     /** ********************Organization Icon*************************** */

    $("#iconfile").change(function(event) {
        var file =this.files[0];
        if(validateExtension(file.name) == false){
	        $('#icondiv').hide();
	        $('#iconfilesize').hide();
	        $('#logomsg').show();
	        $('#logomsg').html("Add only PNG or JPG extension image");
	        this.value=null;
	        return;
	    }
	    if(!file.type.match('image')){
	        $('#icondiv').hide();
	        $('#iconfilesize').hide();
	        $('#logomsg').show();
	        this.value=null;
	    } else{
	        if (file.size > 1024 * 1024 * 3) {
	            $('#icondiv').hide();
	            $('#logomsg').hide();
	            $('#iconfilesize').show();
	            $('#iconfile').val('');
	        } else {
                $('#icondiv').show();
                $('#logomsg').hide();
                $('#iconfilesize').hide();
                var file = this.files[0];
                var fileName = file.name;
                var fileSize = file.size;
        
                var picReader = new FileReader();
                picReader.addEventListener("load",function(event) {
                    var picFile = event.target;
                    $('#imgIcon').attr('src',picFile.result);
                    $('#delIcon').attr('src',"//s3.amazonaws.com/crowdera/assets/delete.ico");
               });
               // Read the image
               picReader.readAsDataURL(file);
	        }
	    } 
    });


     /*******************************Description text length******************** */
    var counter = 1;
    $('#descarea').on('keydown', function(event) {
    
    event.altKey==true;
    var currentString = $('#descarea').val().length;
    if(currentString <=139) {
        var text = currentString + 1;
    }
    if (event.keyCode > 31) {
      if(event.altKey==true){
        setDescriptionText();
      }
      else{
    	  if(currentString <139)
          currentString++;
          $('#desclength').text(text);
      }

    } else {
          currentString--;
          $('#desclength').text(text);
      }
  }).keyup(function(e) {
      
    if(e.altKey==true){
        setDescriptionText();
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
        setDescriptionText();
        break;
      case 16:      //shift
       setDescriptionText();
       break;
    }
  }).focus(function(){
        setDescriptionText();
    }).focusout(function(){
        setDescriptionText();
  });
  
  function setDescriptionText(){
     
    var currentString = $('#descarea').val().length;
    if (currentString == 0) {
      $('#desclength').text("0");
    } 
    else {
      currentString = currentString;
      $('#desclength').text(currentString);
    }
  }
  
  /*******************************Title text length******************** */
  var counter = 1;
  $('#campaignTitle').on('keydown', function(event) {
  
  event.altKey==true;
  var currentstring = $('#campaignTitle').val().length;
  if(currentstring <=54) {
      var text = currentstring + 1;
  }
  if (event.keyCode > 31) {
    if(event.altKey==true){
    	setTitleText();
    }
    else{
  	  if(currentstring <54)
  		currentstring++;
        $('#titleLength').text(text);
    }

  } else {
	  currentstring--;
        $('#titleLength').text(text);
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

function setTitleText(){
   
  var currentstring = $('#campaignTitle').val().length;
  if (currentstring == 0) {
    $('#titleLength').text("0");
  } 
  else {
	  currentstring = currentstring;
    $('#titleLength').text(currentstring);
  }
}
     
      /** *************************Multiple Image Selection*************** */
    var isvalidsize =  false;
    $('#projectImageFile').change(function(event) {
        var file =this.files[0];
        if(validateExtension(file.name) == false){
        	 $('.pr-thumbnail-div').hide();
        	 $('#imgmsg').show();
        	 $('#imgmsg').html("Add only PNG or JPG extension images");
             $('#campaignfilesize').hide();
             this.value=null;
             return;
        }
        if(!file.type.match('image')){
            $('.pr-thumbnail-div').hide();
            $('#imgmsg').show();
            $('#campaignfilesize').hide();
            this.value=null;
        } else{
            $('#imgmsg').hide();
            $('#campaignfilesize').hide();
            var files = event.target.files; // FileList object
            var output = document.getElementById("result");
            var fileName;
            var isFileSizeExceeds = false;
            for ( var i = 0; i < files.length; i++) {
                var file = files[i];
                var filename = file.name;
                if(file.size < 1024 * 1024 * 3) {
                	isvalidsize =  true;
                    var picReader = new FileReader();
                    picReader.addEventListener("load",function(event) {
                        var picFile = event.target;
                        var div = document.createElement("div");
                        div.innerHTML = "<div id=\"imgdiv\" class=\"pr-thumbnail-div\"><img  class='pr-thumbnail' src='"+ picFile.result+ "'"+ "title='"
                            + file.name + "'/><div class=\"deleteicon\"><img onClick=\"$(this).parents('#imgdiv').remove();\" src=\"//s3.amazonaws.com/crowdera/assets/delete.ico\" style=\"margin:2px;width:10px;height:10px;\"/></div>"+ "</div>";
                            output.insertBefore(div, null);
                    });
                    // Read the image
                    picReader.readAsDataURL(file);
                } else {
                	if (fileName) {
                	    fileName = fileName +" "+ file.name;
                	} else {
                		fileName = file.name;
                	}
                	$('#campaignfilesize').show();
                	isFileSizeExceeds = true;
                }
                
            }
            document.getElementById("campaignfilesize").innerHTML= "The file " +fileName+ " you are attempting to upload is larger than the permitted size of 3MB.";
            if (isFileSizeExceeds && !isvalidsize) {
                $('#projectImageFile').val('');
            }
        }
    });
    
    function validateExtension(imgExt)
    {
          var allowedExtensions = new Array("jpg","JPG","png","PNG");
          for(var imgExtImg=0;imgExtImg<allowedExtensions.length;imgExtImg++)
          {
              imageFile = imgExt.lastIndexOf(allowedExtensions[imgExtImg]);
              if(imageFile != -1){
            	  return true;
              }
          }
          return false;
    }
    
    $('#createreward').click(function(){
        count++;
        var str ='<div class="rewardsTemplate cr-perks-spec" id="rewardTemplate">'+
        
        '<div class="col-sm-2">'+
           '<div class="form-group">'+
               '<div class="col-sm-12">';
        
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
           	str = str + '<span class="cr2-currency-label fa fa-inr cr-perks-amts"></span>';
             }else{
           	str = str + '<span class="cr2-currency-label">$</span>' ;
             }
               
             str = str +  '<input type="text" placeholder="Amount"  name="rewardPrice'+count+'" id="rewardPrice'+count+
                       '" style="width:100%;" class="form-control cr-input-digit rewardPrice">'+
           '</div>'+
       '</div>'+
    '</div>'+
       
    '<div class="col-sm-5">'+
       '<div class="form-group">'+
           '<div class="col-sm-12">'+
              '<input type="text" placeholder="Name of Perk" name="rewardTitle'+count+'" id="rewardTitle'+count+
                      '"  class="form-control cr-perk-title-number required">'+
           '</div>'+
       '</div>'+
    '</div>'+
    
    '<div class="col-sm-5">'+
       '<div class="form-group">'+
           '<div class="col-sm-12">'+
               '<input type="text" placeholder="Number available" name="rewardNumberAvailable'+count+'" id="rewardNumberAvailable'+count+'" class="form-control rewardNumberAvailable cr-perk-title-number">'+
           '</div>'+
       '</div>'+
    '</div>'+
  
   '<div class="form-group row">'+
       '<div class="col-sm-12">'+
           '<div class="col-sm-12">'+
             '<textarea class="form-control required rewardDescription" name="rewardDescription'+count+
                '" id="rewardDesc'+count+'" rows="2" placeholder="Description" maxlength="250"></textarea>'+
                '<p class="cr-perk-des-font">Please refer to our Terms of Use for more details on perks.</p>'+
           '</div>'+
       '</div>'+
   '</div>'+
   '<div class="col-sm-12">'+
       '<div class="form-group">'+
           '<div class="btn-group col-sm-12 cr-perk-check" data-toggle="buttons">'+
               '<label class="btn btn-default col-sm-3 col-xs-12"><input type="checkbox" name="mailingAddress'+count+'" value="true" id="mailaddcheckbox'+count+'">Mailing address</label>'+
               '<label class="btn btn-default col-sm-3 col-xs-12"><input type="checkbox" name="emailAddress'+count+'" value="true" id="emailcheckbox'+count+'">Email address</label>'+
               '<label class="btn btn-default col-sm-3 col-xs-12"><input type="checkbox" name="twitter'+count+'" value="true" id="twittercheckbox'+count+'">Twitter handle</label>'+
               '<input type="text" name="custom'+count+'" id="customcheckbox'+count+'" class="customText" placeholder="Custom">'+
           '</div>'+
       '</div>'+
   '</div>'+
 '</div>';
        $('#addNewRewards').append(str);
        $('#rewardCount').attr('value',count);
     });  
    
  $('#removereward').click(function(){
    if($('#addNewRewards').find('.rewardsTemplate').length > 1) {
         count--;
         $('#rewardCount').attr('value',count);
         $('#addNewRewards').find('.rewardsTemplate').last().remove();
    }else{
         $('.rewardTitle').val('');
         $('.rewardDescription').val('');
         $('.rewardPrice').val('');
    }
  });
     
     $.validator.addMethod('isequaltofirstadmin', function(value, element){
    	 var emailId = $('#firstadmin').val();
 	     if(value.length != 0 && value == emailId) {
 	         return (!value == emailId)
 	     }
     	 return true;
     }, "This Co-creator is already added");
     
     $.validator.addMethod('isequaltosecondadmin', function(value, element){
    	 var emailId = $('#secondadmin').val();
     	 if(value.length != 0 && value == emailId) {
     	     return (!value == emailId)
     	 } 
     	 return true;
     }, "This Co-creator is already added");
     
     $.validator.addMethod('isequaltothirdadmin', function(value, element){
    	 var emailId = $('#thirdadmin').val();
 	     if(value.length != 0 && value == emailId) {
 	         return (!value == emailId)
 	     } 
     	 return true;
     }, "This Co-creator is already added");
     
     $.validator.addMethod('iscampaigncreator', function(value, element){
    	 var emailId = $('#email').val();
    	 if(value.length != 0 && value == emailId) {
    		 return (!value == emailId)
    	 }
    	 return true;
     }, "Campaign creator cannot be added as a Co-creator");

    /* Click handler for Myself/Someone I Know. */
    /*
    $('#fundRaisingFor').change(function(event) {
        var optionChosen = $(this).val(),
            nameEl = $('#name'),
            emailEl = $('#email');

        if (optionChosen == 'MYSELF') {
            validator.resetForm();

            nameEl.closest('.form-group').removeClass('has-error');
            nameEl.val(function() {
                return $(this).attr('value');
            });
            nameEl.prop('disabled', true);

            emailEl.closest('.form-group').removeClass('has-error');
            emailEl.val(function() {
                return $(this).attr('value');
            });
            emailEl.prop('disabled', true);
        } else if (optionChosen == 'OTHER') {
            nameEl.prop('disabled', false);
            emailEl.prop('disabled', false);
        }
    });
    */

    $(document).ready(function (){
        //called when key is pressed in textbox
        $("#amount").keypress(function (e) {
            //if the letter is not digit then display error and don't type anything
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                //display error message
                $("#errormsg").html("Digits Only").show().fadeOut("slow");
                return false;
            } 
        });

        $("form").on("click", ".rewardPrice", function () {
          $('.rewardPrice').each(function () {
              $(this).keypress(function (e) {
                //if the letter is not digit then display error and don't type anything
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                  //display error message
                  return false;
                } 
              });
          });
        });
   });
    
   $('#paypalEmailId').change(function(){
       var base_url = $("#b_url").val();
       if (base_url != 'https://crowdera.co'){
           var email =  $('#paypalEmailId').val();
           $.ajax({
               type:'post',
               url:$("#b_url").val()+'/project/paypalEmailVerification',
               data:'email='+email,
               success: function(data){
                   $('#paypalEmailAck').val(data);
                   if (data == 'Success') {
                       $('.paypalVerification').find("span").remove();
                       $('.paypalVerification').closest(".form-group").removeClass('has-error');
                   }
               }
           }).error(function(){
               alert('An error occured');
           });
        }
    });
   
    $('#category').change(function(){
        var selectedCategory = $(this).val();
        autoSave('category', selectedCategory);
    });
   
    $('#country').change(function(){
        var selectedCountry = $(this).val();
        autoSave('country', selectedCountry);
    });
    
//    $('#firstadmin').change(function(){
//        var emailValue = $(this).val();
//        autoSave('email1', emailValue);
//    });
//    
//    $('#secondadmin').change(function(){
//        var emailValue = $(this).val();
//        autoSave('email2', emailValue);
//    });
//    
//    $('#thirdadmin').change(function(){
//        var emailValue = $(this).val();
//        autoSave('email3', emailValue);
//    });
    
    $('#organizationname').blur(function (){
    	var name = $(this).val();
    	autoSave('organizationname', name);
    });
    
    $('#webAddress').blur(function (){
    	var webAddress = $(this).val();
    	autoSave('webAddress', webAddress);
    });
    
    $('#firstName').blur(function (){
        var firstName = $(this).val();
        autoSave('firstName', firstName);
    });

    $('#lastName').blur(function (){
        var lastName = $(this).val();
        autoSave('lastName', lastName);
    });

    $('#telephone').blur(function (){
        var telephone = $(this).val();
        autoSave('telephone', telephone);
    });
    
    $('#paypalEmailId').blur(function (){
        var paypalEmailId = $(this).val();
        $('#charitable').find('input').val('');
        autoSave('paypalEmailId', paypalEmailId);
    });
    
    $('#payuemail').blur(function (){
        var payUEmailId = $(this).val();
        autoSave('payuEmail', payUEmailId);
    });
    
    $('#secretKey').blur(function (){
        var secretKey = $(this).val();
        autoSave('secretKey', secretKey);
    });

    function autoSave(variable, varValue) {
        var projectId = $('#projectId').val();
        $.ajax({
            type:'post',
            url:$("#b_url").val()+'/project/autoSave',
            data:'projectId='+projectId+'&variable='+variable+'&varValue='+varValue,
            success: function(data) {
                $('#test').val('test');
            }
        }).error(function() {
            alert('An error occured');
        });
     }
    
    $('#saveButton').click(function (){
    	var uuid = $('#uuid').val();
    	var charityName = $('#charity_name').val();
    	$('#charitable').find('input').val(uuid);
		$('#organizationName').find('input').val(charityName);
		$('#paypalemail').find('input').val('');
		autoSave('charitableId', uuid);
        var delay = 15; //delayed code to prevent error
        setTimeout(function() {
            autoSave('organizationname', charityName);
        }, delay);
    });
    
    $('#impact').click(function(){
        $('#usedFor').val('IMPACT');
    });

    $('#passion').click(function(){
        $('#usedFor').val('PASSION');
    });

    $('#innovating').click(function(){
        $('#usedFor').val('SOCIAL_NEEDS');
    });

    $('#personal').click(function(){
        $('#usedFor').val('PERSONAL_NEEDS');
    });
    
    $('#person').click(function(){
        autoSave('fundsRecievedBy', 'PERSON');
    });
    
    $('#non-profit').click(function(){
        autoSave('fundsRecievedBy', 'NON-PROFITS');
    });
    
    $('#ngo').click(function(){
        autoSave('fundsRecievedBy', 'NGO');
    });
    
    $('#others').click(function(){
        autoSave('fundsRecievedBy', 'OTHERS');
    });
    
/*Javascript error raised due to tooltip is resolved*/
    /* Show pop-over tooltip on hover for some fields. */
    var showPopover = function () {
            $(this).popover('show');
        },
        hidePopover = function () {
            $(this).popover('hide');
        };

    /* Initialize pop-overs (tooltips) */
   /* $("input[name='days']").popover({
        content: 'Number of days to raise the funds by.',
        trigger: 'manual',
        placement: 'top'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);*/
});

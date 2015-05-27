$(function() {
    console.log("create.js initialized");

    $('#logomsg').hide();
    $('#imgmsg').hide();
    $('#iconfilesize').hide();
    $('#campaignfilesize').hide();
  /*********************************************************************/

    $("#updatereward").hide();
    $("#rewardTemplate").hide();
    
    $("#paypalcheckbox").hide();

    $('#val2').hide();

    $("#charitableId").hide();
    $("#icondiv").hide();
        
    $("#payopt").show(); // paypal option
    $("#paypalemail").hide(); // paypal button
    
    /* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });

    $('.multiselect').multiselect({
        numberDisplayed: 1,
        nonSelectedText: 'Choose multiple rewards'
    });

    /* Validate form on submit. */
    var validator = $('form').validate({
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
            amount: {
                required: true,
                number: true,
                maxlength: 6,
                max: 500000
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
            /*
            imageUrl: {
                url: true
            }
            */
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
    
    $('#submitProject').on('click', function() {
    	$('[name="pay"], [name="iconfile"],[name="organizationName"],[name="thumbnail"],[name="answer"],[name="wel"],[name="charitableId"]').each(function () {
            $(this).rules('add', {
                required: true
            });
        });
    	$("[name='webAddress']").rules("add", {
    		isWebUrl: true,
    		required: true
    	});
    	$('[name="paypalEmail"]').rules("add", {
    		required: true,
        	email:true
    	});
        $( "#projectImageFile" ).rules( "add", {
            required: true,
            messages: {
                required: "Please upload at least one campaign image"
            }
        });
    	
    	if (validator.form()) {
    		$('#isSubmitButton').attr('value',false);
    		$('#campaigncreate').find('form').submit();
    		$('#submitProject').attr('disabled','disabled');
    		$('#saveasdraft').attr('disabled','disabled');
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

      /******************************Video Thumbnail***************************************/
     
     $('#videoUrl').change(function(){
          var regExp = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
          var url= $('#videoUrl').val().trim();
          var match = url.match(regExp);
        
          if (match && match[2].length == 11) {
              $('#ytVideo').show();
              var vurl=url.replace("watch?v=", "v/");
              $('#ytVideo').html('<iframe style="width:200px;height:100px; display:block;" src='+ vurl +'></iframe>');
          }else if($(this)){
              $('#ytVideo').hide();
          }
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
  if(currentstring <=99) {
      var text = currentstring + 1;
  }
  if (event.keyCode > 31) {
    if(event.altKey==true){
    	setTitleText();
    }
    else{
  	  if(currentstring <99)
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
     $('#addNewRewards').append(
         '<div class="rewardsTemplate" id="rewardTemplate">'+
           '<div>'+
             '<div class="form-group col-sm-6">'+
                '<label class="col-sm-4 control-label">Perk Title</label>'+
                '<div class="col-sm-8 rewardTitle">'+
                   '<input type="text" placeholder="Title" name="rewardTitle'+count+'" id="rewardTitle'+count+
                      '"  class="form-control required rewardTitle">'+
                '</div>'+
              '</div>'+
              '<div class="form-group col-sm-6 rewardPriceClass">'+
                 '<label class="col-sm-3 control-label" id="lblrPrice">Perk Price</label>'+
                 '<div class="col-sm-9 rewardPriceDiv">'+
                   '<input type="number" placeholder="Enter digits only"  name="rewardPrice'+count+'" id="rewardPrice'+count+
                      '" style="width:100%;" class="form-control  rewardPrice required" min="0" >'+
                  '</div>'+
              '</div>'+
            '</div>'+
            '<div class="form-group row">'+
                '<div class="col-sm-12">'+
                   '<label class="col-sm-2 control-label rewarddesctitle">Perk Description</label>'+
                    '<div class="col-sm-10">'+
                      '<textarea class="form-control required rewardDescription" name="rewardDescription'+count+
                         '" id="rewardDesc'+count+'" rows="2" placeholder="Description" maxlength="250"></textarea>'+
                    '</div>'+
                '</div>'+
            '</div>'+
            '<div class="form-group row">'+
                '<div class="col-sm-12">'+
                    '<div class="col-sm-2">'+
                        '<label class="control-label">Which of the following is necessary to ship this perk:</label>'+
                    '</div>'+
                    '<div class="col-sm-10 shippingreward">'+
                        '<label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="mailingAddress'+count+'" value="true" id="mailaddcheckbox'+count+'">Mailing address</label>'+
                        '<label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="emailAddress'+count+'" value="true" id="emailcheckbox'+count+'">Email address</label>'+
                        '<label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="twitter'+count+'" value="true" id="twittercheckbox'+count+'">Twitter handle</label>'+
                        '<label class="btn btn-primary btn-sm checkbox-inline control-label lblCustom"><input type="checkbox" name="custom'+count+'" value="true" id="customcheckbox'+count+'">Custom</label>'+
                    '</div>'+
                '</div>'+
            '</div><hr>'+
          '</div>'
      );
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
                  $(this).val('');
                  return false;
                } 
              });
          });
        });
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

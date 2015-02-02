$(function() {
    console.log("create.js initialized");

    $('#logomsg').hide();
    $('#imgmsg').hide();
    /********************* Create page Session timeout ***************************/
  var SessionTime = 60*1000*5; //set for 1 minute
  var tickDuration = 1000;
  var count = 1;
  var myInterval = setInterval(function() {
    SessionTime = SessionTime - tickDuration
  }, 1000);

  var myTimeOut = setTimeout(SessionExpireEvent, SessionTime);
  function SessionExpireEvent() {
    clearInterval(myInterval);
  }

  function SessionTimeout() {
    if (SessionTime <= 0) {
      alert("Your session has expired. Please login again.");
      window.location.href =$("#b_url").val()+"/logout";
      
    }

  }

  $("#submitProject").click(function() {

    SessionTimeout();

  });
  
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
            charitableId: {
                required: true
            },
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
                number: true,
                maxlength: 10,
                minlength: 4
            },
            country: {
                required: true
            },
            amount: {
                required: true,
                number: true,
                maxlength: 5,
                max: 50000
            },
            days: {
                required: true
            },
            title: {
                required: true,
                minlength: 5,
                maxlength: 140
            },
            description: {
                required: true,
                minlength: 10,
                maxlength: 140
            },
            story: {
                required: true,
                minlength: 10,
                maxlength: 5000
            },
            thumbnail: {
                required: true
            },
            videoUrl: {
                isYoutubeVideo: true
            },
            answer: {
            	required: true
            },
             wel:{
                required: true
            },
             organizationName: {
                required: true
            },
            webAddress: {
            	isWebUrl: true,
            	required: true
            },
            textfile: {
                required: true
            },
            iconfile: {
                required: true
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
            paypalEmail:{
            	required: true,
            	email:true
            },
            pay:{
            	required: true
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
            }else{ 
                error.insertAfter(element);
            }
        },//end error Placement
        
        //ignore: []
    });

    $( "#projectImageFile" ).rules( "add", {
      required: true,
      messages: {
        required: "Please upload at least one campaign image"
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
     
     $('#videoUrl').focus(function(){
       
     }).change(function(){
          var regExp = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
          var url= $('#videoUrl').val().trim();
          var match = url.match(regExp);
        
          if (match && match[2].length == 11) {
              $('#ytVideo').show();
              var vurl=url.replace("watch?v=", "v/");
              $('#ytVideo').html('<iframe style="width:200px;height:100px; display:block;" src='+ vurl +'></iframe>');
          }else if($(this).val('')){
              $('#ytVideo').hide();
          }
     });


     /** ********************Organization Icon*************************** */

  $('#chooseFile').click(function(event) {
    event.preventDefault();
    $('#iconfile').trigger('click');
  });

  $("#iconfile").on("change",function() {
          var file =this.files[0];
          if(!file.type.match('image')){
            $('#icondiv').hide();
            $('#logomsg').show();
            this.value=null;
          }else{
            $('#icondiv').show();
            $('#logomsg').hide();
            var file = this.files[0];
            var fileName = file.name;
            var fileSize = file.size;
            
            var picReader = new FileReader();
            picReader.addEventListener("load",function(event) {
                      var picFile = event.target;
                      $('#imgIcon').attr('src',picFile.result);
                      $('#delIcon').attr('src',"/images/delete.ico");
            });
            // Read the image
            picReader.readAsDataURL(file);
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
     
      /** *************************Multiple Image Selection*************** */

    $('#projectImageFile').change(function(event) {
        var file =this.files[0];
        if(!file.type.match('image')){
            $('.pr-thumbnail-div').hide();
            $('#imgmsg').show();
            this.value=null;
        }else{
            $('#imgmsg').hide();
            var files = event.target.files; // FileList object
            var output = document.getElementById("result");
            for ( var i = 0; i < files.length; i++) {
                var file = files[i];
                var filename = file.name;
                var picReader = new FileReader();
                picReader.addEventListener("load",function(event) {
                    var picFile = event.target;
                    var div = document.createElement("div");
                    div.innerHTML = "<div id=\"imgdiv\" class=\"pr-thumbnail-div\"><img  class='pr-thumbnail' src='"+ picFile.result+ "'"+ "title='"
                        + file.name + "'/><div class=\"deleteicon\"><img onClick=\"$(this).parents('#imgdiv').remove();\" src=\"/images/delete.ico\" style=\"margin:2px;width:10px;height:10px;\"/></div>"+ "</div>";
                        output.insertBefore(div, null);
                    });
                // Read the image
                picReader.readAsDataURL(file);
            }
        }
    });
     
  $('#createreward').click(function(){
     count++;
     $('#addNewRewards').append(
         '<div class="rewardsTemplate" id="rewardTemplate">'+
           '<div class="form-group">'+
             '<div class="col-sm-6">'+
                '<label class="col-sm-4 control-label">Perk Title</label>'+
                '<div class="col-sm-8 rewardTitle">'+
                   '<input type="text" placeholder="Title" name="rewardTitle'+count+'" id="rewardTitle'+count+
                      '"  class="form-control required rewardTitle">'+
                '</div>'+
              '</div>'+
              '<div class="col-sm-6">'+
                 '<label class="col-sm-3 control-label" id="lblrPrice">Perk Price</label>'+
                 '<div class="col-sm-9">'+
                   '<input type="number" placeholder="Enter digits only"  name="rewardPrice'+count+'" id="rewardPrice'+count+
                      ' style="width:100%;" class="form-control  rewardprice " required min="0" >'+
                  '</div>'+
              '</div>'+
            '</div>'+
            '<div class="form-group row">'+
                '<div class="col-sm-12">'+
                   '<label class="col-sm-2 control-label rewarddesctitle">Perk Description</label>'+
                    '<div class="col-sm-10">'+
                      '<textarea class="form-control required rewardDescription" name="rewardDescription'+count+
                         '" id="rewardDesc'+count+'" rows="2" placeholder="Description" maxlength="140"></textarea>'+
                    '</div>'+
                '</div>'+
            '</div>'+
            '<div class="form-group row">'+
                '<div class="col-sm-12">'+
                    '<div class="col-sm-2">'+
                        '<label class="control-label">Which of the following is necessary to ship this perk:</label>'+
                    '</div>'+
                    '<div class="col-sm-10">'+
                        '<label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="mailingAddress'+count+'" value="true" id="mailaddcheckbox'+count+'">Mailing address</label>'+
                        '<label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="emailAddress'+count+'" value="true" id="emailcheckbox'+count+'">Email address</label>'+
                        '<label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="twitter'+count+'" value="true" id="twittercheckbox'+count+'">Twitter handle</label>'+
                        '<label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="custom'+count+'" value="true" id="customcheckbox'+count+'">Custom</label>'+
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

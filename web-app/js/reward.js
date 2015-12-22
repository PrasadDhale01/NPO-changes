$(function() {
    console.log('reward.js initialized');
    $('.shippingError').hide();
    $('#createRewardModal').find('form').validate({
        rules: {
            title: {
            	required: true,
                minlength: 2,
                maxlength: 55
            },
            numberAvailable: {
                required: true,
                number: true,
                min: 0
            },
            description: {
                required: true,
                minlength: 5,
                maxlength: 250
            },
            price: {
                required: true,
                number: true,
                max : 999999,
                isPerk:true,
                min: function() {
                	var isINR = $('#isINR').val();
                    if (isINR == undefined) {
                        return 0;
                    } else {
                        return 100;
                    }
                }
            }
        }
    });

    $('.editperks').each(function () {
        $(this).find('form').validate({
        	rules: {
        		title: {
                	required: true,
                    minlength: 2
                },
                description: {
                    required: true,
                    minlength: 5,
                    maxlength: 250
                },
                numberAvailable: {
                    required: true,
                    number: true,
                    min: 0
                },
                price: {
                    required: true,
                    number: true,
                    max : 999999,
                    isPerk:true,
                    min: function() {
                    	var isINR = $('#isINR').val();
                        if (isINR == undefined) {
                            return 0;
                        } else {
                            return 100;
                        }
                    }
                }
        	}
        });
    });
    
    $('.perkPrice').each(function () {
    	$(this).keypress(function (e) {
            //if the letter is not digit then display error and don't type anything
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                //display error message
                $(".errormsg").html("Digits Only").show().fadeOut("slow");
                return false;
            } 
        });
    });
    
    $.validator.addMethod('isPerk', function (value, element) {
        var price =  $('.perkPrice').val();
        var cAmount = parseFloat($('#cAmount').val());
        if(value > cAmount){
           return false;
        }
        return true;
    }, "Enter a price less than Campaign amount: " +$('#cAmount').val());

    $("#perkPrice").keypress(function (e) {
            //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                //display error message
            $("#errormsg").html("Digits Only").show().fadeOut("slow");
            return false;
        } 
    });
    
    /****************************Edit Shipping Perk**************************************************/
//    $.validator.addMethod('editShippingInfo', function(value) {
//      var si = 0;
//  	  var checkbox = $('.editShippingInfo:checked').size();
//  	  var custom = $('#custombox').val();
//  	  if (custom) {
//  		  si = si+1;
//  	  } else {
//  		  si = checkbox;
//  	  }
//  	  if(si >0){
//  		  $('.editShippingreward').removeClass('dynCSS');
//  		  $('.editShippingError').hide();
//  		  return true;
//  	  }else{
//  		  $('.editShippingreward').addClass('dynCSS');
//  		  $('.editShippingError').html('This field is required').show();	  
//  	  }
//    }, '');
    
    $('.perkForm').submit(function() {
        if($(".perkForm").valid()) {
            $('#btnCreatePerk').prop('disabled',true);
        }
    });
    
    /***************************Create Shipping Perk***********************************************************************/
    
    $.validator.addMethod('shippingInfo', function(value) {
      var si = 0;
	  var checkbox = $('.shippingInfo:checked').size();
	  var custom = $('#custombox').val();
	  if (custom) {
		  si = si+1;
	  } else {
		  si = checkbox;
	  }
	  if(si >0){
		  $('.shippingreward').removeClass('dynCSS');
		  $('.shippingError').hide();
		  return true;
	  }else{
		  $('.shippingreward').addClass('dynCSS');
		  $('.shippingError').html('This field is required').show();	  
	  }
    }, '');

     /*******************************Description text length******************** */
    var counter = 1;
    $('#rewarddescarea').on('keydown', function(event) {
    
    event.altKey==true;
    var currentString = $('#rewarddescarea').val().length;
    if(currentString >= 4){
        $('.createDescDiv').find("span").remove();
        $('.createDescDiv').closest(".form-group").removeClass('has-error');
    }
    if(currentString <= 250) {
        if (currentString == 250) {
    		var text = currentString;
    	} else {
    		var text = currentString + 1;
    	}
    }
    if (event.keyCode > 31) {
      if(event.altKey==true){
        setDescriptionText();
      }
      else{
          if(currentString < 249)
          currentString++;
          $('.desclength').text(text+'/250');
      }

    } else {
          currentString--;
          $('.desclength').text(text+'/250');
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
     
    var currentString = $('#rewarddescarea').val().length;
    if (currentString == 0) {
      $('.desclength').text("0/250");
    } 
    else {
      currentString = currentString;
      $('.desclength').text(currentString+'/250');
    }
  }
  
   /* Show pop-over tooltip on hover for some fields. */
    var showPopover = function () {
        $(this).popover('show');
    },
    hidePopover = function () {
        $(this).popover('hide');
    };
    
    $('.supporterExist').each(function(){    
        $(this).popover({
            content: 'This perk can\'t be edited as it is already selected by a contributor',
            trigger: 'manual',
            placement: 'left'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);
    });
    
    $(".defaultperk").popover({
        content: 'Default perk can\'t be edited',
        trigger: 'manual',
        placement: 'left'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
});

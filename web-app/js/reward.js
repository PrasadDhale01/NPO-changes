$(function() {
    console.log('reward.js initialized');
    $('.shippingError').hide();
    $('#createRewardModal').find('form').validate({
        rules: {
            title: {
            	required: true,
                minlength: 2
            },
            description: {
                required: true,
                minlength: 2,
                maxlength: 250
            },
            price: {
                required: true,
                number: true,
                max : 50000,
                isPerk:true,
                min: 0
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
                    minlength: 2,
                    maxlength: 250
                },
                price: {
                    required: true,
                    number: true,
                    max : 50000,
                    isPerk:true,
                    min: 0
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
        if(price > cAmount){
           return false;
        }
        return true;
    }, "Enter a price less than Campaign amount: $" +$('#cAmount').val());

    $("#perkPrice").keypress(function (e) {
            //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                //display error message
            $("#errormsg").html("Digits Only").show().fadeOut("slow");
            return false;
        } 
    });
    
  $.validator.addMethod('shippingInfo', function(value) {
	  var si =$('.shippingInfo:checked').size() ;
	  if(si >0){
		  $('.shippingreward').removeClass('dynCSS');
		  $('.shippingError').hide();
		  return $('.shippingInfo:checked').size() > 0;
	  }else{
		  $('.shippingreward').addClass('dynCSS');
		  $('.shippingError').html('This field is required').show();	  
	  }
  }, '');

     /*******************************Description text length******************** */
    var counter = 1;
    $('#descarea').on('keydown', function(event) {
    
    event.altKey==true;
    var currentString = $('#descarea').val().length;
    if(currentString <=249) {
        var text = currentString + 1;
    }
    if (event.keyCode > 31) {
      if(event.altKey==true){
        setDescriptionText();
      }
      else{
          if(currentString <249)
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

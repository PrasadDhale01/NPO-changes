$(function() {
    console.log("create.js initialized");
    $("#updatereward").hide();
    $("#rewardTemplate").hide();
    $("#charityTextBox").show();

    $("#charitableId").hide();
    $("#textfile").hide();

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
                required: false
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
                required: true
            },
            country: {
                required: true
            },
            gender: {
                required: true
            },
            amount: {
                required: true,
                number: true,
                maxlength: 5,
                max: 50000
            },
            days: {
                required: true,
                number: true,
                max: 365
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
                required: true,
                url: true
            },
            textfile: {
                required: true
            },
            iconfile: {
                required: true
            }
            /*
            imageUrl: {
                url: true
            }
            */
        },
        messages:{
            thumbnail: "Please upload a thumbnail image for project"
        },
        messages:{
            textfile: "Please upload your Letter of Determination "
        },
        messages:{
            iconfile: "Please upload your Organizations icon"
        },
        errorPlacement: function(error, element) {
        	if ( element.is(":radio") || element.is(":checkbox")) {
        		error.appendTo(element.parent().parent());
        	}else{
        		error.insertAfter(element);
        	}
        },//end error Placement
        
        //ignore: []
    });

     $.validator.addMethod('isYoutubeVideo', function (value, element) {
        if(value && value.length !=0){
           var p = /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
           return (value.match(p)) ? RegExp.$1 : false;
        }
        return true;

     }, "Please upload a url of Youtube video");
     
     $("input[name='answer']").change(function(){
     	if($(this).val()=="yes") {
     		$("#rewardTemplate").show();
     	    $("#updatereward").show();
     	} else {
     	    $("#updatereward").hide();
     	    $("#rewardTemplate").hide();
     	}
     });
     
     $('#saveButton').click(function(){
    	 $("#charityTextBox").hide();
     });

     $("input[name='wel']").change(function(){
        if($(this).val()=="yes") {
            $("#charitableId").show();
            $("#textfile").hide();
        } else {
            $("#charitableId").hide(); 
            $("#textfile").show();
        }
     });
     
     $('#createreward').click(function(){
         var rewardsTemplateObj = $('.rewardsTemplate').last().clone();
         $('#addNewRewards').append(rewardsTemplateObj);
         $('#addNewRewards').find('.rewardsTemplate').last().find('input').val('').focus();
     });
     
     $('#removereward').click(function(){
         if ($('#addNewRewards').find('.rewardsTemplate').length > 1) {
    		 $('#addNewRewards').find('.rewardsTemplate').last().remove();
    	 }
     });

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


    /* Show pop-over tooltip on hover for some fields. */
    var showPopover = function () {
            $(this).popover('show');
        },
        hidePopover = function () {
            $(this).popover('hide');
        };

    /* Initialize pop-overs (tooltips) */
    $("input[name='days']").popover({
        content: 'Number of days to raise the funds by.',
        trigger: 'manual',
        placement: 'top'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
});

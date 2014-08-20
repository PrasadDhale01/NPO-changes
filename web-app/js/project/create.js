$(function() {
    console.log("create.js initialized");

    /* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });

	$('#dropdown .dropdown-menu').on({
    	"click":function(e){
    		e.stopPropagation();
    	}
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
                required: false
            },
            addressLine1: {
                required: true
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
                number: true
            },
            days: {
                required: true,
                number: true
            },
            title: {
                required: true,
                minlength: 5
            },
            story: {
                required: true,
                minlength: 10
            }
            /*
            imageUrl: {
                url: true
            }
            */
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

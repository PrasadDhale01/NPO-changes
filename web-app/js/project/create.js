$(function() {
    console.log("create.js initialized");

    $('.selectpicker').selectpicker();

    $('form').validate({
        rules: {
            name: {
                minlength: 2,
                required: true
            },
            email: {
                required: true,
                email: true
            },
            telephone: {
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
        },
        highlight: function (element) {
            $(element).closest('.form-group').addClass('has-error');
        },
        unhighlight: function (element) {
            $(element).closest('.form-group').removeClass('has-error');
        },
        errorElement: 'span',
        errorClass: 'help-block',
        errorPlacement: function(error, element) {
            if (element.parent('.input-group').length) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        }
    });

    var showPopover = function () {
            $(this).popover('show');
        },
        hidePopover = function () {
            $(this).popover('hide');
        };

    /* Initialize pop-overs */
    $("input[name='days']").popover({
        content: 'Number of days to raise the funds by.',
        trigger: 'manual',
        placement: 'auto left'
    })
    .focus(showPopover)
    .blur(hidePopover)
    .hover(showPopover, hidePopover);
});

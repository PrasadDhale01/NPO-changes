$(function() {
    console.log("FEDU is up");

    // Decode the blog post HTML so that <p></p> gets recognized.
    var text = $('.blogpost h4').html();
    var decoded = $('<div/>').html(text).text();
    $('.blogpost h4').html(decoded);

    // override jquery validate plugin defaults to suit Twitter Bootstrap
    $.validator.setDefaults({
        highlight: function(element) {
            $(element).closest('.form-group').addClass('has-error');
        },
        unhighlight: function(element) {
            $(element).closest('.form-group').removeClass('has-error');
        },
        errorElement: 'span',
        errorClass: 'help-block',
        errorPlacement: function(error, element) {
            if(element.parent('.input-group').length) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        }
    });
});

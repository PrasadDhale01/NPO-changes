$(function() {
    console.log("fund.js initialized");

    function getSelectedRewardId() {
        return $('.list-group-item.active').data('rewardid');
    }

    function getSelectedRewardPrice() {
        return $('.list-group-item.active').data('rewardprice');
    }

    $('form').validate({
        submitHandler: function(form) {
            if (getSelectedRewardId() == undefined) {
                $('.choose-error').html("<div class='alert alert-danger'>Please choose a reward</div>");
            } else {
                var rewardId = getSelectedRewardId();
                $('form input[name="rewardId"]').val(rewardId);

                form.submit();
            }
        },
        rules: {
            amount: {
                required: true,
                number: true,
                min: function() {
                    var rewardPrice = getSelectedRewardPrice();
                    if (rewardPrice == undefined) {
                        return 10;
                    } else {
                        return _.max([10, Number(rewardPrice)]);
                    }
                }
            }
        }
    });

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


    $('.list-group-item').click(function() {
        $('.choose-error').html('');

        $(this).siblings().removeClass('active');
        $(this).addClass('active');
    });
});

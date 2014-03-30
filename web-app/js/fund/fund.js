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

    $('.list-group-item').click(function() {
        $('.choose-error').html('');

        $(this).siblings().removeClass('active');
        $(this).addClass('active');
    });
});

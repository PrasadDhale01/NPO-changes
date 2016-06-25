$(function() {
	
	$(document).ready(function() {
		
	    $('#campaignlist').DataTable({
	    	"iDisplayLength": 5,
	    	"aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
	    });
	    
	    $("#disbursementDiv").on('click','.contributions', function(event) {
	    	event.preventDefault();
        	$("#loading-gif").show();
            
            var url = $(this).attr('href');
            var grid = $('#contributionList');
            
            $.ajax({
                type: 'POST',
                url: url,
                success: function(data) {
                    $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                    $("#loading-gif").hide();
                },
                error: function() {
                	$("#loading-gif").hide();
                }
            });
        });
	    
	    $("#disbursementDiv").on('click','.checkbalance', function(e) {
			$("#loading-gif").show();
			var url = "/fund/getSellerAccountBalance"
	        
	        $.ajax({
	            type: 'POST',
	            url: url,
	            data: 'sellerId='+ $('#sellerId').val(),
	            success: function(data) {
	                $('#selleramount').val(data);
	                $("#loading-gif").hide();
	            },
	            error: function() {
	                $("#loading-gif").hide();
	            }
	        });
		});

		$("#disbursementDiv").on('click','.contributionSettlement', function(e) {
			e.preventDefault();
			$("#loading-gif").show();
			
			var contribution = this;
			var url = "/fund/settleMent/"
			var contributionId = $(this).data("contributionid");
			var splitId = $(this).data("splitid");
			
	        $.ajax({
	            type: 'POST',
	            url: url,
	            data: 'contributionId='+ contributionId+'&splitId='+splitId,
	            success: function(data) {
	                if (data == true || data == "true") {
	                	$(contribution).removeClass("contributionSettlement");
	                	$(contribution).removeClass("btn-default");
	                	$(contribution).addClass("btn-primary");
	                	$(contribution).addClass("disburseContribution");
	                    $(contribution).text("Disburse");
	                }
	                $("#loading-gif").hide();
	            },
	            error: function() {
	                $("#loading-gif").hide();
	            }
	        });
		});

		$("#disbursementDiv").on('click','.disburseContribution', function(e) {
	        e.preventDefault();
	        $("#loading-gif").show();
	        
	        var contribution = this;
	        var url = "/fund/releaseFundToSeller"
	        var contributionId = $(this).data("contributionid");
	        var splitId = $(this).data("splitid");
	        
	        $.ajax({
	            type: 'POST',
	            url: url,
	            data: 'contributionId='+ contributionId+'&splitId='+splitId,
	            success: function(data) {
	                if (data == true || data == "true") {
	                	$(contribution).replaceWith('<button type="button" class="btn btn-success btn-xs contributionreleased">Released</button>')
	                }
	                $("#loading-gif").hide();
	            },
	            error: function() {
	            	$("#loading-gif").hide();
	            }
	        });
	    });
        
    });
	
});

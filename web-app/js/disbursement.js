$(function() {
	
	$(document).ready(function() {
		
	    $('#campaignlist').DataTable({
	    	"iDisplayLength": 5,
	    	"aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
	    });
	    
        $('.contributions').click(function(event) {
            event.preventDefault();
            var url = $(this).attr('href');
            var grid = $('#contributionList');
            
            $.ajax({
                type: 'POST',
                url: url,
                success: function(data) {
                    $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                }
            });
        });
        
    });
	
});

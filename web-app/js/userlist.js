$(function() {
	
	$(document).ready(function() {
		
	    $('#verifiedUserList').DataTable({
	    	"iDisplayLength": 5,
	    	"aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
	    });
	    
	    $('#unVerifiedUserList').DataTable({
	    	"iDisplayLength": 5,
	    	"aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
	    });
	    
	    // Campaign Statistics Section
	    
	    getcampaignlist();
	    
	    /*$('#campaignSortedlist').DataTable({
	    	"iDisplayLength": 5,
	    	"aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
	    });*/
	   
	    
	});
	
});

<g:set var="adminService" bean="adminService"/>
<%	def base_url = grailsApplication.config.crowdera.BASE_URL
 %>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="userlistjs"/>
    <r:require module="datatablecss"/>
</head>
<body>
<input type="hidden" id="baseUrl" value="<%=base_url%>" />
<div class="feducontent">
<div class="pull-left form-group col-sm-2">
<select class="sortCampaignss selectpicker btn btn-primary text-center" name="sortCampaignss"  onchange="getcampaignlist();">
  <optgroup class="text-center" label="STATUS">
    <option class="sortCampaigns text-center" value="LIVE">LIVE</option>
    <option class="sortCampaigns text-center" value="PENDING">PENDING</option>
    <option class="sortCampaigns text-center" value="DRAFT">DRAFT</option>
    <option class="sortCampaigns text-center" value="REJECTED">REJECTED</option>
    <option class="sortCampaigns text-center" value="ONHOLD">ONHOLD</option>
  </optgroup>
  <optgroup  class="text-center" label="COUNTRY">
    <option class="sortCampaigns text-center" value="IN">IN</option>
    <option class="sortCampaigns text-center" value="US">US</option>
  </optgroup>
<%--  <optgroup  class="text-center" label="PAYMENT_GATEWAY">--%>
<%--    <option class="sortCampaigns text-center" value="CITRUS">CITRUS</option>--%>
<%--    <option class="sortCampaigns text-center" value="WEPAY">WEPAY</option>--%>
<%--    <option class="sortCampaigns text-center" value="PAYU">PAYU</option>--%>
<%--    <option class="sortCampaigns text-center" value="PAYPAL">PAYPAL</option>--%>
<%--    <option class="sortCampaigns text-center" value="FIRSTGIVING">FIRSTGIVING</option>--%>
<%--  </optgroup>--%>
<%--  <optgroup  class="text-center" label="FOREIGN FUNDING">--%>
<%--    <option class="sortCampaigns text-center" value="YES">YES</option>--%>
<%--    <option class="sortCampaigns text-center" value="NO">NO</option>--%>
<%--  </optgroup>--%>
</select>


</div>
<g:form controller="project" action="generateCampaignCSVforAdmin" name="generateCampaignCSVforAdmin" id="generateCampaignCSVforAdmin" method="post">
	<button type="submit" class="pull-right btn btn-primary campaignCSV" >EXPORT CSV </button>
</g:form>

        <div class="container">
            <div class="row">
                <h1 style="text-align: center; margin-top: 8%; margin-bottom: 2%;"> Campaign Statistics</h1><br>
                <h6 class="pull-right"><b>NA = Not Available</b></h6>
                <div class="table table-responsive" style="overflow-x: scroll; margin-top: 2%">
                    <table class="table table-bordered table-striped table-hover" id="campaignSortedlist">
                        <thead>
                            <tr class="alert alert-title">
                                <th>ID</th>
                                <th>CAMPAIGN TITLE</th>
                                <th>CAMPAIGN COUNTRY</th>
                                <th>DATE OF CREATION</th>
                                <th>TIME OF CREATION</th>
                                <th>CAMPAIGN STATUS</th>
                                <th>FUNDRAISER NAME</th>
                                <th>FUNDRAISER EMAIL</th>
                                <th>FUNDRAISER TELEPHONE</th>
                                <th>FOREIGN FUNDING</th>
                                <th>PAYMENT GATEWAY</th>
                                <th>WEBSITE URL</th>
                                <th>TRANSACTION EMAIL / CHARITABLE ID</th>
                            </tr>
                        </thead>
                        <tbody id="campaignDataTable">
							<%-- campaigngrid template loaded here --%>
                        </tbody>
                    </table>
                </div>
                
            </div>
        </div>
    </div>
    
    
    
    <div class="loadinggif text-center" id="loading-gif">
        <img src="//s3.amazonaws.com/crowdera/documents/loading.gif" alt="'loadingImage'" id="loading-gif-img">
    </div>
<script type="text/javascript">
function getcampaignlist(){
	
	var selectedSortValue = $("select[name='sortCampaignss'] option:selected").text();
	var grid = $('#campaignDataTable');
	$('#loading-gif').show();

	$.ajax({
		type: 'post',
		url: $('#baseUrl').val()+'project/sortcampaignsforadmin',
		data: 'selectedSortValue='+selectedSortValue,
		success: function(data){
			/*$('#campaignSortedlist').dataTable().fnDestroy();*/
			
			$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});

			/*$('#campaignSortedlist').DataTable({
				"iDisplayLength": 5,
		    	"aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
			});*/
			
			$('#loading-gif').hide();
		}
	
	}).error(function(){
		$('#loading-gif').hide();
	});
};
 
</script>
</body>
</html>

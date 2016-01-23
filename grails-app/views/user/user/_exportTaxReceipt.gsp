<div class="tax-receipt-background">
	<g:each in="${taxReceiptContribution}" var="contribution">
		<div class="col-sm-4 col-md-3 col-lg-3 col-xs-6 text-center file-thumbnail-div" data-contribution="${contribution.id}" data-toggle="modal" data-target="#tax-receipt">
			<div class="tax-receipt-thumbnail-container file-thumbnail-container ">
				<div class="tax-receipt-thumbnail">
				    <span class="glyphicon glyphicon-file"></span>
				</div>
				<div class="tax-reciept-project-title fileName-text">
				    ${contribution.project.title}
				</div>
			</div>
		</div>
	</g:each>
</div>

<div class="clear"></div>
<div class="pull-right exportpaginate filespaginate">
    <g:paginate controller="user" max="6" action="loadExportThumbnail" total="${totalProjects.size()}"/>
</div>

<script>
	/*Pagination logic*/
	$(".exportTaxReceiptThumbnail").find('.exportpaginate a').click(function(event) {
		event.preventDefault();
		var url = $(this).attr('href');
		var grid = $(this).parents('.exportTaxReceiptThumbnail');

		$.ajax({
			type: 'GET',
			url: url,
			success: function(data) {
			    $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
			}
		});
	});
</script>

<div class="modal fade" id="tax-receipt" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h3 class="modal-title"><b>Tax Receipt</b></h3>
			</div>
			<div class="modal-body">
				<g:link controller="user" action="exportTaxReceiptpdf" class="btn btn-primary btn-sm pull-right">Download Receipt</g:link><br>
				<g:render template="user/taxReceipt"></g:render>
			</div>
		</div>
	</div>
</div>

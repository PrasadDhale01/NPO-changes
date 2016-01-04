<%
	def count = contributionList.size()
	def index = 0
	def indexcount = offset ? offset : 0
%>
<g:hiddenField name="vanityTitle" class="vanityTitle" value="${vanityTitle}"/>
<g:if test="${contributionList}">
<br>
<div class="table table-responsive">
	<table class="table table-bordered">
		<thead>
			<tr class="alert alert-title">
				<th class="text-center">Sr.No</th>
				<th class="text-center">Select</th>
				<th class="col-sm-3 text-center">Name</th>
				<th class="col-sm-3 text-center">Email</th>
				<th class="text-center">Amount</th>
				<th class="text-center">Date & Time</th>
			</tr>
		</thead>
		<tbody>
			<% while(index < count) { %>
			 <g:render template="/user/user/contributorsList" model="['contribution': contributionList.get(index++), index: ++indexcount]"></g:render>
			<% } %>
		</tbody>
	</table>
</div>
</g:if>

<div class="pull-right sendTaxReceiptPaginate filespaginate">
    <g:paginate controller="user" max="5" maxsteps="5" action="loadContributors" params="['vanityTitle':vanityTitle, sort:sort]" total="${totalContributions.size()}"/>
</div>
<script>
    $(".send-tax-receipt-to-contributors").find('.sendTaxReceiptPaginate a').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var grid = $(this).parents(".send-tax-receipt-to-contributors");

        $.ajax({
            type: 'GET',
            url: url,
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
            }
        });
    });
</script>


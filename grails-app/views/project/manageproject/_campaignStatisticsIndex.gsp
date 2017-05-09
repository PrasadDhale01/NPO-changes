<br>
<h3><b>Campaign Statistics</b></h3>
<br>
<g:if test="${flash.message}">
	<div class="alert alert-success">
		${flash.message}
	</div>
</g:if>
<div class="table table-responsive manage-table-bottom">
	<table class="table table-bordered">
		<thead>
			<tr class="alert alert-title ">
				<th>Id</th>
				<th>Team Member</th>
				<th>Joining Date</th>
				<th>Contribution Deadline</th>
				<th>Amount Authorized</th>
				<th><g:if test="${'in'.equalsIgnoreCase(country_code)}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>Achieved</th>
				<th>Need to hit minimum</th>
				<th>Team Status</th>
			</tr>
		</thead>
		<tbody>
			<g:render template="manageproject/campaignStatisticsGrid" model="[teams : teams]"></g:render>
		</tbody>
	</table>
</div>

<div class="row"><br>
	<h3>Campaign Statistics</h3>
	<br>
	<g:if test="${flash.message}">
		<div class="alert alert-success">
			${flash.message}
		</div>
	</g:if>
	<div class="table table-responsive">
		<table class="table table-bordered">
			<thead>
				<tr class="alert alert-title ">
					<th>Id</th>
					<th>Team Member</th>
					<th>Joining Date</th>
					<th>Official Team Member</th>
					<th>Contribution Deadline</th>
					<th>Amount Authorized</th>
					<th>$ Raised</th>
					<th>$ Achieved</th>
					<th>Need to hit minimum</th>
				</tr>
			</thead>
			<tbody>
				<g:render template="manageproject/campaignStatisticsGrid"
					model="[team:team, project:project]"></g:render>
			</tbody>
		</table>
	</div>
</div>

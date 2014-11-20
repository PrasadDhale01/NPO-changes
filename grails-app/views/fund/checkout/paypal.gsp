<g:set var="projectService" bean="projectService" />
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="checkoutjs" />
</head>
<body>
	<div class="feducontent">
		<div class="container">
			<g:form action="paypalurl" method="POST" name="payment-form"
				role="form">
				<div class="row">
					<div class="col-md-8">
						<div class="row">
							<div class="panel panel-default">
								<div class="panel-body">
									<h3>
										Your contribution: <span class="pull-right">$${amount}</span>
									</h3>
									<h4>
										Your Reward: <span class="pull-right">${reward.title}</span>
									</h4>
								</div>
							</div>
						</div>
						<div class="row">
							<button class="btn btn-primary btn-lg" name="fund-button">Fund
								this project</button>
						</div>
					</div>
					<span class="payment-errors"></span>

					<g:hiddenField name="projectId" value="${project.id}" />
					<g:hiddenField name="rewardId" value="${reward.id}" />
					<g:hiddenField name="amount" value="${amount}" />
					<g:hiddenField name="currencyCode" value="USD" />
					<g:hiddenField name="charityId" value="${project.charitableId}" />
					<g:hiddenField name="projectAmount" value="${project.amount}" />
					<!-- TDODO-->
					<g:hiddenField name="remoteAddr" value="192.168.1.1" />

					<div class="col-md-4">
						<g:render template="/layouts/tile" />
					</div>
				</div>
			</g:form>
		</div>
	</div>
</body>
</html>

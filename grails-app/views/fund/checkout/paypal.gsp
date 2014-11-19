<g:set var="projectService" bean="projectService" />
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="checkoutjs" />
</head>
<body>
	<div class="feducontent">
		<div class="container">
			<g:form action="paypalurl" method="POST" name="payment-form" role="form">
				<div class="row">
					<div class="col-md-8">
						<div class="panel panel-default">
							<div class="panel-body">
								<h3>
									Your contribution: <span class="pull-right">$${amount}</span>
								</h3>
								<h4>
									Your reward: <span class="pull-right">
										${reward.title}
									</span>
								</h4>
							</div>
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



					<div class="col-md-4 box">
						<div class="row">
							<g:render template="rewardtile" />
						</div>
						<div class="row">
							<g:render template="/layouts/tile" />
						</div>
						<div class="row" align="center">
							<button class="btn btn-primary btn-block btn-lg"
								name="fund-button">Fund this project</button>
						</div>
					</div>
				</div>
			</g:form>
		</div>
	</div>
</body>
</html>

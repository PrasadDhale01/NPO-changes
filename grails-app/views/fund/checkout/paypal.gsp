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
						<div>
							<div class="panel panel-default">
								<div class="panel-body">
									<h3>
										<% def contributedAmount = projectService.getDataType(amount) %>
										Your contribution: <span class="pull-right">$${contributedAmount}</span>
									</h3>
									<g:if test="${project.rewards.size()>1}">
										<h4>Your Reward: <span class="pull-right">${reward.title}</span></h4>
									</g:if>
									<g:if test="${fundraiser != project.user}">
					                    <h4>Fundraiser: <span class="pull-right">${fundraiser.firstName} ${fundraiser.lastName}</span></h4>
						            </g:if>
								</div>
							</div>
						</div>
						<div >
							<button class="btn btn-primary btn-lg" name="fund-button">Fund this Campaign</button>
						</div>
						<div>
						    <br><img src="/images/paypal-secured.jpg" width="245 px" height="60 px"/>
						</div>
					</div>
					<span class="payment-errors"></span>
					<div class="col-md-4">
						<g:render template="/layouts/tile" />
					</div>
				</div>
			</g:form>
		</div>
	</div>
</body>
</html>

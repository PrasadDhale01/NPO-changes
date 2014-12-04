<html>
<head>
<meta name="layout" content="main" />
<r:require modules="fundjs" />
</head>
<body>
	<div class="feducontent">
		<div class="container">
			<div class="row">
				<g:if test="${project.paypalEmail}">
					<div class="alert alert-title">
						<h1>Powered by Paypal</h1>
					</div>
					<div class="col-md-4">
						<h1>Amount</h1>
						<g:form action="charge" method="POST" role="form">
							<g:hiddenField name="stripeToken" value="123456"/>
							<g:hiddenField name="projectId" value="${project.id}" />
							<g:hiddenField name="rewardId" />
							<!-- Value set by Javascript -->

							<div class="form-group">
								<div class="input-group">
									<span class="amount input-group-addon"><span
										class="glyphicon glyphicon-usd"></span> </span> <input
										class="amount form-control"
										<%-- value="${reward.price}" --%> id="amount" name="amount">
								</div>
								<span id="errormsg"></span>
							</div>
							<div class="clear"></div>
							<button type="submit" class="btn btn-primary btn-lg">Continue</button>
						</g:form>
					</div>
				</g:if>
				<g:else>
					<div class="alert alert-title">
						<h1>Powered by Firstgiving</h1>
					</div>
					<div class="col-md-4">
						<h1>Amount</h1>
						<g:form action="checkout" method="POST" role="form">

							<g:hiddenField name="projectId" value="${project.id}" />
							<g:hiddenField name="rewardId" />
							<!-- Value set by Javascript -->

							<div class="form-group">
								<div class="input-group">
									<span class="amount input-group-addon"><span
										class="glyphicon glyphicon-usd"></span> </span> <input
										class="amount form-control"
										<%-- value="${reward.price}" --%> id="amount" name="amount">
								</div>
								<span id="errormsg"></span>
							</div>
							<div class="clear"></div>
							<button type="submit" class="btn btn-primary btn-lg">Continue</button>
						</g:form>
					</div>
				</g:else>

				<div class="col-md-4">
                    <g:if test="${project.rewards.size()>1}">
                        <g:render template="fund/rewards"/>
                    </g:if>
                </div>

				<div class="col-md-4">
					<g:render template="/layouts/tile" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>

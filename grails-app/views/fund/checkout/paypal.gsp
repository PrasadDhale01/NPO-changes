<g:set var="projectService" bean="projectService" />
<g:set var="rewardservice" bean="rewardService"/>
<%
    def shippingInfo = rewardservice.getShippingInfo(reward)
    def contributedAmount = projectService.getDataType(amount)
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="checkoutjs" />
</head>
<body>
	<div class="feducontent">
		<div class="container">
			<g:form action="paypalurl" method="POST" name="payment-form" id="${project.id}" role="form">
				<g:hiddenField name="fr" value="${fundraiser.id}"/>
				<g:hiddenField name="rewardId" value="${reward.id}"/>
				<g:hiddenField name="userId" value="${user.id}"/>
				<g:hiddenField name="amount" value="${amount}"/>
				<div class="row">
					<div class="col-md-8">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="form-group">
									<h3>Your Contribution: <span class="pull-right">$${contributedAmount}</span></h3>
								</div>
								<g:if test="${project.rewards.size()>1}">
									<div class="form-group">
										<h4>Your Perk: <span class="pull-right">${reward.title}</span></h4>
									</div>
								</g:if>
								<g:if test="${fundraiser != null}">
									<div class="form-group">
				                    	<h4>Fundraiser: <span class="pull-right">${fundraiser.firstName} ${fundraiser.lastName}</span></h4>
				                    </div>
					            </g:if>
							</div>
						</div>
						
						<g:if test="${shippingInfo}">
						    <div class="panel panel-default">
						        <div class="panel-heading">
						            <h3 class="panel-title">Shipping Information Required to Fulfill a Perk</h3>
						        </div>
						        <div class="panel-body">
						            <g:if test="${shippingInfo.address != null}">
						                <div class="col-md-6">
						                    <div class="form-group">
						                        <div class="input-group col-md-12">
						                            <input class="form-control" type="text" placeholder="Physical Address" name="physicalAddress">
						                        </div>
						                    </div>
						                </div>
						            </g:if>
						            <g:if test="${shippingInfo.email != null}">
						                <div class="col-md-6">
						                    <div class="form-group">
						                        <div class="input-group col-md-12">
						                            <input class="form-control" type="text" placeholder="Email" name="shippingEmail">
						                        </div>
						                    </div>
						                </div>
						            </g:if>
						            <g:if test="${shippingInfo.twitter != null}">
						                <div class="col-md-6">
						                    <div class="form-group">
						                        <div class="input-group col-md-12">
						                            <input class="form-control" type="text" placeholder="Twitter Handle" name="twitterHandle">
						                        </div>
						                    </div>
						                </div>
						            </g:if>
						            <g:if test="${shippingInfo.custom != null}">
						                <div class="col-md-6">
						                    <div class="form-group">
						                        <div class="input-group col-md-12">
						                            <input class="form-control" type="text" placeholder="Custom Details ex. Size of T-shirts etc" name="shippingCustom">
						                        </div>
						                    </div>
						                </div>
						            </g:if>
						            
						        </div>
						    </div>
						</g:if>
						<div class="form-group">
							<button class="btn btn-primary btn-lg" name="fund-button">Fund this Campaign</button>
						</div>
						<div class="paypal-secured-image">
						    <img src="/images/paypal-secured.jpg"/>
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

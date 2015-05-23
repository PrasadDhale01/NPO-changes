<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<g:set var="rewardservice" bean="rewardService"/>
<%
    def shippingInfo = rewardservice.getShippingInfo(reward)
    def contributedAmount = projectService.getDataType(amount)
    def currentUser = userService.getCurrentUser()
    def isAnonymous = userService.isAnonymous(user)
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
				<g:if test="${user1}">
				    <g:hiddenField name="tempValue" value="${user1.id}"/>
				</g:if>
				<g:hiddenField name="rewardId" value="${reward.id}"/>
				<g:hiddenField name="userId" value="${user.id}"/>
				<g:hiddenField name="amount" value="${amount}"/>
				<g:hiddenField name="anonymous" value="${anonymous}" id="anonymous"/>
				<g:hiddenField name="projectTitle" value="${projectTitle}"/>
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
						
						<g:if test="${currentUser == null}">
						    <div class="panel panel-default">
							    <div class="panel-heading">
							        <h3 class="panel-title">Contact details (for your receipt)</h3>
							    </div>
							    <div class="panel-body">
							        <div class="col-md-6">
							            <div class="form-group">
							                <div class="input-group col-md-12">
							                    <input class="form-control" type="text" placeholder="Full Name" name="receiptName" id="receiptName">
							                </div>
							            </div>
							        </div>
							        <div class="col-md-6">
							            <div class="form-group">
							                <div class="input-group col-md-12">
							                    <input class="form-control" type="text" placeholder="Email" name="receiptEmail">
							                </div>
							            </div>
							        </div>
							    </div>
						    </div>
						</g:if>
						<g:if test="${shippingInfo}">
							<g:if test="${shippingInfo.address != null || shippingInfo.email  != null || shippingInfo.twitter  != null || shippingInfo.custom  != null}">
							    <div class="panel panel-default">
							        <div class="panel-heading">
							            <h3 class="panel-title">Shipping Information Required to Fulfill a Perk</h3>
							        </div>
							        <div class="panel-body">
							            <g:if test="${shippingInfo.address != null}">
                                            <div class="col-md-6" id="physicalAddress">
                                                <div class="form-group">
                                                    <div class="input-group col-md-12">
                                                        <input class="form-control" type="text" placeholder="AddressLine1" name="addressLine1">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="input-group col-md-12">
                                                        <input class="form-control" type="text" placeholder="AddressLine2" name="addressLine2">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="input-group col-md-12">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <input class="form-control" type="text" placeholder="City" name="city" id="city">
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input class="form-control" type="text" placeholder="Zip" name="zip"> 
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="input-group col-md-12">
                                                        <g:select class="selectpicker" name="state" id="states"
                                                            from="${state}" optionKey="key" optionValue="value"/>
                                                    </div>
                                                </div>
                                                <div class="form-group" id="ostate">
                                                    <div class="input-group col-md-12">
                                                        <input class="form-control" type="text" placeholder="Other State" name="otherstate" >
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="input-group col-md-12">
                                                        <g:select class="selectpicker" name="country" 
                                                            from="${country}" value="US"
                                                            optionKey="key" optionValue="value"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clear"></div>
                                            <g:if test="${shippingInfo.email  != null || (shippingInfo.twitter  != null && !isAnonymous) || shippingInfo.custom  != null}">
                                                <hr>
                                            </g:if>
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
							            <g:if test="${shippingInfo.twitter != null && anonymous=="false"}">
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
						</g:if>
						
					</div>
					<span class="payment-errors"></span>
					<div class="col-md-4">
						<g:render template="/layouts/tile" />
						<div>
                            <label class="checkbox control-label">
                                <input type="checkbox" name="agreetoTermsandUse" id="agreetoTermsandUse">By continuing, you agree to our <a href="${resource(dir: '/termsofuse')}">Terms of Use</a>
                            </label>
                        </div>
						<div class="center-fund">
							<button class="btn btn-primary btn-block" name="fund-button">Fund this Campaign</button>
						</div>
						<div class="powerdby">
                            <p>Powered By Paypal</p>
                                <p><img src="//s3.amazonaws.com/crowdera/assets/poweredByFirstgiving.jpg" alt="Powered By paypal"/></p>
                        </div>
					</div>
				</div>
			</g:form>
		</div>
	</div>
</body>
</html>

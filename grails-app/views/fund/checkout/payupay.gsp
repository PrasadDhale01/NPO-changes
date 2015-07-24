<%@page import="org.codehaus.groovy.grails.commons.GrailsApplication"%>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<g:set var="rewardservice" bean="rewardService"/>
<%
    def shippingInfo = rewardservice.getShippingInfo(reward)
    def currentUser = userService.getCurrentUser()
    isAnonymous = userService.isAnonymous(currentUser)
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="checkoutjs"/>

    <script type="text/javascript" src="https://js.stripe.com/v2/"></script>
    <script type="text/javascript">
        Stripe.setPublishableKey('${grailsApplication.config.grails.plugins.stripe.publishableKey}');
        if (window.location.protocol === 'file:') {
            alert("stripe.js does not work when included in pages served over file:// URLs.");
        }
    </script>
    <script id="credit-error-template" type="text/x-handlebars-template">
        <div class="alert alert-danger">
            {{message}}
        </div>
    </script>
    <script type="text/javascript">
	    var needToConfirm = true;
	    window.onbeforeunload = confirmExit;
	    function confirmExit()
	    {
	        if(needToConfirm){
	        	return "You have attempted to leave this page.  If you have made any changes to the fields without clicking the Save button, your changes will be lost.  Are you sure you want to exit this page?";
	        }
	    }
    </script>
</head>
<body>
	<div class="feducontent">
		<div class="container" id="checkoutgsp">
			<% def contributedAmount = projectService.getDataType(Double.parseDouble(amount)) %>
			<form action="${grailsApplication.config.crowdera.PAYU.TEST_URL}" method="post">
				<input type="hidden" name="key" value="${key}"/>
				<input type="hidden" name="txnid" value="${txnid}"/>
				<input type="hidden" name="hash" value="${hash}"/>
				<input type="hidden" name="surl" value="${surl}"></input>
				<input type="hidden" name="furl" value="${furl}"></input>
				<input type="hidden" name="service_provider" value="${service_provider}"></input>
				<div class="row">
					<div class="col-md-8">
						<div class="panel panel-default">
							<div class="panel-body payu-inr">
								<h3>Your Contribution: <span class="pull-right"><span class="fa fa-inr"></span>&nbsp;<b>${contributedAmount}</b></span></h3>
								<h4>Your Perk: <span class="pull-right">${reward.title}</span></h4>
								<g:if test="${fundraiser != project.user}">
									<h4>Fundraiser: <span class="pull-right">${fundraiser.firstName} ${fundraiser.lastName}</span></h4>
								</g:if>
							</div>
						</div>
						<span class="payment-errors"></span>
						<g:hiddenField name="projectId" value="${project.id}"/>
						<g:if test="${user1}">
							<g:hiddenField name="tempValue" value="${user.id}"/>
						</g:if>
						<g:else>
							<g:hiddenField name="tempValue" value="${user.id}"/>
						</g:else>
							<g:hiddenField name="userId" value="${user.id}"/>
							<g:hiddenField name="rewardId" value="${reward.id}"/>
							<g:hiddenField name="fr" value="${fundraiser.username}"/>
							<g:hiddenField name="projectAmount" value="${project.amount}"/>
							<div class="panel panel-default">
								<div class="panel-heading">
									<h3 class="panel-title">Billing Information <g:if test="${currentUser == null}">(Your contact details are used to send a receipt)</g:if></h3>
								</div>
								<div class="panel-body">  
									<div class="row">
										<input class="form-control" type="hidden" value="Mr/Mrs/Ms" name="billToTitle" id="billToTitle" />
										<div class="col-md-6">
											<g:if test="${userService.isAnonymous(user)}">
												<div class="form-group">
													<div class="input-group col-md-12">
														<input class="form-control" type="text" placeholder="First Name" name="firstname" id="payuFirstName" readonly value="${params.firstname}">
													</div>
												</div>
												<div class="form-group">
													<div class="input-group col-md-12">
														<input class="form-control" type="text" placeholder="lastname" name="lastname" value="${params.lastname}" readonly>
													</div>
												</div>
												<div class="form-group">
													<div class="input-group col-md-12">
														<input class="form-control" type="text" placeholder="Email" name="email" value="${params.email}" readonly>
													</div>
												</div>
											</g:if>
											<g:else>
												<div class="form-group">
													<div class="input-group col-md-12">
														<input class="form-control" type="text" placeholder="First Name" name="firstname" id="payuFirstName" value="${params.firstname}" readonly>
													</div>
												</div>
												<div class="form-group">
													<div class="input-group col-md-12">
														<input class="form-control" type="text" placeholder="Last Name" name="lastname" value="${params.lastname}" readonly>
													</div>
												</div>
												<div class="form-group">
													<div class="input-group col-md-12">
														<input class="form-control" type="text" placeholder="Email" name="email" value="${params.email}" readonly>
													</div>
												</div>
											</g:else>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<div class="input-group col-md-12">
													<input class="form-control" type="text" placeholder="Phone Number" name="phone" value="${phone}" readonly>
												</div>
											</div>
                      	
											<div class="form-group">
												<div class="input-group col-md-12">
													<input class="form-control" type="text" placeholder="PayuMoney product info" name="productinfo" value="${params.productinfo}" readonly>
												</div>
											</div>
											<div class="form-group">
												<div class="input-group col-md-12">
													<input class="form-control" type="text" placeholder="PayUMoney Amount" name="amount" value="${amount}" readonly>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<g:if test="${shippingInfo}">
								<g:if test="${shippingInfo.address != null || shippingInfo.email  != null || shippingInfo.twitter  != null || shippingInfo.custom  != null}">
									<div class="panel panel-default">
										<div class="panel-heading">
											<h3 class="panel-title">Shipping Information</h3>
										</div>
										<div class="panel-body">
											<g:if test="${shippingInfo.address != null}">
												<div class="col-md-6">
													<div class="form-group">
														<div class="input-group col-md-12">
															<input class="form-control" type="text" placeholder="Physical Address" name="physicalAddress" value="${params.physicalAddress}" readonly>
														</div>
													</div>
												</div>
											</g:if>
											<g:if test="${shippingInfo.email  != null}">
												<div class="col-md-6">
													<div class="form-group">
														<div class="input-group col-md-12">
															<input class="form-control" type="text" placeholder="Email" name="shippingEmail" value="${params.shippingEmail}" readonly>
														</div>
													</div>
												</div>
											</g:if>
											<g:if test="${shippingInfo.twitter  != null && anonymous=="false"}">
												<div class="col-md-6">
													<div class="form-group">
														<div class="input-group col-md-12">
															<input class="form-control" type="text" placeholder="Twitter Handle" name="twitterHandle" value="${params.twitterHandle}" readonly>
														</div>
													</div>
												</div>
											</g:if>
											<g:if test="${shippingInfo.custom  != null}">
												<div class="col-md-6">
													<div class="form-group">
														<div class="input-group col-md-12">
															<input class="form-control" type="text" placeholder="Custom Details ex. Size of T-shirts etc" name="shippingCustom"  value="${params.shippingCustom}" readonly>
														</div>
													</div>
												</div>
											</g:if>  
										</div>
									</div>
								</g:if>
							</g:if>
						</div>
	
						<div class="col-md-4 box fund-campaign-tile-center-align">
							<g:render template="/layouts/tile"/>
							<div class="form-group term-of-use-center-alignment">
								<label class="checkbox control-label">
									<input type="checkbox" name="agreetoTermsandUse" id="agreetoTermsandUse">By continuing, you agree to our <a href="${resource(dir: '/termsofuse')}">Terms of Use</a>
								</label>
							</div>
							<div class="center-fund">
								<button type="submit" class="btn btn-primary btn-block btn-lg checkoutsubmitbutton" name="fund-button" id="paypalsubmitbutton">Fund this campaign</button>
							</div>
							<div class="powerdby">
								<p class="powerd-by-text">Powered By PayUMoney</p>
								<p><img src="//s3.amazonaws.com/crowdera/assets/poweredByFirstgiving.jpg"/></p>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>

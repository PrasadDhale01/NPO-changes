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
			<g:form action="payupayment" controller="fund" method="POST"  role="form">
				<input type="hidden"  name="anonymous" value="${anonymous}" id="anonymous"/>
				<div class="row">
					<div class="col-md-8">
						<div class="panel panel-default">
							<div class="panel-body">
								<h3>Your Contribution: <span class="pull-right">$${contributedAmount}</span></h3>
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
						<g:hiddenField name="projectTitle" value="${projectTitle}"/>
						<!-- TDODO-->
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
													<input class="form-control" type="text" placeholder="First Name" name="firstname" id="payuFirstName">
												</div>
											</div>
											<div class="form-group">
												<div class="input-group col-md-12">
													<input class="form-control" type="text" placeholder="lastname" name="lastname">
												</div>
											</div>
											<div class="form-group">
												<div class="input-group col-md-12">
													<input class="form-control" type="text" placeholder="Email" name="email">
												</div>
											</div>
										</g:if>
										<g:else>
											<div class="form-group">
												<div class="input-group col-md-12">
													<input class="form-control" type="text" placeholder="First Name" name="firstname" id="payuFirstName" value="${user.firstName}">
												</div>
											</div>
											<div class="form-group">
												<div class="input-group col-md-12">
													<input class="form-control" type="text" placeholder="Last Name" name="lastname" value="${user.lastName}">
												</div>
											</div>
											<div class="form-group">
												<div class="input-group col-md-12">
													<input class="form-control" type="text" placeholder="Email" name="email" value="${project.payuEmail}">
												</div>
											</div>
										</g:else>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<div class="input-group col-md-12">
												<input class="form-control" type="text" placeholder="Phone Number" name="phone" >
											</div>
										</div>
										<div class="form-group">
											<div class="input-group col-md-12">
												<input class="form-control" type="text" placeholder="PayuMoney product info" name="productinfo" value="${project.title}" readonly>
											</div>
										</div>
										<div class="form-group">
											<div class="input-group col-md-12">
												<input class="form-control" type="text" placeholder="PayUMoney Amount" name="amount" value="${amount}" id="payuAmount" readonly>
											</div>
											<div id="errormsg"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					
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
                                                        <g:select class="selectpicker" name="country" 
                                                            from="${country}" value="IN"
                                                            optionKey="key" optionValue="value"/>
                                                    </div>
                                                </div>
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
                                            </div>
                                            <div class="clear"></div>
                                            <g:if test="${shippingInfo.email  != null || (shippingInfo.twitter  != null && !isAnonymous) || shippingInfo.custom  != null}">
                                                <hr>
                                            </g:if>
										</g:if>
										<g:if test="${shippingInfo.email  != null}">
											<div class="col-md-6">
												<div class="form-group">
													<div class="input-group col-md-12">
														<input class="form-control" type="text" placeholder="Email" name="shippingEmail">
													</div>
												</div>
											</div>
										</g:if>
										<g:if test="${shippingInfo.twitter  != null && anonymous=="false"}">
											<div class="col-md-6">
												<div class="form-group">
													<div class="input-group col-md-12">
														<input class="form-control" type="text" placeholder="Twitter Handle" name="twitterHandle">
													</div>
												</div>
											</div>
										</g:if>
										<g:if test="${shippingInfo.custom  != null}">
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
			
					<div class="col-md-4 box fund-campaign-tile-center-align">
						<g:render template="/layouts/tile"/>
						<div class="center-fund payu_continue_btn-align">
							<button type="submit" class="btn btn-primary btn-block btn-lg checkoutsubmitbutton" name="fund-button" id="paypalsubmitbutton">Continue</button>
						</div>
						<div class="powerdby">
							<p  class="powerd-by-text">Powered By PayUMoney</p>
							<p><img src="//s3.amazonaws.com/crowdera/assets/poweredByFirstgiving.jpg"/></p>
						</div>
					</div>
				</div>
			</g:form>
		</div>
	</div>
</body>
</html>

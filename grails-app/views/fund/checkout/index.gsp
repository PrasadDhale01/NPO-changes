<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<g:set var="rewardservice" bean="rewardService"/>
<%
    def shippingInfo = rewardservice.getShippingInfo(reward)
    def currentUser = userService.getCurrentUser()
    def isAnonymous = userService.isAnonymous(user)
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
    <% def contributedAmount = projectService.getDataType(amount) %>
    <g:form action="charge" method="POST" name="payment-form" role="form" id="payment-form" class="payment-form">
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
                        <g:hiddenField name="tempValue" value="${user1.id}"/>
                    </g:if>
                    <g:else>
                        <g:hiddenField name="tempValue" value="${user1}"/>
                    </g:else>
                    <g:hiddenField name="userId" value="${user.id}"/>
                    <g:hiddenField name="rewardId" value="${reward.id}"/>
                    <g:hiddenField name="fr" value="${username}"/>
                    <g:hiddenField name="amount" value="${amount}"/>
                    <g:hiddenField name="currencyCode" value="USD"/>
                    <g:hiddenField name="charityId" value="${project.charitableId}"/>
                    <g:hiddenField name="projectAmount" value="${project.amount}"/>
                    <g:hiddenField name="anonymous" value="${anonymous}" id="anonymous"/>
                    <g:hiddenField name="projectTitle" value="${projectTitle}"/>
                    <!-- TDODO-->

                    <div class="panel panel-default">
			        <div class="panel-heading">
						<h3 class="panel-title">Card Details</h3>
					</div>
					<div class="panel-body">
					    <div class="form-group">
						    <div class="leftcard-column">
						        <span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
                        		<input type="text" class="card-number form-control" placeholder="Card Number" data-stripe="number" name="ccNumber">
						        <div class="clear-both"></div>
						    </div>
						    <div class="rightcard-column">
						        <span class="input-group-addon card-details"><span class="glyphicon glyphicon-credit-card"></span> </span>
                        		<g:select class="selectpicker card-number" name="ccType" id="ccType"
                           			from="${cardTypes}" optionKey="key" optionValue="value"/>
                           		<div class="clear-both"></div>
						    </div>
						    <div class="clear-both"></div>
                     	</div>
                        <div class="clear"></div>
                     	<div class="form-group">
                            <div class="leftcard-column-one">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span> </span>
                                    <input class="form-control" type="text" placeholder="CVC" data-stripe="cvc" name="ccCardValidationNum">
                                <div class="clear"></div>   	
                            </div>
                            <div class="leftcard-column-two">
                            <span class="input-group-addon card-details"><span class="glyphicon glyphicon-calendar"></span> </span>
                                    <g:select class="selectpicker" name="ccExpDateMonth" from="${month}" optionKey="key" data-stripe="exp-month" optionValue="value"/>
                                <div class="clear"></div>	
                            </div>
                            <div class="leftcard-column-three">
                            <span class="input-group-addon card-details"><span class="glyphicon glyphicon-calendar"></span> </span>
                                    <g:select class="selectpicker" name="ccExpDateYear" from="${year}" optionKey="key" data-stripe="exp-year" optionValue="value"/>
                                <div class="clear"></div>
                            </div>
                            <div class="clear"></div>
                    	</div>
                    </div>
                </div><br>
                
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
                                    	<input class="form-control" type="text" placeholder="First Name" name="billToFirstName" id="billToFirstName">
                                	</div>
                            	</div>
								<div class="form-group">
									<div class="input-group col-md-12">
										<input class="form-control" type="text" placeholder="Last Name" name="billToLastName">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group col-md-12">
										<input class="form-control" type="text" placeholder="Email" name="billToEmail">
									</div>
								</div>
							</g:if>
							<g:else>
								<div class="form-group">
									<div class="input-group col-md-12">
										<input class="form-control" type="text" placeholder="First Name" name="billToFirstName" id="billToFirstName" value="${user.firstName}">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group col-md-12">
										<input class="form-control" type="text" placeholder="Last Name" name="billToLastName" value="${user.lastName}">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group col-md-12">
										<input class="form-control" type="text" placeholder="Email" name="billToEmail" value="${user.email}">
									</div>
								</div>
							</g:else>
								<div class="form-group">
									<div class="input-group col-md-12">
										<input class="form-control" type="text" placeholder="Phone Number" name="billToPhone">
									</div>
								</div>
                            	<div class="clear"></div>
                            </div>

                        	<div class="col-md-6">
                                <div class="form-group">
                                    <div class="input-group col-md-12">
                                        <input class="form-control" type="text" placeholder="Address Line 1" name="billToAddressLine1" id="billToAddressLine1">
                                    </div>
                                </div>
                        		<div class="form-group">
                                	<div class="input-group col-md-12">
                                    	<input class="form-control" type="text" placeholder="Address Line 2" name="billToAddressLine2" id="billToAddressLine2">
                                	</div>
                            	</div>

                            	<div class="form-group">
                                	<div class="input-group col-md-12">
                                		<div class="row">
                                			<div class="col-sm-6">
                                				<input class="form-control" type="text" placeholder="City" name="billToCity" id="billToCity" id="billToCity">
                                			</div>
                                			<div class="col-sm-6">
                                    			<input class="form-control" type="text" placeholder="Zip" name="billToZip" id="billToZip"> 
                                			</div>
                                		</div>
                                	</div>
                            	</div>
                            
                            	<div class="form-group">
                            		<div class="input-group col-md-12">
                                    	<g:select class="selectpicker" name="billToState" id="billToState"
                                      				from="${state}" 
                                      				optionKey="key" optionValue="value"/>
                                	</div>
                            	</div>
                            	
                            	<div class="form-group" id="otherState">
                            		<div class="input-group col-md-12">
                            			<input class="form-control" type="text" placeholder="Other State" name="otherState" id="os">
                            		</div>
                            	</div>
                            
                            	<div class="form-group">
                                	<div class="input-group col-md-12">
                                		<g:select class="selectpicker" name="billToCountry" id="billToCountry"
                                      		from="${country}" value="${defaultCountry}"
                                      		optionKey="key" optionValue="value"/>
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
	                            <h3 class="panel-title">Shipping Information Required to Fulfill a Perk</h3>
	                        </div>
	                        <div class="panel-body">
	                            <g:if test="${shippingInfo.address != null}">
	                                <label class="checkbox control-label">
		                               <input type="checkbox" name="checkAddress" id="checkAddress" > Address same as above.
		                            </label>
	                                <div class="col-md-6" id="physicalAddress">
	                                    <div class="form-group">
	                                        <div class="input-group col-md-12">
	                                            <input class="form-control" type="text" placeholder="AddressLine1" name="addressLine1" id="addressLine1">
	                                        </div>
	                                    </div>
	                                    <div class="form-group">
	                                        <div class="input-group col-md-12">
	                                            <input class="form-control" type="text" placeholder="AddressLine2" name="addressLine2" id="addressLine2">
	                                        </div>
	                                    </div>
                                        <div class="form-group">
                                            <div class="input-group col-md-12">
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <input class="form-control" type="text" placeholder="City" name="city" id="city">
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <input class="form-control" type="text" placeholder="Zip" name="zip" id="zip"> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
	                                </div>
	                                <div class="col-md-6">
	                                    <div class="form-group">
	                                        <div class="input-group col-md-12">
	                                            <g:select class="selectpicker state" name="state" id="state"
                                      				from="${state}" optionKey="key" optionValue="value"/>
	                                        </div>
	                                    </div>
                                        <div class="form-group" id="other">
                                            <div class="input-group col-md-12">
                                                <input class="form-control" type="text" placeholder="Other State" name="otherstate" id="otherstate">
                                            </div>
                                        </div>
	                                    <div class="form-group">
	                                        <div class="input-group col-md-12">
	                                            <g:select class="selectpicker" name="country" id="country"
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
	                            <g:if test="${shippingInfo.email  != null}">
	                                <div class="col-md-6">
	                                    <div class="form-group">
	                                        <div class="input-group col-md-12">
	                                            <input class="form-control" type="text" placeholder="Email" name="shippingEmail">
	                                        </div>
	                                    </div>
	                                </div>
	                            </g:if>
	                            <g:if test="${shippingInfo.twitter  != null && anonymous == "false"}">
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
                <div class="form-group term-of-use-center-alignment">
                    <label class="checkbox control-label">
                        <input type="checkbox" name="agreetoTermsandUse" id="agreetoTermsandUse">By continuing, you agree to our <a href="${resource(dir: '/termsofuse')}">Terms of Use</a>
                    </label>
                </div>
                <div class="center-fund">
                	<button type="submit" class="btn btn-primary btn-block btn-lg checkoutsubmitbutton" name="fund-button" id="btnPaypal">Fund this Campaign</button>
                </div>
                <div class="powerdby">
                    <p class="powerd-by-text">Powered By Firstgiving</p>
                    <p><img src="//s3.amazonaws.com/crowdera/assets/poweredByFirstgiving.jpg" alt="Powered By Firstgiving"/></p>
                </div>
            </div>
        </div>
        </g:form>
    </div>
</div>
</body>
</html>

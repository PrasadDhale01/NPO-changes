<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
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
</head>
<body>
<div class="feducontent">
    <div class="container">
    <div class="alert alert-title">
		<h1>Powered by Firstgiving</h1>
	</div>
    <% def contributedAmount = projectService.getDataType(amount) %>
    <g:form action="charge" method="POST" name="payment-form" role="form" id="payment-form">
        <div class="row">
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h3>Your contribution: <span class="pull-right">$${contributedAmount}</span></h3>
                        <h4>Your reward: <span class="pull-right">${reward.title}</span></h4>
                    </div>
                </div>
                
                	<span class="payment-errors"></span>

                    <g:hiddenField name="projectId" value="${project.id}"/>
                    <g:hiddenField name="userId" value="${user.id}"/>
                    <g:hiddenField name="rewardId" value="${reward.id}"/>
                    <g:hiddenField name="amount" value="${amount}"/>
                    <g:hiddenField name="currencyCode" value="USD"/>
                    <g:hiddenField name="charityId" value="${project.charitableId}"/>
                    <g:hiddenField name="projectAmount" value="${project.amount}"/>
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
						        <div style="clear:both"></div>
						    </div>
						    <div class="rightcard-column">
						        <span class="input-group-addon card-details"><span class="glyphicon glyphicon-credit-card"></span> </span>
                        		<g:select class="selectpicker card-number" name="ccType" id="ccType"
                           			from="${cardTypes}" optionKey="key" optionValue="value"/>
                           		<div style="clear:both"></div>
						    </div>
						    <div style="clear:both"></div>
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
						<!--<div class="form-group">
							<div class="input-group">
                    			<span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
                        		<input type="text" class="card-number form-control" placeholder="Card Number" data-stripe="number" name="ccNumber">

                        		<span class="input-group-addon card-details"><span class="glyphicon glyphicon-credit-card"></span> </span>
                        		<g:select class="selectpicker card-number" name="ccType" id="ccType"
                           			from="${cardTypes}" optionKey="key" optionValue="value"/>
                     		</div>
                     	</div>
                        <div class="clear"></div>
                     	<div class="form-group">
                        	<div class="input-group">
	                           	<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span> </span>
	                           	<input class="form-control" type="text" placeholder="CVC" data-stripe="cvc" name="ccCardValidationNum">
	                           	
                          		<span class="input-group-addon card-details"><span class="glyphicon glyphicon-calendar"></span> </span>
                          		<g:select class="selectpicker" name="ccExpDateMonth" from="${month}" optionKey="key" data-stripe="exp-month" optionValue="value"/>
                          		
	                           	<span class="input-group-addon card-details"><span class="glyphicon glyphicon-calendar"></span> </span>
	                           	<g:select class="selectpicker" name="ccExpDateYear" from="${year}" optionKey="key" data-stripe="exp-year" optionValue="value"/>
                        	</div>
                    	</div>
                    	-->
                    </div>
                </div><br>
                
                <div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Personal Details</h3>
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
								<div class="form-group">
                                	<div class="input-group col-md-12">
                                    	<input class="form-control" type="text" placeholder="Address Line 1" name="billToAddressLine1">
                                	</div>
                            	</div>
                            	<div class="clear"></div>
                            </div>

                        	<div class="col-md-6">
                        		<div class="form-group">
                                	<div class="input-group col-md-12">
                                    	<input class="form-control" type="text" placeholder="Address Line 2" name="billToAddressLine2">
                                	</div>
                            	</div>
                        
                            	<div class="form-group">
                                	<div class="input-group col-md-12">
                                    	<input class="form-control" type="text" placeholder="Address Line 3" name="billToAddressLine3">
                                	</div>
                            	</div>

                            	<div class="form-group">
                                	<div class="input-group col-md-12">
                                		<div class="row">
                                			<div class="col-sm-6">
                                				<input class="form-control" type="text" placeholder="City" name="billToCity" id="billToCity">
                                			</div>
                                			<div class="col-sm-6">
                                    			<input class="form-control" type="text" placeholder="Zip" name="billToZip"> 
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
                            			<input class="form-control" type="text" placeholder="Other State" name="otherState" >
                            		</div>
                            	</div>
                            
                            	<div class="form-group">
                                	<div class="input-group col-md-12">
                                		<g:select class="selectpicker" name="billToCountry" 
                                      		from="${country}" value="${defaultCountry}"
                                      		optionKey="key" optionValue="value"/>
                                	</div>
                            	</div>
                    		</div>
                    	</div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 box">
                <div class="row">
                	<g:if test="${project.rewards.size()>1}">
                        <g:render template="rewardtile"/>
                    </g:if>
                </div>
                <div class="row">
                	<g:render template="/layouts/tile"/>
                </div>
                <div class="row">
                    <label class="checkbox control-label">
                        <input type="checkbox" name="agreetoTermsandUse" id="agreetoTermsandUse">By continuing, you agree to our <a href="${resource(dir: '/termsofuse')}">Terms of Use</a>
                    </label>
                </div>
                <div class="row" align="center">
                	<button type="submit" class="btn btn-primary btn-block btn-lg" name="fund-button" id="paypalsubmitbutton">Fund this Campaign</button>
                </div>
            </div>
        </div>
        </g:form>
    </div>
</div>
</body>
</html>

<g:set var="projectService" bean="projectService"/>
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
    <g:form action="charge" method="POST" name="payment-form" role="form" id="payment-form">
        <div class="row">
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h3>Your contribution: <span class="pull-right">$${amount}</span></h3>
                        <h4>Your reward: <span class="pull-right">${reward.title}</span></h4>
                    </div>
                </div>
                
                	<span class="payment-errors"></span>

                    <g:hiddenField name="projectId" value="${project.id}"/>
                    <g:hiddenField name="rewardId" value="${reward.id}"/>
                    <g:hiddenField name="amount" value="${amount}"/>
                    <g:hiddenField name="currencyCode" value="USD"/>
                    <g:hiddenField name="charityId" value="${project.charitableId}"/>
                    <g:hiddenField name="projectAmount" value="${project.amount}"/>
                    <!-- TDODO-->
                    <g:hiddenField name="remoteAddr" value="192.168.1.1"/>

                    <div class="panel panel-default">
			        <div class="panel-heading">
						<h3 class="panel-title">Card Details</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<div class="input-group">
                    			<span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
                        		<input type="text" class="card-number form-control" placeholder="Card Number" data-stripe="number" name="ccNumber">

                        		<span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
                        		<g:select class="selectpicker card-number" name="ccType" id="ccType"
                           			from="${cardTypes}" optionKey="key" optionValue="value"/>
                     		</div>
                     	</div>
                                    
                     	<div class="form-group">
                        	<div class="input-group cvc-details">
                        		<div class="col-md-4">
	                            	<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span> </span>
	                            	<input class="form-control" type="text" placeholder="CVC" data-stripe="cvc" name="ccCardValidationNum">
								</div>
								<div class="col-md-4">
                            		<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
	                            	<input class="form-control" type="text" placeholder="MM" data-stripe="exp-month"  name="ccExpDateMonth">
	                            </div>
								<div class="col-md-4">
	                            	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
	                            	<input class="form-control" type="text" placeholder="YYYY" data-stripe="exp-year" name="ccExpDateYear">
	                            </div>
                        	</div>
                    	</div>
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
                        	<% if (user!=null){ %>	
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
								<% } else { %>
								<div class="form-group">
									<div class="input-group col-md-12">
										<input class="form-control" type="text" placeholder="First Name" name="billToFirstName" id="billToFirstName" >
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
								<%}%>
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
                                				<input class="form-control" type="text" placeholder="City" name="billToCity">
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
                 <div class="row" align="center">
                	<button type="submit" class="btn btn-primary btn-block btn-lg" name="fund-button" id="paypalsubmitbutton">Fund this project</button>
                </div>
            </div>
        </div>
        </g:form>
    </div>
</div>
</body>
</html>

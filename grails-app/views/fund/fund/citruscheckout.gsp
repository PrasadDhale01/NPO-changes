<%@page import="org.codehaus.groovy.grails.commons.GrailsApplication"%>
<g:set var="projectService" bean="projectService"/>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="citrusfundjs" />
    <r:require modules="fundcss" />
    <title>Crowdera- Contribute</title>
    
</head>
<body>
    <div class="feducontent">
        <div class="container fund-sm-container footer-container">
        
            <div class="row" id="fundindex">
                <div class="alert alert-info" id="perkForAnonymousUser">
                    <b>Sorry ! You cannot select twitter perk as you are contributing anonymously.</b>
                </div>
                
                
                <%
				    def citrusCardTypes = ['credit': 'Credit', 'debit': 'Debit']
				    def citrusSchemes = ['visa': 'VISA', 'mastercard' :'MASTER', 'maestro':'MAESTRO', 'rupay':'RUPAY']
                    def citrus = true;
				%>
				<div id="myWizard">
				    <g:form action="citrusCheckout" method="POST" class="checkoutForm">
				        <section class="step" data-step-title="Transaction Amount">
				            <div class="col-md-4">
				                <g:if test="${flash.amt_message}">
				                    <div class="alert alert-danger">
				                        ${flash.amt_message}
				                    </div>
				                </g:if>
				                <div class="row">
				                    <div class="col-md-12 col-sm-12 col-xs-12">
				                        <h1>Amount</h1>
				                    </div>
				                </div>
				        
				        
				                <g:hiddenField name="isINR" value="${project.payuStatus}" id="isINR"/>
				                <g:hiddenField name="projectId" value="${project.id}" />
				                <g:hiddenField name="fr" value="${vanityUsername}" />
				                <g:hiddenField name="rewardId" />
				                <g:hiddenField name="url" value="${base_url}" id="url"/>
				                <g:hiddenField name="anonymous" value="false" id="anonymous"/>
				                <g:hiddenField name="projectTitle" value="${vanityTitle}"/>
				            
				    
				                <div class="row">
				                    <div class="col-md-12 col-sm-12 col-xs-12">
				                    <div class="form-group">
				                        <div class="input-group">
				                            <span class="amount input-group-addon"><g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else><span class="glyphicon glyphicon-usd"></span></g:else></span>
				                            <input class="amount form-control" id="amount" name="amount" type="text" <g:if test="${perk}">value="${perk.price.round()}"</g:if><g:else>value=""</g:else> >
				                        </div>
				                        <span id="errormsg"></span>
				                    </div>
				                    </div>
				                </div>
				            
				                <div class="row">
				                    <div class="col-md-12 col-sm-12 col-xs-12">
				                        <g:if test="${user != null}">
				                            <g:hiddenField name="tempValue" id="tempValue" value="${user.id}"/>
				                            <g:hiddenField name="userId"  id="userId" value="${user.id}"/>
				                        </g:if>
				                        <label class="checkbox">
				                            <input type="checkbox" name="anonymousUser" id="anonymousUser" > Please keep my contribution anonymous.
				                        </label>
				                    </div>
				                </div>
				            
				                <div class="row">
				                    <div class="col-md-12 col-sm-12 col-xs-12">
				                        <div  class="amount-button"><button type="submit" class="btn btn-primary btn-lg" id="btnCheckoutContinue">Continue</button></div>
				                    </div>
				                </div>
				            
				            </div>
				        
				            <div class="col-md-8">
				                <g:if test="${project.rewards.size()>1}">
				                    <g:render template="fund/rewards" model="[user:user, citrus: citrus]" />
				                </g:if>
				            </div>
				        </section>
				    
				        <section class="step" data-step-title="Billing Information">
				            <div class="panel panel-default">
				                <div class="panel-heading">
				                    <h3 class="panel-title">Billing Information <g:if test="${currentUser == null}">(Your contact details are used to send a receipt)</g:if></h3>
				                </div>
				                <div class="panel-body">  
				                    <div class="row">
				                    
				                        <div class="col-md-6">
				                            <g:if test="${!isAnonymous}">
				                                <div class="form-group">
				                                    <div class="input-group col-md-12">
				                                        <input class="form-control all-place" type="text" placeholder="First Name" name="citrusFirstName" id="citrusFirstName">
				                                    </div>
				                                </div>
				                                <div class="form-group">
				                                    <div class="input-group col-md-12">
				                                        <input class="form-control all-place" type="text" placeholder="Last Name" name="citrusLastName" id="citrusLastName">
				                                    </div>
				                                </div>
				                                <div class="form-group">
				                                    <div class="input-group col-md-12">
				                                        <input class="form-control all-place" type="text" placeholder="Email" name="citrusEmail" id="citrusEmail">
				                                    </div>
				                                </div>
				                            </g:if>
				                            <g:else>
				                                <div class="form-group">
				                                    <div class="input-group col-md-12">
				                                        <input class="form-control all-place" type="text" placeholder="First Name" name="citrusFirstName" id="citrusFirstName" value="${user.firstName}">
				                                    </div>
				                                </div>
				                                <div class="form-group">
				                                    <div class="input-group col-md-12">
				                                        <input class="form-control all-place" type="text" placeholder="Last Name" name="citrusLastName" id="citrusLastName" value="${user.lastName}">
				                                    </div>
				                                </div>
				                                <div class="form-group">
				                                    <div class="input-group col-md-12">
				                                        <input class="form-control all-place" type="text" placeholder="Email" name="citrusEmail" id="citrusEmail" value="${user.email}">
				                                    </div>
				                                </div>
				                            </g:else>
				                            <div class="form-group">
				                                <div class="input-group col-md-12">
				                                    <input class="form-control all-place" type="text" placeholder="Phone Number" name="citrusMobile" id="citrusMobile">
				                                </div>
				                            </div>
				                            <div class="clear"></div>
				                        </div>
				
				                        <div class="col-md-6">
				                            <div class="form-group">
				                                <div class="input-group col-md-12">
				                                    <input class="form-control all-place" type="text" placeholder="Address Line 1" name="citrusStreet1" id="citrusStreet1">
				                                </div>
				                            </div>
				                            <div class="form-group">
				                                <div class="input-group col-md-12">
				                                    <input class="form-control all-place" type="text" placeholder="Address Line 2" name="citrusStreet2" id="citrusStreet2">
				                                </div>
				                            </div>
				
				                            <div class="form-group">
				                                <div class="input-group col-md-12">
				                                    <div class="row">
				                                        <div class="col-sm-6">
				                                            <input class="form-control TW-city-margin all-place" type="text" placeholder="City" name="citrusCity" id="citrusCity" id="billToCity">
				                                        </div>
				                                        <div class="col-sm-6">
				                                            <input class="form-control all-place" type="text" placeholder="Zip" name="citrusZip" id="citrusZip"> 
				                                        </div>
				                                    </div>
				                                </div>
				                            </div>
				
				                            <div class="form-group">
				                                <div class="input-group col-md-12">
				                                    <g:select class="selectpicker" name="billToState" id="billToState" from="${state}" optionKey="key" optionValue="value"/>
				                                </div>
				                            </div>
				                            <input type="hidden" name="citrusState" id="citrusState" value="">
				                            
				                            <div class="form-group" id="otherState">
				                                <div class="input-group col-md-12">
				                                    <input class="form-control all-place" type="text" placeholder="Other State" name="otherState" id="os">
				                                </div>
				                            </div>
				                            
				                            <div class="form-group">
				                                <div class="input-group col-md-12">
				                                    <g:select class="selectpicker" name="citrusCountry" id="citrusCountry" from="${country}" value="${defaultCountry}" optionKey="key" optionValue="value"/>
				                                </div>
				                            </div>
				                            
				                        </div>
				                        
				                    </div>
				                </div>
				            </div>
				                
				            <g:if test="${shippingInfo}">
				                <g:if test="${shippingInfo.address != null || shippingInfo.email  != null || (shippingInfo.twitter  != null && anonymous == 'false') || (shippingInfo.custom  != null && shippingInfo.custom  != '')}">
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
				                                            <input class="form-control all-place" type="text" placeholder="AddressLine1" name="addressLine1" id="addressLine1">
				                                        </div>
				                                    </div>
				                                    <div class="form-group">
				                                        <div class="input-group col-md-12">
				                                            <input class="form-control all-place" type="text" placeholder="AddressLine2" name="addressLine2" id="addressLine2">
				                                        </div>
				                                    </div>
				                                    <div class="form-group">
				                                        <div class="input-group col-md-12">
				                                            <div class="row">
				                                                <div class="col-sm-6">
				                                                    <input class="form-control all-place" type="text" placeholder="City" name="city" id="city">
				                                                </div>
				                                                <div class="col-sm-6">
				                                                    <input class="form-control all-place" type="text" placeholder="Zip" name="zip" id="zip"> 
				                                                </div>
				                                            </div>
				                                        </div>
				                                    </div>
				                                </div>
				                                <div class="col-md-6">
				                                    <div class="form-group">
				                                        <div class="input-group col-md-12">
				                                            <g:select class="selectpicker state" name="state" id="state" from="${state}" optionKey="key" optionValue="value"/>
				                                        </div>
				                                    </div>
				                                    <div class="form-group" id="other">
				                                        <div class="input-group col-md-12">
				                                            <input class="form-control all-place" type="text" placeholder="Other State" name="otherstate1" id="otherstate1">
				                                        </div>
				                                    </div>
				                                    <div class="form-group">
				                                        <div class="input-group col-md-12">
				                                            <g:select class="selectpicker" name="country" id="country" from="${country}" value="US" optionKey="key" optionValue="value"/>
				                                        </div>
				                                    </div>
				                                </div>
				                                
				                                <div class="clear"></div>
				                                <g:if test="${shippingInfo.email  != null || (shippingInfo.twitter  != null && anonymous == 'false') || shippingInfo.custom  != null}">
				                                    <hr>
				                                </g:if>
				                            </g:if>
				                            <g:if test="${shippingInfo.email  != null}">
				                                <div class="col-md-6">
				                                    <div class="form-group">
				                                        <div class="input-group col-md-12">
				                                            <input class="form-control all-place" type="text" placeholder="Email" name="shippingEmail">
				                                        </div>
				                                    </div>
				                                </div>
				                            </g:if>
				                            <g:if test="${shippingInfo.twitter  != null && anonymous == 'false'}">
				                                <div class="col-md-6">
				                                    <div class="form-group">
				                                        <div class="input-group col-md-12">
				                                            <input class="form-control all-place" type="text" placeholder="Twitter Handle" name="twitterHandle">
				                                        </div>
				                                    </div>
				                                </div>
				                            </g:if>
				                            <g:if test="${shippingInfo.custom != null && shippingInfo.custom != ''}">
				                                <g:hiddenField name="customField" id="customField" value="${shippingInfo.custom}"/>
				                                <div class="col-md-6">
				                                    <div class="form-group">
				                                        <div class="input-group col-md-12">
				                                            <input class="form-control all-place" type="text" id="customShippingInfo" name="shippingCustom">
				                                        </div>
				                                    </div>
				                                </div>
				                            </g:if>
				                            
				                        </div>
				                    </div>
				                </g:if>
				            </g:if>
				        
				        </section>
				    
				        <section class="step" data-step-title="Card Details">
				            <div class="panel panel-default">
				                <div class="panel-heading">
				                    <h3 class="panel-title">Card Details</h3>
				                </div>
				                <div class="panel-body">
				                    <div class="form-group">
				                        <div class="leftcard-column">
				                            <span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
				                            <input type="text" class="card-number form-control all-place" placeholder="Card Holder Name" name="citrusCardHolder" id="citrusCardHolder" required>
				                            <div class="clear-both"></div>
				                        </div>
				                        <div class="rightcard-column">
				                            <span class="input-group-addon card-details"><span class="glyphicon glyphicon-credit-card"></span> </span>
				                            <g:select class="selectpicker card-number card-number-width" name="citrusCardType" id="citrusCardType" from="${citrusCardTypes}" optionKey="key" optionValue="value"/>
				                            <div class="clear-both"></div>
				                        </div>
				                        <div class="clear-both"></div>
				                    </div>
				                    
				                    <div class="clear"></div>
				                    
				                    <div class="form-group">
				                        <div class="leftcard-column">
				                            <span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
				                            <input type="text" class="card-number form-control all-place" placeholder="Card Number" name="citrusNumber" id="citrusNumber" data-stripe="number" required>
				                            <div class="clear-both"></div>
				                        </div>
				                        <div class="rightcard-column">
				                            <span class="input-group-addon card-details"><span class="glyphicon glyphicon-credit-card"></span> </span>
				                            <g:select class="selectpicker card-number card-number-width" name="citrusScheme" id="citrusScheme" from="${citrusSchemes}" optionKey="key" optionValue="value"/>
				                            <div class="clear-both"></div>
				                        </div>
				                        <div class="clear-both"></div>
				                    </div>
				                    
				                    <div class="clear"></div>
				                    
				                    <div class="form-group cvc-width">
				                        <div class="leftcard-column-one">
				                        <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span> </span>
				                                <input class="form-control all-place" type="text" placeholder="CVV" data-stripe="cvc" name="citrusCvv" id="citrusCvv" required>
				                            <div class="clear"></div>       
				                        </div>
				                        <div class="leftcard-column-two">
				                        <span class="input-group-addon card-details"><span class="glyphicon glyphicon-calendar"></span> </span>
				                                <g:select class="selectpicker card-number-width" name="ccExpDateMonth" id="ccExpDateMonth" from="${month}" optionKey="key" data-stripe="exp-month" optionValue="value"/>
				                            <div class="clear"></div>   
				                        </div>
				                        <div class="leftcard-column-three">
				                        <span class="input-group-addon card-details"><span class="glyphicon glyphicon-calendar"></span> </span>
				                                <g:select class="selectpicker card-number-width" name="ccExpDateYear" id="ccExpDateYear" from="${year}" optionKey="key" data-stripe="exp-year" optionValue="value"/>
				                            <div class="clear"></div>
				                        </div>
				                        <div class="clear"></div>
				                        <div class="dateErrorMsg">Please select valid date. It should be greater than current date.</div>
				                        <input type="hidden" id="isValidDate" value="true"/>
				                    </div>
				                </div>
				            </div><br>
				        </section>
				    
				    </g:form>
				</div>
                
            </div>
        </div>
        
    </div>
</body>
</html>

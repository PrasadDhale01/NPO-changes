<%@page import="org.codehaus.groovy.grails.commons.GrailsApplication"%>
<g:set var="projectService" bean="projectService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="wepayfundjs" />
    <r:require modules="fundcss" />
    <title>Crowdera- Contribute</title>
    
</head>
<body>
    <div class="feducontent">
        <div class="container fund-sm-container footer-container">
        
            <div class="row citrusfundbody" id="fundindex">
                <div class="alert alert-info" id="perkForAnonymousUser">
                    <b>Sorry ! You cannot select twitter perk as you are contributing anonymously.</b>
                </div>
                
                <%
                    SimpleDateFormat dateFormat = new SimpleDateFormat("MM/YYYY");
                    def currentDate = dateFormat.format(new Date());
					def country_code = projectService.getCountryCodeForCurrentEnv(request);
                    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
                    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
                    
                    def baseUrl = base_url.substring(0, (base_url.length() - 1))
                    def returnURL = baseUrl + '/fund/wepayreturn'
                    
                    def clientId = grailsApplication.config.crowdera.wepay.CLIENT_ID
					def endPoint;
					if ('production'.equals(currentEnv)) {
						endPoint = 'production'
					} else {
					    endPoint = 'stage'
					}
					
                %>
                <div id="myWizard">
                    <g:form action="wepayReturn" controller="fund" method="POST" class="payment-form" id="payment-form" name="payment-form">
                        
                        <div class="step" data-step-title="Transaction Amount">
                            <div class="col-md-5">
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
                        
                        
                                <g:if test="${user}">
                                    <g:hiddenField name="tempValue" value="${user.id}"/>
                                     <g:hiddenField name="userId"  id="userId" value="${user.id}"/>
                                </g:if>
                                <g:else>
                                    <g:hiddenField name="tempValue"/>
                                </g:else>
                
                                <g:hiddenField name="projectId" value="${project.id}" />
                                <g:hiddenField name="fr" value="${vanityUsername}" />
                                <g:hiddenField name="rewardId" />
                                <g:hiddenField name="url" value="${baseUrl}" id="url"/>
                                <g:hiddenField name="anonymous" value="false" id="anonymous"/>
                                <g:hiddenField name="projectTitle" value="${vanityTitle}"/>
                                <input type="hidden" name="projectAmount" id="projectAmount" value="${project.amount.round() }"/>
                                
                                <g:hiddenField type="hidden" name="projectTitle" value="${projectTitle}"/>
                                
                                <!--   WEPAY Transaction details -->
                                
                                <input type="hidden" name="cardExpiry" id="cardExpiry" value="${currentDate}" />
                
                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="amount input-group-addon"><g:if test="${'in'.equalsIgnoreCase(project?.country?.countryCode)}"><span class="fa fa-inr"></span></g:if><g:else><span class="glyphicon glyphicon-usd"></span></g:else></span>
                                            <input class="amount form-control" id="amount" name="amount" type="text" <g:if test="${perk}">value="${perk.price.round()}"</g:if><g:else>value=""</g:else> >
                                        </div>
                                        <span id="errormsg"></span>
                                    </div>
                                    </div>
                                </div>
                                
                                <label class="checkbox control-label">
                                    <input type="checkbox" name="anonymousUser" id="anonymousUser" > Please keep my contribution anonymous.
                                </label>
                                
                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xs-12 eazywizard-bottom-margin">
                                        <div  class="amount-button"><button type="button" class="btn btn-info btn-md btn-block" id="btnCheckoutContinue">Continue</button></div>
                                    </div>
                                    <div class="clear"></div>
                                    <div class="col-sm-12">
                                        <h4><b>Powered by WePay</b></h4>
                                    </div>
                                    <div class="col-sm-12 eazywizard-bottom-margin">
                                        <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/4479bc5f-f890-4cf4-8429-567ed2a1b58e.png" alt="wepay">
                                    </div>
                                </div>
                            
                            </div>
                            
                            <div class="col-md-offset-1 col-md-6 col-sm-offset-0 col-sm-12">
                                <g:if test="${project.rewards.size()>1}">
                                    <g:render template="fund/rewards" model="[user:user, citrus: citrus]" />
                                </g:if>
                            </div>
                        </div>
                        
                        <div class="step" data-step-title="Billing Information" id="billingInformation">
                            <div class="panel panel-primary billing-panel">
                                <div class="panel-heading shipping-heading">
                                    <h3 class="panel-title">Billing Information <g:if test="${currentUser == null}">(Your contact details are used to send a receipt)</g:if></h3>
                                </div>
                                <div class="panel-body">  
                                    
                                    <div class="col-md-6 col-sm-6">
                                        <g:if test="${user == null}">
                                            <div class="form-group">
                                                <div class="input-group col-md-12">
                                                    <input class="form-control all-place" type="text" placeholder="First Name" name="contributorFirstName" id="contributorFirstName">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group col-md-12">
                                                    <input class="form-control all-place" type="text" placeholder="Last Name" name="contributorLastName" id="contributorLastName">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group col-md-12">
                                                    <input class="form-control all-place" type="text" placeholder="Email" name="contributorEmail" id="contributorEmail">
                                                </div>
                                            </div>
                                        </g:if>
                                        <g:else>
                                            <div class="form-group">
                                                <div class="input-group col-md-12">
                                                    <input class="form-control all-place" type="text" placeholder="First Name" name="contributorFirstName" id="contributorFirstName" value="${user.firstName}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group col-md-12">
                                                    <input class="form-control all-place" type="text" placeholder="Last Name" name="contributorLastName" id="contributorLastName" value="${user.lastName}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group col-md-12">
                                                    <input class="form-control all-place" type="text" placeholder="Email" name="contributorEmail" id="contributorEmail" value="${user.email}">
                                                </div>
                                            </div>
                                        </g:else>
                                        
                                        <div class="form-group">
                                            <div class="input-group col-md-12">
                                                <input class="form-control all-place" type="text" placeholder="Phone Number" name="contributorMobile" id="contributorMobile">
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                    </div>
            
                                    <div class="col-md-6 col-sm-6">
                                        <div class="form-group">
                                            <div class="input-group col-md-12">
                                                <input class="form-control all-place" type="text" placeholder="Address Line 1" name="contributorStreet1" id="contributorStreet1">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group col-md-12">
                                                <input class="form-control all-place" type="text" placeholder="Address Line 2" name="contributorStreet2" id="contributorStreet2">
                                            </div>
                                        </div>
            
                                        <div class="form-group">
                                            <div class="input-group col-md-12">
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <input class="form-control TW-city-margin all-place" type="text" placeholder="City" name="contributorCity" id="contributorCity">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <input class="form-control all-place" type="text" placeholder="Zip" name="contributorZip" id="contributorZip">
                                                        </div> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
            
                                        <div class="form-group">
                                            <div class="input-group col-md-12 wepayCountryDiv">
                                                <g:select class="selectpicker" name="wepayCountry" id="wepayCountry" from="${country}" optionKey="key" optionValue="value" value="${defaultCountry}"/>
                                            </div>
                                        </div>
                                        <input class="form-control all-place" type="hidden" placeholder="Country" name="contributorCountry" id="contributorCountry" value="${defaultCountry}" readonly>
                                        

                                        <div class="form-group">
                                            <div class="input-group col-md-12 citrusStateDiv">
                                                <g:select class="selectpicker" name="billToState" id="billToState" from="${state}" optionKey="key" optionValue="value"/>
                                            </div>
                                        </div>
                                        <input type="hidden" name="contributorState" id="contributorState" value="">
                                        
                                        <div class="form-group" id="otherState">
                                            <div class="input-group col-md-12">
                                                <input class="form-control all-place" type="text" placeholder="Other State" name="otherState" id="otherStateName">
                                            </div>
                                        </div>
                                        
                                    </div>
                                        
                                </div>
                            </div>
                            
                            <div id="perkShippingInfo">
                                
                            </div>
                            
                            <div class="col-xs-12 eazywizard-bottom-margin">
                                <div class="col-sm-6">
                                    <h4><b>Powered by WePay</b></h4>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/4479bc5f-f890-4cf4-8429-567ed2a1b58e.png" alt="citrus">
                                </div>
                                <div class="col-sm-4 pull-right col-xs-offset-0 col-xs-12">
                                    <div class="amount-button"><button type="button" class="btn btn-info btn-lg btn-block" id="btnShippingContinue">Continue</button></div>
                                </div>
                            </div>
				        </div>
				    
				        <div class="step" data-step-title="Card Details" id="citrusCardDetails">
				            <div class="panel panel-primary billing-panel">
				                <div class="panel-heading shipping-heading">
				                    <h3 class="panel-title">Card Details</h3>
				                </div>
				                <div class="panel-body">
					                <div class="col-md-offset-1 col-md-10 col-sm-offset-0 col-sm-12 col-xs-12 col-xs-offset-0">
					                    <div class="form-group">
					                        <div class="leftcard-column">
					                            <span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
					                            <input type="text" class="card-number form-control all-place" placeholder="Card Holder Name" name="wepayContributorName" id="wepayContributorName" maxlength="30" required>
					                            <div class="clear-both"></div>
					                        </div>
					                        <div class="rightcard-column">
					                            <span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
					                            <input type="text" class="form-control all-place" placeholder="Card Holder Email" name="wepayContributorEmail" id="wepayContributorEmail" maxlength="30" required>
					                            <div class="clear-both"></div>
					                        </div>
					                        <div class="clear-both"></div>
					                    </div>
					                    
					                    <div class="clear"></div>
					                    
					                    <div class="form-group">
					                        <div class="leftcard-column">
					                            <span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
					                            <input type="text" class="card-number form-control all-place" placeholder="Card Number" name="wepayccNumber" id="cc-number" data-stripe="number" required>
					                            <div class="clear-both"></div>
					                        </div>
					                        <div class="rightcard-column">
					                            <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/4479bc5f-f890-4cf4-8429-567ed2a1b58e.png" alt="card" id="cardType">
					                            <div class="clear-both"></div>
					                        </div>
					                        <div class="clear-both"></div>
					                    </div>
					                    
					                    <div class="clear"></div>
					                    
					                    <div class="form-group cvc-width">
					                        <div class="leftcard-column-one">
					                        <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span> </span>
					                                <input class="form-control all-place" type="password" placeholder="CVV" data-stripe="cvc" name="wepayCVV" id="cc-cvv" required>
					                            <div class="clear"></div>       
					                        </div>
					                        <div class="leftcard-column-two">
					                        <span class="input-group-addon card-details"><span class="glyphicon glyphicon-calendar"></span> </span>
					                                <g:select class="selectpicker card-number-width" name="cc-month" id="cc-month" from="${month}"  value="${currentMonthByWeek}" optionKey="key" data-stripe="exp-month" optionValue="value"/>
					                            <div class="clear"></div>   
					                        </div>
					                        <div class="leftcard-column-three">
					                        <span class="input-group-addon card-details"><span class="glyphicon glyphicon-calendar"></span> </span>
					                                <g:select class="selectpicker card-number-width" name="cc-year" id="cc-year" from="${year}" value="${currentYearByWeek}" optionKey="key" data-stripe="exp-year" optionValue="value"/>
					                            <div class="clear"></div>
					                        </div>
					                        <div class="clear"></div>
					                        <div class="dateErrorMsg">Please select valid expiry date.</div>
					                        <input type="hidden" id="isValidDate" value="true"/>
					                        
					                        <input type="hidden" name="postal_code" id="postal_code" value="94025">
					                    </div>
					                    
					                    
					                    <div class="col-xsl-0 col-md-4 col-xs-12 box fund-campaign-tile-center-align eazywizard-bottom-margin">
					                    
	                                        <div class="form-group term-of-use-center-alignment">
	                                            <label class="checkbox control-label">
	                                                <input type="checkbox" name="agreetoTermsandUse" id="agreetoTermsandUse">By continuing, you agree to our <a href="${resource(dir: '/termsofuse')}">Terms of Use</a>
	                                            </label>
	                                        </div>
	                                        
	                                        <div class="center-fund">
	                                            <button type="submit" class="btn btn-info btn-block btn-lg wepaycheckoutsubmitbtn" name="fund-button" id="submitButton">Fund this Campaign</button>
	                                            <button type="button" class="btn btn-info hidden btn-block btn-lg wepaycheckoutsubmitbtn" name="Submit" value="Submit" id="cc-submit"></button>
	                                            <br>
	                                            <h4><b>Powered by WePay</b></h4>
	                                        </div>
	                                    </div>
	                                    
                                    </div>
                                    
                                </div><br>
                                
                            </div>
                            
                        </div>
                    
                    </g:form>
                </div>
                
            </div>
        </div>
        
    </div>
    
    <div class="loadinggif text-center" id="loading-gif">
        <img src="//s3.amazonaws.com/crowdera/documents/loading.gif" alt="'loadingImage'" id="loading-gif-img">
    </div>
    
    <script type="text/javascript">
        var $jq = jQuery.noConflict();
    </script>
	
	<g:if env="development">
	    <script type="text/javascript" src="https://static.wepay.com/min/js/tokenization.v2.js"></script>
    </g:if>
    <g:elseif env="staging">
    	<script type="text/javascript" src="https://static.wepay.com/min/js/tokenization.v2.js"></script>
    </g:elseif>
    <g:elseif env="production">
    <%--
        Need to replace script for production env
    	--%>
    	<script type="text/javascript" src="https://static.wepay.com/min/js/tokenization.v2.js"></script>
    </g:elseif>
    
	<script type="text/javascript">
		(function() {
		    WePay.set_endpoint("${endPoint}"); // change to "production" when live
			
		    // Shortcuts
		    var d = document;
	        d.id = d.getElementById,
	        valueById = function(id) {
	            return d.id(id).value;
	        };
			
		    // For those not using DOM libraries
		    var addEvent = function(e,v,f) {
		        if (!!window.attachEvent) { e.attachEvent('on' + v, f); }
		        else { e.addEventListener(v, f, false); }
		    };
		
		    // Attach the event to the DOM
		    addEvent(d.id('cc-submit'), 'click', function() {

		        var userName = [valueById('wepayContributorName')].join(' ');
		            response = WePay.credit_card.create({
		            "client_id":        ${clientId},
		            "user_name":        valueById('wepayContributorName'),
		            "email":            valueById('wepayContributorEmail'),
		            "cc_number":        valueById('cc-number'),
		            "cvv":              valueById('cc-cvv'),
		            "expiration_month": valueById('cc-month'),
		            "expiration_year":  valueById('cc-year'),
		            "address": {
		                "postal_code": valueById('postal_code')
		            }
		        }, function(data) {
		            if (data.error) {
		                console.log(data);
		                // handle error response
		            } else {
			            
			            var creditCardId = data.credit_card_id;
			            var creditCardState = data.state;
			            
			            $.ajax({
				            type:'post',
				            url: $('#url').val()+'/fund/chargeWepayCard',
				            data:'creditCardId='+creditCardId+'&amount='+$("#amount").val()+'&projectId='+$('#projectId').val(),
				            success: function(response) {
				            	var jsonObj = JSON.parse(response);
				            	
				                if (jsonObj.status === 1) {
					                $("#payment-form").submit();
				                } else {
					                // Replace it with Notify dialogue
									alert()
					            }
				                
				                $('#loading-gif').hide();
				            }
				        }).error(function() {
				        	 $('#loading-gif').hide();
				        })
		            }
		        });
			    
		    });
		
		})();
	</script>
</body>

</html>

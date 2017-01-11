<%@page import="org.codehaus.groovy.grails.commons.GrailsApplication"%>
<g:set var="projectService" bean="projectService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="citrusfundjs" />
    <r:require modules="fundcss" />
    <title>Crowdera- Contribute</title>
    
    <script src="/js/jquery-1.11.1.min.js"> </script>
    <script src="/js/citrus.js"></script>
</head>
<body>
    <div class="feducontent">
        <div class="container fund-sm-container footer-container">
        
            <div class="row citrusfundbody" id="fundindex">
                <div class="alert alert-info" id="perkForAnonymousUser">
                    <b>Sorry ! You cannot select twitter perk as you are contributing anonymously.</b>
                </div>
                
                <%
                    def citrusCardTypes = ['credit': 'Credit', 'debit': 'Debit']
                    def citrusSchemes = ['visa': 'VISA', 'mastercard' :'MASTER', 'maestro':'MAESTRO', 'rupay':'RUPAY', 'amex': 'AMEX']
                    def citrus = true;
                    SimpleDateFormat dateFormat = new SimpleDateFormat("MM/YYYY");
                    def currentDate = dateFormat.format(new Date());
                    def citrusAvailableOptions = ['CID002':'AXIS Bank', 'CID019':'Bank of India']
					def country_code = projectService.getCountryCodeForCurrentEnv(request);
                    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
                    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
                    
                    def baseUrl = base_url.substring(0, (base_url.length() - 1))
                    def returnURL = baseUrl + '/fund/citrusreturn'
                    
                    def accessKey = grailsApplication.config.crowdera.CITRUS.ACCESS_KEY
                    def citrusVanityUrl = grailsApplication.config.crowdera.CITRUS.VANITYURL
                %>
                <div id="myWizard">
                    <g:form action="charge" method="POST" class="payment-form" id="payment-form" name="payment-form">
                        <div class="step" data-step-title="Transaction Amount" id="citrusTransactionAmount">
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
                
                                <g:hiddenField name="isINR" value="${project.payuStatus}" id="isINR"/>
                                <g:hiddenField name="projectId" value="${project.id}" />
                                <g:hiddenField name="fr" value="${vanityUsername}" />
                                <g:hiddenField name="rewardId" />
                                <g:hiddenField name="url" value="${baseUrl}" id="url"/>
                                <g:hiddenField name="anonymous" value="false" id="anonymous"/>
                                <g:hiddenField name="projectTitle" value="${vanityTitle}"/>
                                <input type="hidden" name="projectAmount" id="projectAmount" value="${project.amount.round() }"/>
                                
                                <g:hiddenField type="hidden" name="projectTitle" value="${projectTitle}"/>
                                
                                <!--   Citrus Transaction details -->
                
                                <input type="hidden" name="citrusAmount" id="citrusAmount"/>
                                <input type="hidden" name="citrusMerchantTxnId" id="citrusMerchantTxnId"/>
                                <input type="hidden" name="citrusSignature" id="citrusSignature"/>
                                <input type="hidden" name="citrusReturnUrl" id="citrusReturnUrl" value="${returnURL}" />
                                <input type="hidden" name="citrusNotifyUrl" id="citrusNotifyUrl" value="http://localhost:8080/fund/citrusnotify" />
                                
                                <input type="hidden" name="citrusExpiry" id="citrusExpiry" value="${currentDate}" />
                                
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
                                <g:if test="${isTaxReceipt}">
	                                <label class="checkbox control-label">
	                                    <input type="checkbox" name="isTaxreceipt" id="isTaxreceipt" > Do you want donation receipt?
	                                </label>
	                                <div class="form-group fund-inr pannumberdiv">
	                                    <input class="form-control" id="panNumber" name="panNumber" type="text" placeholder="Enter PAN Number" maxlength="10"/>
	                                </div>
                                </g:if>
                                <label class="checkbox control-label">
                                    <input type="checkbox" name="anonymousUser" id="anonymousUser" > Please keep my contribution anonymous.
                                </label>
                                
                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xs-12 eazywizard-bottom-margin">
                                        <div  class="amount-button"><button type="button" class="btn btn-info btn-md btn-block" id="btnCheckoutContinue">Continue</button></div>
                                    </div>
                                    <div class="clear"></div>
                                    <div class="col-sm-12">
                                        <h4><b>Powered by Citrus</b></h4>
                                    </div>
                                    <div class="col-sm-12 eazywizard-bottom-margin">
                                        <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/4479bc5f-f890-4cf4-8429-567ed2a1b58e.png" alt="citrus">
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
            
                                    <div class="col-md-6 col-sm-6">
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
                                                        <div class="form-group">
                                                            <input class="form-control TW-city-margin all-place" type="text" placeholder="City" name="citrusCity" id="citrusCity">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <input class="form-control all-place" type="text" placeholder="Zip" name="citrusZip" id="citrusZip">
                                                        </div> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
            
                                        <div class="form-group">
                                            <div class="input-group col-md-12 citrusStateDiv">
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
                                                <input class="form-control all-place" type="text" placeholder="Country" name="citrusCountry" id="citrusCountry" value="${defaultCountry}" readonly>
                                            </div>
                                        </div>
                                        
                                    </div>
                                        
                                </div>
                            </div>
                            
                            <div id="perkShippingInfo">
                                
                            </div>
                            
                            <div class="col-xs-12 eazywizard-bottom-margin">
                                <div class="col-sm-6">
                                    <h4><b>Powered by Citrus</b></h4>
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
					                            <input type="text" class="card-number form-control all-place" placeholder="Card Holder Name" name="citrusCardHolder" id="citrusCardHolder" maxlength="30" required>
					                            <div class="clear-both"></div>
					                        </div>
					                        <div class="rightcard-column citrusCardType-column">
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
					                            <input type="hidden" value="" name="citrusScheme" id="citrusScheme" />
					                            <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/4479bc5f-f890-4cf4-8429-567ed2a1b58e.png" alt="card" id="cardType">
					                            <div class="clear-both"></div>
					                        </div>
					                        <div class="clear-both"></div>
					                    </div>
					                    
					                    <div class="clear"></div>
					                    
					                    <div class="form-group cvc-width">
					                        <div class="leftcard-column-one">
					                        <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span> </span>
					                                <input class="form-control all-place" type="password" placeholder="CVV" data-stripe="cvc" name="citrusCvv" id="citrusCvv" required>
					                            <div class="clear"></div>       
					                        </div>
					                        <div class="leftcard-column-two">
					                        <span class="input-group-addon card-details"><span class="glyphicon glyphicon-calendar"></span> </span>
					                                <g:select class="selectpicker card-number-width" name="ccExpDateMonth" id="ccExpDateMonth" from="${month}"  value="${currentMonthByWeek}" optionKey="key" data-stripe="exp-month" optionValue="value"/>
					                            <div class="clear"></div>   
					                        </div>
					                        <div class="leftcard-column-three">
					                        <span class="input-group-addon card-details"><span class="glyphicon glyphicon-calendar"></span> </span>
					                                <g:select class="selectpicker card-number-width" name="ccExpDateYear" id="ccExpDateYear" from="${year}" value="${currentYearByWeek}" optionKey="key" data-stripe="exp-year" optionValue="value"/>
					                            <div class="clear"></div>
					                        </div>
					                        <div class="clear"></div>
					                        <div class="dateErrorMsg">Please select valid expiry date.</div>
					                        <input type="hidden" id="isValidDate" value="true"/>
					                    </div>
					                    
					                    
					                    <div class="col-xsl-0 col-md-4 col-xs-12 box fund-campaign-tile-center-align eazywizard-bottom-margin">
					                    
	                                        <div class="form-group term-of-use-center-alignment">
	                                            <label class="checkbox control-label">
	                                                <input type="checkbox" name="agreetoTermsandUse" id="agreetoTermsandUse">By continuing, you agree to our <a href="${resource(dir: '/termsofuse')}">Terms of Use</a>
	                                            </label>
	                                        </div>
	                                        
	                                        <div class="center-fund">
	                                            <button type="submit" class="btn btn-info btn-block btn-lg citruscheckoutsubmitbtn" name="fund-button" id="submitButton">Fund this Campaign</button>
	                                            <button type="button" class="btn btn-info btn-block btn-lg hidden citruscheckoutsubmitbtn" name="fund-button" id="citrusCardPayButton"></button>
	                                            <br>
	                                            <h4><b>Powered by Citrus</b></h4>
	                                        </div>
	                                    </div>
	                                    
                                        <g:select class="selectpicker hidden" name="citrusAvailableOptions" id="citrusAvailableOptions" from="${citrusAvailableOptions}" optionKey="key" optionValue="value"/>
                                    </div>
                                    
                                </div><br>
                                
                            </div>
                            
                        </div>
                    
                    </g:form>
                </div>
                
            </div>
        </div>
        
    </div>
    <script type="text/javascript">
        var $jq = jQuery.noConflict();
    
        CitrusPay.Merchant.Config = {
            // Merchant details
            Merchant: {
                accessKey: '${accessKey}', //Replace with your access key
                vanityUrl: '${citrusVanityUrl}'  //Replace with your vanity URL
            }
        };
    
        fetchPaymentOptions();
    
        function handleCitrusPaymentOptions(citrusPaymentOptions) {
            if (citrusPaymentOptions.netBanking != null)
            for (i = 0; i < citrusPaymentOptions.netBanking.length; i++) {
                var obj = document.getElementById("citrusAvailableOptions");
                var option = document.createElement("option");
                option.text = citrusPaymentOptions.netBanking[i].bankName;
                option.value = citrusPaymentOptions.netBanking[i].issuerCode;
                obj.add(option);
            }
        }
    
        //Net Banking
        $jq('#citrusNetbankingButton').on("click", function () { 
            makePayment("netbanking") });
        //Card Payment
        $jq("#citrusCardPayButton").on("click", function () { 
            makePayment("card"); });
    
    
        function citrusServerErrorMsg(errorResponse) {
            console.log(errorResponse);
            if (errorResponse.pgRespCode == 125) {
                alert("Transaction Cannot be completed! Please verify your payment settings");
            } else {
                alert("Transaction Cannot be completed! Please verify your payment settings");
            }
        }
        
        function citrusClientErrMsg(errorResponse) {
            console.log(errorResponse);
        }

    </script>

</body>

</html>

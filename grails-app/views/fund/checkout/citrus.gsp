<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<g:set var="rewardservice" bean="rewardService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    def shippingInfo = rewardservice.getShippingInfo(reward)
    def currentUser = userService.getCurrentUser()
    def isAnonymous = userService.isAnonymous(user)
    def citrusCardTypes = ['credit': 'Credit', 'debit': 'Debit']
    def citrusSchemes = ['visa': 'VISA', 'mastercard' :'MASTER']
    def returnURL = 'http://localhost:8080/fund/citrusreturn'
    SimpleDateFormat dateFormat = new SimpleDateFormat("MM/YYYY");
    def currentDate = dateFormat.format(new Date());
    
    def citrusAvailableOptions = ['CID002':'AXIS Bank', 'CID019':'Bank of India']
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="citruscheckoutjs" />
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
    
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"> </script>
    <script src="/js/citrus.js"></script>
</head>
<body>
<div class="feducontent">
    <div class="container" id="checkoutgsp">
    <% def contributedAmount = projectService.getDataType(amount) %>
    <g:form action="charge" method="POST" name="payment-form" id="payment-form" class="payment-form">
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
                    
                <g:if test="${user1}">
                    <g:hiddenField name="tempValue" value="${user1.id}"/>
                </g:if>
                <g:else>
                    <g:hiddenField name="tempValue" value="${user1}"/>
                </g:else>
                
                <g:hiddenField name="campaignId" value="${project.id}"/>
                <g:hiddenField name="userId" value="${user.id}"/>
                <g:hiddenField name="rewardId" value="${reward.id}"/>
                <g:hiddenField name="fr" value="${username}"/>
                <g:hiddenField type="hidden" name="projectTitle" value="${projectTitle}"/>
                <g:hiddenField name="anonymous" value="${anonymous}" id="anonymous"/>
                
                
                <!--   Citrus Transaction details -->
                
                <input type="hidden" name="citrusAmount" id="citrusAmount" value="${amount}"/>
                <input type="hidden" name="citrusMerchantTxnId" id="citrusMerchantTxnId" value="${txnID}" />
                <input type="hidden" name="citrusSignature" id="citrusSignature" value="${securitySignature}" />
                <input type="hidden" name="citrusReturnUrl" id="citrusReturnUrl" value="${returnURL}" />
                <input type="hidden" name="citrusNotifyUrl" id="citrusNotifyUrl" value="http://localhost:8080/fund/citrusnotify" />
                
                <input type="hidden" name="citrusExpiry" id="citrusExpiry" value="${currentDate}" />
                
                <!-- TDODO-->

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
                        </div>
                    </div>
                </div><br>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Billing Information <g:if test="${currentUser == null}">(Your contact details are used to send a receipt)</g:if></h3>
                    </div>
                    <div class="panel-body">  
                        <div class="row">
                            <div class="col-md-6">
                            <g:if test="${isAnonymous}">
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
            </div>
            
            <div class="col-md-4 box fund-campaign-tile-center-align">
                <g:render template="/layouts/tile"/>
                <div class="form-group term-of-use-center-alignment">
                    <label class="checkbox control-label">
                        <input type="checkbox" name="agreetoTermsandUse" id="agreetoTermsandUse">By continuing, you agree to our <a href="${resource(dir: '/termsofuse')}">Terms of Use</a>
                    </label>
                </div>
                
                <div class="center-fund">
                    <button type="submit" class="btn btn-primary btn-block btn-lg citruscheckoutsubmitbtn" name="fund-button" id="submitButton">Fund this Campaign</button>
                    <button type="button" class="btn btn-primary btn-block btn-lg hidden citruscheckoutsubmitbtn" name="fund-button" id="citrusCardPayButton"></button>
                </div>
            </div>
            <g:select class="selectpicker hidden" name="citrusAvailableOptions" id="citrusAvailableOptions" from="${citrusAvailableOptions}" optionKey="key" optionValue="value"/>
        </div>
        </g:form>
        
    </div>
</div>

<script type="text/javascript">
    var $jq = jQuery.noConflict();

    CitrusPay.Merchant.Config = {
        // Merchant details
        Merchant: {
            accessKey: 'VVXKH02XVEWHUGWJHAMI', //Replace with your access key
            vanityUrl: '8wqhvmq506'  //Replace with your vanity URL
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
    $jq('#citrusNetbankingButton').on("click", function () { makePayment("netbanking") });
    //Card Payment
    $jq("#citrusCardPayButton").on("click", function () { makePayment("card") });


    function citrusServerErrorMsg(errorResponse) {
        console.log(errorResponse);
    }

    function citrusClientErrMsg(errorResponse) {
        console.log(errorResponse);
    }

</script>

</body>
</html>

<g:form action="charge" method="POST" class="chargeForms">
    <g:hiddenField name="twitterField" id="twitterField" value=""/>
    <g:hiddenField name="customField" id="customField" value=""/>
    <g:hiddenField name="addr1" id="addr1" value=""/>
    <g:hiddenField name="addr2" id="addr2" value=""/>
    <g:hiddenField name="emailField" id="emailField" value=""/>
    <g:hiddenField name="cityField" id="cityField" value=""/>
    <g:hiddenField name="stateField" id="stateField" value="AL"/>
    <g:hiddenField name="countryField" id="countryField" value="US"/>
    <g:hiddenField name="zipField" id="zipField" value=""/>
    <g:hiddenField name="otherField" id="otherField" value=""/>

    <div class="col-md-4">
        <g:if test="${flash.amt_message}">
            <div class="alert alert-danger">
                ${flash.amt_message}
            </div>
        </g:if>
        <g:if test="${paypalFailureMessage}">
            <div class="alert alert-danger">
                ${paypalFailureMessage}
            </div>
        </g:if>
        <div class="row">
        <%--     <div class="col-md-12 col-sm-6 col-xs-12">
                <h1>Amount</h1>
            </div>--%>
        </div>
    
        <g:hiddenField name="campaignId" id="projectId" value="${project.id}" />
        <g:hiddenField name="fr" value="${vanityUsername}" />
        <g:hiddenField name="rewardId" />
        <g:hiddenField name="url" value="${base_url}" id="url"/>
        <g:hiddenField name="anonymous" value="false" id="anonymous"/>
        <g:hiddenField name="projectTitle" value="${vanityTitle}"/>
        
        <!-- Value set by Javascript -->
        <div class="row">
            <div class="col-md-12 col-sm-6 col-xs-12">
                <div class="form-group">
                   <div class="input-group">
                       <span class="amount input-group-addon"><span class="glyphicon glyphicon-usd"></span></span>
                       <input class="amount form-control" Placeholder="Enter Donation Amount" <g:if test="${perk}">value="${reward.price.round()}"</g:if><g:else>value=""</g:else> id="amount" name="amount" type="text">
                   </div>
                   <span id="errormsg"></span>
                </div>
    
                <g:if test="${user != null}">
                    <g:hiddenField name="tempValue" id="tempValue" value="${user.id}"/>
                    <g:hiddenField name="userId"  id="userId" value="${user.id}"/>
                </g:if>
    
                <label class="checkbox control-label">
                   <input type="checkbox" name="anonymousUser" id="anonymousUser" > Please keep my contribution anonymous.
                </label>
                
    			<div class="panel panel-default">
                     <div class="panel-heading">
                         <h3 class="panel-title">Contact details (for your receipt)</h3>
                     </div>
                     <div class="panel-body">
                    
                 		<div class="col-md-12 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <div class="input-group col-md-12">
                                    <input class="form-control" type="text" placeholder="Full Name" name="receiptName" id="receiptName" value="${user?.firstName} ${user?.lastName}">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <div class="input-group col-md-12">
                                    <input class="form-control" type="text" placeholder="Email" name="receiptEmail" value="${user?.email}">
                                </div>
                            </div>
                        </div>
                        
                     </div>
                </div>
                
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 form-group">
                        <label class="checkbox control-label">
                        <input type="checkbox" name="agreetoTermsandUse" id="agreetoTermsandUse"> By continuing, you agree to our <a href="${resource(dir: '/termsofuse')}">Terms of Use</a>
                        </label>
                        <div class="amount-button"><button type="submit" class="btn donateNow btnChargeContinue visible-lg visible-md">DONATE NOW</button></div>
                        <div class="amount-button"><button type="submit" class="btn donateNow visible-sm btnChargeContinue-md">DONATE NOW</button></div>
                        <div><button type="submit" class="btn donateNow btn-block visible-xs">DONATE NOW</button></div>
                        <p>Powered By Paypal</p>
                        <div class="powerdbyPaypal">
                            <p><img src="//s3.amazonaws.com/crowdera/assets/poweredByFirstgiving.jpg" alt="Powered By paypal"/></p>
                        </div>
                    </div>
                </div>
            </div>
    
            <div class="col-sm-6 col-xs-12 campaignTile visible-sm visible-xs">
                <g:render template="fund/fundTile" />
            </div>

            <div class="col-md-12 col-sm-12 col-xs-12">
<%--                <g:if test="${!user}">--%>
<%--                    <div class="panel panel-default">--%>
<%--                        <div class="panel-heading">--%>
<%--                            <h3 class="panel-title">Contact details (for your receipt)</h3>--%>
<%--                        </div>--%>
<%--                        <div class="panel-body">--%>
<%--                            <div class="col-md-12 col-sm-6 col-xs-12">--%>
<%--                                <div class="form-group">--%>
<%--                                    <div class="input-group col-md-12">--%>
<%--                                        <input class="form-control" type="text" placeholder="Full Name" name="receiptName" id="receiptName">--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="col-md-12 col-sm-6 col-xs-12">--%>
<%--                                <div class="form-group">--%>
<%--                                    <div class="input-group col-md-12">--%>
<%--                                        <input class="form-control" type="text" placeholder="Email" name="receiptEmail">--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </g:if>--%>
                <div class="hidden-sm hidden-xs" id="perkShippingInfo">
                    <g:render template="fund/perkShippingDetails" model="[anonymous:'false']"></g:render>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <g:if test="${project.rewards.size()>1 && ((project.paypalEmail && project.payuEmail) == null)}">
            <g:render template="fund/rewards" model="[user:user]" />
        </g:if>
    </div>
    <div class="col-md-4 visible-sm visible-xs" id="perkShippingInfo-sm">
        <g:render template="fund/perkShippingDetails" model="[anonymous:'false']"></g:render>
    </div>
</g:form>

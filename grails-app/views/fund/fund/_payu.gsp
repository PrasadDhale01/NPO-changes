<%@page import="org.codehaus.groovy.grails.commons.GrailsApplication"%>
<%
    def payu_url=   grailsApplication.config.crowdera.PAYU.BASE_URL
%>

<form action="${grailsApplication.config.crowdera.PAYU.TEST_URL}" name="payuForm" class="payment-form" method="POST">
                        
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
 <%--     <div class="row">
         <div class="col-md-12 col-sm-12 col-xs-12">
             <h1>Amount</h1>
         </div>
     </div>--%>

     <g:hiddenField name="projectId" id="projectId" value="${project.id}" />
     <input type="hidden" name="fr" value="${vanityUsername}" />
     <input type="hidden" name="anonymous" value="false" id="anonymous"/>
      
     <input class="form-control" type="hidden" value="Mr/Mrs/Ms" name="billToTitle" id="billToTitle" />
     <g:hiddenField name="url" value="${payu_url}" id="url"/>
     <g:hiddenField name="projectTitle" value="${vanityTitle}"/>
     
     <input type="hidden" name="key" value="${key}"/>
     <input type="hidden" name="txnid" value="${txnid}"/>
     <input type="hidden" name="hash" value="${hash}"/>
     <input type="hidden" name="surl" value="${surl}"></input>
     <input type="hidden" name="furl" value="${furl}"></input>
     <input type="hidden" name="service_provider" value="${service_provider}"></input>
     
     <g:hiddenField name="isINR" value="${project.payuStatus}" id="isINR"/>
     <input type="hidden" name="campaignId" value="${project.id}"/>
     <g:hiddenField name="rewardId" value="${reward.id}"/>
     <g:hiddenField name="fr" value="${fundraiser.username}"/>
     <input type="hidden" name="projectAmount" value="${project.amount}"/>
     <input type="hidden" name="projectTitle" value="${project.title}"/>
     
     <g:hiddenField name="payuCountry" value="IN" id="payuCountry"/>
     <input type="hidden" name="payuStates" value="AP" id="payuStates"/>
     <input type="hidden" name="productinfo" value="${project.title}">
     <g:hiddenField name="b_url" id="b_url" value="${base_url}"/>
         
     <g:if test="${user}">
         <input type="hidden" name="tempValue" id="tempValue" value="${user.id}"/>
         <input type="hidden" name="userId"  id="userId" value="${user.id}"/>
     </g:if>
     <g:else>
         <input type="hidden" name="tempValue" id="tempValue" value="3"/>
         <input type="hidden" name="userId"  id="userId" value="3"/>
     </g:else>

     <div class="row">
         <div class="col-md-12 col-sm-6 col-xs-12">
             <div class="form-group fund-inr">
                 <div class="input-group">
                     <span class="amount input-group-addon"><g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else><span class="glyphicon glyphicon-usd"></span></g:else></span>
                     <input class="amount form-control" id="amount" placeholder="Enter Donation Amount" name="amount" type="text" <g:if test="${perk}">value="${perk.price.round()}"</g:if><g:else>value=""</g:else> >
                 </div>
                 <span id="errormsg"></span>
             </div>
             <g:if test="${isTaxReceipt}">
	              <label class="checkbox control-label">
	                  <input type="checkbox" name="isTaxreceipt" id="isTaxreceipt"/> Do you want donation receipt?
	              </label>
	              <div class="form-group fund-inr pannumberdiv">
	                  <input class="form-control" id="panNumber" name="panNumber" type="text" maxlength="10" placeholder="Enter PAN Number"/>
	              </div>
             </g:if>
             <label class="checkbox control-label">
                 <input type="checkbox" name="anonymousUser" id="anonymousUser" > Please keep my contribution anonymous.
             </label>

         </div>
         
         <div class="col-sm-6 col-xs-12 campaignTile visible-sm visible-xs">
             <g:render template="fund/fundTile" />
         </div>

         <g:if test="${project.rewards.size() > 1}">
             <div class="col-md-12 col-sm-12 col-xs-12">
             
                 <div class="panel panel-default">
                     <div class="panel-heading">
                         <h3 class="panel-title">Contact details (for your receipt)</h3>
                     </div>
                     <div class="panel-body">
                         <div class="col-md-12 col-sm-6 col-xs-12">
                             <div class="form-group">
                                 <div class="input-group col-md-12">
                                     <g:if test="${user}">
                                         <input class="form-control" type="text" placeholder="First Name" name="firstname" value="${user.firstName}" required>
                                     </g:if>
                                     <g:else>
                                         <input class="form-control" type="text" placeholder="First Name" name="firstname" required>
                                     </g:else>
                                 </div>
                             </div>
                         </div>
                         <div class="col-md-12 col-sm-6 col-xs-12">
                             <div class="form-group">
                                 <div class="input-group col-md-12">
                                     <g:if test="${user}">
                                         <input class="form-control" type="text" placeholder="Last Name" name="lastname" value="${user.lastName}" required>
                                     </g:if>
                                     <g:else>
                                         <input class="form-control" type="text" placeholder="Last Name" name="lastname" required>
                                     </g:else>
                                 </div>
                             </div>
                         </div>
                         <div class="col-md-12 col-sm-6 col-xs-12">
                             <div class="form-group">
                                 <div class="input-group col-md-12">
                                     <input class="form-control" type="email" placeholder="Email" name="email" value="${user?.email}" required>
                                 </div>
                             </div>
                         </div>
                         <div class="col-md-12 col-sm-6 col-xs-12">
                             <div class="form-group">
                                 <div class="input-group col-md-12">
                                     <input class="form-control" type="text" placeholder="Phone Number" name="phone" required>
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
	                     <div class="amount-button"><button type="submit" class="btn donateNow btnChargeContinue visible-lg visible-md payucheckoutsubmitbutton">DONATE NOW</button></div>
	                     <div class="amount-button"><button type="submit" class="btn donateNow visible-sm btnChargeContinue-md payucheckoutsubmitbutton">DONATE NOW</button></div>
	                     <div><button type="submit" class="btn donateNow btn-block visible-xs payucheckoutsubmitbutton">DONATE NOW</button></div>
	                 </div>
	             </div>
                 <div class="hidden-sm hidden-xs" id="perkShippingInfo">
                     <g:render template="fund/perkShippingDetails" model="[anonymous:'false']"></g:render>
                 </div>
         
             </div>
             
         </g:if>
     </div>
     </div>
     <div class="col-md-4">
         <g:if test="${project.rewards.size()>1}">
             <g:render template="fund/rewards" model="[user:user]" />
         </g:if>
         <g:else>
        
             <div class="col-md-12 col-sm-12 col-xs-12">
             
                  <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Contact details (for your receipt)</h3>
                    </div>
                    <div class="panel-body">
                        <div class="col-md-12 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <div class="input-group col-md-12">
                                    <g:if test="${user}">
                                        <input class="form-control" type="text" placeholder="First Name" name="firstname" value="${user.firstName}">
                                    </g:if>
                                    <g:else>
                                        <input class="form-control" type="text" placeholder="First Name" name="firstname">
                                    </g:else>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <div class="input-group col-md-12">
                                    <g:if test="${user}">
                                        <input class="form-control" type="text" placeholder="Last Name" name="lastname" value="${user.lastName}">
                                    </g:if>
                                    <g:else>
                                        <input class="form-control" type="text" placeholder="Last Name" name="lastname">
                                    </g:else>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <div class="input-group col-md-12">
                                    <input class="form-control" type="text" placeholder="Email" name="email" value="${user?.email}">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <div class="input-group col-md-12">
                                    <input class="form-control" type="text" placeholder="Phone Number" name="phone">
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
	                     <div class="amount-button"><button type="submit" class="btn donateNow btnChargeContinue visible-lg visible-md payucheckoutsubmitbutton">DONATE NOW</button></div>
	                     <div class="amount-button"><button type="submit" class="btn donateNow visible-sm btnChargeContinue-md payucheckoutsubmitbutton">DONATE NOW</button></div>
	                     <div><button type="submit" class="btn donateNow btn-block visible-xs payucheckoutsubmitbutton">DONATE NOW</button></div>
	                 </div>
	             </div>
                <div class="hidden-sm hidden-xs" id="perkShippingInfo">
                    <g:render template="fund/perkShippingDetails" model="[anonymous:'false']"></g:render>
                </div>

             </div>
         </g:else>
    </div>
    <div class="col-md-4 visible-sm visible-xs" id="perkShippingInfo-sm">
        <g:render template="fund/perkShippingDetails" model="[anonymous:'false']"></g:render>
    </div>
    
</form>

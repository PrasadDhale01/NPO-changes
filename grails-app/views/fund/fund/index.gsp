<%@page import="org.codehaus.groovy.grails.commons.GrailsApplication"%>
<g:set var="projectService" bean="projectService"/>
<%
	def payu_url=	grailsApplication.config.crowdera.PAYU.BASE_URL
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="fundjs" />
<r:require modules="fundcss" />
</head>
<body>
    <div class="feducontent">
        <div class="container fund-sm-container footer-container">
            <% 
                def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
                def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            %>
            <div class="row" id="fundindex">
                <div class="alert alert-info" id="perkForAnonymousUser">
                    <b>Sorry ! You cannot select twitter perk as you are contributing anonymously.</b>
                </div>
                
                <g:if test="${project.payuStatus}">
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
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <h1>Amount</h1>
                                </div>
                            </div>
                
							<g:hiddenField name="projectId" id="projectId" value="${project.id}" />
							<input type="hidden" name="fr" value="${vanityUsername}" />
							<input type="hidden" name="rewardId" value="${reward.id}"/>
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
                                            <input class="amount form-control" id="amount" name="amount" type="text" <g:if test="${perk}">value="${perk.price.round()}"</g:if><g:else>value=""</g:else>>
                                        </div>
                                        <span id="errormsg"></span>
                                    </div>

   
                                    <label class="checkbox control-label">
                                        <input type="checkbox" name="anonymousUser" id="anonymousUser" > Please keep my contribution anonymous.
                                    </label>

                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <g:if test="${fundraiser != null}">
                                                <div class="form-group">
                                                    <g:if test="${team.user!=project.user }">
                                                        <div class="col-sm-12"><b>Fundraiser:</b></div>
                                                        <div class="col-sm-12">
                                                           <span>${project.organizationName}</span>
                                                        </div>
                                                        <div class="col-sm-12"><b>Team:</b></div>
                                                        <div class="col-sm-12">
                                                           <span>${fundraiser.firstName} ${fundraiser.lastName}</span>
                                                        </div>
                                                    </g:if>
                                                    <g:else>
                                                        <div class="col-sm-12"><b>Fundraiser:</b></div>
                                                        <div class="col-sm-12">
                                                           <span>${project.organizationName}</span>
                                                        </div>
                                                    </g:else>
                                                </div>
                                            </g:if>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12 col-sm-12 col-xs-12 form-group">
                                            <label class="checkbox control-label">
                                                <input type="checkbox" name="agreetoTermsandUse" id="agreetoTermsandUse"> By continuing, you agree to our <a href="${resource(dir: '/termsofuse')}">Terms of Use</a>
                                            </label>
                                            <div class="amount-button"><button type="submit" class="btn btn-primary btnChargeContinue visible-lg visible-md payucheckoutsubmitbutton">Fund This Campaign</button></div>
                                            <div class="amount-button"><button type="submit" class="btn btn-primary visible-sm btnChargeContinue-md payucheckoutsubmitbutton">Fund this Campaign</button></div>
                                            <div><button type="submit" class="btn btn-primary btn-block visible-xs payucheckoutsubmitbutton">Fund this Campaign</button></div>
                                        </div>
                                    </div>

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
                                                                <input class="form-control" type="text" placeholder="Last Name" name="lastname" value="${user.firstName}" required>
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
                                                            <input class="form-control" type="email" placeholder="Email" name="email" required>
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
                                                           <input class="form-control" type="text" placeholder="Last Name" name="lastname" value="${user.firstName}">
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
                                                       <input class="form-control" type="text" placeholder="Email" name="email">
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
					
				</g:if>
                <g:elseif test="${project.paypalEmail}">
                
                
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
								<div class="col-md-12 col-sm-6 col-xs-12">
								    <h1>Amount</h1>
							    </div>
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
								           <input class="amount form-control" <g:if test="${perk}">value="${reward.price.round()}"</g:if><g:else>value=""</g:else> id="amount" name="amount" type="text">
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
										<div class="panel-body">
											<g:if test="${fundraiser != null}">
												<div class="form-group">
                                                    <g:if test="${team.user!=project.user }">
                                                        <div class="col-sm-12"><b>Fundraiser:</b></div>
                                                        <div class="col-sm-12">
                                                            <span>${project.organizationName}</span>
                                                        </div>
                                                        <div class="col-sm-12"><b>Team:</b></div>
                                                        <div class="col-sm-12">
                                                            <span>${fundraiser.firstName} ${fundraiser.lastName}</span>
                                                        </div>
                                                    </g:if>
                                                    <g:else>
                                                        <div class="col-sm-12"><b>Fundraiser:</b></div>
                                                        <div class="col-sm-12">
                                                            <span>${project.organizationName}</span>
                                                        </div>
                                                    </g:else>
												</div>
											</g:if>
										</div>
									</div>
						
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12 form-group">
											<label class="checkbox control-label">
											<input type="checkbox" name="agreetoTermsandUse" id="agreetoTermsandUse"> By continuing, you agree to our <a href="${resource(dir: '/termsofuse')}">Terms of Use</a>
											</label>
											<div class="amount-button"><button type="submit" class="btn btn-primary btnChargeContinue visible-lg visible-md">Fund This Campaign</button></div>
											<div class="amount-button"><button type="submit" class="btn btn-primary visible-sm btnChargeContinue-md">Fund this Campaign</button></div>
											<div><button type="submit" class="btn btn-primary btn-block visible-xs">Fund this Campaign</button></div>
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
									<g:if test="${!user}">
										<div class="panel panel-default">
											<div class="panel-heading">
											    <h3 class="panel-title">Contact details (for your receipt)</h3>
											</div>
											<div class="panel-body">
												<div class="col-md-12 col-sm-6 col-xs-12">
													<div class="form-group">
														<div class="input-group col-md-12">
														    <input class="form-control" type="text" placeholder="Full Name" name="receiptName" id="receiptName">
														</div>
													</div>
												</div>
												<div class="col-md-12 col-sm-6 col-xs-12">
													<div class="form-group">
														<div class="input-group col-md-12">
														    <input class="form-control" type="text" placeholder="Email" name="receiptEmail">
														</div>
													</div>
												</div>
											</div>
										</div>
									</g:if>
						            <div class="hidden-sm hidden-xs" id="perkShippingInfo">
						                <g:render template="fund/perkShippingDetails" model="[anonymous:'false']"></g:render>
						            </div>
						        </div>
						    </div>
						</div>
						<div class="col-md-4">
							<g:if test="${project.rewards.size()>1}">
							    <g:render template="fund/rewards" model="[user:user]" />
							</g:if>
						</div>
						<div class="col-md-4 visible-sm visible-xs" id="perkShippingInfo-sm">
						    <g:render template="fund/perkShippingDetails" model="[anonymous:'false']"></g:render>
						</div>
					</g:form>
				</g:elseif>
				<g:else>
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
						<g:form action="checkout" method="POST" class="checkoutForm">
						

							<g:hiddenField name="projectId" value="${project.id}" />
							<g:hiddenField name="fr" value="${vanityUsername}" />
							<g:hiddenField name="rewardId" />
							<g:hiddenField name="url" value="${base_url}" id="url"/>
							<g:hiddenField name="anonymous" value="false" id="anonymous"/>
                            <g:hiddenField name="projectTitle" value="${vanityTitle}"/>
							<!-- Value set by Javascript -->
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<div class="input-group">
										<span class="amount input-group-addon"><span class="glyphicon glyphicon-usd"></span></span>
										<input class="amount form-control" <g:if test="${perk}">value="${reward.price.round()}"</g:if><g:else>value=""</g:else> id="amount" name="amount" type="text">
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
						</g:form>
					</div>
					<div class="col-md-4">
						<g:if test="${project.rewards.size()>1}">
							<g:render template="fund/rewards" model="[user:user]" />
						</g:if>
					</div>
				</g:else>

                <g:if test="${project.paypalEmail || project.payuStatus}">
                    <div class="col-md-4 hidden-sm hidden-xs campaignTile ">
                        <g:render template="fund/fundTile"/>
                    </div>
                </g:if>
				<g:elseif test="${project.charitableId}">
					<div class="col-md-4">
						<g:render template="/layouts/tile" />
					</div>
				</g:elseif>
			</div>
		</div>
	</div>
</body>
</html>

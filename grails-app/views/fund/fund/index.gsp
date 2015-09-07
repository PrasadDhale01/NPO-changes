<%
	def payu_url=	grailsApplication.config.crowdera.PAYU.BASE_URL
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="fundjs" />
</head>
<body>
	<div class="feducontent">
		<div class="container">
        <% 
            def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
        %>
			<div class="row" id="fundindex">
				<g:if test="${project.payuStatus}">
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
						<g:form action="payByPayUmoney" controller="fund" method="POST">
							<g:hiddenField name="projectId" id="projectId" value="${project.id}" />
							<g:hiddenField name="fr" value="${vanityUsername}" />
							<g:hiddenField name="rewardId" />
							<g:hiddenField name="anonymous" value="false" id="anonymous"/>
							<g:hiddenField name="url" value="${payu_url}" id="url"/>
							<g:hiddenField name="projectTitle" value="${vanityTitle}"/>
                            <g:if test="${project.payuStatus}">
                                <g:hiddenField name="isINR" value="${project.payuStatus}" id="isINR"/>
                            </g:if>

							<!-- Value set by Javascript -->
							<div class="row">
								<div class="col-md-12 col-sm-12 col-xs-12">
									<div class="form-group fund-inr">
										<div class="input-group">
											<span class="amount input-group-addon"><g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else><span class="glyphicon glyphicon-usd"></span></g:else></span>
											<input class="amount form-control" id="amount" name="amount" type="text">
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
									<label class="checkbox control-label">
										<input type="checkbox" name="anonymousUser" id="anonymousUser" > Please keep my contribution anonymous.
									</label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12 col-sm-12 col-xs-12">
									<div  class="amount-button"><button type="submit" class="btn btn-primary btn-lg">Continue</button></div>
								</div>
							</div>
						</g:form>
					</div>
				</g:if>
				<g:elseif test="${project.paypalEmail}">
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
						<g:form action="charge" method="POST" class="chargeForms">
							<g:hiddenField name="campaignId" id="projectId" value="${project.id}" />
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
											<input class="amount form-control" <%-- value="${reward.price}" --%> id="amount" name="amount" type="text">
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
	                                <label class="checkbox control-label">
	                                    <input type="checkbox" name="anonymousUser" id="anonymousUser" > Please keep my contribution anonymous.
	                                </label>
	                            </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
							        <div  class="amount-button"><button type="submit" class="btn btn-primary btn-lg" id="btnChargeContinue">Continue</button></div>
							    </div>
							</div>
						</g:form>
					</div>
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
										<input class="amount form-control" <%-- value="${reward.price}" --%> id="amount" name="amount" type="text">
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
				</g:else>

				<div class="col-md-4">
                    <g:if test="${project.rewards.size()>1}">
                        <g:render template="fund/rewards" model="[user:user]"/>
                    </g:if>
                </div>

				<div class="col-md-4">
					<g:render template="/layouts/tile" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>

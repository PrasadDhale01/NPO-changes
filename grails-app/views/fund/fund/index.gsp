<html>
<head>
<meta name="layout" content="main" />
<r:require modules="fundjs" />
</head>
<body>
	<div class="feducontent">
		<div class="container">
		<% def base_url = grailsApplication.config.crowdera.BASE_URL %>
			<div class="row">
				<g:if test="${project.paypalEmail}">
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
						<g:form action="charge" method="POST" role="form">
							<g:hiddenField name="projectId" value="${project.id}" />
							<g:hiddenField name="fundraiserUsername" value="${fundraiserUsername}" />
							<g:hiddenField name="rewardId" />
							<g:hiddenField name="url" value="${base_url}" id="url"/>
							
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
									<% if (user != null){ %>
		                                <g:hiddenField name="tempValue" id="tempValue" value="${user.id}"/>
		                                <g:hiddenField name="userId"  id="userId" value="${user.id}"/>
		                                <label class="checkbox control-label">
		                                    <input type="checkbox" name="anonymousUser" id="anonymousUser" > Please keep my contribution anonymous.
		                                </label>
		                            <% } %>
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
						<g:form action="checkout" method="POST" role="form">

							<g:hiddenField name="projectId" value="${project.id}" />
							<g:hiddenField name="fundraiserUsername" value="${fundraiserUsername}" />
							<g:hiddenField name="rewardId" />
							<g:hiddenField name="url" value="${base_url}" id="url"/>
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
								<% if (user != null){ %>
	                                <g:hiddenField name="tempValue" id="tempValue" value="${user.id}"/>
	                            	<g:hiddenField name="userId"  id="userId" value="${user.id}"/>
	                    			<label class="checkbox">
	                        	        <input type="checkbox" name="anonymousUser" id="anonymousUser" > Please keep my contribution anonymous.
	                    			</label>
	                			<% } %>
	                			</div>
                			</div>
                			<div class="row">
                			    <div class="col-md-12 col-sm-12 col-xs-12">
								    <div  class="amount-button"><button type="submit" class="btn btn-primary btn-lg">Continue</button></div>
							    </div>
							</div>
						</g:form>
					</div>
				</g:else>

				<div class="col-md-4">
                    <g:if test="${project.rewards.size()>1}">
                        <g:render template="fund/rewards"/>
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

<!-- Contributions -->
<g:set var="userService" bean="userService"/>
<g:set var="facebookService" bean="facebookService"/>
<g:set var="projectService" bean="projectService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<div class="col-md-8 col-sm-8 col-xs-12">
	<g:if test="${!project.contributions.empty}">
		<div class="panel panel-default">
	        <div class="panel-heading">
	            <h3 class="panel-title">Campaign Contributions</h3>
 	        </div>
 	         <div class="panel-body commentsoncampaign">
	    		<g:each in="${project.contributions}" var="contribution">
			        <%
			            def date = dateFormat.format(contribution.date)
			            def friendlyName = userService.getFriendlyName(contribution.user)
			            def isFacebookUser = userService.isFacebookUser(contribution.user)
			            def userFacebookUrl = facebookService.getUserFacebookUrl(contribution.user)
			            def reward = contribution.reward
			        %>
        			
			        <div class="modal-body tile-footer manage-comments-footer">
				        <b>$${contribution.amount}</b>
				        <g:if test="${isFacebookUser}">
				            <dd>By <a href="${userFacebookUrl}">${friendlyName}</a>, on ${date}</dd>
				        </g:if>
				        <g:else>
				            <g:if test="${userService.isAnonymous(contribution.user)}">
				                <p>By Anonymous, on ${date}</p>
				            </g:if>
				            <g:else>
			                        <p>By ${friendlyName}, on ${date}</p>
			                    </g:else>
				        </g:else>
				        <g:if test="${reward.id == 1}">
				            <b>No Perk</b>
			            </g:if>
			            <g:else>
			                <b>Perk</b>
				            <div class="rewardsection">
						        <p>${reward.description}</p>
						        <a href="#" data-id="${contribution}" data-toggle="modal" data-target="#rewarddetails${contribution.id}" model="['contribution': contribution]">Shipping Details</a>
						    </div>
			            </g:else>
			        </div>
        		
        			<!-- Modal -->
					<div class="modal fade" id="rewarddetails${contribution.id}" tabindex="-1" role="dialog" aria-labelledby="rewarddetails" aria-hidden="true">
				        <div class="modal-dialog">
				            <div class="modal-content">
				                <div class="modal-header">
				                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				                    <h4 class="modal-title">Shipping Details</h4>
				                </div>
				                <div class="modal-body">
				                    <div class="form-group">
				                        <label for="name">Name: &nbsp; ${contribution.user.firstName}&nbsp; ${contribution.user.lastName}</label>
				                    </div>
				                    <div class="form-group">
				                        <label for="email">Email: &nbsp; ${contribution.user.email}</label>
				                    </div>
				                    <g:if test="${contribution.email  != null}">
				                    	<g:if test="${!contribution.email.equalsIgnoreCase('null')}">
									        <div class="form-group">
									        	<label for="name">Shipping Email: &nbsp; ${contribution.email}</label>
									        </div>
								        </g:if>
									</g:if>
									<g:if test="${contribution.physicalAddress != null}">
										<g:if test="${!contribution.physicalAddress.equalsIgnoreCase('null')}">
									        <div class="form-group">
									            <label for="name">Physical Address: &nbsp; ${contribution.physicalAddress}</label>
									        </div>
								        </g:if>
									</g:if>
									<g:if test="${contribution.twitterHandle  != null}">
										<g:if test="${!contribution.twitterHandle.equalsIgnoreCase('null')}">
									        <div class="form-group">
									        	<label for="name">Twitter Handle: &nbsp; ${contribution.twitterHandle}</label>
									        </div>
								        </g:if>
									</g:if>
									<g:if test="${contribution.custom  != null}">
										<g:if test="${!contribution.custom.equalsIgnoreCase('null')}">
									        <div class="form-group">
									        	<label for="name">Custom Details: &nbsp; ${contribution.custom}</label>
									        </div>
								        </g:if>
									</g:if>
				                </div>
				            </div>
				        </div>
					</div>

    			</g:each>
    		</div>
    	</div>
	</g:if>
	<g:else>
	    <div class="alert alert-info">No contributions yet.</div>
	</g:else>
</div>

<div class="col-md-4 col-sm-4 col-xs-12">
    <g:render template="/project/manageproject/tilesanstitle" />
    <g:if test="${project.draft}">
        <g:form controller="project" action="saveasdraft" id="${project.id}">
         <button class="btn btn-block btn-primary">
          <i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval
            </button>
        </g:form>
    </g:if>
</div>

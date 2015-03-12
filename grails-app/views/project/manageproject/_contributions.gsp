<!-- Contributions -->
<g:set var="userService" bean="userService"/>
<g:set var="facebookService" bean="facebookService"/>
<g:set var="projectService" bean="projectService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def i = 1;
    def manageCampaign = "manageCampaign"
    def user = userService.getCurrentUser()
    def fundRaiser = user.username
    def projectId = project.id
%>
<button class="btn btn-primary btn-block contribution-seperator"></button>
<g:if test="${project.validated}">
<div class="col-md-10 col-md-offset-1 col-sm-12 col-xs-12">
    <g:if test="${project.contributions.empty}">
        <div class="alert alert-info">No contributions yet.</div>
    </g:if>
    <g:if test="${project.validated}">
        <a href="#" class="btn btn-primary btn-sm pull-right managecontribution" data-toggle="modal" data-target="#offlineContributionModal" model="['project': project]">
            Manage Offline Contribution
        </a>
    </g:if>
    <div class="clear"></div>
    <!-- Modal -->
    <div class="modal fade offlineContributionModal" id="offlineContributionModal" tabindex="-1" role="dialog" aria-labelledby="offlineContributionModal" aria-hidden="true">
        <g:form action="saveOfflineContribution" controller="fund" id="${project.id}"  params="['fr':fundRaiser]" role="form">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="col-sm-12 margin">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="heading">ENTER OFFLINE CONTRIBUTION</h4>
                        </div>
                        <div class="col-sm-12 margin">
	                        <p class="justify text-paragraph">If your friends donate by check or hand you a pile of cash or a stack of casino chips,
	                         you can enter their name and donation amount below and the donor will show up in your donations scroll and everyone will be happy.
	                         If you want to enter checks in bulk, just make the Display Name say something like "Offline Donations."
	                        </p>
                        </div>
                        <g:hiddenField name="manageCampaign" value="${manageCampaign}"></g:hiddenField>
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label class="text" for="title">Display Name</label>
                                <input type="text" class="form-control contributioninput" name="contributorName1"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="title" class="text">Amount</label>
                                <input type="text" class="form-control contributioninput" name="amount1" id="offlineAmount1"/>
                            </div>
                            <div id="errormsg1"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label class="text" for="title">Display Name</label>
                                <input type="text" class="form-control contributioninput" name="contributorName2"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="title" class="text">Amount</label>
                                <input type="text" class="form-control contributioninput" name="amount2" id="offlineAmount2"/>
                            </div>
                            <div id="errormsg2"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label class="text" for="title">Display Name</label>
                                <input type="text" class="form-control contributioninput" name="contributorName3"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="title" class="text">Amount</label>
                                <input type="text" class="form-control contributioninput" name="amount3" id="offlineAmount3"/>
                            </div>
                            <div id="errormsg3"></div>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-primary">Close</button>
                        <button class="btn btn-primary" type="submit" id="saveButton">Save</button>
                    </div>
                </div>
            </div>
        </g:form>
    </div>
	<g:if test="${!project.contributions.empty}">
        <h2 class="crowderasupport"><img src="/images/icon-contribution.png">&nbsp;&nbsp;Campaign Contributions</h2>
	    <div class="commentsoncampaign">
    		<g:each in="${project.contributions}" var="contribution">
		        <%
		            def date = dateFormat.format(contribution.date)
		            def friendlyName = userService.getFriendlyName(contribution.user)
		            def isFacebookUser = userService.isFacebookUser(contribution.user)
		            def userFacebookUrl = facebookService.getUserFacebookUrl(contribution.user)
		            def reward = contribution.reward
		        %>
       			<g:if test="${!contribution.isContributionOffline}">
		            <div class="modal-body tile-footer manage-comments-footer">
		                <p class="text-success">Contribution #${i++}</p>
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
		        </g:if>
		        <g:else>
		            <div class="modal-body tile-footer manage-comments-footer">
		                <%
						    def isContributionBelongsToCurrentUser = userService.isContributionBelongsToCurrentTeam(contribution, user, project)
						%>
		                <p class="text-success">Contribution #${i++}</p>
		                <div class="rewardsection">
		                    <b>Offline Contribution</b>
		                </div>
		                <div class="rewardsection">
                            <b>$${contribution.amount.round()}</b>
                            <div class="clear"></div>
                                By ${contribution.contributorName}, on ${date}
                            </div>
                            <div class="clear"></div>
                            <g:if test="${isContributionBelongsToCurrentUser}">
                            <div class="editAndDeleteBtn">
                                <div class="pull-right">
                                    <button class="projectedit close" id="editproject"  data-toggle="modal" data-target="#contributionedit${contribution.id}" model="['project': project,'contribution': contribution]">
                                        <i class="glyphicon glyphicon-edit" ></i>
                                    </button>
                                </div>
                                <div class="pull-right">
                                    <g:form controller="project" action="contributiondelete" method="post" id="${contribution.id}" params="['projectId':projectId, 'fr': fundRaiser]">
                                        <g:hiddenField name="manageCampaign" value="${manageCampaign}"></g:hiddenField>
                                        <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this contribution?&#39;);">
                                            <i class="glyphicon glyphicon-trash" ></i>
                                        </button>
                                    </g:form>
                                </div>
                            </div>
                        </g:if>
                        <div class="clear"></div>
                        
                        <!-- EditContributionModal -->
                        <div class="modal fade offlineContributionModal contributionedit" id="contributionedit${contribution.id}" tabindex="-1" role="dialog" aria-labelledby="contributionedit${contribution.id}" aria-hidden="true">
                            <g:form action="contributionedit" controller="project" id="${contribution.id}"  params="['projectId':projectId, 'fr': fundRaiser]" role="form">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <div class="col-sm-12 margin">
                                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                <h4 class="heading crowderasupport"><img src="/images/icon-edit.png">&nbsp;&nbsp;EDIT OFFLINE CONTRIBUTION</h4>
                                            </div>
                                            <g:hiddenField name="manageCampaign" value="${manageCampaign}"></g:hiddenField>
                                            <div class="col-sm-8">
                                                <div class="form-group">
                                                    <label class="text" for="title">Display Name</label>
                                                    <input type="text" class="form-control contributioninput" name="contributorName" value="${contribution.contributorName}"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label for="title" class="text">Amount</label>
                                                    <input type="text" class="form-control contributioninput" name="amount" value="${contribution.amount.round()}" id="offlineAmount"/>
                                                </div>
                                                <div id="errormsg"></div>
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="modal-footer">
                                            <button data-dismiss="modal" class="btn btn-primary">Close</button>
                                            <button class="btn btn-primary" type="submit" id="saveButton">Save</button>
                                        </div>
                                    </div>
                                </div>
                            </g:form>
                        </div>
		            </div>
		        </g:else>
       		    
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
	</g:if>
</div>
</g:if>
<g:else>
    <div class="alert alert-info">Campaign is yet to be validated.</div>
</g:else>

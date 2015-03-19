<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<%
    def isFundingAchieved = contributionService.isFundingAchievedForProject(project)
    def percentage = contributionService.getPercentageContributionForProject(project)
    def achievedDate
    if (isFundingAchieved) {
        achievedDate = contributionService.getFundingAchievedDate(project)
    }
    def endDate = projectService.getProjectEndDate(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
    def isFundingOpen = projectService.isFundingOpen(project)
    def contributedSoFar = contributionService.getTotalContributionForProject(project)
    def contribution = projectService.getDataType(contributedSoFar)
    def amount = projectService.getDataType(project.amount)

    def user = userService.getCurrentUser()
    def username = user.username
    def iscampaignAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
	def team = project.teams
	def isTeamAdmin = projectService.isTeamAdmin(project)
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def cents
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }
%>
<div class="fedu thumbnail grow user-tiles-style">
	<div class="blacknwhite tile">
	    <g:if test="${iscampaignAdmin}">
			<g:link controller="project" action="manageproject" id="${project.id}"
				title="${project.title}">
				<div class="imageWithTag">
					<div class="under">
						<img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}">
					</div>
					<g:if test="${project.draft}">
						<div class="over user-tiles-widths">
							<img src="/images/draft.png">
						</div>
					</g:if>
					<g:elseif test="${project.rejected}">
						<div class="over user-tiles-widths">
							<img src="/images/rejected.png">
						</div>
					</g:elseif>
					<g:elseif test="${!project.validated}">
						<div class="over user-tiles-widths">
							<img src="/images/Pending.png">
						</div>
					</g:elseif>
					<g:elseif test="${ended}">
					    <div class="over user-tiles-widths">
							<img src="/images/ended.png">
						</div>
					</g:elseif>
					<g:elseif test="${percentage >= 75}">
				    	<div class="over user-tiles-widths">
							<img src="/images/funded1.png">
						</div>
					</g:elseif>
					<g:elseif test="${project.validated}">
						<g:if test="${user == project.user || iscampaignAdmin}">
						    <div class="over user-tiles-widths">
								<img src="/images/Owner.png">
							</div>
						</g:if>
						<g:else>
							<div class="over user-tiles-widths">
								<img src="/images/Pending.png">
							</div>
						</g:else>
					</g:elseif>
					<g:elseif test="${isTeamAdmin}">
					    <div class="over user-tiles-widths">
							<img src="/images/Owner.png">
						</div>
					</g:elseif>
					<g:else>
					    <div class="over user-tiles-widths">
							<img src="/images/teamTop.png">
						</div>
					</g:else>
				</div>
			</g:link>
		</g:if>
		<g:else>
		    <g:link controller="project" action="show" id="${project.id}" params="['fr': username]" title="${project.title}">
				<div class="imageWithTag">
					<div class="under">
						<img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}">
					</div>
					<g:if test="${project.draft}">
						<div class="over user-tiles-widths">
							<img src="/images/draft.png">
						</div>
					</g:if>
					<g:elseif test="${project.rejected}">
						<div class="over user-tiles-widths">
							<img src="/images/rejected.png">
						</div>
					</g:elseif>
					<g:elseif test="${!project.validated}">
						<div class="over user-tiles-widths">
							<img src="/images/Pending.png">
						</div>
					</g:elseif>
					<g:elseif test="${ended}">
					    <div class="over user-tiles-widths">
							<img src="/images/ended.png">
						</div>
					</g:elseif>
					<g:elseif test="${percentage >= 75}">
				    	<div class="over user-tiles-widths">
							<img src="/images/funded1.png">
						</div>
					</g:elseif>
					<g:if test="${isTeamAdmin}">
					    <div class="over teamtile-banner">
							<img src="/images/Owner.png">
						</div>
					</g:if>
					<g:else>
					    <div class="over teamtile-banner">
							<img src="/images/teamTop.png">
						</div>
					</g:else>
				</div>
			</g:link>
		</g:else>
	</div>

	<div class="caption">
		<div class="project-title">
		    <g:if test="${iscampaignAdmin}">
				<g:link controller="project" action="manageproject" id="${project.id}" params="['fr': username]" title="${project.title}">
			        ${project.title}
			    </g:link>
		    </g:if>
		    <g:else>
		        <g:link controller="project" action="show" id="${project.id}" params="['fr': username]" title="${project.title}">
			        ${project.title}
			    </g:link>
		    </g:else>
		</div>
		<hr class="tile-separator">
		<div class="project-story-span">
			${project.description}
		</div>
	</div>

	<div class="modal-footer tile-footer"
		style="text-align: left; margin-bottom: 2px;">
		<div class="row tilepadding">
			<div class="col-sm-5 col-sm-offset-1 col-xs-5 col-xs-offset-1 progress-pie-chart" data-percent="43">
				<div class="c100 p${cents} small text-center">
					<span> ${percentage}%
					</span>
					<div class="slice">
						<div class="bar"></div>
						<div class="fill"></div>
					</div>
				</div>
			</div>
			<g:if test="${isFundingAchieved}">
				<div class="col-md-6 col-xs-6">
					<h6 class="text-center user-achived-raised">
						<span class="lead">$${contribution}</span><br />ACHIEVED
					</h6>
				</div>
			</g:if>
			<g:else>
			    <div class="col-md-6 col-xs-6">
					<h6 class="text-center user-achived-raised">
						<span class="lead">$${contribution}</span><br />RAISED
					</h6>
				</div>
			</g:else>
		</div>
	</div>
	<div class="modal-footer tile-footer user-goal">
		<div class="row tilepadding">
			<div class="col-md-6 col-xs-6">
                <h6 class="text-center"><span class="lead">$${amount}</span><br/>GOAL</h6>
            </div>
            <g:if test="${ended}">
                <div class="col-md-6 col-xs-6">
                    <h6 class="text-center"><span class="lead">0</span><br>DAYS TO GO</h6>
                </div>
            </g:if>
            <g:else>
                <!-- Time left till end date. -->
                <div class="col-md-6 col-xs-6">
                    <h6 class="text-center"><span class="lead">${projectService.getRemainingDay(project)}</span><br>DAYS TO GO</h6>
                </div>
            </g:else>
		</div>

		<div class="modal-footer tile-footer user-footer-icon">
			<div class="row">
                <g:if test="${!project.validated || username.equals('campaignadmin@crowdera.co') }">
                    <g:form controller="project" action="projectdelete" method="post" id="${project.id}">
                        <button class="projectedit close pull-right" id="projectdelete"
                         onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);">
                            <i class="glyphicon glyphicon-trash"></i>
                        </button>
                    </g:form>
                </g:if>
                <g:if test="${isTeamAdmin || (user==project.user)}">
                	<g:form controller="project" action="edit" method="post" id="${project.id}">
                    	<g:hiddenField name="projectId" value="${project.id}" />
                    	<button class="projectedit close pull-right" id="editproject">
                        	<i class="glyphicon glyphicon-edit"></i>
                    	</button>
                	</g:form>
                	<g:form controller="project" action="manageproject" method="post" id="${project.id}">
                    	<button class="projectedit close pull-right" id="projectpreview">
                        	<i class="glyphicon glyphicon-picture"></i>
                    	</button>
                	</g:form>
                </g:if>
                <g:else>
                	<button class="projectedit close pull-right" id="editproject" name="editproject"
               	   	 data-toggle="popover">
                       	<i class="glyphicon glyphicon-edit"></i>
                   	</button>
                   	<button class="projectedit close pull-right" id="projectpreview" name="projectpreview"
                   	 data-toggle="popover">
                       	<i class="glyphicon glyphicon-picture"></i>
                   	</button>
                </g:else>
			</div>
		</div>
	</div>
</div>

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
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<div class="fedu thumbnail grow" style="padding: 0">
	<div class="blacknwhite tile">
	    <g:if test="${iscampaignAdmin}">
			<g:link controller="project" action="manageproject" id="${project.id}"
				title="${project.title}">
				<div class="imageWithTag">
					<div class="under">
						<img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}">
					</div>
					<g:if test="${project.draft}">
						<div class="over">
							<img src="/images/draft.png" width="100">
						</div>
					</g:if>
					<g:elseif test="${project.rejected}">
						<div class="over">
							<img src="/images/rejected.png" width="100">
						</div>
					</g:elseif>
					<g:elseif test="${!project.validated}">
						<div class="over">
							<img src="/images/PENDING.png" width="100">
						</div>
					</g:elseif>
					<g:elseif test="${ended}">
					    <div class="over">
							<img src="/images/ended.png" width="100">
						</div>
					</g:elseif>
				</div>
			</g:link>
		</g:if>
		<g:else>
		    <g:link controller="project" action="show" id="${project.id}" params="['fundRaiser': username]" title="${project.title}">
				<div class="imageWithTag">
					<div class="under">
						<img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}">
					</div>
					<g:if test="${project.draft}">
						<div class="over">
							<img src="/images/draft.png" width="100">
						</div>
					</g:if>
					<g:elseif test="${project.rejected}">
						<div class="over">
							<img src="/images/rejected.png" width="100">
						</div>
					</g:elseif>
					<g:elseif test="${!project.validated}">
						<div class="over">
							<img src="/images/PENDING.png" width="100">
						</div>
					</g:elseif>
					<g:elseif test="${ended}">
					    <div class="over">
							<img src="/images/ended.png" width="100">
						</div>
					</g:elseif>
				</div>
			</g:link>
		</g:else>
	</div>

	<div class="caption">
		<div class="project-title">
			<g:link controller="project" action="manageproject" id="${project.id}" title="${project.title}">
		        ${project.title}
		    </g:link>
		</div>
		<hr class="tile-separator">
		<div class="project-story-span">
			${project.description}
		</div>
	</div>

	<div class="modal-footer tile-footer"
		style="text-align: left; margin-bottom: 2px;">
		<div class="row">
			<div class="col-sm-5 col-sm-offset-1 col-xs-5 col-xs-offset-1 progress-pie-chart" data-percent="43">
				<div class="c100 p${percentage} small text-center">
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
					<h6 class="text-center" style="margin-top: 10px;">
						<span class="lead">$${contribution}</span><br />ACHIEVED
					</h6>
				</div>
			</g:if>
			<g:else>
			    <div class="col-md-6 col-xs-6">
					<h6 class="text-center" style="margin-top: 10px;">
						<span class="lead">$${contribution}</span><br />RAISED
					</h6>
				</div>
			</g:else>
		</div>
	</div>
	<div class="modal-footer tile-footer" style="text-align: left; margin-top: 0;">
		<div class="row">
			<div class="col-md-6 col-xs-6">
                <h6 class="text-center"><span class="lead">$${amount}</span><br/>GOAL</h6>
            </div>
            <g:if test="${ended}">
                <%--<g:if test="${isFundingAchieved}">
                    <!-- Funding achieved in time. -->
                    <div class="col-md-6 col-xs-6">
                        <h6 class="text-center"><span class="lead">${dateFormat.format(achievedDate.getTime())}</span><br>ACHIEVED</h6>
                    </div>
                </g:if>
                <g:else>
                   <!-- Funding not achieved in time. -->
                    <div class="col-md-6 col-xs-6">
                        <h6 class="text-center"><span class="lead">${dateFormat.format(endDate.getTime())}</span><br>ENDED</h6>
                    </div>
                </g:else>--%>
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

		<div class="modal-footer tile-footer" style="text-align: left; margin-top: 0;">
			<div class="row">
				<div class="col-sm-8" align="right" style="right-padding: 0px">
					<g:form controller="project" action="edit" method="post" id="${project.id}">
						<g:hiddenField name="projectId" value="${project.id}" />
						<button class="projectedit close " aria-label="Edit project" id="editproject">
							<i class="glyphicon glyphicon-edit"></i>
						</button>
					</g:form>
				</div>
				<div class="col-sm-2">
					<g:form controller="project" action="manageproject" method="post" id="${project.id}">
						<button class="projectpreview close" aria-label="Preview project" id="projectpreview">
							<i class="glyphicon glyphicon-picture"></i>
						</button>
					</g:form>
				</div>

				<div class="col-sm-2">
					<g:form controller="project" action="projectdelete" method="post" id="${project.id}">
						<button class="projectdelete close pull-right" aria-label="Delete project" id="projectdelete"
							onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);">
							<i class="glyphicon glyphicon-trash"></i>
						</button>
					</g:form>
				</div>
				
			</div>
		</div>
	</div>
</div>

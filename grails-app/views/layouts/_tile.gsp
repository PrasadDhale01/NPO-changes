<%--
Expects the parent containers to be like so:
<div class="row">
    <ul class="thumbnails list-unstyled">
        <li class="col-xs-6 col-md-3">
            ... /layouts/tile ...
        </li>
    </ul>
</div>
--%>
<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
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
    def username = project.user.username
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def cents
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }
%>
<g:if test="${project.validated}">
<div class="fedu thumbnail grow tile-pad">
    <div class="blacknwhite tile">
        <g:link controller="project" action="show" id="${project.id}" title="${project.title}" params="['fr': username]">
            <div class="imageWithTag">
                <div class="under">
                    <img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}"/>
                </div>
                <g:if test="${ended}">
				    <div class="over banner-wid">
						<img src="//s3.amazonaws.com/crowdera/assets/ended.png" alt="Ended"/>
					</div>
				</g:if>
                <g:elseif test="${percentage >= 75}">
				    <div class="over banner-wid">
						<img src="//s3.amazonaws.com/crowdera/assets/funded1.png" alt="Funded"/>
					</div>
				</g:elseif>
            </div>
        </g:link>
    </div>

    <div class="caption tile-title-descrp">
        <div class="project-title">
            <g:link controller="project" action="show" id="${project.id}" title="${project.title}">
                ${project.title}
            </g:link>
        </div>
        <hr class="tile-separator">
        <div class="project-story-span">
            ${project.description}
        </div>
    </div>

    <div class="modal-footer tile-footer tile-fonts-footer">
        <div class="row tilepadding">
            <div class="col-sm-5 col-sm-offset-1 col-xs-5 col-xs-offset-1 progress-pie-chart" data-percent="43">
				<div class="c100 p${cents} small text-center">
                    <span>${percentage}%</span>
                    <div class="slice">
                        <div class="bar"></div>
                        <div class="fill"></div>
                    </div>
                </div>
            </div>
            <g:if test="${isFundingAchieved}">
				<div class="col-md-6 col-xs-6">
					<h6 class="text-center achived-styles">
						<span class="lead">$${contribution}</span><br />ACHIEVED
					</h6>
				</div>
			</g:if>
			<g:else>
			    <div class="col-md-6 col-xs-6">
					<h6 class="text-center tile-raised">
						<span class="lead">$${contribution}</span><br />RAISED
					</h6>
				</div>
			</g:else>
        </div>
    </div>
    <div class="modal-footer tile-footer tile-footer-goal">
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
    </div>
    <%--<g:if test="${isFundingOpen}">
        <div class="progress progress-striped active">
            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;">
                ${percentage}%
            </div>
        </div>
    </g:if>
    <g:else>
        <div class="progress">
            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;">
                ${percentage}%
            </div>
        </div>
    </g:else>
--%></div>
</g:if>

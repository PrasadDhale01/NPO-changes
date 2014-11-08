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

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<g:if test="${project.validated}">
<div class="fedu thumbnail grow" style="padding: 0">
    <div style="height: 200px; overflow: hidden;" class="blacknwhite">
        <g:link controller="project" action="show" id="${project.id}" title="${project.title}">
            <img alt="${project.title}" style="width: 100%;" src="${projectService.getProjectImageLink(project)}">
        </g:link>
    </div>

    <div class="caption" style="margin-bottom:0;">
    <h4 style="margin-top: 10px; margin-bottom:0px;"><strong>${project.title}</strong></h4>
    <hr class="tile-separator">
    <span>${project.description}</span>
    </div>

    <div class="modal-footer tile-footer" style="text-align: left; margin-bottom: 2px;">
        <div class="row">
            <div class="col-sm-5 col-sm-offset-1 progress-pie-chart" data-percent="43">
				<div class="c100 p${percentage} small text-center">
                    <span>${percentage}%</span>
                    <div class="slice">
                        <div class="bar"></div>
                        <div class="fill"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <h6 class="text-center" style="margin-top: 10px;"><span class="lead">$${contributedSoFar}</span><br/>ACHIEVED</h6>
            </div>
        </div>
    </div>
    <div class="modal-footer tile-footer" style="text-align: left; margin-top: 0;">
        <div class="row">
            <div class="col-md-6">
                <h6 class="text-center"><span class="lead">$${project.amount}</span><br/>GOAL</h6>
            </div>
            <g:if test="${ended}">
                <g:if test="${isFundingAchieved}">
                    <!-- Funding achieved in time. -->
                    <div class="col-md-6">
                        <h6 class="text-center"><span class="lead">${dateFormat.format(achievedDate.getTime())}</span><br>ACHIEVED</h6>
                    </div>
                </g:if>
                <g:else>
                    <!-- Funding not achieved in time. -->
                    <div class="col-md-6">
                        <h6 class="text-center"><span class="lead">${dateFormat.format(endDate.getTime())}</span><br>ENDED</h6>
                    </div>
                </g:else>
            </g:if>
            <g:else>
                <!-- Time left till end date. -->
                <div class="col-md-6">
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

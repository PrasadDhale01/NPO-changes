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

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<div class="fedu thumbnail" style="padding: 0">
    <div style="height: 200px; overflow: hidden;" class="blacknwhite">
        <g:link controller="project" action="show" id="${project.id}" title="${project.title}">
            <img alt="${project.title}" style="width: 100%;" src="${projectService.getProjectImageLink(project)}">
        </g:link>
    </div>

    <div class="caption">
        <h4><g:link controller="project" action="show" id="${project.id}" title="${project.title}">${project.title}</g:link></h4>
        <p>${project.name}</p>
    </div>

    <div class="modal-footer" style="text-align: left; margin-top: 0;">
        <div class="row">
            <div class="col-md-6">
                <h5 class="text-center">GOAL<br/><span class="lead">$${project.amount}</span></h5>
            </div>
            <g:if test="${ended}">
                <g:if test="${isFundingAchieved}">
                    <div class="col-md-6">
                        <h5 class="text-center">ACHIEVED<br><span class="lead">${dateFormat.format(achievedDate.getTime())}</span></h5>
                    </div>
                </g:if>
                <g:else>
                    <div class="col-md-6">
                        <h5 class="text-center">ENDED<br><span class="lead">${dateFormat.format(endDate.getTime())}</span></h5>
                    </div>
                </g:else>
            </g:if>
            <g:else>
                <div class="col-md-6">
                    <h5 class="text-center">ENDING<br><span class="lead">${dateFormat.format(endDate.getTime())}</span></h5>
                </div>
            </g:else>
        </div>
    </div>
    <g:if test="${isFundingOpen}">
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
</div>

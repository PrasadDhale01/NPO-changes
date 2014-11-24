<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="projectService" bean="projectService"/>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectValidate" value="${project.validated}"/>
 
<!-- Projects to be validated -->

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

<g:if test="${!projectValidate}">
    <div class="fedu thumbnail grow" style="padding: 0">
        <div style="height: 200px; overflow: hidden;" class="blacknwhite">
            <g:link controller="project" action="validateshow" id="${project.id}" title="${project.title}">
                <img alt="${project.title}" style="width: 100%; height: 100%;" src="${projectService.getProjectImageLink(project)}">
            </g:link>
        </div>
	<div class="caption">
        <strong style="margin-top: 10px; margin-bottom: 0px; text-align: justify; overflow: hidden;">
            ${project.title}
        </strong>
         <hr class="tile-separator">
        <span class="project-story-span">${project.description}</span>
    </div>
	<div class="modal-footer tile-footer" style="text-align: left; margin-bottom: 2px;">
        <div class="row">
            <div class="col-sm-6 progress-pie-chart" data-percent="43">
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
</div> 
</g:if>

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
    def contribution = projectService.getDataType(contributedSoFar)
    def amount = projectService.getDataType(project.amount)

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>

<g:if test="${!projectValidate}">
    <div class="fedu thumbnail grow validate-paddings">
        <div class="blacknwhite validate-style">
            <g:link controller="project" action="validateshow" id="${project.id}" title="${project.title}">
                <img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}">
            </g:link>
        </div>
	<div class="caption">
        <div class="project-title">
            <g:link controller="project" action="validateshow" id="${project.id}" title="${project.title}">
                ${project.title}
            </g:link>
        </div>
        <hr class="tile-separator">
        <div class="project-story-span">
            ${project.description}
        </div>
    </div>
	<div class="modal-footer tile-footer validate-percentage-style">
        <div class="row">
            <div class="col-sm-5 col-sm-offset-1 col-xs-5 col-xs-offset-1 progress-pie-chart" data-percent="43">
				<div class="c100 p${percentage} small text-center">
                    <span>${percentage}%</span>
                    <div class="slice">
                        <div class="bar"></div>
                        <div class="fill"></div>
                    </div>
                </div>
            </div>
            <g:if test="${isFundingAchieved}">
				<div class="col-md-6 col-xs-6">
					<h6 class="text-center validate-achived-raised">
						<span class="lead">$${contribution}</span><br />ACHIEVED
					</h6>
				</div>
			</g:if>
			<g:else>
			    <div class="col-md-6 col-xs-6">
					<h6 class="text-center validate-achived-raised">
						<span class="lead">$${contribution}</span><br />RAISED
					</h6>
				</div>
			</g:else>
        </div>
    </div>
    <div class="modal-footer tile-footer validate-goal">
        <div class="row">
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
</div> 
</g:if>

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
    def cents
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }
%>

<g:if test="${!projectValidate}">
    <div class="fedu thumbnail grow validate-paddings">
        <div class="blacknwhite">
            <g:link controller="project" action="validateShowCampaign" id="${project.id}" title="${project.title}">
                <img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}"/>
            </g:link>
        </div>
	<div class="caption project-title project-story-span tile-min-height">
        <g:link controller="project" action="validateShowCampaign" id="${project.id}" title="${project.title}">
              ${project.title.toUpperCase()}
        </g:link>
        <div class="campaign-title-margin-bottom"></div>
        <span>${project.description}</span>
    </div>
	<div class="modal-footer tile-footer tile-fonts-footer">
        <div class="row">
        	<div class="col-xs-4 col-sm-4 col-md-4 goalIcon">
				<img src="//s3.amazonaws.com/crowdera/assets/tile-goal-icon.png">
			</div>
			<div class="col-xs-4 col-sm-4 col-md-4 daysleftIcon campaign-tile-border">
				<img src="//s3.amazonaws.com/crowdera/assets/timeleft.png">
			</div>
            <div class="col-sm-4 col-xs-4 progress-pie-chart show-tile progressBarIcon" data-percent="43">
				<div class="c100 p${cents} small text-center">
                    <span>${percentage}%</span>
                    <div class="slice">
                        <div class="bar showprogressBar"></div>
                        <div class="fill showprogressBar"></div>
                    </div>
                </div>
            </div>
         </div>
         <div class="row tilepadding">
             <div class="col-xs-4 col-sm-4 col-md-4 amount-alignment amount-text-align text-center">
                 <span class="text-center tile-goal">
                     <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else><span class="lead">${amount}</span>
                 </span>
             </div>
             <g:if test="${ended}">
                 <div class="col-md-4 col-sm-4 col-xs-4 show-tile-text-size  campaign-tile-border">
                     <span class="days-alignment">DAYS<br>LEFT</span>
                     <span class="tile-day-num">00</span>
                 </div>
             </g:if>
            <g:else>
                <!-- Time left till end date. -->
                <div class="col-md-4 col-sm-4 col-xs-4 show-tile-text-size campaign-tile-border">
                    <span class="days-alignment">DAYS<br>LEFT</span>
                	<g:if test="${projectService.getRemainingDay(project) > 0 && projectService.getRemainingDay(project) < 10 }">
                    	<span class="tile-day-num">0${projectService.getRemainingDay(project)}</span>
                    </g:if>
                    <g:else>
                    	<span class="tile-day-num">${projectService.getRemainingDay(project)}</span>
                    </g:else>
                </div>
            </g:else>
            <div class="col-md-4 col-xs-4 amount-alignment amount-text-align text-center">
                <span class="text-center tile-goal">
                    <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else><span class="lead">${contribution}</span>
                </span>
			</div>
        </div>
    </div>
</div> 
</g:if>

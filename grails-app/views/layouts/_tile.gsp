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
    <g:hiddenField name="projectId" class="projectId" id="projectId" value="${project.id}"/>
    <g:if test="${percentage >= 75}">
        <div class="over show-tile">
            <img src="//s3.amazonaws.com/crowdera/assets/Funded-Tag.png" alt="Funded"/>
        </div>
    </g:if>
    <g:elseif test="${ended}">
        <div class="over show-tile">
            <img src="//s3.amazonaws.com/crowdera/assets/ended-tag.png" alt="Ended"/>
        </div>
    </g:elseif>
    <div class="blacknwhite tile">
        <g:link controller="project" action="showCampaign" id="${project.id}" title="${project.title}" params="['fr': username]">
            <div class="imageWithTag">
                <div class="under">
                    <img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}"/>
                </div>
            </div>
        </g:link>
    </div>

    <div class="caption tile-title-descrp project-title project-story-span tile-min-height">
        <g:link controller="project" action="showCampaign" id="${project.id}" title="${project.title}">
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
			<div class="col-xs-4 col-sm-4 col-md-4 campaign-tile-border daysleftIcon">
				<img src="//s3.amazonaws.com/crowdera/assets/timeleft.png">
			</div>
        	<div class="col-sm-4 col-md-4 col-xs-4 progress-pie-chart show-tile progressBarIcon " data-percent="43">
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
                <div class="col-md-4 col-sm-4 col-xs-4 show-tile-text-size campaign-tile-border">
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

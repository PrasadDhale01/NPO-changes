<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    
    def percentage = contributionService.getPercentageContributionForProject(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
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
    
    def currentEnv = projectService.getCurrentEnvironment()
    def conversionMultiplier = multiplier
    if (!conversionMultiplier) {
        conversionMultiplier = projectService.getCurrencyConverter();
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
    <div class="blacknwhite tile" id="campaignTileId">
        <g:form controller="project" action="showCampaign" title="${project.title}" name="${project.title}" novalidate="novalidate" id="${project.id}">
            <g:hiddenField name="fr" value="${username }" id="fr:${project.id}"/>
            <g:hiddenField name="id" value="${project.id}" id="id:${project.id}"/>
            <div class="imageWithTag">
                <div class="under">
                    <a href="javascript:void(0)" onclick="submitCampaignShowForm('show', '${project.id}','${username }');" id="show:${project.id}">
                      <img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}"/>
                    </a>
                </div>
            </div>
        </g:form>
    </div>

    <div class="caption tile-title-descrp project-title project-story-span tile-min-height">
        <a href="javascript:void(0)" onclick="submitCampaignShowForm('show','${project.id}','${username }');" id="title:${project.id}">
            ${project.title.toUpperCase()}
        </a>
        <div class="campaign-title-margin-bottom"></div>
            <span>${project.description}</span>
        </div>

    <div class="modal-footer tile-footer tile-fonts-footer">
    	<div class="row">
    		<div class="col-xs-4 col-sm-4 col-md-4 goalIcon">
				<img src="//s3.amazonaws.com/crowdera/assets/tile-goal-icon.png" alt="tile-goal">
			</div>
			<div class="col-xs-4 col-sm-4 col-md-4 campaign-tile-border daysleftIcon">
				<img src="//s3.amazonaws.com/crowdera/assets/timeleft.png" alt="timeleft">
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
                    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                        <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><span class="lead">${amount}</span></g:if><g:else><span class="lead">${amount * conversionMultiplier}</span></g:else>
                    </g:if>
                    <g:else>
                        $<span class="lead">${amount}</span>
                    </g:else>
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
                    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                        <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><span class="lead">${contribution}</span></g:if><g:else><span class="lead">${contribution * conversionMultiplier}</span></g:else>
                    </g:if>
                    <g:else>
                        $<span class="lead">${contribution}</span>
                    </g:else>
                </span>
            </div>
        </div>
     </div>
   </div>
</g:if>

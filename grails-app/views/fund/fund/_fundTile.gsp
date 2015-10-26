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
<div class="fedu thumbnail c-thumbnail">
	<g:hiddenField name="projectId" class="projectId" id="projectId" value="${project.id}" />
	<g:if test="${percentage >= 75}">
		<div class="over show-tile">
		    <img src="//s3.amazonaws.com/crowdera/assets/Funded-Tag.png" alt="Funded" />
		</div>
	</g:if>
	<g:elseif test="${ended}">
	   <div class="over show-tile">
	       <img src="//s3.amazonaws.com/crowdera/assets/ended-tag.png" alt="Ended" />
	   </div>
	</g:elseif>
	<div class="blacknwhite tile">
		<g:link controller="project" action="showCampaign" id="${project.id}" title="${project.title}" params="['fr': username]">
			<div class="imageWithTag">
				<div class="under">
					<div class="days-left-caption">
						Days left 
						<g:if test="${projectService.getRemainingDay(project) > 0 && projectService.getRemainingDay(project) < 10}">
						    0${projectService.getRemainingDay(project)}
						</g:if>
						<g:else>
						    ${projectService.getRemainingDay(project)}
						</g:else>
					</div>
					<img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}" />
					<div class="amount-caption">
						<span class="pull-left">
						    Raised 
						    <g:if test="${project.payuStatus}">
						        <span class="fa fa-inr"></span>
						    </g:if>
						    <g:else>$</g:else>
					        ${contribution}
						</span>
						<span class="pull-right">
						    Goal
						    <g:if test="${project.payuStatus}">
						        <span class="fa fa-inr"></span>
						    </g:if>
						    <g:else>$</g:else>
						    ${amount}
						</span>
					</div>
				</div>
			</div>
		</g:link>
	</div>
	<div class="progress progress-striped active">
		<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;">
		    ${percentage}%
		</div>
	</div>
	<div class="caption tile-title-descrp project-title project-story-span tile-min-height">
		<g:link controller="project" action="showCampaign" id="${project.id}" title="${project.title}">
		    ${project.title.toUpperCase()}
		</g:link>
		<div class="campaign-title-margin-bottom"></div>
	    <span>${project.description}</span>
    </div>
</div>

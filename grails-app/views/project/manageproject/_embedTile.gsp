<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
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
    def contributionamount = projectService.getDataType(contributedSoFar)
   
    def goal
    def contributedAmount
    if (currentTeam) {
        if (currentTeam.user == project.user) {
            goal = project.amount.round()
        } else {
            goal = currentTeam.amount.round()
        }
         
        contributedAmount = contributionService.getTotalContributionForUser(project?.country?.countryCode, currentTeam.contributions, project?.country?.currency?.dollar)
    }

    def amount = projectService.getDataType(contributedAmount)
    
    def username = project.user.username
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def cents
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }
%>
<div class="fedu thumbnail c-thumbnail wid-bottom">
 <g:hiddenField name="projectId" class="projectId" id="projectId" value="${project.id}" />
 <div class="blacknwhite tile">
  <g:link controller="project" action="showCampaign" id="${project.id}" title="${project.title}" params="['fr': username]">
   <div class="imageWithTag">
    <div class="under">
     <div class="days-left-caption hidden">
      Days left
      <g:if test="${projectService.getRemainingDay(project) > 0 && projectService.getRemainingDay(project) < 10}">
          0${projectService.getRemainingDay(project)}
      </g:if>
      <g:else>
          ${projectService.getRemainingDay(project)}
      </g:else>
     </div>
  
     <img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}" />
    </div>
   </div>
  </g:link>
       <div class="amount-caption">
      <span class="pull-left hidden">
          Raised
          <g:if test="${!project.payuStatus}">
              <span class="fa fa-inr"></span>
          </g:if>
          <g:else>$</g:else>
             ${amount}
      </span>
      <span class="pull-right hidden">
          Goal
          <g:if test="${project.payuStatus}">
              <span class="fa fa-inr"></span>
          </g:if>
          <g:else>$</g:else>
          ${goal}
      </span>
      
      <div class="wid-inline-days pull-right">
	      <div class="wid-days-lbl">DAYS<br>LEFT</div> 
	      <div class="wid-days">
			  <g:if test="${projectService.getRemainingDay(project) > 0 && projectService.getRemainingDay(project) < 10}">
		          0${projectService.getRemainingDay(project)}
		      </g:if>
		      <g:else>
		          ${projectService.getRemainingDay(project)}
		      </g:else>
	      </div>
      </div>
     </div>
 </div>
 
	 <div class="progress progress-striped active">
	  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;">
	      ${percentage}%
	  </div>
	 </div>
	 
 
 <div class="text-center">
    <div class="form-group wid-inline-font">
        <div class="wid-goal-padding">
            <img class="show-goal-size" src="//s3.amazonaws.com/crowdera/assets/tile-goal-icon.png" alt="Goal-Icon">
        </div>
        <div class="wid-goal-rs ">
          
          <g:if test="${project.payuStatus}">
              <span class="fa fa-inr "></span>
          </g:if>
          <g:else>$</g:else>
          <span class="wid-space">${goal}</span>
        </div>
    </div>
 </div>
 
 <div class="caption tile-title-descrp project-title project-story-span tile-min-height">
  <g:link controller="project" action="showCampaign" id="${project.id}" title="${project.title}">
      ${project.title.toUpperCase()}
  </g:link>
  <div class="campaign-title-margin-bottom"></div>
     <span class="wid-descrip-height">${project.description}</span>
    </div>
</div>

                      
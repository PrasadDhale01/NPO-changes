<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <r:require module="crowderacss"/>
    <r:layoutResources />
</head>
<body>
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
	def country_code = projectService.getCountryCodeForCurrentEnv(request)
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
      
      
     </div>
 </div>
	 <div class="progress progress-striped active wid-progress-break col-sm-9 wid-progresbar">
	  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;">
	     <div class="wid-percen-spacing"> ${percentage}%</div>
	  </div>
	 </div>
	 <div class="wid-inline-days pull-right col-sm-3">
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
 <div class="text-center">
    <div class="clear"></div>
    <div class="form-group wid-inline-font">
        <div class="wid-goal-padding">
            <img class="show-goal-size" src="//s3.amazonaws.com/crowdera/assets/tile-goal-icon.png" alt="Goal-Icon">
        </div>
        <div class="wid-goal-rs ">
          
          <g:if test="${project.payuStatus}">
              <span class="fa fa-inr wid-inr"></span>
          </g:if>
          <g:else>$</g:else>
          <span class="wid-space">${amount}</span>
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

<div class="text-center">  
    <g:if test="${percentage == 999}">
	    <button type="button" class="btn btn-success show-campaign-sucessbtn wid-embed-btn mob-show-sucessend" disabled>SUCCESSFULLY FUNDED!</button>
	</g:if>
	<g:elseif test="${ended}">
	    <div class="show-A-fund"> </div>
	    <button type="button" class="btn btn-warning show-campaign-sucess-endedbtn wid-embed-btn mob-show-sucessend show-campaign-ended-funded" disabled>CAMPAIGN ENDED!</button>
	</g:elseif>
	<g:else>
	    
	    <g:if test="${project.paypalEmail || project.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
	       <g:form controller="fund" action="fund" params="['fr':fr, 'projectTitle':projectTitle]" class="fundFormDesktop">   
	            <div class="show-A-fund"> </div>
	            <button name="submit" class="btn btn-show-fund show-fund-size mob-show-fund wid-embed-btn sh-fund-donate-contri" id="btnFundDesktop">DONATE NOW</button>
	        </g:form>
	    </g:if>
	    <g:elseif test="${(project.payuEmail || project.citrusEmail) && !('in'.equalsIgnoreCase(country_code))}">
	    <g:form controller="fund" action="fund" params="['fr':fr, 'projectTitle':projectTitle]" class="fundFormDesktop">  
	      	<button name="inactiveContributeButton" class="btn btn-show-fund show-fund-size mob-show-fund wid-embed-btn sh-fund-donate-contri">DONATE NOW</button>
	    </g:form>
	    </g:elseif>
	    <g:else>
	        <div class="show-A-fund"> </div>
	        <button name="contributeButton" class="btn btn-show-fund show-fund-size mob-show-fund wid-embed-btn sh-fund-donate-contri">DONATE NOW</button>
	    </g:else>
	</g:else>
 </div>
    <r:layoutResources />
</body>
</html>
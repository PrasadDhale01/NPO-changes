<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />

<%
    def percentage = contributionService.getPercentageContributionForProject(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
    def isFundingOpen = projectService.isFundingOpen(project)
    def contributedSoFar = contributionService.getTotalContributionForProject(project)
    def contribution = projectService.getDataType(contributedSoFar)
    def amount = projectService.getDataType(project.amount)
	
	def username = userService.getVanityNameFromUsername(project.user.username, project.id)
	def title = projectService.getVanityTitleFromId(project.id)
	
    def cents
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }
	def country_code = projectService.getCountryCodeForCurrentEnv(request)
%>
<g:if test="${project.validated}">
    <div class="fedu thumbnail grow userdashboard-tiles">
        <g:hiddenField name="projectId" class="projectId" id="projectId" value="${project.id}"/>
        
        <div class="blacknwhite dashboardtileheight">
        	<g:link mapping="showCampaign" params="[country_code: country_code?.toLowerCase(), projectTitle:title,fr: username,category:project.fundsRecievedBy.toLowerCase()]">
                <div class="dashboard-imageWithTag">
                    <div class="under">
                        <img alt="${project.title}" class="dashboard-project-img" src="${projectService.getProjectImageLink(project)}">
                        <div class="userprofile-days">
                            Days Left
                            <g:if test="${projectService.getRemainingDay(project) > 0 && projectService.getRemainingDay(project) < 10 }">
                                <span>0${projectService.getRemainingDay(project)}</span>
                            </g:if>
                            <g:else>
                                <span>${projectService.getRemainingDay(project)}</span>
                            </g:else>
                        </div>
                    </div>
                </div>
            </g:link>
        </div>
    
        <div class="tile-title-descrp project-title project-story-span">
            <g:link mapping="showCampaign" params="[country_code: country_code?.toLowerCase(), projectTitle:title,fr: username,category:project.fundsRecievedBy.toLowerCase()]">
                ${project.title.toUpperCase()}
            </g:link>
            <div class="campaign-title-margin-bottom"></div>
        </div>
        
        <div class="contribution-progress-bar">
            <g:if test="${isFundingOpen}">
                <div class="progress progress-striped active">
                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;"></div>
                </div>
            </g:if>
            <g:else>
                <div class="progress">
                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;"></div>
                </div>
            </g:else>
        </div>
        
        <div class="userprofilecaption">
            <span class="pull-left">
                <span class="userdashboard-caption-font">Raised</span>
                <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><span class="lead">${contribution}</span></g:if><g:else><span class="lead">$${contribution}</span></g:else>
            </span>

            <span class="pull-right">
                <span class="userdashboard-caption-font">Goal</span>
                <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><span class="lead">${amount}</span></g:if><g:else><span class="lead">$${amount}</span></g:else>
            </span>
        </div>
        
        <a target="_blank" class="btn btn-block btn-social btn-facebook fbshareUrl"  href="http://www.facebook.com/sharer.php?p&#91;url&#93;=${fbShareUrl}">
            <i class="fa fa-facebook fa-facebook-styles"></i> Share on Facebook
        </a>
    </div>
    
</g:if>

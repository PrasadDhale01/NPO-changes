<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<g:if test="${usercontributions == null}">
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
    
        def user = userService.getCurrentUser()
        def username = user.username
        def iscampaignAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
        def team = project.teams
        def isTeamAdmin = projectService.isTeamAdmin(project)
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
        def cents
        if(percentage >= 100) {
            cents = 100
        } else {
            cents = percentage
        }
        
        def currentEnv = projectService.getCurrentEnvironment()
        def conversionMultiplier = projectService.getCurrencyConverter();
    %>
    
    <div class="fedu thumbnail grow userdashboard-tiles">
<%--        <g:if test="${iscampaignAdmin}">--%>
<%--            <g:if test="${project.draft}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/Draft-tag.png" alt="draft">--%>
<%--                </div>--%>
<%--            </g:if>--%>
<%--            <g:elseif test="${project.rejected}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/Rejected-tag.png"  alt="rejected">--%>
<%--                </div>--%>
<%--            </g:elseif>--%>
<%--            <g:elseif test="${!project.validated}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/Pending-tag.png" alt="PENDING">--%>
<%--                </div>--%>
<%--            </g:elseif>--%>
<%--            <g:elseif test="${ended}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/ended-tag.png" alt="ended">--%>
<%--                </div>--%>
<%--            </g:elseif>--%>
<%--            <g:elseif test="${percentage >= 75}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/Funded-Tag.png" alt="Funded"/>--%>
<%--                </div>--%>
<%--            </g:elseif>--%>
<%--            <g:elseif test="${project.validated}">--%>
<%--                <g:if test="${user == project.user}">--%>
<%--                    <div class="over user-tile">--%>
<%--                        <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="Owner"/>--%>
<%--                    </div>--%>
<%--                </g:if>--%>
<%--                <g:elseif test="${isTeamAdmin}">--%>
<%--                    <div class="over user-tile">--%>
<%--                     <img src="//s3.amazonaws.com/crowdera/assets/Co-owner-tag.png" alt="co-owner"/>--%>
<%--                    </div>--%>
<%--                </g:elseif>--%>
<%--                <g:else>--%>
<%--                    <div class="over user-tile">--%>
<%--                        <img src="//s3.amazonaws.com/crowdera/assets/Pending-tag.png" alt="Pending"/>--%>
<%--                    </div>--%>
<%--                </g:else>--%>
<%--            </g:elseif>--%>
<%--            <g:elseif test="${isTeamAdmin}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="Owner"/>--%>
<%--                </div>--%>
<%--            </g:elseif>--%>
<%--            <g:else>--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/Team-tag.png" alt="Team top"/>--%>
<%--                </div>--%>
<%--            </g:else>--%>
<%--        </g:if>--%>
<%--        <g:else>--%>
<%--            <g:if test="${project.draft}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/Draft-tag.png" alt="draft"/>--%>
<%--                </div>--%>
<%--            </g:if>--%>
<%--            <g:elseif test="${project.rejected}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/Rejected-tag.png" alt="rejected"/>--%>
<%--                </div>--%>
<%--            </g:elseif>--%>
<%--            <g:elseif test="${!project.validated}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/Pending-tag.png" alt="Pending"/>--%>
<%--                </div>--%>
<%--            </g:elseif>--%>
<%--            <g:elseif test="${ended}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/ended-tag.png" alt="ended"/>--%>
<%--                </div>--%>
<%--            </g:elseif>--%>
<%--            <g:elseif test="${percentage >= 75}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/Funded-Tag.png" alt="Funded"/>--%>
<%--                </div>--%>
<%--            </g:elseif>--%>
<%--            <g:if test="${isTeamAdmin}">--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="Owner"/>--%>
<%--                </div>--%>
<%--            </g:if>--%>
<%--            <g:else>--%>
<%--                <div class="over user-tile">--%>
<%--                    <img src="//s3.amazonaws.com/crowdera/assets/Team-tag.png" alt="Team top"/>--%>
<%--                </div>--%>
<%--            </g:else>--%>
<%--        </g:else>--%>
        <div class="blacknwhite dashboardtileheight">
            <g:if test="${iscampaignAdmin}">
                <g:link controller="project" action="manageCampaign" id="${project.id}" title="${project.title}">
                    <div class="userprofile-days">
                        Days Left
                        <g:if test="${projectService.getRemainingDay(project) > 0 && projectService.getRemainingDay(project) < 10 }">
                            <span>0${projectService.getRemainingDay(project)}</span>
                        </g:if>
                        <g:else>
                            <span>${projectService.getRemainingDay(project)}</span>
                        </g:else>
                    </div>
                    <div class="dashboard-imageWithTag">
                        <div class="under">
                            <img alt="${project.title}" class="dashboard-project-img" src="${projectService.getProjectImageLink(project)}"/>
                        </div>
                    </div>
                </g:link>
            </g:if>
            <g:else>
                <g:link controller="project" action="showCampaign" id="${project.id}" params="['fr': username]" title="${project.title}">
                    <div class="userprofile-days">
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
                    <div class="dashboard-imageWithTag">
                        <div class="under">
                            <img alt="${project.title}" class="dashboard-project-img" src="${projectService.getProjectImageLink(project)}"/>
                        </div>
                    </div>
                </g:link>
            </g:else>
            
        </div>
        
        <div class="project-title project-story-span">
            <g:if test="${iscampaignAdmin}">
                <g:link controller="project" action="manageCampaign" id="${project.id}" title="${project.title}">
                    ${project.title.toUpperCase()}
                </g:link>
            </g:if>
            <g:else>
                <g:link controller="project" action="showCampaign" id="${project.id}" params="['fr': username]" title="${project.title}">
                    ${project.title.toUpperCase()}
                </g:link>
            </g:else>
            <div class="campaign-title-margin-bottom"></div>
        </div>
        
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
        <div class="userprofilecaption">
            <span class="pull-left">
                <span class="userdashboard-caption-font">Raised</span>
                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><span class="lead">${contribution}</span></g:if><g:else><span class="lead">${contribution * conversionMultiplier}</span></g:else>
                </g:if>
                <g:else>
                    <span class="lead">$${contribution}</span>
                </g:else>
            </span>
            
            <span class="pull-right">
                <span class="userdashboard-caption-font">Goal</span>
                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><span class="lead">${amount}</span></g:if><g:else><span class="lead">${amount * conversionMultiplier}</span></g:else>
                </g:if>
                <g:else>
                    <span class="lead">$${amount}</span>
                </g:else>
            </span>
        </div>
        <g:if test="${iscampaignAdmin}">
            <g:link controller="project" action="manageCampaign" id="${project.id}" title="${project.title}">
                <span class="btn btn-default btn-block btn-sm manage-campaign-btn">Manage Campaign</span>
            </g:link>
        </g:if>
        <g:else>
            <g:link controller="project" action="showCampaign" id="${project.id}" params="['fr': username]" title="${project.title}">
                <span class="btn btn-default btn-block btn-sm manage-campaign-btn">Manage Team</span>
            </g:link>
        </g:else>
    </div>
</g:if>
<g:else>
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
        
        def currentEnv = projectService.getCurrentEnvironment()
        def conversionMultiplier = projectService.getCurrencyConverter();
    %>
    <g:if test="${project.validated}">
        <div class="fedu thumbnail grow userdashboard-tiles">
            <g:hiddenField name="projectId" class="projectId" id="projectId" value="${project.id}"/>
            <div class="blacknwhite dashboardtileheight">
                <g:link controller="project" action="showCampaign" id="${project.id}" title="${project.title}" params="['fr': username]">
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
                <g:link controller="project" action="showCampaign" id="${project.id}" title="${project.title}">
                    ${project.title.toUpperCase()}
                </g:link>
                <div class="campaign-title-margin-bottom"></div>
            </div>
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
            
            <div class="userprofilecaption">
				            <span class="pull-left">
				                <span class="userdashboard-caption-font">Raised</span>
				                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
				                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><span class="lead">${contribution}</span></g:if><g:else><span class="lead">${contribution * conversionMultiplier}</span></g:else>
				                </g:if>
				                <g:else>
				                    <span class="lead">$${contribution}</span>
				                </g:else>
				            </span>
				            
				            <span class="pull-right">
				                <span class="userdashboard-caption-font">Goal</span>
				                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
				                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><span class="lead">${amount}</span></g:if><g:else><span class="lead">${amount * conversionMultiplier}</span></g:else>
				                </g:if>
				                <g:else>
				                    <span class="lead">$${amount}</span>
				                </g:else>
				            </span>
				        </div>
            
            <a target="_blank" class="btn btn-block btn-social btn-facebook fbshareUrl" id="fbshare${index}" href="http://www.facebook.com/sharer/sharer.php?s=100&amp;p[url]=${fbShareUrl}">
                <i class="fa fa-facebook fa-facebook-styles"></i> Share on Facebook
            </a>
        </div>
        
    </g:if>
</g:else>

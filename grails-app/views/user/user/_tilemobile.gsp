<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
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
%>
<div class="fedu thumbnail grow user-tiles-style sh-mobile-tile sh-thumbnil-tile">
    <g:if test="${iscampaignAdmin}">
        <g:if test="${project.draft}">
            <div class="over user-tile sh-tiles-baner">
                <img src="//s3.amazonaws.com/crowdera/assets/Draft-tag.png" alt="draft">
            </div>
        </g:if>
        <g:elseif test="${project.rejected}">
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/Rejected-tag.png"  alt="rejected">
            </div>
        </g:elseif>
        <g:elseif test="${!project.validated}">
            <div class="over user-tile sh-tiles-baner">
                <img src="//s3.amazonaws.com/crowdera/assets/Pending-tag.png" alt="PENDING">
            </div>
        </g:elseif>
        <g:elseif test="${ended}">
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/ended-tag.png" alt="ended">
            </div>
        </g:elseif>
        <g:elseif test="${percentage >= 75}">
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/Funded-Tag.png" alt="Funded">
            </div>
        </g:elseif>
        <g:elseif test="${project.validated}">
            <g:if test="${user == project.user}">
                <div class="over user-tile">
                    <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="Owner">
                </div>
            </g:if>
            <g:elseif test="${isTeamAdmin}">
                <div class="over user-tile">
                    <img src="//s3.amazonaws.com/crowdera/assets/Co-owner-tag.png" alt="co-owner">
                </div>
            </g:elseif>
            <g:else>
                <div class="over user-tile">
                    <img src="//s3.amazonaws.com/crowdera/assets/Pending-tag.png" alt="Pending">
                </div>
            </g:else>
        </g:elseif>
        <g:elseif test="${isTeamAdmin}">
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="Owner">
            </div>
        </g:elseif>
        <g:else>
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/Team-tag.png" alt="Team top">
            </div>
        </g:else>
    </g:if>
    <g:else>
        <g:if test="${project.draft}">
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/Draft-tag.png" alt="draft">
            </div>
        </g:if>
        <g:elseif test="${project.rejected}">
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/Rejected-tag.png" alt="rejected">
            </div>
        </g:elseif>
        <g:elseif test="${!project.validated}">
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/Pending-tag.png" alt="Pending">
            </div>
        </g:elseif>
        <g:elseif test="${ended}">
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/ended-tag.png" alt="ended">
            </div>
        </g:elseif>
        <g:elseif test="${percentage >= 75}">
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/Funded-Tag.png" alt="Funded">
            </div>
        </g:elseif>
        <g:if test="${isTeamAdmin}">
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="Owner">
            </div>
        </g:if>
        <g:else>
            <div class="over user-tile">
                <img src="//s3.amazonaws.com/crowdera/assets/Team-tag.png" alt="Team top">
            </div>
        </g:else>
    </g:else>
    <div class="blacknwhite tile">
        <g:if test="${iscampaignAdmin}">
            <g:link controller="project" action="manageCampaign" id="${project.id}" title="${project.title}">
                <div class="imageWithTag">
                    <div class="under">
                        <img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}">
                    </div>
                </div>
            </g:link>
        </g:if>
        <g:else>
            <g:link controller="project" action="showCampaign" id="${project.id}" params="['fr': username]" title="${project.title}">
                <div class="imageWithTag">
                    <div class="under">
                        <img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}">
                    </div>
                </div>
            </g:link>
        </g:else>
    </div>

    <div class="caption project-title project-story-span tile-min-height">
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
        <span>${project.description}</span>
    </div>
    
     <h4 class="panel-title text-center">
         <a class="accordion-toggle collapsed show-mobile-readstory" data-toggle="collapse" data-parent="#accordion" href="#read-story-mobile">Read Story</a>
     </h4>
     <div id="read-story-mobile" class="panel-collapse collapse faq-panel-height">
         <div class="panel-body sh-tilmobileIframe sh-tilemobileIframP">
             <g:if test="${isCrFrCampBenOrAdmin}">
                 <p class="campaignStory justify">${raw(project.story)}</p>
             </g:if>
             <g:else>
                 <p class="campaignStory justify">${raw(currentTeam.story)}</p>
                 <p class="campaignStory justify">${raw(project.story)}</p>
             </g:else>
         </div>
     </div>

    <div class="modal-footer tile-footer tile-fonts-footer">
        <div class="row">
            <div class="col-xs-4 col-sm-4 col-md-4 goalIcon">
                <img src="//s3.amazonaws.com/crowdera/assets/tile-goal-icon.png" alt="tile-goal">
            </div>
            <div class="col-xs-4 col-sm-4 col-md-4 daysleftIcon campaign-tile-border">
                <img src="//s3.amazonaws.com/crowdera/assets/timeleft.png" alt="time-left">
            </div>
            <div class="col-sm-4 col-md-4 col-xs-4 progress-pie-chart show-tile progressBarIcon" data-percent="43">
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
                <div class="col-md-4 col-sm-4 col-xs-4  show-tile-text-size campaign-tile-border">
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

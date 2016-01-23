<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService"/>
<%
    def user = team.user
    def username = user.username
    def userImageUrl = user.userImageUrl
    def userName = user.firstName
    def goal
    if (team.user == project.user) {
        goal = project.amount.round()
    } else {
        goal = team.amount.round()
    }
    def contributedAmount = contributionService.getTotalContributionForUser(team.contributions)
    def amount = projectService.getDataType(contributedAmount)
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def uri = request.forwardURI
    def ismanagepage = uri.contains("manageproject")
    def isAdminOrBeneficiary = userService.isCampaignBeneficiaryOrAdmin(project, user)
    def isCampaignAdmin = userService.isCampaignAdmin(project, username)
    def isCampaignAdminByUser=userService.isCampaignAdminByUserID(project, user)
    def percentage = contributionService.getPercentageContributionForTeam(team)
	
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }

    if (user){
        def obj = userService.getCurrentUserImage(userName)
        alphabet = obj.alphabet
        imageUrl = obj.userImage
    }
    def currentEnv = projectService.getCurrentEnvironment()
    def conversionMultiplier = multiplier
    if (!conversionMultiplier) {
        conversionMultiplier = projectService.getCurrencyConverter();
    }
%>

<div class="fedu thumbnail grow teamtile teamtile-padding hidden-xs">
    <g:if test="${userService.isFacebookUser() || project.user}">
        <g:if test="${!isAdminOrBeneficiary}">
            <g:if test="${team.enable==false}">
                <div class="over teamtile-banner">
                    <img src="//s3.amazonaws.com/crowdera/assets/Disabled-tag.png" alt="diabledTeam">
                </div>
            </g:if>
            <g:else>
                <div class="over teamtile-banner">
                    <img src="//s3.amazonaws.com/crowdera/assets/Team-tag.png" alt="team">
                </div>
            </g:else>
        </g:if>
        <g:elseif test="${isCampaignAdminByUser}">
            <g:if test="${team.enable==false}">
                <div class="over teamtile-banner">
                    <img src="//s3.amazonaws.com/crowdera/assets/Disabled-tag-tag.png" alt="diabledTeam">
                </div>
            </g:if>
            <g:else>
                <div class="over teamtile-banner">
                    <img alt="co-owner" src="//s3.amazonaws.com/crowdera/assets/Co-owner-tag.png">
                </div>
            </g:else>
        </g:elseif>
        <g:else>
            <div class="over teamtile-banner">
	               <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="owner">
            </div>
        </g:else>
    </g:if>
    <g:elseif test="${!ismanagepage || !isAdminOrBeneficiary}">
        <div class="over teamtile-banner">
            <g:if test="${!team.enable}">
                <img src="//s3.amazonaws.com/crowdera/assets/Disabled-tag.png" alt="diabledTeam">
            </g:if>
            <g:else>
                <g:if test="${user == project.user}">
                    <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="owner">
                </g:if>
                <g:elseif test="${isCampaignAdmin}">
                    <img src="//s3.amazonaws.com/crowdera/assets/Co-owner-tag.png" alt="co-owner">
                </g:elseif>
                <g:else>
                    <img src="//s3.amazonaws.com/crowdera/assets/Team-tag.png" alt="team">
                </g:else>
            </g:else>
        </div>
    </g:elseif>
    
    
    <div class="blacknwhite teamtile-style">
        <g:if test="${isPreview || isvalidateShow}">
            <g:if test="${userImageUrl != null}">
                <img alt="${userName}" class="project-img" src="${userImageUrl}">
            </g:if>
            <g:else>
                <div class="under">
                    <img src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" class="project-img" alt="Upload Photo">
                </div>
            </g:else>
        </g:if>
        <g:elseif test="${!ismanagepage || !isAdminOrBeneficiary}">
            <g:link controller="project" action="showCampaign" id="${project.id}" params="['fr': username]">
                <g:if test="${userImageUrl != null}">
                    <img alt="${userName}" class="project-img" src="${userImageUrl}">
                </g:if>
                <g:else>
                    <div class="under">
                        <img src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" class="project-img" alt="Upload Photo">
                    </div>
                </g:else>
            </g:link>
        </g:elseif>
        <g:else>
            <g:link controller="project" action="manageCampaign" id="${project.id}">
                <g:if test="${userImageUrl != null}">
                    <img alt="${userName}" class="project-img" src="${userImageUrl}">
                </g:if>
                <g:else>
                    <div class="imageWithTag">
                        <div class="under">
                            <img src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" class="project-img" alt="Upload Photo">
                            <div class="team-caption">
                                <p>${userName.toUpperCase()}</p>
                            </div>
                        </div>
                    </div>
                </g:else>
            </g:link>
        </g:else>
        <div class="team-caption">
            <p>${userName.toUpperCase()}</p>
        </div>
    </div>

    <div class="modal-footer tile-footer">
        <div class="row">
            <div class="col-md-6 col-xs-6 goalIcon">
                <img src="//s3.amazonaws.com/crowdera/assets/goal-icon.png" alt="Goal Icon">
            </div>
            <div class="col-md-6 col-xs-6 progress-pie-chart team-tile-border progressBarIcon" data-percent="43">
                <div class="c100  p${cents} pie-tile-manage pie-css text-center mobile-pie">
                    <span class="c999">${percentage}%</span>
                    <div class="slice">
                        <div class="bar progressBar"></div>
                        <div class="fill progressBar"></div>
                    </div>	
                </div>
            </div>
        </div>
        <g:if test="${isshow}">
	        <div class="row tilepadding">
	            <div class="col-md-6 col-xs-6 text-center">
	                <span class="text-center tile-goal teamtile">
	                    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
	                        <span class="fa fa-inr"></span><span class="lead goal-size teamtile"><g:if test="${project.payuStatus}">${goal}</g:if><g:else>${goal * conversionMultiplier}</g:else></span>
	                    </g:if>
	                    <g:else>
	                        $<span class="lead goal-size teamtile">${goal}</span>
	                    </g:else>
	                </span>
	            </div>
	            <div class="col-md-6 col-xs-6 text-center team-achieve-amt-border">
	                <span class="text-center tile-goal teamtile">
	                    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
	                        <span class="fa fa-inr"></span><span class="lead achived-size teamtile"><g:if test="${project.payuStatus}">${amount}</g:if><g:else>${amount * conversionMultiplier}</g:else></span>
	                    </g:if>
	                    <g:else>
	                        $<span class="lead achived-size teamtile">${amount}</span>
	                    </g:else>
	                </span>
	            </div>
	        </div>
        </g:if>
        <g:else>
            <div class="row tilepadding">
	            <div class="col-md-6 col-xs-6 text-center">
	                <span class="text-center tile-goal teamtile">
	                    <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else><span class="lead goal-size teamtile">${goal}</span>
	                </span>
	            </div>
	            <div class="col-md-6 col-xs-6 text-center team-achieve-amt-border">
	                <span class="text-center tile-goal teamtile">
	                    <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else><span class="lead achived-size teamtile">${amount}</span>
	                </span>
	            </div>
	        </div>
        </g:else>
    </div>
</div>


<div class="visible-xs <g:if test="${isshow}">show-panel-mobilesize</g:if><g:else>manage-panel-mobile-size</g:else> ${alphabet}">
    <div class ="col-xs-4 show-mobimg-panels">
        <g:if test="${isPreview || isvalidateShow}">
            <g:if test="${userImageUrl}">
                 <img alt="${userName}" class=" user-img-header" src="${userImageUrl}">
            </g:if>
            <g:else>
                 <div class="under show-mobimg-panels">
                     <img src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" class="user-img-header" alt="Upload Photo">
                 </div>
            </g:else>
        </g:if>
        <g:elseif test="${!ismanagepage || !isAdminOrBeneficiary}">
            <g:link controller="project" action="showCampaign" id="${project.id}" params="['fr': username]">
                <g:if test="${userImageUrl}">
                    <img alt="${userName}" class=" user-img-header" src="${userImageUrl}">
                </g:if>
                <g:else>
                    <div class="under show-mobimg-panels">
                        <img src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" class="user-img-header" alt="Upload Photo">
                    </div>
                </g:else>
            </g:link>
        </g:elseif>
    </div>

    <div class =" col-xs-8 ">
        <div class="pn-word">
            <h4>${userName.toUpperCase()}</h4>
        </div>
     
        <g:if test="${isshow}">
	        <div class="mobile-show-team">
	            <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
	                <span class="fa fa-inr"></span><span class="show-mob-goal-amt"><b><g:if test="${project.payuStatus}">${goal}</g:if><g:else>${goal * conversionMultiplier}</g:else></b><span class="show-mobfont-goal">&nbsp;&nbsp;Goal</span></span>
	            </g:if>
	            <g:else>
	                 <span class="show-mob-goal-amt">$<b>${goal}</b><span class="show-mobfont-goal">&nbsp;&nbsp;Goal</span></span>
	            </g:else>
	        </div>
	        <div class="mobile-show-team">
	            <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
	                <span class="fa fa-inr"></span><span class="show-mob-goal-amt"><b><g:if test="${project.payuStatus}">${amount}</g:if><g:else>${amount * conversionMultiplier}</g:else></b><span class="show-mobfont-goal">&nbsp;&nbsp;Raised</span></span>
	            </g:if>
	            <g:else>
	                <span class="show-mob-goal-amt">$<b>${amount}</b><span class="show-mobfont-goal">&nbsp;&nbsp;Raised</span></span>
	            </g:else>
	        </div>
        </g:if>
        <g:else>
            <div class="mobile-show-team">
                <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><span class="show-mob-goal-amt"><b>${goal}</b></span></g:if><g:else><span class="show-mob-goal-amt">$<b>${goal}</b></span></g:else><span class="show-mobfont-goal">&nbsp;&nbsp;Goal</span>
            </div>
            <div class="mobile-show-team">
                <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><span class="show-mob-goal-amt"><b>${amount}</b></span></g:if><g:else><span class="show-mob-goal-amt">$<b>${amount}</b></span></g:else><span class="show-mobfont-goal">&nbsp;&nbsp;Raised</span>
            </div>
        </g:else>
    </div>
</div>

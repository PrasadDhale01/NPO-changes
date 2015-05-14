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
%>

<div class="fedu thumbnail grow teamtile teamtile-padding">
    <div class="blacknwhite teamtile-style">
        <g:if test="${userService.isFacebookUser() || project.user}">
            <g:if test="${!isAdminOrBeneficiary}">
                <g:if test="${team.enable==false}">
                    <div class="over user-tiles-widths">
                        <img src="//s3.amazonaws.com/crowdera/assets/disabledTeam.png" alt="diabledTeam">
                    </div>
                </g:if>
                <g:else>
                    <div class="over teamtile-banner">
                        <img src="//s3.amazonaws.com/crowdera/assets/teamTop.png" alt="team">
                    </div>
                </g:else>
            </g:if>
            <g:elseif test="${isCampaignAdminByUser}">
                <g:if test="${team.enable==false}">
                    <div class="over user-tiles-widths">
                        <img src="//s3.amazonaws.com/crowdera/assets/disabledTeam.png" alt="diabledTeam">
                    </div>
                </g:if>
                <g:else>
                    <div class="over user-tiles-widths">
                        <img alt="co-owner" src="//s3.amazonaws.com/crowdera/assets/Co-Owner1.png">
                    </div>
                </g:else>
            </g:elseif>
            <g:else>
                <div class="over teamtile-banner">
                    <img src="//s3.amazonaws.com/crowdera/assets/OWNER.png" alt="owner">
                </div>
            </g:else>
        </g:if>
        
        <g:if test="${!ismanagepage || !isAdminOrBeneficiary}">
            <g:link controller="project" action="show" id="${project.id}" params="['fr': username]">
                <g:if test="${userImageUrl != null}">
                    <img alt="${userName}" class="project-img" src="${userImageUrl}">
                </g:if>
                <g:else>
                    <div class="imageWithTag">
                        <div class="under">
                            <img src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" class="project-img" alt="Upload Photo">
                        </div>
                        <div class="over teamtile-banner">
                            <g:if test="${!team.enable}">
                                <img src="//s3.amazonaws.com/crowdera/assets/disabledTeam.png" alt="diabledTeam">
                            </g:if>
                            <g:else>
                                <g:if test="${user == project.user}">
                                    <img src="//s3.amazonaws.com/crowdera/assets/OWNER.png" alt="owner">
                                </g:if>
                                <g:elseif test="${isCampaignAdmin}">
                                    <img src="//s3.amazonaws.com/crowdera/assets/Co-Owner1.png" alt="co-owner">
                                </g:elseif>
                                <g:else>
                                    <img src="//s3.amazonaws.com/crowdera/assets/teamTop.png" alt="team">
                                </g:else>
                            </g:else>
                        </div>
                    </div>
                </g:else>
            </g:link>
        </g:if>
	    <g:else>
            <g:link controller="project" action="manageproject" id="${project.id}">
                <g:if test="${userImageUrl != null}">
                    <img alt="${userName}" class="project-img" src="${userImageUrl}">
                </g:if>
                <g:else>
                    <div class="imageWithTag">
                        <div class="under">
                            <img src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" class="project-img" alt="Upload Photo">
                        </div>
                        <div class="over teamtile-banner">
                            <g:if test="${!team.enable}">
                                <img src="//s3.amazonaws.com/crowdera/assets/disabledTeam.png" alt="diabledTeam">
                            </g:if>
                            <g:else>
                                <g:if test="${user == project.user}">
                                    <img src="//s3.amazonaws.com/crowdera/assets/OWNER.png" alt="owner">
                                </g:if>
                                <g:elseif test="${isCampaignAdmin}">
                                    <img src="//s3.amazonaws.com/crowdera/assets/Co-Owner1.png" alt="co-owner">
                                </g:elseif>
                                <g:else>
                                    <img src="//s3.amazonaws.com/crowdera/assets/teamTop.png" alt="team">
                                </g:else>
                            </g:else>
                        </div>
                    </div>
                </g:else>
            </g:link>
        </g:else>
    </div>

    <div class="modal-footer tile-footer">
        <div class="text-left">
            <span>${userName}</span>
        </div>
    </div>

    <div class="modal-footer tile-footer">
        <div class="row tilepadding">
            <div class="col-md-6 col-xs-6">
                <h6 class="text-center"><span class="lead goal-size">$${goal}</span><br/>GOAL</h6>
            </div>
            <div class="col-md-6 col-xs-6">
                <h6 class="text-center"><span class="lead achived-size">$${amount}</span><br />ACHIEVED</h6>
            </div>
        </div>
    </div>
</div>

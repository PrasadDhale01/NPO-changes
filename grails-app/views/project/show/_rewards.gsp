<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="rewardService" bean="rewardService"/>
<g:set var="userService" bean="userService"/>
<%
    boolean isFundingOpen = projectService.isFundingOpen(project)
    def beneficiary = project.user
    def username
    if (user) {
        username = user.username
    } else {
        username = beneficiary.username
    }
    def currentUser = userService.getCurrentUser()
%>
<div class="modal-footer tile-footer perks-style">
    <g:if test="${isFundingOpen}">
        <h2 class="rewardsectionheading">Perks</h2>
    </g:if>
    <g:else>
        <h2 class="rewardsectionheading">Funding closed</h2>
    </g:else>
</div>
<div class="tile-footer perks-supporters">
    <div class="rewardsection">
        <g:each in="${project.rewards}" var="reward">
            <%
                def backers = contributionService.getBackersForProjectByReward(project, reward);
        		def price = projectService.getDataType(reward.price);
				def rewardId = reward.id
                def isOnlyTwitterHandled = rewardService.isOnlyTwitterHandled(reward)
                def isTwitterHandled = rewardService.isTwitterHandled(reward)
            %>
            <div class="rewardsection-row">
                <g:if test="${isFundingOpen}">
                    <div class="rewardBottomBorder">
                        <h4>CONTRIBUTE $${price} OR MORE</h4>
                        <span class="badge">${backers}</span>&nbsp;&nbsp;<b>SUPPORTERS</b>
                        <p class="rewarddescription" id="${reward.id}">${raw(reward.description)}</p>
                        <g:if test="${currentUser == null && isOnlyTwitterHandled}">
                            <p title="As you are anonymous, this perk which contains twitter handler is disabled for you">SELECT THIS PERK</p>
                        </g:if>
                        <g:elseif test="${currentUser == null && isTwitterHandled}">
                            <g:link controller="fund" title="As you are keeping your contribution anonymous, Twitter perks will be disabled for you" action="fund" id="${project.id}" params="['fr': username, 'rewardId': rewardId]">SELECT THIS PERK</g:link>
                        </g:elseif>
                        <g:else>
                            <g:link controller="fund" action="fund" id="${project.id}" params="['fr': username, 'rewardId': rewardId]">SELECT THIS PERK</g:link>
                        </g:else>
                    </div>
                </g:if>
                <g:else>
                    <div class="rewardBottomBorder">
                        <h4>CONTRIBUTE $${price} OR MORE</h4>
                        <span class="badge">${backers}</span>&nbsp;&nbsp;<b>SUPPORTERS</b>
                        <p class="rewarddescription">${reward.description}</p>
                    </div>
                </g:else>
            </div>
        </g:each>
    </div>
</div>

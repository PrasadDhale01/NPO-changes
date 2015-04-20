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
    def rewards = rewardService.getSortedRewards(project);
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
        <g:each in="${rewards}" var="reward">
            <%
                def backers = contributionService.getBackersForProjectByReward(project, reward);
        		def price = projectService.getDataType(reward.price);
				def rewardId = reward.id
                def isOnlyTwitterHandled = rewardService.isOnlyTwitterHandled(reward)
                def isTwitterHandled = rewardService.isTwitterHandled(reward)
            %>
            <g:if test="${isFundingOpen}">
                <g:link controller="fund" action="fund" id="${project.id}" params="['fr': username, 'rewardId': rewardId]">
                    <div class="rewardsection-row">
                        <div class="rewardBottomBorder">
                            <g:if test="${reward.id==1 }">
                                <div class="rewardtitlespan">${reward.title}</div>
                            </g:if>
                            <g:else>
                                <div class="rewardpricespan">$${price}</div>
                                <div class="rewardtitlespan">${reward.title}</div>
                            </g:else>
                            <p class="rewarddescription" id="${reward.id}">${raw(reward.description)}</p>
                            <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perkSupporter">SUPPORTERS</span>
                        </div>
                    </div>
                </g:link>
            </g:if>
            <g:else>
                <div class="rewarddiv">
                    <div class="rewardBottomBorder">
                        <div class="rewardpricespan">$${price}</div>
                        <div class="rewardtitlespan">${reward.title}</div>
                        <p class="rewarddescription">${reward.description}</p>
                        <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perkSupporter">SUPPORTERS</span>
                     </div>
                 </div>
            </g:else>
        </g:each>
    </div>
</div>

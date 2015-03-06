<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    boolean isFundingOpen = projectService.isFundingOpen(project)
    def beneficiary = project.user
    def username
    if (user) {
        username = user.username
    } else {
        username = beneficiary.username
    }
%>
<div class="modal-footer tile-footer perks-style">
    <g:if test="${isFundingOpen}">
        <h2 class="rewardsectionheading">Perks</h2>
    </g:if>
    <g:else>
        <h2 class="rewardsectionheading">Funding closed</h2>
    </g:else>
</div>
<div class="modal-footer tile-footer perks-supporters">
    <div class="rewardsection">
        <g:each in="${project.rewards}" var="reward">
            <%
                def backers = contributionService.getBackersForProjectByReward(project, reward);
        		def price = projectService.getDataType(reward.price);
				def rewardId = reward.id
            %>
            <div class="rewardsection-row">
            <g:if test="${isFundingOpen}">
                <h4>CONTRIBUTE $${price} OR MORE</h4>
                <span class="badge">${backers}</span>&nbsp;&nbsp;<b>SUPPORTERS</b>
                <p class="rewarddescription" id="${reward.id}">${raw(reward.description)}</p>
                <g:link controller="fund" action="fund" id="${project.id}" params="['fr': username, 'rewardId': rewardId]">SELECT THIS PERK</g:link>
            </g:if>
            <g:else>
                <h4>CONTRIBUTE $${price} OR MORE</h4>
                <span class="badge">${backers}</span>&nbsp;&nbsp;<b>SUPPORTERS</b>
                <p class="rewarddescription">${reward.description}</p>
            </g:else>
            </div>
        </g:each>
    </div>
</div>

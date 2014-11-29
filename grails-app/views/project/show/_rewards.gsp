<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    boolean isFundingOpen = projectService.isFundingOpen(project)
%>
<div class="modal-footer tile-footer" style="text-align: left; margin-top: 30px;">
    <g:if test="${isFundingOpen}">
        <h2 class="rewardsectionheading">Rewards</h2>
    </g:if>
    <g:else>
        <h2 class="rewardsectionheading">Funding closed</h2>
    </g:else>
</div>
<div class="modal-footer tile-footer" style="text-align: left; margin-top:2px;">
    <div class="rewardsection">
        <g:each in="${project.rewards}" var="reward">
            <%
                def backers = contributionService.getBackersForProjectByReward(project, reward);
            %>
            <div class="rewardsection-row">
            <g:if test="${isFundingOpen}">
                <h4>CONTRIBUTE $${reward.price} OR MORE</h4>
                <span class="badge">${backers}</span>&nbsp;&nbsp;<b>SUPPORTERS</b>
                <p class="rewarddescription">${reward.description}</p>
                <g:link absolute="true" uri="/projects/${project.id}/fund">SELECT THIS REWARD</g:link>
            </g:if>
            <g:else>
                <h4>CONTRIBUTE $${reward.price} OR MORE</h4>
                <span class="badge">${backers}</span>&nbsp;&nbsp;<b>SUPPORTERS</b>
                <p class="rewarddescription">${reward.description}</p>
            </g:else>
            </div>
        </g:each>
    </div>
</div>

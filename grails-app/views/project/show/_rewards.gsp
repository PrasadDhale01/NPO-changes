<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="rewardService" bean="rewardService"/>
<g:set var="userService" bean="userService"/>

<div class="tile-footer perks-supporters">
	<div class="modal-footer tile-footer perks-style perk-title">
		<g:if test="${isFundingOpen}">
			<h2 class="rewardsectionheading">Perks</h2>
		</g:if>
		<g:else>
			<h2 class="rewardsectionheading">Funding closed</h2>
		</g:else>
	</div>
    <div class="rewardsection">
        <g:each in="${rewards}" var="reward">
            <%
                def backers = contributionService.getBackersForProjectByReward(project, reward);
        		def price = reward.price.round();
				def rewardId = reward.id
            %>
            <g:if test="${isFundingOpen}">
                <g:link controller="fund" action="fund" params="['fr': vanityUsername, 'rewardId': rewardId, 'projectTitle': vanityTitle]">
                    <div class="rewardsection-row">
                        <div class="rewardBottomBorder">
                            <g:if test="${reward.id==1 }">
                                <div class="rewardtitlespan">I just want to help.</div>
                            </g:if>
                            <g:else>
                                <div class="tile-goal-show">$<span class="rewardpricespan">${price}</span></div>
                                <div class="rewardtitlespan">${reward.title}</div>
                            </g:else>
							<g:if test="${reward.id==1 }">
								<p class="rewarddescription"></p>
							</g:if>
							<g:else>
								<p class="rewarddescription">${raw(reward.description)}</p>
							</g:else>
                            <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perkSupporter">SUPPORTERS</span>
                        </div>
                    </div>
                </g:link>
            </g:if>
            <g:else>
                <div class="rewarddiv">
                    <div class="rewardBottomBorder">
						<div class="tile-goal-show">$<span class="rewardpricespan">${price}</span></div>
						<div class="rewardtitlespan">${reward.title}</div>
                        <p class="rewarddescription">${reward.description}</p>
                        <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perkSupporter">SUPPORTERS</span>
                     </div>
                 </div>
            </g:else>
        </g:each>
    </div>
</div>

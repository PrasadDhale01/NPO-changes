<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="rewardService" bean="rewardService"/>
<g:set var="userService" bean="userService"/>
<% 
def conversionMultiplier = multiplier
if (!conversionMultiplier) {
    conversionMultiplier = projectService.getCurrencyConverter();
}
%>

<div class="tile-footer show-perksRewardtabs">

    <div class="rewardsection">
    <g:if test="${isFundingOpen || isPreview}">
            <span class="rewardsectionheading">Choose a Perks</span>
        </g:if>
        <g:else>
            <h2 class="rewardsectionheading sh-fundclosed-mobile">Funding Closed</h2>
        </g:else>
        <g:each in="${rewards}" var="reward">
        <%
             def backers = contributionService.getBackersForProjectByReward(project, reward);
             def price = reward.price.round();
             def rewardId = reward.id
             def totalNumberOfReward = reward.numberAvailable
        %>
        <g:if test="${(isFundingOpen && !isPreview) || (isFundingOpen && project.validated)}">
            <g:if test="${(project.payuStatus == false) && (currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia')}">
                <div class="redirectCampaignOnPerk crowdera-perk">
                    <g:if test="${backers == totalNumberOfReward && reward.id != 1}">
                        <p class="soldOutRewards"><span id="sold-out-text">All Perks Claimed</span></p>
                        <div class="rewardsection-row perks-supporters">
                            <div class="rewardBottomBorder">
                                <div class="tile-goal-show">
                                    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                        <span class="fa fa-inr"></span><span class="rewardpricespan"><g:if test="${project.payuStatus}">${price}</g:if><g:else>${price * conversionMultiplier}</g:else></span>
                                    </g:if>
                                    <g:else>
                                        $<span class="rewardpricespan">${price}</span>
                                    </g:else>
                                </div>
                                <div class="rewardtitlespan">${reward.title}</div>
                                <p class="rewarddescription">${raw(reward.description)}</p>
                                <p class="perk-claimed"><b>${backers} out of ${totalNumberOfReward} claimed</b></p>
                                <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perkSupporter">SUPPORTERS</span>
                            </div>
                        </div>
                    </g:if>
                    <g:else>
                        <g:link controller="fund" action="fund" params="['fr': vanityUsername, 'rewardId': rewardId, 'projectTitle': vanityTitle]">
                            <div class="rewardsection-row perks-supporters">
                                <div class="rewardBottomBorder">
                                    <g:if test="${reward.id==1 }">
                                         <div class="rewardtitlespan">I just want to help.</div>
                                    </g:if>
                                    <g:else>
                                         <div class="tile-goal-show">
                                             <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                                 <span class="fa fa-inr"></span><span class="rewardpricespan"><g:if test="${project.payuStatus}">${price}</g:if><g:else>${price * conversionMultiplier}</g:else></span>
                                             </g:if>
                                             <g:else>
                                                 $<span class="rewardpricespan">${price}</span>
                                             </g:else>
                                         </div>
                                         <div class="rewardtitlespan">${reward.title}</div>
                                    </g:else>
                                    <g:if test="${reward.id==1 }">
                                        <p class="rewarddescription"></p>
                                    </g:if>
                                    <g:else>
                                        <p class="rewarddescription">${raw(reward.description)}</p>
                                        <p class="perk-claimed"><b>${backers} out of ${totalNumberOfReward} claimed</b></p>
                                    </g:else>
                                    <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perkSupporter">SUPPORTERS</span>
                                </div>
                            </div>
                        </g:link>
                    </g:else>
                </div>
            </g:if>
            <g:else>
                <g:if test="${backers == totalNumberOfReward && reward.id != 1}">
                    <div class="rewardsection-row crowdera-perk perks-supporters">
                        <p class="soldOutRewards"><span id="sold-out-text">All Perks Claimed</span></p>
                        <div class="rewardBottomBorder">
                            <div class="tile-goal-show">
                                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                    <span class="fa fa-inr"></span><span class="rewardpricespan"><g:if test="${project.payuStatus}">${price}</g:if><g:else>${price * conversionMultiplier}</g:else></span>
                                </g:if>
                                <g:else>
                                    $<span class="rewardpricespan">${price}</span>
                                </g:else>
                            </div>
                            <div class="rewardtitlespan">${reward.title}</div>
                            <p class="rewarddescription">${raw(reward.description)}</p>
                            <p class="perk-claimed"><b>${backers} out of ${totalNumberOfReward} claimed</b></p>
                            <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perkSupporter">SUPPORTERS</span>
                        </div>
                    </div>
                </g:if>
                <g:else>
                    <g:link controller="fund" action="fund" params="['fr': vanityUsername, 'rewardId': rewardId, 'projectTitle': vanityTitle]">
                        <div class="rewardsection-row perks-supporters">
                            <div class="rewardBottomBorder">
                                <g:if test="${reward.id==1 }">
                                    <div class="rewardtitlespan">I just want to help.</div>
                                </g:if>
                                <g:else>
                                    <div class="tile-goal-show">
                                        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                            <span class="fa fa-inr"></span><span class="rewardpricespan"><g:if test="${project.payuStatus}">${price}</g:if><g:else>${price * conversionMultiplier}</g:else></span>
                                        </g:if>
                                        <g:else>
                                            $<span class="rewardpricespan">${price}</span>
                                        </g:else>
                                    </div>
                                    <div class="rewardtitlespan">${reward.title}</div>
                                </g:else>
                                <g:if test="${reward.id==1 }">
                                    <p class="rewarddescription"></p>
                                </g:if>
                                <g:else>
                                    <p class="rewarddescription">${raw(reward.description)}</p>
                                    <p class="perk-claimed"><b>${backers} out of ${totalNumberOfReward} claimed</b></p>
                                </g:else>
                                <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perkSupporter">SUPPORTERS</span>
                            </div>
                        </div>
                    </g:link>
                </g:else>
            </g:else>
        </g:if>
        <g:else>
            <div class="rewardsection-row crowdera-perk perks-supporters">
                <g:if test="${backers == totalNumberOfReward && reward.id != 1}">
                    <p class="soldOutRewards"><span id="sold-out-text">All Perks Claimed</span></p>
                </g:if>
                <div class="rewardBottomBorder">
                    <g:if test="${reward.id==1 }">
                        <div class="rewardtitlespan">I just want to help.</div>
                    </g:if>
                    <g:else>
                        <div class="tile-goal-show">
                            <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                <span class="fa fa-inr"></span><span class="rewardpricespan"><g:if test="${project.payuStatus}">${price}</g:if><g:else>${price * conversionMultiplier}</g:else></span>
                            </g:if>
                            <g:else>
                                $<span class="rewardpricespan">${price}</span>
                            </g:else>
                        </div>
                        <div class="rewardtitlespan">${reward.title}</div>
                    </g:else>
                    <g:if test="${reward.id==1 }">
                        <p class="rewarddescription"></p>
                    </g:if>
                    <g:else>
                        <p class="rewarddescription">${reward.description}</p>
                        <p class="perk-claimed"><b>${backers} out of ${totalNumberOfReward} claimed</b></p>
                    </g:else>
                    <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perkSupporter">SUPPORTERS</span>
                </div>
            </div>
        </g:else>
        </g:each>
    </div>
</div>

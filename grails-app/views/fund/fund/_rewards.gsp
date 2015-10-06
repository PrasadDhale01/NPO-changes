<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="rewardService" bean="rewardService"/>
<g:set var="userService" bean="userService"/>

<%
    def rewards = rewardService.getSortedRewards(project);
%>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Choose a Perk</h3>
    </div>
    <div class="panel-body rewardTileOnFundPage">
        <div class="choose-error"></div>
        <% isAnonymous = userService.isAnonymous(user) %>
        <div class="list-group twitterHandler">
            <g:each in="${rewards}" var="reward">
                <%
                    def backers = contributionService.getBackersForProjectByReward(project, reward);
                    def price = projectService.getDataType(reward.price);
                    def totalNumberOfReward = reward.numberAvailable
                %>
                <div class="col-md-12 col-sm-6 col-xs-12">
                <br>
                <g:if test="${backers == totalNumberOfReward && reward.id != 1}">
                    <div class="crowdera-perk list-group-item">
                        <p class="soldOutRewards"><span id="sold-out-text">All Perks Claimed</span></p>
                        <div class="tile-goal-show">
                            <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else><span class="perk-amount-fund">${price}</span>
                        </div>
                        <h4 class="perk-title-fund">${reward.title}</h4>
                        <p class="perk-desc-fund">${reward.description}</p>
                        <p><b>${backers} out of ${totalNumberOfReward} claimed</b></p>
                        <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perksupporter">SUPPORTERS</span>
                    </div>
                </g:if>
                <g:else>
                    <a href="#" class="list-group-item <% if(perk == reward){%> active <%}%>" id="${reward.id}" data-rewardprice="${reward.price}">
                        <g:if test="${reward.id!=1 }">
                            <div class="tile-goal-show">
                                <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else><span class="perk-amount-fund">${price}</span>
                            </div>
                        </g:if>
                        <g:if test="${reward.id==1 }">
                            <h4 class="perk-title-fund">I just want to help.</h4><br>
                            <p class="perk-desc-fund"></p>
                        </g:if>
                        <g:else>
                            <h4 class="perk-title-fund">${reward.title}</h4>
                            <p class="perk-desc-fund">${reward.description}</p>
                            <p class="perk-claimed"><b>${backers} out of ${totalNumberOfReward} claimed</b></p>
                        </g:else>
                        <span class="badge">${backers}</span>&nbsp;&nbsp;<span class="perksupporter">SUPPORTERS</span>
                    </a>
                </g:else>
                </div>
            </g:each>
        </div>
    </div>
</div>

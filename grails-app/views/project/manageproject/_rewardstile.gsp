<g:set var="rewardService" bean="rewardService"/>
<g:set var="projectService" bean="projectService"/>
<%
	def projectId = project.id
	def backers = contributionService.getBackersForProjectByReward(project, reward);
	def totalNumberOfReward = reward.numberAvailable
	def availableReward = totalNumberOfReward - backers;
	
%>
<div class="panel panel-primary crowdera-perk perk-tile reward-tile managcampaign-rewardtile">
    <div class="panel-heading">
        <g:if test="${reward.id==1 }">
            <h3 class="panel-title"><b>I just want to help.</b></h3>
        </g:if>
        <g:else>
            <h3 class="panel-title"><b>${reward.title}</b></h3>
        </g:else>
    </div>
	<div class="panel-body perktile">
	    <div class="containrewards">
	        <g:if test="${reward.id !=1 }">
		        <p>${raw(reward.description)}</p>
		    </g:if>
		</div>
        <g:if test="${reward.id !=1 }">
            <span class="perkNumberAvailable"><b>Number available :</b> ${availableReward}</span>
        </g:if>
        <g:else>
            <div class="rewardTileSpace"></div>
        </g:else>
	</div>
	<div class="panel-footer reward-footer">
		<% def price = reward.price.round(); %>
		<g:if test="${reward.id==1 }">
            <b>&nbsp;</b>
        </g:if><g:else>
            <b><g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${price}</b>
        </g:else>
		<b class="pull-right">&nbsp;SUPPORTERS</b><span class="badge pull-right">${backers}</span>
	</div>

    <span class="campaignEditDeleteIcon">
        <g:if test="${reward.id != 1}">
            <g:if test="${project.draft}">
                <span class="perkedit" data-toggle="modal" data-target="#editperks${reward.id}">
                     <i class="glyphicon glyphicon-edit"></i>
                </span>
                <g:form controller="project" action="deletecustomrewards" id="${reward.id}" params="['projectId': projectId]"  method="post">
                    <button class="perkdelete rewarddelete" name="" value="Delete" onClick="return confirm(&#39;Are you sure you want to Delete this Perk?&#39;);">
                        <i class="glyphicon glyphicon-trash"></i>
                    </button>
                </g:form>
            </g:if>
            <g:else>
                <g:if test="${backers >= 1}">
                    <span class="perkdelete perkedit1 supporterExist">
                        <i class="glyphicon glyphicon-edit"></i>
                    </span>
                </g:if>
                <g:else>
                    <span class="perkdelete perkedit1" data-toggle="modal" data-target="#editperks${reward.id}">
                        <i class="glyphicon glyphicon-edit"></i>
                    </span>
                </g:else>
            </g:else>
        </g:if>
    </span>

</div>
<div class="modal fade editperks" id="editperks${reward.id}" tabindex="-1" role="dialog" aria-labelledby="#editperks${reward.id}" aria-hidden="true">
    <g:form controller="project" action="customrewardedit" id="${reward.id}">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit The Perk</h4>
                </div>
                <div class="modal-body">
                    <g:hiddenField name="amount" value="${project.amount}" id="cAmount"/>
                    <g:hiddenField name="projectId" value="${project.id}"/>
                    <g:if test="${project.payuStatus}">
                        <g:hiddenField name="isINR" value="${project.payuStatus}" id="isINR"/>
                    </g:if>
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" class="form-control all-place" name="title" value="${reward.title}" placeholder="Title"/>
                    </div>
                    <div class="form-group">
                        <label for="title">Number available</label>
                        <input type="text" class="form-control all-place" name="numberAvailable" value="${reward.numberAvailable}" placeholder="Number available"/>
                    </div>
                    <div class="form-group descriptionDiv createDescDiv">
                        <label for="description">Description</label>
                        <textarea class="form-control all-place" id="rewarddescarea" name="description" maxlength="250" rows="4" placeholder="Description">${reward.description}</textarea>
                        <label class="pull-right " id="desclength"></label>
                    </div>
                    <div class="clear"></div>
                    <div class="form-group">
                        <label for="price">Price (<g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>)</label>
                        <input type="number" class="form-control perkPrice all-place" name="price" value="${reward.price.round()}" id="perkPrice" placeholder="Price"/>
                        <span id="errormsg" class="errormsg"></span>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Which of the following is necessary to fulfill this perk:</label>
                        <%
                            def rewarShipping = rewardService.getRewardShippingInfo(reward)
                        %>
                        <g:if test="${rewarShipping}">
                        <div class="editShippingreward shipping-inline col-lg-12 col-xs-12 col-md-12 col-sm-12">
                            <label class="btn btn-primary btn-sm checkbox-inline control-label col-lg-3 col-xs-6 col-md-3 col-sm-4 editshipping-margin"><input type="checkbox" class="editShippingInfo" name="address" value="true" id="mailaddcheckbox" <g:if test="${rewarShipping.address}">checked="checked"</g:if> >Mailing address</label>
                            <label class="btn btn-primary btn-sm checkbox-inline control-label col-lg-3 col-xs-6 col-md-3 col-sm-4 editshipping-margin"><input type="checkbox" class="editShippingInfo" name="email" value="true" id="emailcheckbox" <g:if test="${rewarShipping.email}">checked="checked"</g:if>>Email address</label>
                            <label class="btn btn-primary btn-sm checkbox-inline control-label col-lg-3 col-xs-6 col-md-3 col-sm-4 editshipping-margin"><input type="checkbox" class="editShippingInfo" name="twitter" value="true" id="twittercheckbox" <g:if test="${rewarShipping.twitter}">checked="checked"</g:if>>Twitter handle</label>
                            <input type="text" class="editShippingInfo col-lg-3 col-xs-6 col-md-3 col-sm-4 cutom-perks-border form-control" name="custom" value="${rewarShipping.custom}" id="custombox" placeholder="Custom"/>
                        </div>
                        <div class="editShippingError"></div>
                        </g:if>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary btn-block">Update Perk</button>
                </div>
            </div>
        </div>
    </g:form>
</div>

<g:set var="rewardService" bean="rewardService"/>
<g:set var="projectService" bean="projectService"/>
<%
	def projectId = project.id
	def backers = contributionService.getBackersForProjectByReward(project, reward);
%>
<div class="panel panel-primary reward-tile">
	<div class="panel-heading">
		<h3 class="panel-title">${reward.title}</h3>
	</div>
	<div class="panel-body perktile">
	    <div class="containrewards">
		    <p>${raw(reward.description)}</p>
		</div>
		<g:if test="${project.draft}">
			<g:if test="${reward.id != 1}">
				<g:form controller="project" action="deletecustomrewards" id="${reward.id}" params="['projectId': projectId]"  method="post">
					<button class="pull-right rewarddelete close" name="" value="Delete" onClick="return confirm(&#39;Are you sure you want to Delete this Perk?&#39;);">
						<i class="fa fa-trash-o"></i>
					</button>
				</g:form>
			</g:if>
		</g:if>
		<g:if test="${reward.id != 1}">
		    <g:if test="${backers >= 1}">
		        <button class="pull-right supporterExist rewarddelete close" id="editproject">
                    <i class="glyphicon glyphicon-edit"></i>
                </button>
            </g:if>
            <g:else>
                <button class="pull-right rewarddelete close" id="editproject"  data-toggle="modal" data-target="#editperks${reward.id}">
                    <i class="glyphicon glyphicon-edit"></i>
                </button>
            </g:else>
        </g:if>
        <g:else>
            <button class="pull-right defaultperk rewarddelete close" id="editproject">
                <i class="glyphicon glyphicon-edit"></i>
            </button>
        </g:else>

	</div>
	<div class="panel-footer reward-footer">
		<% def price = projectService.getDataType(reward.price); %>
		<b>$${price}</b>
		<b class="pull-right">&nbsp;SUPPORTERS</b><span class="badge pull-right">${backers}</span>
	</div>
</div>
<div class="modal fade editperks" id="editperks${reward.id}" tabindex="-1" role="dialog" aria-labelledby="#editperks${reward.id}" aria-hidden="true">
    <g:form controller="project" action="customrewardedit" id="${reward.id}"role="form">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit The Perk</h4>
                </div>
                <div class="modal-body">
                    <g:hiddenField name="amount" value="${project.amount}" id="cAmount"/>
                    <g:hiddenField name="projectId" value="${project.id}"/>
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" class="form-control" name="title" value="${reward.title}" placeholder="Title"/>
                    </div>
                    <div class="form-group descriptionDiv createDescDiv">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="descarea" name="description" maxlength="250" rows="4" placeholder="Description">${reward.description}</textarea>
                        <label class="pull-right " id="desclength"></label>
                    </div>
                    <div class="clear"></div>
                    <div class="form-group">
                        <label for="price">Price ($)</label>
                        <input type="number" class="form-control perkPrice" name="price" value="${reward.price.round()}" id="perkPrice" min="0" placeholder="Price"/>
                        <span id="errormsg" class="errormsg"></span>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Which of the following is necessary to fulfill this perk:</label>
                        <%
                            def rewarShipping = rewardService.getRewardShippingInfo(reward)
                        %>
                        <g:if test="${rewarShipping}">
                        <div class="shippingreward">
                            <label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="address" value="true" id="mailaddcheckbox" <g:if test="${rewarShipping.address}">checked="checked"</g:if> >Mailing address</label>
                            <label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="email" value="true" id="emailcheckbox" <g:if test="${rewarShipping.email}">checked="checked"</g:if>>Email address</label>
                            <label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="twitter" value="true" id="twittercheckbox" <g:if test="${rewarShipping.twitter}">checked="checked"</g:if>>Twitter handle</label>
                            <label class="btn btn-primary btn-sm checkbox-inline control-label lblCustom"><input type="checkbox" name="custom" value="true" id="customcheckbox" <g:if test="${rewarShipping.custom}">checked="checked"</g:if>>Custom</label>
                        </div>
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

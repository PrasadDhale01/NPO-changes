<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="rewardService" bean="rewardService"/>
<%
    boolean ended = projectService.isProjectDeadlineCrossed(project)
    boolean isFundingOpen = projectService.isFundingOpen(project)
    def rewards = rewardService.getSortedRewards(project);
%>
<div class="row">
    <div class="col-xs-12">
        
        <!-- Button trigger modal -->
        <g:if test="${!ended}">
	        <a href="#" class="btn btn-primary btn-sm btn-circle pull-right" data-toggle="modal" data-target="#createRewardModal" model="['project': project]">
	            <i class="fa fa-plus-circle"></i> Create Perk
	        </a>
        </g:if>
        <g:else>
        	<div class="alert alert-info">Campaign Ended.</div>
        </g:else>
        
        <!-- Modal -->
        <div class="modal fade" id="createRewardModal" tabindex="-1" role="dialog" aria-labelledby="createRewardModal" aria-hidden="true">
            <g:form action="customrewardsave" id="${project.id}"role="form">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">Create a new Perk</h4>
                        </div>
                        <div class="modal-body">
                            <g:hiddenField name="amount" value="${project.amount}" id="cAmount"/>
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control" name="title" placeholder="Title"/>
                            </div>
                            <div class="form-group descriptionDiv">
                                <label for="description">Description</label>
                                <textarea class="form-control" id="descarea" name="description" maxlength="140" rows="4" placeholder="Description"></textarea>
                                <label class="pull-right " id="desclength"></label>
                            </div>
                            <div class="clear"></div>
                            <div class="form-group">
                                <label for="price">Price ($)</label>
                                <input type="number" class="form-control" name="price" id="perkPrice" min="0" placeholder="Price"/>
                                <span id="errormsg"></span>
                            </div>
                            <div class="form-group">
                                <label class="control-label">Which of the following is necessary to fulfill this perk:</label>
                                <div class="shippingreward">
                                    <label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="address" value="true" id="mailaddcheckbox">Mailing address</label>
                                    <label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="email" value="true" id="emailcheckbox">Email address</label>
                                    <label class="btn btn-primary btn-sm checkbox-inline control-label"><input type="checkbox" name="twitter" value="true" id="twittercheckbox">Twitter handle</label>
                                    <label class="btn btn-primary btn-sm checkbox-inline control-label lblCustom"><input type="checkbox" name="custom" value="true" id="customcheckbox">Custom</label>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary btn-block">Create Perk</button>
                        </div>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <g:render template="manageproject/rewardsgrids" model="['rewards': rewards]"></g:render>
    </div>
</div>

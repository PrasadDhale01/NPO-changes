<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    boolean isFundingOpen = projectService.isFundingOpen(project)
%>
<br>
<div class="row">
    <div class="col-xs-12">
        <!-- Button trigger modal -->
        <a href="#" class="btn btn-primary btn-circle pull-right" data-toggle="modal" data-target="#createRewardModal" model="['project': project]">
            <i class="fa fa-plus-circle"></i> Create Reward
        </a>
        
        <!-- Modal -->
        <div class="modal fade" id="createRewardModal" tabindex="-1" role="dialog" aria-labelledby="createRewardModal" aria-hidden="true">
            <g:form action="customrewardsave" id="${project.id}"role="form">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">Create a new Reward</h4>
                        </div>
                        <div class="modal-body">
                            <g:hiddenField name="amount" value="${project.amount}"/>
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control" name="title" placeholder="Title" required/>
                            </div>
                            <div class="form-group">
                                <label for="description">Description</label>
                                <textarea class="form-control" name="description" rows="4" placeholder="Description" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="price">Price ($)</label>
                                <input type="number" class="form-control" name="price" placeholder="Price" required/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary btn-block">Create Reward</button>
                        </div>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>
<div class="panel panel-default" style="margin-top: 30px;">
    <div class="panel-body">
        <div class="list-group">
            <g:each in="${project.rewards}" var="reward">
                <%
                    def backers = contributionService.getBackersForProjectByReward(project, reward);
                    def price = projectService.getDataType(reward.price);
                    
                %>
                <div class="list-group-item">
                    <h4 class="list-group-item-heading">${reward.title}</h4>
                    <h5 class="list-group-item-heading lead">$${price}</h5>
                    <p class="list-group-item-text text-justify">${reward.description}</p>
                    <p class="list-group-item-text text-justify">${backers} backer(s)</p>
                </div>
            </g:each>
        </div>
    </div>
</div>

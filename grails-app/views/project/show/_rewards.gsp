<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    boolean isFundingOpen = projectService.isFundingOpen(project)
%>
<div class="panel panel-default" style="margin-top: 30px;">
    <div class="panel-heading">
        <g:if test="${isFundingOpen}">
            <h3 class="panel-title">Fund this project</h3>
        </g:if>
        <g:else>
            <h3 class="panel-title">Funding closed</h3>
        </g:else>
    </div>
    <div class="panel-body">
        <div class="list-group">
            <g:each in="${project.rewards}" var="reward">
                <%
                    def backers = contributionService.getBackersForProjectByReward(project, reward);
                %>
                <g:if test="${isFundingOpen}">
                    <g:link absolute="true" uri="/projects/${project.id}/fund" class="list-group-item">
                        <h4 class="list-group-item-heading">${reward.title}</h4>
                        <h5 class="list-group-item-heading lead">$${reward.price}</h5>
                        <p class="list-group-item-text text-justify">${reward.description}</p>
                        <p class="list-group-item-text text-justify">${backers} backer(s)</p>
                    </g:link>
                </g:if>
                <g:else>
                    <div class="list-group-item">
                        <h4 class="list-group-item-heading">${reward.title}</h4>
                        <h5 class="list-group-item-heading lead">$${reward.price}</h5>
                        <p class="list-group-item-text text-justify">${reward.description}</p>
                        <p class="list-group-item-text text-justify">${backers} backer(s)</p>
                    </div>
                </g:else>
            </g:each>
        </div>
    </div>
</div>

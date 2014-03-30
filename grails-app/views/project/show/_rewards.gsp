<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
    def endDate = projectService.getProjectEndDate(project)
    boolean ended = projectService.isProjectEnded(project)

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<div class="panel panel-default" style="margin-top: 30px;">
    <div class="panel-heading">
        <h3 class="panel-title">Fund this project</h3>
    </div>
    <div class="panel-body">
        <g:if test="${percentage == 100}">
            <button type="button" class="btn btn-success btn-block" disabled>SUCCESSFULLY FUNDED</button>
        </g:if>
        <g:elseif test="${ended}">
            <button type="button" class="btn btn-warning btn-block" disabled>PROJECT ENDED!</button>
            <h4>Ended on ${dateFormat.format(endDate.getTime())}</h4>
        </g:elseif>
        <g:else>
            <%-- <h4>Ends on ${dateFormat.format(endDate.getTime())}</h4> --%>

            <div class="list-group">
                <g:each in="${project.rewards}" var="reward">
                    <%
                        def backers = contributionService.getBackersForProjectByReward(project, reward);
                    %>
                    <g:link absolute="true" uri="/projects/${project.id}/fund" class="list-group-item">
                        <h4 class="list-group-item-heading">${reward.title}</h4>
                        <h5 class="list-group-item-heading lead">$${reward.price}</h5>
                        <p class="list-group-item-text text-justify">${reward.description}</p>
                        <p class="list-group-item-text text-justify">${backers} backer(s)</p>
                    </g:link>
                </g:each>
            </div>
        </g:else>
    </div>
</div>

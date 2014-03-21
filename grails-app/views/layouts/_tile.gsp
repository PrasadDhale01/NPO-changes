<%--
Expects the parent containers to be like so:
<div class="row">
    <ul class="thumbnails list-unstyled">
        ... /layouts/tile ...
    </ul>
</div>
--%>
<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
    def achievedDate
    if (percentage == 100) {
        achievedDate = contributionService.getFundingAchievedDate(project)
    }
    def endDate = projectService.getProjectEndDate(project)
    boolean ended = projectService.isProjectEnded(project)

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<li class="col-xs-6 col-md-3">
    <div class="thumbnail" style="padding: 0">
        <div style="height: 200px; overflow: hidden;" class="blacknwhite">
            <g:if test="${project.imageUrl}">
                <img alt="${project.title}" style="width: 100%;" src="${project.imageUrl}">
            </g:if>
            <g:elseif test="${project.image}">
                <img alt="${project.title}" style="width: 100%;" src="${createLink(controller: 'project', action: 'thumbnail', id: project.id)}">
            </g:elseif>
            <g:else>
                <img alt="${project.title}" style="width: 100%;" src="http://lorempixel.com/400/400/abstract">
            </g:else>
        </div>

        <div class="caption">
            <h4><g:link controller="project" action="show" id="${project.id}" title="${project.title}"><div>${project.title}</div></g:link></h4>
            <p>${project.name}</p>
            <!-- <p><i class="icon icon-map-marker"></i>Place, Country</p> -->
        </div>

        <div class="modal-footer" style="text-align: left; margin-top: 0;">
            <div class="row">
                <div class="col-md-6">GOAL<br/><b>$${project.amount}</b></div>
                <g:if test="${ended}">
                    <g:if test="${percentage == 100}">
                        <div class="col-md-6">ACHIEVED<br><b>${dateFormat.format(achievedDate.getTime())}</b></div>
                    </g:if>
                    <g:else>
                        <div class="col-md-6">ENDED<br><b>${dateFormat.format(endDate.getTime())}</b></div>
                    </g:else>
                </g:if>
                <g:else>
                    <div class="col-md-6">ENDING<br><b>${dateFormat.format(endDate.getTime())}</b></div>
                </g:else>
            </div>
        </div>
        <div class="progress">
            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;">
                <!-- <span class="sr-only">${percentage}% Complete</span> -->
                ${percentage}%
            </div>
        </div>
    </div>
</li>

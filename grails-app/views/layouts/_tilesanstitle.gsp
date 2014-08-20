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
    boolean ended = projectService.isProjectDeadlineCrossed(project)
    def isFundingOpen = projectService.isFundingOpen(project)
    def contributedSoFar = contributionService.getTotalContributionForProject(project)

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
    <div class="fedu thumbnail" style="padding: 0; margin-top: 30px;">
        <div style="height: 200px; overflow: hidden;" class="blacknwhite">
            <img alt="${project.title}" style="width: 100%;" src="${projectService.getProjectImageLink(project)}">
        </div>

        <div class="modal-footer" style="text-align: left; margin-top: 0;">
            <div class="row">
                <div class="col-md-4">
                    <h6 class="text-center">GOAL<br/><span class="lead">$${project.amount}</span></h6>
                </div>
		<div class="col-md-4">
                    <h6 class="text-center">ACHIEVED<br/><span class="lead">$${contributedSoFar}</span></h6>
                </div>
	        <g:if test="${ended}">
                    <g:if test="${percentage == 100}">
                        <div class="col-md-4">
                            <h6 class="text-center">ACHIEVED<br><span class="lead">${dateFormat.format(achievedDate.getTime())}</span></h6>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="col-md-4">
                            <h6 class="text-center">ENDED<br><span class="lead">${dateFormat.format(endDate.getTime())}</span></h6>
                        </div>
                    </g:else>
                </g:if>
                <g:else>
                    <div class="col-md-4">
                        <h6 class="text-center">ENDING<br><span class="lead">${dateFormat.format(endDate.getTime())}</span></h6>
                    </div>
                </g:else>
            </div>
            <div class="row">
                <% if(!(percentage == 100)) { %>
                <form action="edit" method="post" >
                    <g:hiddenField name="projectId" value="${project.id}"/>               
	            <button class="edit close"  aria-label="Edit project">
                        <i class="glyphicon glyphicon-edit"></i>
                    </button>
                </form>
                <% } %>
            </div>
        </div>
        <g:if test="${isFundingOpen}">
            <div class="progress progress-striped active">
                <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;">
                    ${percentage}%
                </div>
            </div>
        </g:if>
        <g:else>
            <div class="progress">
                <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;">
                    ${percentage}%
                </div>
            </div>
        </g:else>
    </div>

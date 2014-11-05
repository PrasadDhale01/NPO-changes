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
    def day= projectService.getRemainingDay(project)

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
    <div class="fedu thumbnail" style="padding: 0; margin-top: 30px;">
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
                            <h6 class="text-center">ENDED</h6>
                        </div>
                    </g:else>
                </g:if>
                <g:else>
                    <div class="col-md-4">
                        <h6 class="text-center">DAYS TO GO<br><span class="lead">${day}</span><br></h6>
                    </div>
                </g:else>
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

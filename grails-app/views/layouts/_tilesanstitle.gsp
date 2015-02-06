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
    def contribution = projectService.getDataType(contributedSoFar)
    def amount = projectService.getDataType(project.amount)

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<div class="fedu thumbnail" style="padding: 0; margin-top: 30px;">
    <div class="modal-footer tile-footer" style="text-align: left; margin-top: 0px; margin-bottom: 2px;">
        <div class="row">
            <div class="col-md-5 col-md-offset-1 col-xs-5 col-xs-offset-1 col-sm-4 col-sm-offset-2 progress-pie-chart" data-percent="43">
				<div class="c100 p${percentage} small text-center">
                    <span>${percentage}%</span>
                    <div class="slice">
                        <div class="bar"></div>
                        <div class="fill"></div>
                    </div>
                </div>
            </div>
            <g:if test="${isFundingAchieved}">
				<div class="col-md-6 col-xs-6">
					<h6 class="text-center" style="margin-top: 10px;">
						<span class="lead">$${contribution}</span><br />ACHIEVED
					</h6>
				</div>
			</g:if>
			<g:else>
			    <div class="col-md-6 col-xs-6">
					<h6 class="text-center" style="margin-top: 10px;">
						<span class="lead">$${contribution}</span><br />RAISED
					</h6>
				</div>
			</g:else>
        </div>
    </div>
    <div class="modal-footer tile-footer" style="text-align: left; margin-top: 0; margin-bottom: 2px;">
        <div class="row">
            <div class="col-md-6 col-xs-6">
                <h6 class="text-center"><span class="lead">$${amount}</span><br/>GOAL</h6>
            </div>
            <g:if test="${ended}">
                <div class="col-md-6 col-xs-6">
                    <h6 class="text-center"><span class="lead">0</span><br>DAYS TO GO</h6>
                </div>
            </g:if>
            <g:else>
                <!-- Time left till end date. -->
                <div class="col-md-6 col-xs-6">
                    <h6 class="text-center"><span class="lead">${projectService.getRemainingDay(project)}</span><br>DAYS TO GO</h6>
                </div>
            </g:else>
        </div>
    </div>

</div>

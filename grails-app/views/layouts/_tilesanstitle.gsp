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
	<div class="modal-footer tile-footer" style="text-align: left; margin-bottom: 2px; margin-top:0;">
	    <div class="row">
	    	<div class="project-pie-chart">
	        <div class="progress-pie-chart" data-percent="43">
	            <div class="c100 p${percentage} small text-center">
	                <span>${percentage}%</span>
	                <div class="slice">
	                    <div class="bar"></div>
	                    <div class="fill"></div>
	                </div>
	            </div>
	        </div>
	        </div>
	        <div class="project-achieved">
	            <h6 class="text-center" style="margin-top: 10px;"><span class="lead">$${contribution}</span><br/>ACHIEVED</h6>
	        </div>
	    </div>
	</div>
	
	<div class="modal-footer tile-footer" style="text-align: left; margin-top: 0;">
	    <div class="row">
	    	<div class="project-goal">
	            <h6 class="text-center"><span class="lead">$${amount}</span><br/>GOAL</h6>
	        </div><div class="project-end-date">
	        <g:if test="${ended}">
	            <g:if test="${isFundingAchieved}">
	                <!-- Funding achieved in time. -->
	                
	                    <h6 class="text-center"><span class="lead">${dateFormat.format(achievedDate.getTime())}</span><br>ACHIEVED</h6>
	                
	            </g:if>
	            <g:else>
	                <!-- Funding not achieved in time. -->
	                
	                    <h6 class="text-center"><span class="lead">${dateFormat.format(endDate.getTime())}</span><br>ENDED</h6>
	                
	            </g:else>
	        </g:if>
	        <g:else>
	            <!-- Time left till end date. -->
	            
	                <h6 class="text-center"><span class="lead">${projectService.getRemainingDay(project)}</span><br>DAYS TO GO</h6>
	            
	        </g:else></div>
	    </div>
	</div>

</div>

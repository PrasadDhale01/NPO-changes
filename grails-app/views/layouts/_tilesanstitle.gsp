<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    def percentage
    def contributedSoFar
    def amount
    if (project.user == currentFundraiser){
        percentage = contributionService.getPercentageContributionForProject(project)
        contributedSoFar = contributionService.getTotalContributionForProject(project)
        amount = projectService.getDataType(project.amount)
    } else {
        percentage = contributionService.getPercentageContributionForTeam(currentTeam)
        contributedSoFar = teamContribution
        amount = currentTeamAmount
    }
    def achievedDate
    if (percentage == 100) {
	achievedDate = contributionService.getFundingAchievedDate(project)
    }
    def endDate = projectService.getProjectEndDate(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
    def isFundingOpen = projectService.isFundingOpen(project)
    def day= projectService.getRemainingDay(project)
    def cents
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    username = currentFundraiser.email
%>

<%--<div class="fedu thumbnail tilesanstitle-achived-ended">--%>
<%--    <div class="modal-footer tile-footer tilesanstitle-footered">--%>
<%--        <div class="row tilepadding">--%>
            
<%--            <g:if test="${isFundingAchieved}">--%>
<%--				<div class="col-md-6 col-xs-6">--%>
<%--					<h6 class="text-center tilesanstitle-achived">--%>
<%--						<span class="lead">$${contributedSoFar}</span><br />ACHIEVED--%>
<%--					</h6>--%>
<%--				</div>--%>
<%--			</g:if>--%>
<%--			<g:else>--%>
<%--			    <div class="col-md-6 col-xs-6">--%>
<%--					<h6 class="text-center tilesanstitle-raised">--%>
<%--						<span class="lead">$${contributedSoFar}</span><br />RAISED--%>
<%--					</h6>--%>
<%--				</div>--%>
<%--			</g:else>--%>
<%--        </div>--%>
<%--    </div>--%>
    <div class="modal-footer tile-footer tileanstitle-goals">
        <div class="row tilepadding">
           <div class="manage-tiles">
                <div class="col-md-5 col-xs-5">
                    <h5 class="text-center tile-goal"><span class="lead">$${amount}</span><br/><p class="tile-text-size">GOAL</p></h5>
                </div>
            </div>
             <div class="col-md-3 col-md-offset-1 col-sm-3 col-sm-offset-2 col-xs-3 col-xs-offset-2 progress-pie-chart" data-percent="43">
				<div class="c100  p${cents} pie-tile pie-css text-center mobile-pie">
                    <span class="c999">${percentage}%</span>
                     <div class="slice">
                         <div class="bar"></div>
                         <div class="fill"></div>
                     </div>
                 </div>
             </div>
            <g:if test="${ended}">
                <div class="col-md-3 col-xs-3">
                    <h6 class="text-center"><span class="lead">0</span><br><p class="tile-text-size">DAYS TO GO</p></h6>
                </div>
            </g:if>
            <g:else>
                <!-- Time left till end date. -->
                <div class="manage-tileanstitle">
	               <div class="col-md-3 col-xs-3">
	                   <h6 class="text-center"><span class="lead">${projectService.getRemainingDay(project)}</span><br><p class="tile-text-size">DAYS TO GO</p></h6>
	               </div>
               </div> 
            </g:else>
        </div>
    </div>
    
<g:if test="${validatedPage}">
    <g:render template="/layouts/personaldetails" model="['currentFundraiser':currentFundraiser,'username':username, 'project':project]"/>
</g:if>

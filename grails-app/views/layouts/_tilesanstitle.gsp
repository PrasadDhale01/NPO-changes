<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    def percent
    def contributedSoFar
    def amount
    if (project.user == currentFundraiser){
        percent = percentage
        contributedSoFar = totalContribution
        amount = project.amount.round()
    } else {
        percent = teamPercentage
        contributedSoFar = teamContribution
        amount = currentTeamAmount.round()
    }
    def achievedDate
    if (percent == 100) {
        achievedDate = contributionService.getFundingAchievedDate(project)
    }
    def cents
    if(percent >= 100) {
        cents = 100
    } else {
        cents = percent
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    username = currentFundraiser.email
%>
<div class="modal-footer tile-footer tileanstitle-goals">
    <div class="row tilepadding">
        <div class="manage-tiles">
            <div class="col-md-5 col-xs-5">
                <h5 class="text-center tile-goal"><span class="lead">$${amount}</span><br/><p class="tile-text-size">GOAL</p></h5>
            </div>
        </div>
        <div class="col-md-3 col-md-offset-1 col-sm-3 col-sm-offset-2 col-xs-3 col-xs-offset-2 progress-pie-chart" data-percent="43">
            <div class="c100  p${cents} pie-tile pie-css text-center mobile-pie">
                <span class="c999">${percent}%</span>
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
                    <h6 class="text-center"><span class="lead">${day}</span><br><p class="tile-text-size">DAYS TO GO</p></h6>
                </div>
            </div> 
        </g:else>
    </div>
</div>
    
<g:if test="${validatedPage}">
    <g:render template="/layouts/personaldetails"/>
</g:if>

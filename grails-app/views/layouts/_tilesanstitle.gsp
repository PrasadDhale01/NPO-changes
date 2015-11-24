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
    
    def cents
    if(percent >= 100) {
        cents = 100
    } else {
        cents = percent
    }
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    username = currentFundraiser.email
    
    def currentEnv = projectService.getCurrentEnvironment()
    def conversionMultiplier = multiplier
    if (!conversionMultiplier) {
        conversionMultiplier = projectService.getCurrencyConverter();
    }
    
%>
<div class="modal-footer tile-footer tileanstitle-goals tileanstitle-goal-margin organization-panel">
    <div class="row icons-centering">
        <div class="col-xs-4 col-sm-4 col-md-4 goalIcon">
            <img src="//s3.amazonaws.com/crowdera/assets/goal-icon.png" alt="Goal-Icon">
        </div>
        <div class="col-xs-4 col-sm-4 col-md-4 progress-pie-chart show-contri-tile progressBarIcon" data-percent="43">
            <div class="c100  p${cents} pie-tile pie-css text-center mobile-pie">
                <span class="c999">${percent}%</span>
                <div class="slice">
                    <div class="bar progressBar"></div>
                    <div class="fill progressBar"></div>
                </div>
            </div>
        </div>
        <div class="col-xs-4 col-sm-4 col-md-4 daysleftIcon">
            <img src="//s3.amazonaws.com/crowdera/assets/timeleft.png" alt="daysleft-icon">
        </div>
    </div>
    <div class="row amount-centering">
        <div class="col-xs-4 col-sm-4 col-md-4 amount-alignment amount-text-align text-center">
            <span class="text-center tile-goal show-contribution-amt-tile">
                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><span class="lead show-contribution-amt-tile">${amount}</span></g:if><g:else><span class="lead show-contribution-amt-tile">${amount * conversionMultiplier}</span></g:else>
                </g:if>
                <g:else>
                    $<span class="lead show-contribution-amt-tile">${amount}</span>
                </g:else>
            </span>
        </div>
        <div class="col-md-4 col-xs-4 amount-alignment contribution-border amount-text-align text-center">
            <span class="text-center tile-goal show-contribution-amt-tile">
                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><span class="lead show-contribution-amt-tile">${contributedSoFar}</span></g:if><g:else><span class="lead show-contribution-amt-tile">${contributedSoFar * conversionMultiplier}</span></g:else>
                </g:if>
                <g:else>
                    $<span class="lead show-contribution-amt-tile">${contributedSoFar}</span>
                </g:else>
            </span>
        </div>
        
        <g:if test="${ended}">
            <div class="col-md-4 col-sm-4 col-xs-4 show-tile-text-size contribution-tile show-contribution-amt-tile">
                <span class="days-alignment show-contribution-amt-tile ">DAYS<br>LEFT</span>
                <span class="tile-day-num show-contribution-amt-tile ">00</span>
            </div>
        </g:if>
        <g:else>
            <div class="col-md-4 col-sm-4 col-xs-4 show-tile-text-size contribution-tile show-contribution-amt-tile">
               <span class="days-alignment">DAYS<br>LEFT</span>
               <g:if test="${day > 0 && day < 10 }">
                    <span class="tile-day-num show-contribution-amt-tile ">0${day}</span>
               </g:if>
               <g:else>
                    <span class="tile-day-num show-contribution-amt-tile ">${day}</span>
               </g:else>
           </div>
        </g:else>
    </div>
</div>

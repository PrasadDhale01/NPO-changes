<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    def percent
    def contributedSoFar
    def amount
    if (project.user == currentFundraiser || isCampaignOwnerOrAdmin || isAdmin){
        percent = percentage
        contributedSoFar = totalContribution
        amount = project?.amount.round()
    } else {
        percent = teamPercentage
        contributedSoFar = teamContribution
        amount = currentTeamAmount?.round()
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
	def country = projectService.getCountryForProject(project)
	def currencyValue = projectService.getCurrencyByCountryId(country)
	def country_code = projectService.getCountryCodeForCurrentEnv(request)
	
%>
<div class="modal-footer tile-footer tileanstitle-goals tileanstitle-goal-margin show-tiles-padding new-show-height new-tab-orgTile">
<%--    <div class="row icons-centering sh-moballamt">--%>
        <div class="col-lg-12 col-sm-12 col-md-12 show-org-tile-padding raised-goal-toppadding" data-percent="43">
            <div class="col-lg-4 col-sm-4 col-md-4 show-progressbar goal-icon-padding">
                <div class="c100  p${cents} pie-tile pie-css text-center mobile-pie">
                    <span class="c999">${percent}%</span>
                    <div class="slice">
                        <div class="bar progressBar"></div>
                        <div class="fill progressBar"></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-8 col-sm-8 col-md-8 sh-width-control gau-new-color">
                <span class="show-tile-raised amount-left-padding">Raised</span><br>
                <span class="show-raised-amt amount-left-padding show-contribution-amt-tile">
<%--                    <g:if test="${country_code == 'in'}">--%>
<%--                        <!--  <span class="fa fa-inr"></span>-->--%>
<%--                        ${currencyValue}--%>
<%--                        	<span class="lead show-contribution-amt-tile">--%>
<%--                        		<g:if test="${payuStatus}">${contributedSoFar}</g:if>--%>
<%--                        		<g:else>${contributedSoFar}</g:else>--%>
<%--                        	</span>--%>
<%--                    </g:if>--%>
                       <span class="show-raised-amt show-contribution-amt-tile"> ${currencyValue}${contributedSoFar}</span>
                </span>
            </div>
        </div>
        <div class="col-lg-12 col-sm-12 col-md-12 show-org-tile-padding raised-goal-toppadding">
           
            <div class="col-lg-4 col-sm-4 col-md-4 show-goal-padding goal-icon-padding">
                <img class="show-goal-size" src="//s3.amazonaws.com/crowdera/assets/tile-goal-icon.png" alt="Goal-Icon">
            </div>
            
            <div class="col-lg-8 col-sm-8 col-md-8 sh-width-control gau-new-color">
                 <span class="show-tile-raised amount-left-padding">Goal</span><br>
                <span class="show-raised-amt amount-left-padding">
<%--                    <g:if test="${country_code == 'in'}">--%>
<%--                       <!--  <span class="fa fa-inr"></span>-->--%>
<%--                       ${currencyValue}--%>
<%--                        <span class="">--%>
<%--	                        <g:if test="${payuStatus}">${amount}</g:if>--%>
<%--	                        <g:else>${amount * conversionMultiplier}</g:else>--%>
<%--                       </span>--%>
<%--                    </g:if>--%>
                        <span class="show-raised-amt">${currencyValue}${amount}</span>
                </span>
            </div>
        </div>
        
        <div class="col-lg-12 col-sm-12 col-md-12 show-org-tile-padding raised-goal-toppadding">
            <div class="col-lg-4 col-sm-4 col-md-4 show-time-day-padding days-new-padding">
                <img class="show-timeday-size" src="//s3.amazonaws.com/crowdera/assets/timeleft.png" alt="daysleft-icon">
            </div>
            
            <div class="col-lg-8 col-sm-8 col-md-8 sh-width-control gau-new-color">
                <g:if test="${ended}">
                    <span class="show-tile-raised amount-left-padding">Days Left</span><br>
                    <span class=" show-contribution-amt-tile show-raised-amt amount-left-padding">00</span>
                 </g:if>
                 <g:else>
                     <span class="show-tile-raised amount-left-padding">Days Left</span><br>
                     <g:if test="${day > 0 && day < 10 }">
                         <span class="show-raised-amt show-contribution-amt-tile amount-left-padding show-raised-amt">0${day}</span>
                     </g:if>
                     <g:else>
                         <span class="show-raised-amt show-contribution-amt-tile amount-left-padding show-raised-amt">${day}</span>
                     </g:else>
           
                 </g:else>
            </div>
        </div>
        
        
<%--    </div>--%>
    
</div>

<g:if test="${validatedPage}">
    <g:render template="/layouts/personaldetails"/>
</g:if>

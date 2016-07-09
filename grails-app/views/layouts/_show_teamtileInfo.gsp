<%
    def percent
    def contributedSoFar
    def amount
    if (project.user == currentFundraiser){
        percent = percentage
        contributedSoFar = totalContribution
        amount = project?.amount.round()
    } else {
        percent = teamPercentage
        contributedSoFar = teamContribution
        amount = currentTeamAmount?.round()
    }
%>

<div class="col-lg-12 col-sm-12 col-md-12 panel-body panel-bgColor text-center">
     <div class="col-lg-12 show-raised-amt">
         <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
              <span class="fa fa-inr"></span><span class="lead show-contribution-amt-tile"><g:if test="${project.payuStatus}">${contributedSoFar}</g:if><g:else>${contributedSoFar * conversionMultiplier}</g:else></span>
         </g:if>
         <g:else>
              $<span class="show-raised-amt show-contribution-amt-tile">${contributedSoFar}</span>
         </g:else>
     </div>
     <span class="col-lg-12 col-sm-12 col-md-12 show-funds-padding">Funds Raised</span>
</div>

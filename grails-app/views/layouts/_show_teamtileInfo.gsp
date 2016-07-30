<%
    def percent
    def contributedSoFar
    def amount
    if (currentFundraiser){
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
     <br>
     <div class="show-contact-teamtile">
         <g:if test="${project.beneficiary.telephone}">
             <span class="col-lg-12 col-sm-12 col-md-12 show-teams-padding">${project.beneficiary.telephone}</span>
         </g:if>
         <span class="col-lg-12 col-sm-12 col-md-12">Palo Alto, California, US</span>
    </div>
    
</div>
<g:if test="${!isTeamExist && project.validated}">
        <g:if test="${!ended}">
            <g:form controller="project" action="addTeam" id="${project.id}">
                <button type="submit" value="Join our Team" class="col-lg-12 col-sm-12 col-md-12 text-center btn btn-block show-join-our-team"><span class="show-title-jointeam">Join our Team </span><br> <span class="show-sub-titleJointeam"> To Fundraise for us</span></button>
                <span></span>
            </g:form> 
         </g:if>
         <g:else>
             <button type="submit" value="Join our Team" class=" col-lg-12 col-sm-12 col-md-12 text-center btn btn-block show-join-our-team">Join our Team <br> <span class="show-sub-titleJointeam"> To Fundraise for us</span></button>
             <span>To Fundraise for us</span>
         </g:else>
         
    </g:if>
    
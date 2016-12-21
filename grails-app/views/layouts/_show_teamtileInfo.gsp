<div class="col-lg-12 col-sm-12 col-md-12 panel-body panel-bgColor text-center">
     <div class="col-lg-12 show-raised-amt">
         <g:if test="${country_code == 'in'}">
              <span class="fa fa-inr"></span><span class="lead show-contribution-amt-tile"><g:if test="${project.payuStatus}">${contributedSoFar}</g:if><g:else>${contributedSoFar}</g:else></span>
         </g:if>
         <g:else>
              $<span class="show-raised-amt show-contribution-amt-tile">${contributedSoFar}</span>
         </g:else>
     </div>
     <span class="col-lg-12 col-sm-12 col-md-12 show-funds-padding">Funds Raised</span>
     <br>
     <div class="show-contact-teamtile">
         <div class="col-lg-12 col-sm-12 col-md-12 locationandtelephone">
             <g:if test="${project.beneficiary.telephone}">
                 <img class="telephone-icons col-lg-4 col-sm-4 col-md-4" src="//s3.amazonaws.com/crowdera/assets/e95db1c4-b5a1-4437-8d1d-9cc41d578bab.png">
                 <span class="col-lg-8 col-sm-8 col-md-8 show-teams-padding">${project.beneficiary.telephone}</span>
             </g:if>
         </div>
         <div class="col-lg-12 col-sm-12 col-md-12 locationandtelephone location-icon-mob">
             <img class="location-icon col-lg-4 col-sm-4 col-md-4" src="//s3.amazonaws.com/crowdera/assets/c9a2645e-0a60-41f0-9f9d-53295a878981.png">
             <g:if test="${country_code == 'in'}">
                  <span class="col-lg-8 col-sm-8 col-md-8">206, Sankalp Nagar,Wathoda layout, Nagpur, Maharashtra, India</span>
             </g:if>
             <g:else>
                  <span class="col-lg-8 col-sm-8 col-md-8">Palo Alto, California, US</span>
             </g:else>
         </div>
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
    
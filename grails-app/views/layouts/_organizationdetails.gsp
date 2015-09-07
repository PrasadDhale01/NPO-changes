<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<% 
    def beneficiary = project.user
%>
<div class="panel panel-default">
    <div class="panel-heading panel-css">
        <g:if test="${currentFundraiser == beneficiary}">
            Campaign by ${beneficiary.firstName} ${beneficiary.lastName}
        </g:if>
        <g:else>
            Benefiting ${beneficiary.firstName} ${beneficiary.lastName}
        </g:else>
    </div>

   	<div class="organization-details text-center">
   		<br><br>
   	    <h4><label class="col-sm-12"><b>${project.organizationName}</b></label></h4>
   	    <g:if test="${!isCrFrCampBenOrAdmin}">
   	    	<g:if test="${currentTeam.user.userImageUrl}">
   	        	<div class="col-sm-12">
   	            	<img alt="Organization" src="${currentTeam.user.userImageUrl}" class="org-logo">
            	</div>
        	</g:if>
        	<g:else>
            	<div class="col-sm-12">
   	            	<img alt="Upload Icon" src="//s3.amazonaws.com/crowdera/assets/defaultOrgIcon.jpg" class="org-logo">
            	</div>
        	</g:else>
   	    </g:if>
   	    <g:elseif test="${project.organizationIconUrl}">
   	        <div class="col-sm-12">
   	            <img alt="Organization" src="${project.organizationIconUrl}" class="org-logo">
            </div>
        </g:elseif>
        <g:else>
            <div class="col-sm-12">
   	            <img alt="Upload Icon" src="//s3.amazonaws.com/crowdera/assets/defaultOrgIcon.jpg" class="org-logo">
            </div>
        </g:else>
        
        <g:if test="${project.webAddress}">
            <div class="col-sm-12 web-links">
                <label>Web: <a href="${webUrl}" target="${webUrl}">${project.webAddress}</a></label>
            </div>
        </g:if>
        
        <div class="col-sm-12">
            <label><a href="#"></a></label>
        </div> 
        <div class="clear"></div>
        
        <div class="tilesanstitletag">
            <g:if test="${project.draft}">
                <img src="//s3.amazonaws.com/crowdera/assets/Draft-tag.png" alt="draft"/>
	        </g:if>
	        <g:elseif test="${project.rejected}">
	            <img src="//s3.amazonaws.com/crowdera/assets/Rejected-tag.png" alt="rejected"/>
	        </g:elseif>
            <g:elseif test="${!project.validated}">
	            <img src="//s3.amazonaws.com/crowdera/assets/Pending-tag.png" alt="validated"/>
	        </g:elseif>
	        <g:elseif test="${ended}">
	            <img src="//s3.amazonaws.com/crowdera/assets/ended-tag.png" alt="ended"/>
	        </g:elseif>
	        <g:elseif test="${percentage >= 75}">
				<img src="//s3.amazonaws.com/crowdera/assets/Funded-Tag.png" alt="funded"/>
		    </g:elseif>
		    <g:elseif test="${isCampaignAdmin}">
                <img src="//s3.amazonaws.com/crowdera/assets/Co-owner-tag.png" alt="CO-OWNER"/>
            </g:elseif>
	        <g:elseif test="${isEnabledTeamExist}">
	            <g:if test="${currentFundraiser == beneficiary}">
					<img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="Owner"/>
	            </g:if>
	            <g:else>
					<img src="//s3.amazonaws.com/crowdera/assets/Team-tag.png" alt="team"/>
	            </g:else>
	        </g:elseif>
	    </div>
    </div>
</div>

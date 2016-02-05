<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
    def beneficiary = project.user
%>
<div class="panel panel-default TW-org-panel-height manage-org-bottomMargin">
   	<div class="manage-organization-details text-center manage-org-title manage-org-height">
   		<br><br>
   	    <h4><b class="TW-org-title-font-size-manage">${project.organizationName}</b></h4>
        
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
            <g:elseif test="${project.onHold}">
                <img src="//s3.amazonaws.com/crowdera/assets/on-hold.png" alt="On Hold">
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

<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<% 
    def beneficiary = project.user
    boolean ended = projectService.isProjectDeadlineCrossed(project)
    def isteamexist = userService.isTeamEnabled(project, currentFundraiser) 
    def webUrl = projectService.getWebUrl(project)
    def percentage = contributionService.getPercentageContributionForProject(project)
    def isCampaignAdmin = userService.isCampaignAdmin(project, username)
%>
<div class="panel panel-default">
    <div class="panel-heading panel-css">
    <g:if test="${currentFundraiser == beneficiary}">
   	    Campaign by ${beneficiary.firstName} ${beneficiary.lastName}
   	</g:if>
   	<g:else>
   	    Benefiting ${beneficiary.firstName} ${beneficiary.lastName}
   	</g:else>
<%--        <g:if test="${isFundingOpen}">--%>
<%--            <h3 class="panel-title">Fund this project</h3>--%>
<%--        </g:if>--%>
<%--        <g:else>--%>
<%--            <h3 class="panel-title">Funding closed</h3>--%>
<%--        </g:else>--%>
    </div>
<%--<div class="blacknwhite" style="height: 100%; width: 100%; overflow: hidden; width: 100%;padding: 0; margin-top: 30px;">--%>
<%--	<label class="col-sm-12" style="margin-top:10px"><h3>Project By</h3></label>--%>
   	<div class="organization-details text-center">
   	    <label class="col-sm-12"><h4><b>${project.organizationName}</b></h4></label>
   	    <g:if test="${project.organizationIconUrl}">
   	        <div class="col-sm-12">
   	            <img alt="Organization" src="${project.organizationIconUrl}" class="org-logo"/>
            </div>
        </g:if>
        <g:else>
            <div class="col-sm-12">
   	            <img alt="Upload Icon" src="//s3.amazonaws.com/crowdera/assets/defaultOrgIcon.jpg" class="org-logo"/>
            </div>
        </g:else>
        <div class="col-sm-12">
        <label>Web: <a href="${webUrl}" target="${webUrl}">${project.webAddress}</a></label>
        </div>
        <div class="col-sm-12">
        <label><a href="#"></a></label>
        </div> 
        <div class="clear"></div>
        <div class="tilesanstitletag banner-wid">
            <g:if test="${project.draft}">
                <img src="//s3.amazonaws.com/crowdera/assets/DRAFT1.png" alt="draft"/>
	        </g:if>
	        <g:elseif test="${project.rejected}">
	            <img src="//s3.amazonaws.com/crowdera/assets/Rejected1.png" alt="rejected"/>
	        </g:elseif>
            <g:elseif test="${!project.validated}">
	            <img src="//s3.amazonaws.com/crowdera/assets/PENDING1.png" alt="validated"/>
	        </g:elseif>
	        <g:elseif test="${ended}">
	            <img src="//s3.amazonaws.com/crowdera/assets/ended1.png" alt="ended"/>
	        </g:elseif>
	        <g:elseif test="${percentage >= 75}">
				<img src="//s3.amazonaws.com/crowdera/assets/funded.png" alt="funded"/>
		    </g:elseif>
		    <g:elseif test="${isCampaignAdmin}">
                <img src="//s3.amazonaws.com/crowdera/assets/Co-Owner.png" alt="CO-OWNER"/>
            </g:elseif>
	        <g:elseif test="${isteamexist}">
	            <g:if test="${currentFundraiser == beneficiary}">
					<img src="//s3.amazonaws.com/crowdera/assets/Owner-Bottom.png" alt="Owner"/>
	            </g:if>
	            <g:else>
					<img src="//s3.amazonaws.com/crowdera/assets/teamBottom.png" alt="team"/>
	            </g:else>
	        </g:elseif>
	    </div>
    </div>
</div>

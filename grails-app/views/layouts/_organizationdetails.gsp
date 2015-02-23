<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<% 
    def beneficiary = project.user
	boolean ended = projectService.isProjectDeadlineCrossed(project)
	def currentUser = userService.getCurrentUser()
	def isteamexist = userService.isTeamAlreadyExist(project, currentUser)
    def webUrl = projectService.getWebUrl(project)
	def percentage = contributionService.getPercentageContributionForProject(project)
%>
<div class="panel panel-default">
    <div class="panel-heading">
   		Campaign by ${beneficiary.firstName} ${beneficiary.lastName}
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
   	            <img alt="" src="${project.organizationIconUrl}" class="org-logo">
            </div>
        </g:if>
        <g:else>
            <div class="col-sm-12">
   	            <img alt="Upload Icon" src="/images/defaultOrgIcon.jpg" class="org-logo">
            </div>
        </g:else>
        <div class="col-sm-12">
        <label>Email: ${beneficiary.email}</label>
        </div>
        <div class="col-sm-12">
        <label>Web: <a href="${webUrl}">${project.webAddress}</a></label>
        </div> 
        <div class="clear"></div>
        <g:if test="${project.draft}">
            <div class="tilesanstitletag banner-wid">
                <img src="/images/DRAFT1.png">
            </div>
	    </g:if>
	    <g:elseif test="${project.rejected}">
	        <div class="tilesanstitletag  banner-wid">
	            <img src="/images/Rejected1.png">
	        </div>
	    </g:elseif>
        <g:elseif test="${!project.validated}">
	        <div class="tilesanstitletag  banner-wid">
	            <img src="/images/PENDING1.png">
	        </div>
	    </g:elseif>
	     <g:elseif test="${ended}">
	        <div class="tilesanstitletag  banner-wid">
	            <img src="/images/ended1.png">
	        </div>
	    </g:elseif>
	    <g:elseif test="${percentage >= 75}">
			<div class="tilesanstitletag  banner-wid">
				<img src="/images/funded.png">
			</div>
		</g:elseif>
	    <g:elseif test="${isteamexist}">
	        <g:if test="${currentUser == beneficiary}">
	            <div class="tilesanstitletag  banner-wid">
					<img src="/images/Owner-Bottom.png">
				</div>
	        </g:if>
	        <g:else>
	            <div class="tilesanstitletag  banner-wid">
					<img src="/images/teamBottom.png">
				</div>
	        </g:else>
	    </g:elseif>
    </div>
</div>

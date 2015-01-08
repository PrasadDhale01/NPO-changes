<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<% 
    def user = project.user
	boolean ended = projectService.isProjectDeadlineCrossed(project)
%>
<div class="panel panel-default">
    <div class="panel-heading">
   		Campaign by
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
   	            <img alt="Upload Icon" src="/images/uploadIcon.jpg" class="org-logo">
            </div>
        </g:else>
        <label class="col-sm-12">WEB: <a href="${project.webAddress}">${project.webAddress}</a></label>
        <div class="clear"></div>
        <g:if test="${project.draft}">
            <div class="tilesanstitletag">
                <img src="/images/DRAFT1.png" width="100">
            </div>
	    </g:if>
	    <g:elseif test="${project.rejected}">
	        <div class="tilesanstitletag">
	            <img src="/images/Rejected1.png" width="100">
	        </div>
	    </g:elseif>
        <g:elseif test="${!project.validated}">
	        <div class="tilesanstitletag">
	            <img src="/images/PENDING1.png" width="100">
	        </div>
	    </g:elseif>
	    <g:elseif test="${ended}">
	        <div class="tilesanstitletag">
	            <img src="/images/ended1.gif" width="100">
	        </div>
	    </g:elseif>
    </div>
</div>


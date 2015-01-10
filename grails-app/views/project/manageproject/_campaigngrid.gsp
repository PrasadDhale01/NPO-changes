<!-- ProjectUpdateInformation -->
<%
    def links = projectService.getProjectUpdatedImageLink(projectUpdate)
%>

<div class="col-md-12 col-sm-12 col-xs-12">
	<p class="text-success">Update #${i}&nbsp;<i class="fa fa-info-circle"></i></p>
    <span class="project-story-span">${raw(projectUpdate.story)}</span>
    
    <g:if test="${!links.isEmpty()}">
	    <div class="blacknwhite campaignupdatedimages" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
	        <g:render template="/project/manageproject/projectimagescarousel" model="['images': links]"/>
	    </div>
    </g:if>
    
</div>

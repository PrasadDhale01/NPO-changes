<!-- ProjectUpdateInformation -->
<%
    def links = projectService.getProjectUpdatedImageLink(projectUpdate)
    def projectId = project.id
%>
<div class="col-md-6 col-sm-6 col-xs-6">
    <span class="text-success">Update #${i}&nbsp;<i class="fa fa-info-circle"></i></span>
</div>
<g:if test="${manageProject}">
    <div class="col-md-6 col-sm-6 col-xs-6">
	    <span>
	        <g:form controller="project" action="editUpdate" method="post"  id="${projectUpdate.id}" params="['projectId': projectId]">
                <button class="projectedit close"  aria-label="Edit project" id="editproject">
                    <i class="glyphicon glyphicon-edit" ></i>
                </button>
            </g:form>
	    </span>
    </div>
</g:if>
<div class="col-md-12 col-sm-12 col-xs-12">
    <p>${raw(projectUpdate.story)}</p>
    
    <g:if test="${!links.isEmpty()}">
	    <div class="blacknwhite campaignupdatedimages" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
	        <g:render template="/project/manageproject/projectupdateimagecarousel" model="['images': links]"/>
	    </div>
    </g:if>
</div>

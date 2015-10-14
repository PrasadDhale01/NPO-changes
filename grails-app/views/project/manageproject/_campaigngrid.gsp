<!-- ProjectUpdateInformation -->
<%
    def links = projectService.getProjectUpdatedImageLink(projectUpdate)
    def projectId = project.id
%>
<div class="col-md-6 col-sm-6 col-xs-12">
    <span><b>Update #${i}</b></span>&nbsp;&nbsp;&nbsp;&nbsp;<b>${projectUpdate.title}</b>
</div>
<g:if test="${manageProject}">
    <div class="col-md-6 col-sm-6 col-xs-6">
	    <span>
	        <g:form controller="project" action="editCampaignUpdate" method="post"  id="${projectUpdate.id}" params="['projectId': projectId]">
                <button class="projectedit close"  aria-label="Edit project" id="editproject">
                    <i class="glyphicon glyphicon-edit" ></i>
                </button>
            </g:form>
	    </span>
    </div>
</g:if>
<div class="col-md-12 col-sm-12 col-xs-12 campaignUpdateStory">
    <p>${raw(projectUpdate.story)}</p>
    
    <g:if test="${!links.isEmpty()}">
	    <div class="blacknwhite campaignupdatedimages sh-imgUpdt-mob" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
	        <g:render template="/project/manageproject/projectupdateimagecarousel" model="['images': links]"/>
	    </div>
    </g:if>
</div>

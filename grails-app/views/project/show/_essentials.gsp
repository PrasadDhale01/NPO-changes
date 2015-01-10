<%
	def projectimages = projectService.getProjectImageLinks(project)
%>
<div class="col-md-12">
	<div class="row">
		<div class="blacknwhite campaignupdatedimages" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
	        <g:render template="/project/manageproject/projectimagescarousel" model="['images': projectimages]"/>
	    </div>
	</div>
    <div class="row">
        <div class="panel panel-default campaign-description">
            <div class="panel-heading">
                <h3 class="panel-title">Campaign Description</h3>
            </div>
            <div class="panel-body">
                <span class="text-left">${raw(project.description)}</span>
            </div>
        </div>
        <div class="panel panel-default" style="margin-top: 30px;">
            <div class="panel-heading">
                <h3 class="panel-title">Campaign Story</h3>
            </div>
            <div class="panel-body project-description">
                <span class="text-centre project-story-span">${raw(project.story)}</span>
            </div>
        </div>  
    </div>
    
    <div class="row">
        <g:if test="${project.videoUrl}">
            <div id="youtubeVideoUrl">
                ${project.videoUrl}
	        </div>
	        <div class="video-container" id="youtube">
	        </div>
        </g:if>
    </div>

</div>

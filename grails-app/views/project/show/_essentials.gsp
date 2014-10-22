<div class="col-md-12">
    <div class="row">
        <div class="panel panel-default" style="margin-top: 30px;">
            <div class="panel-heading">
                <h3 class="panel-title">Project Description</h3>
            </div>
            <div class="panel-body">
                <p class="text-left">${raw(project.description)}</p>
            </div>
        </div>
        <div class="panel panel-default" style="margin-top: 30px;">
            <div class="panel-heading">
                <h3 class="panel-title">Project Story</h3>
            </div>
            <div class="panel-body">
                <p class="text-centre">${raw(project.story)}</p>
            </div>
        </div>  
    </div>
    
    <div class="row">
        <g:if test="${project.videoUrl}">
            <div class="video-container">
                <iframe src="${project.videoUrl}" frameborder="1" allowfullscreen></iframe>
	        </div>
        </g:if>
    </div>

</div>

<%
	def projectimages = projectService.getProjectImageLinks(project)
%>
<div class="col-md-12">
	<div class="row">
		<div class="blacknwhite campaignupdatedimages" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
	        <g:render template="/project/manageproject/projectimagescarousel" model="['images': projectimages]"/>
	    </div>
	</div>
    <br>
    <%-- Social features --%>
    <div class="col-sm-12">
        <a class="share-mail pull-right" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail" data-url="${base_url}/projects/${project.id}" data-name="${project.title}">
            <img src="${resource(dir: 'images', file: 'mail-share@2x.png')}" style="padding: 0; width:30px; bottom-margin:4px; margin:2px;" alt="Mail Share"/>
        </a>
        <a class="twitter-share pull-right" href="https://twitter.com/share?text=Hey check this project at crowdera.co!"  data-url="${base_url}/projects/${project.id}" target="_blank">
            <img src="${resource(dir: 'images', file: 'tw-share@2x.png')}" style="padding: 0; width:30px; bottom-margin:4px; margin:2px;" alt="Twitter Share"/>
        </a>
        <a class="fb-like pull-right" href="http://www.facebook.com/sharer.php?s=100&p[url]=${base_url}/projects/${project.id}&p[title]=${project.title} &p[summary]=${project.story}" data-url="${base_url}/projects/${project.id}" data-share="true">
            <img src="${resource(dir: 'images', file: 'fb-share@2x.png')}" style="padding: 0; width:30px; bottom-margin:4px; margin:2px;" alt="Facebook Share"/>
        </a>
        <span style="float:right; margin:5px;"><label>Share this Campaign</label></span>
    </div>

    <div class="row">
        <div class="panel panel-default campaign-description">
            <div class="panel-heading">
                <h3 class="panel-title">Campaign Description</h3>
            </div>
            <div class="panel-body descript">
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

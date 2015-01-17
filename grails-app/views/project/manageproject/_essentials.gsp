<!-- Comments -->
<%
	def projectimages = projectService.getProjectImageLinks(project)
%>

<div class="col-md-4 mobileview-top">
	<g:render template="/project/manageproject/tilesanstitle" />
	<g:if test="${project.draft}">
		<g:form controller="project" action="saveasdraft"
			id="${project.id}">
			<button class="btn btn-block btn-primary">
				<i class="glyphicon glyphicon-check"></i>&nbsp;Submit for
				approval
			</button>
		</g:form>
	</g:if>
	<br>
</div>

<div class="col-md-8">
    	<div class="blacknwhite campaignupdatedimages" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
	        <g:render template="/project/manageproject/projectimagescarousel" model="['images': projectimages]"/>
	    </div>
    
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
            <div class="panel-body">
                <span class="text-centre project-story-span">${raw(project.story)}</span>
            </div>
        </div>  
        <g:if test="${project.videoUrl}">
            <div id="youtubeVideoUrl">
                ${project.videoUrl}
            </div>
            <div class="video-container" id="youtube">
            </div>
        </g:if>
    
    <%-- Social features --%>
		<div class="col-sm-12">
			<a class="share-mail pull-right" href="#" data-toggle="modal"
				data-target="#sendmailmodal" target="_blank" id="share-mail"
				data-url="${base_url}/projects/${project.id}"
				data-name="${project.title}"> <img
				src="${resource(dir: 'images', file: 'mail-share@2x.png')}"
				style="padding: 0; width: 30px; bottom-margin: 4px; margin: 2px;"
			alt="Mail Share" />
			</a> <a class="twitter-share pull-right"
				href="https://twitter.com/share?text=Hey check this project at crowdera.co!"
				data-url="${base_url}/projects/${project.id}" target="_blank">
				<img src="${resource(dir: 'images', file: 'tw-share@2x.png')}"
				style="padding: 0; width: 30px; bottom-margin: 4px; margin: 2px;"
				alt="Twitter Share" />
			</a> <a class="fb-like pull-right"
				href="http://www.facebook.com/sharer.php?s=100&p[url]=${base_url}/projects/${project.id}&p[title]=${project.title} &p[summary]=${project.story}"
				data-url="${base_url}/projects/${project.id}" data-share="true">
				<img src="${resource(dir: 'images', file: 'fb-share@2x.png')}"
				style="padding: 0; width: 30px; bottom-margin: 4px; margin: 2px;"
				alt="Facebook Share" />
			</a> <span style="float: right; margin: 5px;"><label>Share
					this project</label></span>
	
		<!-- Modal -->
		<div class="modal fade" id="sendmailmodal" tabindex="-1" role="dialog" aria-hidden="true">
			<g:form action="sendemail" id="${project.id}" role="form">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span><span
									class="sr-only">Close</span>
							</button>
							<h4 class="modal-title">Recipient Email ID's</h4>
						</div>
						<div class="modal-body">
							<g:hiddenField name="amount" value="${project.amount}" />
							<div class="form-group">
								<label>Your Name</label> <input type="text"
									class="form-control" name="name" placeholder="Name" />
							</div>
							<div class="form-group">
								<label>Email ID's (separated by comma)</label>
								<textarea class="form-control" name="emails" rows="4"
									placeholder="Email ID's"></textarea>
							</div>
							<div class="form-group">
								<label>Message (Optional)</label>
								<textarea class="form-control" name="message" rows="4"
									placeholder="Message"></textarea>
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary btn-block">Send
								Email</button>
						</div>
					</div>
				</div>
			</g:form>
		</div>
	</div>
	
</div>

<div class="col-md-4 mobileview-bottom">
	<g:render template="/project/manageproject/tilesanstitle" />
	<g:if test="${project.draft}">
		<g:form controller="project" action="saveasdraft"
			id="${project.id}">
			<button class="btn btn-block btn-primary">
				<i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval
			</button>
		</g:form>
	</g:if>
	<br>
</div>

<%
	def base_url = grailsApplication.config.crowdera.BASE_URL
	def beneficiary = project.user
	def currentTeam = projectService.getCurrentTeam(project,currentFundraiser)
	def username
	if (user) {
	    username = user.username
	} else {
	    username = beneficiary.username
	}
	def projectimages = projectService.getProjectImageLinks(project)
	def teamimages = projectService.getTeamImageLinks(currentTeam)
    def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+username
	
%>
<div class="col-md-12">
	<div class="row">
		<div class="blacknwhite campaignupdatedimages" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
		    <g:if test="${userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)}">
	            <g:render template="/project/manageproject/projectimagescarousel" model="['images': projectimages]"/>
	        </g:if>
	        <g:else>
                <g:render template="/project/manageproject/projectimagescarousel" model="['images': teamimages, 'currentTeam': currentTeam]"/>
	        </g:else>
	    </div>
	</div>
    <br>
    <%-- Social features --%>
    <div class="col-sm-12 social">
        <a class="share-mail pull-right" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail">
            <img src="${resource(dir: 'images', file: 'mail-share@2x.png')}" alt="Mail Share"/>
        </a>
        <a class="twitter-share pull-right" href="https://twitter.com/share?text=Check campaign at crowdera.co!"  data-url="${base_url}/projects/${project.id}" target="_blank">
            <img src="${resource(dir: 'images', file: 'tw-share@2x.png')}" alt="Twitter Share"/>
        </a>
        <a target="_blank" class="fb-like pull-right" href="http://www.facebook.com/sharer/sharer.php?s=100&amp;&p[url]=${fbShareUrl}">
            <img src="${resource(dir: 'images', file: 'fb-share@2x.png')}" alt="Facebook Share"/>
        </a>
        <div class="shared">
        	<span><label>Share this Campaign</label></span>
        </div>
    </div>

    <div class="row">
        <div class="panel panel-default campaign-description">
            <div class="panel-heading">
                <h3 class="panel-title">Campaign Description</h3>
            </div>
            <div class="panel-body descript">
                <g:if test="${userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)}">
                    <span class="text-left">${raw(project.description)}</span>
                </g:if>
                <g:else>
                    <span class="text-left">${raw(currentTeam.description)}</span>  
                </g:else>
            </div>
        </div>
        <div class="panel panel-default show-comments-details">
            <div class="panel-heading">
                <h3 class="panel-title">Campaign Story</h3>
            </div>
            <div class="panel-body project-description">
                <g:if test="${userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)}">
                   <span class="text-centre project-story-span">${raw(project.story)}</span>
                </g:if>
                <g:else>
                   <span class="text-centre project-story-span">${raw(currentTeam.story)}</span>
                </g:else>
            </div>
        </div>  
    </div>
</div>

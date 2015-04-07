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

    <div class="col-md-12 col-sm-12 col-xs-12">
        <g:if test="${userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)}">
            <p class="campaignDescription justify">${raw(project.description)}</p>
        </g:if>
        <g:else>
            <p class="campaignDescription justify">${raw(currentTeam.description)}</p>
        </g:else>
        <g:if test="${userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)}">
            <p class="campaignStory justify">${raw(project.story)}</p>
        </g:if>
        <g:else>
            <p class="campaignStory justify">${raw(currentTeam.story)}</p>
        </g:else>
    </div>
</div>

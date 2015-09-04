<%
    def username = user.username
	def base_url = grailsApplication.config.crowdera.BASE_URL
	def projectimages = projectService.getProjectImageLinks(project)
	def teamimages = projectService.getTeamImageLinks(currentTeam,project)
    def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+username
	
%>
<div class="col-md-12">
	<div class="row">
		<div class="blacknwhite campaignupdatedimages" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
		    <g:if test="${userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)}">
	            <g:render template="/project/manageproject/projectimagescarousel" model="['images': projectimages]"/>
	        </g:if>
	        <g:else>
                <g:render template="/project/manageproject/projectimagescarousel" model="['images': teamimages]"/>
	        </g:else>
	    </div>
	</div>
    <br>
    <%-- Social features --%>
    <g:hiddenField name="fbShareUrl" id="fbShareUrl" value="${fbShareUrl}"/>
    <div class="col-sm-12 social sharing-icon-alignment">
		<div class="shared pull-left">
			<span class="TW-show_share-text-margin"><label>SHARE:</label></span>
		</div>
		<g:if test="${isPreview}">
		<a class="fb-like pull-left social fbShareForSmallDevices">
			<img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">
		</a>
		<a class="fb-like pull-left fbShareForLargeDevices">
			<img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">
		</a>
		<a class="share-mail pull-left">
			<img src="//s3.amazonaws.com/crowdera/assets/email-share-icon.png" alt="Mail Share">
		</a>
		<a class="twitter-share pull-left">
			<img src="//s3.amazonaws.com/crowdera/assets/twitter-share-icon.png" alt="Twitter Share">
		</a>
		<a class="pull-left">
			<img src="//s3.amazonaws.com/crowdera/assets/like-Share-icon.png" alt="campaign-supporter">
		</a>
		<a class="social share-linkedin pull-left" target="_blank" id="share-linkedin">
			<img src="//s3.amazonaws.com/crowdera/assets/linked-in-share-icon.png" alt="LinkedIn Share">
		</a>
		<a class="social google-plus-share pull-left" id="googlePlusShare">
			<img src="//s3.amazonaws.com/crowdera/assets/google-plus-share.png" alt="Google+ Share">
		</a>
		</g:if>
		<g:else>
		<a target="_blank" class="fb-like pull-left social fbShareForSmallDevices" href="http://www.facebook.com/sharer/sharer.php?s=100&amp;&p[url]=${fbShareUrl}">
			<img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">
		</a>
		<a target="_blank" class="fb-like pull-left fbShareForLargeDevices" id="fbshare">
			<img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">
		</a>
		<a class="share-mail pull-left" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail">
			<img src="//s3.amazonaws.com/crowdera/assets/email-share-icon.png" alt="Mail Share">
		</a>
		<a class="twitter-share pull-left" id="twitterShare" data-url="${base_url}/campaigns/${vanityTitle}/${vanityUsername}" target="_blank">
			<img src="//s3.amazonaws.com/crowdera/assets/twitter-share-icon.png" alt="Twitter Share">
		</a>
		<g:link absolute="true" uri="/campaign/supporter/${project.id}/${username}" class="pull-left">
			<img src="//s3.amazonaws.com/crowdera/assets/like-Share-icon.png" alt="campaign-supporter" id="add-campaign-supporter">
		</g:link>
		<a class="social share-linkedin pull-left" href="https://www.linkedin.com/cws/share?url=${fbShareUrl}" target="_blank" id="share-linkedin" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
			<img src="//s3.amazonaws.com/crowdera/assets/linked-in-share-icon.png" alt="LinkedIn Share">
		</a>
		<a class="social google-plus-share pull-left" id="googlePlusShare" href="https://plus.google.com/share?url=${fbShareUrl}" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
			<img src="//s3.amazonaws.com/crowdera/assets/google-plus-share.png" alt="Google+ Share">
		</a>
		</g:else>
    </div>

    <div class="col-md-12 col-sm-12 col-xs-12 TW-campaignstory-img-width">
        <g:if test="${isCrFrCampBenOrAdmin}">
            <p class="campaignDescription justify">${raw(project.description)}</p>
        </g:if>
        <g:else>
            <p class="campaignDescription justify">${raw(currentTeam.description)}</p>
        </g:else>
        <g:if test="${isCrFrCampBenOrAdmin}">
            <p class="campaignStory justify">${raw(project.story)}</p>
        </g:if>
        <g:else>
            <p class="campaignStory justify">${raw(currentTeam.story)}</p>
            <p class="campaignStory justify">${raw(project.story)}</p>
        </g:else>
    </div>
</div>

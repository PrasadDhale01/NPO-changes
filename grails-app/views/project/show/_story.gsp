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
</div>
    <br>
    <%-- Social features --%>
    <g:hiddenField name="fbShareUrl" id="fbShareUrl" value="${fbShareUrl}"/>
    <div class="col-sm-12 social sharing-icon-alignment show-share-border-line">
<%--        <div class="shared pull-left">--%>
<%--            <span class="TW-show_share-text-margin"><label>SHARE:</label></span>--%>
<%--        </div>--%>
        <g:if test="${isPreview}">
<%--        <a class="fb-like pull-left social fbShareForSmallDevices show-icons">--%>
<%--            <img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">--%>
<%--        </a>--%>
<%--        <a class="fb-like pull-left fbShareForLargeDevices show-icons">--%>
<%--            <img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">--%>
<%--        </a>--%>
        <a class="share-mail pull-left show-icons show-email-hover">
            <img src="//s3.amazonaws.com/crowdera/assets/show-e-mail-light-gray.png" class="show-email" alt="Mail Share">
        </a>
        <a class="twitter-share pull-left show-icons">
            <img src="//s3.amazonaws.com/crowdera/assets/show-twitter-gray.png" class="show-twitter" alt="Twitter Share">
        </a>
        <a class="pull-left show-icons">
            <img src="//s3.amazonaws.com/crowdera/assets/show-like-gray.png" class="show-like" alt="campaign-supporter">
        </a>
        <a class="social share-linkedin pull-left show-icons" target="_blank" id="share-linkedin">
            <img src="//s3.amazonaws.com/crowdera/assets/show-linkedin-gray.png" class="show-linkedin" alt="LinkedIn Share">
        </a>
        <a class="social google-plus-share pull-left show-icons" id="googlePlusShare">
            <img src="//s3.amazonaws.com/crowdera/assets/show-google-gray.png" alt="Google+ Share">
        </a>
        </g:if>
        <g:else>
<%--        <a target="_blank" class="fb-like pull-left social fbShareForSmallDevices show-icons" href="http://www.facebook.com/sharer/sharer.php?s=100&amp;p[url]=${fbShareUrl}">--%>
<%--            <img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">--%>
<%--        </a>--%>
<%--        <a target="_blank" class="fb-like pull-left fbShareForLargeDevices show-icons" id="fbshare">--%>
<%--            <img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">--%>
<%--        </a>--%>
        <a class="share-mail pull-left show-icons" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail">
            <img src="//s3.amazonaws.com/crowdera/assets/show-e-mail-light-gray.png" alt="Mail Share" class="show-email">
        </a>
        <a class="twitter-share pull-left show-icons" id="twitterShare" data-url="${base_url}/campaigns/${vanityTitle}/${vanityUsername}" target="_blank">
            <img src="//s3.amazonaws.com/crowdera/assets/show-twitter-gray.png" class="show-twitter" alt="Twitter Share">
        </a>
        <g:link absolute="true" uri="/campaign/supporter/${project.id}/${username}" class="pull-left show-icons">
            <img src="//s3.amazonaws.com/crowdera/assets/show-like-gray.png" class="show-like" alt="campaign-supporter" id="add-campaign-supporter">
        </g:link>
        <a class="social share-linkedin pull-left show-icons" href="https://www.linkedin.com/cws/share?url=${fbShareUrl}" target="_blank" id="share-linkedin" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
            <img src="//s3.amazonaws.com/crowdera/assets/show-linkedin-gray.png" class="show-linkedin" alt="LinkedIn Share">
        </a>
        <a class="social google-plus-share pull-left show-icons" id="googlePlusShare" href="https://plus.google.com/share?url=${fbShareUrl}" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
            <img src="//s3.amazonaws.com/crowdera/assets/show-google-gray.png" class="show-google" alt="Google+ Share">
        </a>
        </g:else>
        
    </div>

    <div class="col-md-12 col-sm-12 col-xs-12 TW-campaignstory-img-width">
        <g:if test="${isCrFrCampBenOrAdmin}">
            <div class="show-description">
                <p class="campaignDescription justify">${raw(project.description)}</p>
            </div>
        </g:if>
        <g:else>
            <div class="show-description">
                <p class="campaignDescription justify">${raw(currentTeam.description)}</p>
            </div>
        </g:else>
        <g:if test="${isCrFrCampBenOrAdmin}">
            <p class="campaignStory justify">${raw(project.story)}</p>
        </g:if>
        <g:else>
            <p class="campaignStory justify">${raw(currentTeam.story)}</p>
            <p class="campaignStory justify">${raw(project.story)}</p>
        </g:else>
    </div>


<%
    def username = user.username
    def base_url = grailsApplication.config.crowdera.BASE_URL
    def projectimages = projectService.getProjectImageLinks(project)
    def teamimages = projectService.getTeamImageLinks(currentTeam,project)
    def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+username
    def shareUrl = base_url+'/c/'+shortUrl
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
    <g:hiddenField name="shareUrl" id="shareUrl" value="${shareUrl}"/>
    <g:hiddenField name="embedTileUrl" id="embedTileUrl" value="${embedTileUrl}"/>

    <div class="col-sm-12 social sharing-icon-alignment <g:if test="${hashTagsDesktop || hashTagsTabs}"></g:if><g:else>sharing-icons-padding-left</g:else> <g:if test="${isvalidateShow}">validate-share-border</g:if><g:else>show-share-border-line</g:else> hidden-xs">
        <a class="show-socials-iconsA"></a>
        <g:if test="${isPreview || isvalidateShow}">
            <a class="share-mail pull-left show-icons show-email-hover show-pointer-not">
                <img src="//s3.amazonaws.com/crowdera/assets/show-e-mail-light-gray.png" class="show-email" alt="Mail Share">
            </a>
            <a class="twitter-share pull-left show-icons show-pointer-not">
                <img src="//s3.amazonaws.com/crowdera/assets/show-twitter-gray.png" class="show-twitter" alt="Twitter Share">
            </a>
            <a class="pull-left show-icons show-pointer-not">
                <img src="//s3.amazonaws.com/crowdera/assets/show-like-gray.png" class="show-like" alt="campaign-supporter">
            </a>
            <a class="social share-linkedin pull-left show-icons show-pointer-not" target="_blank" id="share-linkedin">
                <img src="//s3.amazonaws.com/crowdera/assets/show-linkedin-gray.png" class="show-linkedin" alt="LinkedIn Share">
            </a>
            <a class="social google-plus-share pull-left show-icons show-pointer-not" id="googlePlusShare">
                <img src="//s3.amazonaws.com/crowdera/assets/show-google-gray.png" class="show-google" alt="Google+ Share">
            </a>
            <span class="pull-left show-icons show-pointer-not"><img src="//s3.amazonaws.com/crowdera/assets/embedicon-grey.png" alt="embedicon" class="show-embedIcon"></span>
            <span class="shortUrlglyphicon glyphicon glyphicon-link glyphicon-show-design glyphicon-show-link-color show-pointer-not"></span>
			<span class="showing-hashtags <g:if test="${isvalidateShow}">hashtag-font-size</g:if> showing-hashtags-desktop">${hashTagsDesktop}</span>
			<span class="showing-hashtags showing-hashtags-tabs">${hashTagsTabs}</span>
        </g:if>
        <g:else>
            <a class="share-mail pull-left show-icons" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail">
                <img src="//s3.amazonaws.com/crowdera/assets/show-e-mail-light-gray.png" alt="Mail Share" class="show-email">
            </a>
            <a class="twitter-share pull-left show-icons" id="twitterShare" data-url="${shareUrl}" target="_blank">
                <img src="//s3.amazonaws.com/crowdera/assets/show-twitter-gray.png" class="show-twitter" alt="Twitter Share">
            </a>
            <g:link absolute="true" uri="/campaign/supporter/${project.id}/${username}" class="pull-left show-icons">
                <img src="//s3.amazonaws.com/crowdera/assets/show-like-gray.png" class="show-like" alt="campaign-supporter" id="add-campaign-supporter">
            </g:link>
            <a class="social share-linkedin pull-left show-icons" href="https://www.linkedin.com/cws/share?url=${shareUrl}" target="_blank" id="share-linkedin" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                <img src="//s3.amazonaws.com/crowdera/assets/show-linkedin-gray.png" class="show-linkedin" alt="LinkedIn Share">
            </a>
            <a class="social google-plus-share pull-left show-icons" id="googlePlusShare" href="https://plus.google.com/share?url=${shareUrl}" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                <img src="//s3.amazonaws.com/crowdera/assets/show-google-gray.png" class="show-google" alt="Google+ Share">
            </a>
            <a href="#" data-toggle="modal" data-target="#embedTilemodal" target="_blank" class="pull-left show-icons"><img src="//s3.amazonaws.com/crowdera/assets/embedicon-grey.png" class="show-embedIcon" alt="embedicon"></a>
            <g:hiddenField name="urlShortenValue" value="${shareUrl}" id="urlShortenValue"/>
            <div class="popoverClass">
                <span data-title="Copy this short url and share &nbsp;&nbsp;&nbsp;" class="shortUrlglyphicon glyphicon glyphicon-link glyphicon-show-design glyphicon-show-link-color"></span>
                <div id="popoverConent" class="hidden">
                    <button type="button" class="close">&times;</button>
                    <p>${shareUrl}</p>
                </div>
            </div>
			<span class="showing-hashtags showing-hashtags-desktop hashtags-padding-left">${hashTagsDesktop}</span>
			<span class="showing-hashtags showing-hashtags-tabs hashtags-padding-left">${hashTagsTabs}</span>
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
        <g:if test="${spendCauseList && spendAmountPerList}">
        <p>Campaign money will be used as</p>
			<div id="chart-container">
				<g:hiddenField name="spendCauseList" value="${spendCauseList}" id="spendCauseList"/>
				<g:hiddenField name="spendAmountPerList" value="${spendAmountPerList}" id="spendAmountPerList"/>
				<g:hiddenField name="payuStatus" id="payuStatus" value="${project.payuStatus}"/>
				<div id="graph"></div>
			</div>
			<script src="/js/raphel-pie/raphael-min.js"></script>
            <script src="/js/raphel-pie/g.raphael.js"></script>
            <script src="/js/raphel-pie/g.pie.js"></script>
		</g:if>
        <g:if test="${project.impactNumber > 0 && project.impactAmount > 0}">
            <g:if test="${project.category.toString() == 'ANIMALS'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">Our campaign will benefit  ${project.impactNumber}  animals by providing <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">Our campaign will benefit ${project.impactNumber} animals by providing <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:if>
            <g:elseif test="${project.category.toString() == 'ARTS'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">Our campaign will benefit  ${project.impactNumber}  individuals by providing <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">Our campaign will benefit ${project.impactNumber} individuals by providing <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:elseif test="${project.category.toString() == 'CHILDREN'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">Our campaign will impact ${project.impactNumber}  children's life by providing  <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">Our campaign will impact ${project.impactNumber}  children's life by providing  <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:elseif test="${project.category.toString() == 'COMMUNITY'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">Our campaign will benefit  ${project.impactNumber} community by providing <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">Our campaign will benefit ${project.impactNumber} community by providing <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:elseif test="${project.category.toString() == 'CIVIC_NEEDS'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">This campaign will affect ${project.impactNumber} neighborhood by <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">This campaign will affect ${project.impactNumber} neighborhood by  <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:elseif test="${project.category.toString() == 'EDUCATION'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">This campaign will educate ${project.impactNumber} students by providing <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">This campaign will educate ${project.impactNumber} students by providing <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:elseif test="${project.category.toString() == 'ELDERLY'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">Our campaign will benefit ${project.impactNumber} elderlies by providing <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">Our campaign will benefit ${project.impactNumber} elderlies by providing <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:elseif test="${project.category.toString() == 'ENVIRONMENT'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">Our campaign will benefit ${project.impactNumber}  lives by providing <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">Our campaign will benefit ${project.impactNumber} lives by providing <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:elseif test="${project.category.toString() == 'FILM'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">Our film will impact ${project.impactNumber} lives by using <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">Our film will impact ${project.impactNumber} lives by using <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:elseif test="${project.category.toString() == 'HEALTH'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">Our campaign will save ${project.impactNumber} lives by providing <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">Our campaign will save ${project.impactNumber} lives by providing <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:elseif test="${project.category.toString() == 'SOCIAL_INNOVATION'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">Our campaign will benefit ${project.impactNumber} individual by innovating <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">Our campaign will benefit ${project.impactNumber} individual by innovating <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:elseif test="${project.category.toString() == 'RELIGION'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">This campaign will help ${project.impactNumber} religion empowerement by <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">This campaign will help ${project.impactNumber} religion empowerement by <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:elseif test="${project.category.toString() == 'NON_PROFITS'}">
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">Our non-profit will help ${project.impactNumber} lives by providing <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">Our non-profit will help ${project.impactNumber} lives by providing <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:elseif>
            <g:else>
                <g:if test="${project.payuStatus}">
                    <p class="campaignStory justify">Our campaign will benefit ${project.impactNumber} lives by providing <span class="fa fa-inr"></span> ${project.impactAmount}</p>
                </g:if>
                <g:else>
                    <p class="campaignStory justify">Our campaign will benefit ${project.impactNumber} lives by providing <span class="fa fa-usd"></span> ${project.impactAmount}</p>
                </g:else>
            </g:else>
        </g:if>
        <g:if test="${reasons}">
            <p class="campaignStory justify">
            Why you should fund this campaign ?<br>
                <g:if test="${reasons.reason1 && reasons.reason1 != ''}">&nbsp;&nbsp;&nbsp;&nbsp;1. ${reasons.reason1}<br></g:if>
                <g:if test="${reasons.reason2 && reasons.reason2 != ''}">&nbsp;&nbsp;&nbsp;&nbsp;2. ${reasons.reason2}<br></g:if>
                <g:if test="${reasons.reason3 && reasons.reason3 != ''}">&nbsp;&nbsp;&nbsp;&nbsp;3. ${reasons.reason3}</g:if>
            </p>
        </g:if>
        <g:if test="${isCrFrCampBenOrAdmin}">
            <p class="campaignStory justify">${raw(project.story)}</p>
        </g:if>
        <g:else>
            <p class="campaignStory justify">${raw(currentTeam.story)}</p>
            <p class="campaignStory justify">${raw(project.story)}</p>
        </g:else>
        <g:if test="${remainingTagsDesktop}">
            <p class="moretags-desktop">More Tags : ${remainingTagsDesktop}</p>
        </g:if>
        <g:if test="${remainingTagsTabs}">
            <p class="moretags-tabs">More Tags : ${remainingTagsTabs}</p>
        </g:if>
    </div>

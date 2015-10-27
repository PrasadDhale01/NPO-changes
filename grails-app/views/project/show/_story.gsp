<%
    def username = user.username
    def base_url = grailsApplication.config.crowdera.BASE_URL
    def projectimages = projectService.getProjectImageLinks(project)
    def teamimages = projectService.getTeamImageLinks(currentTeam,project)
    def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+username
    def shareUrl = base_url+'/c/'+shortUrl
    def embedTileUrl = base_url+'/campaign/'+vanityTitle+'/'+vanityUsername+'/embed/tile'
    def embedCode = '<iframe src="'+embedTileUrl+'" width="310px" height="451px" frameborder="0" scrolling="no" class="embedTitleUrl"></iframe>'
    def embedVideoCode = '<iframe src="'+project.videoUrl+'" width="480" height="360" frameborder="0" scrolling="no"></iframe>'
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
            <img src="//s3.amazonaws.com/crowdera/assets/show-google-gray.png" class="show-google" alt="Google+ Share">
        </a>
        <a href="#" class="pull-left show-icons"><img src="//s3.amazonaws.com/crowdera/assets/embedicon-grey.png" alt="embedicon" class="show-embedIcon"></a>
        <span class="shortUrlglyphicon glyphicon glyphicon-link glyphicon-show-design glyphicon-show-link-color"></span>
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

    <!-----Embed modal----->
    <div class="modal fade" id="embedTilemodal" tabindex="-1" role="dialog" aria-hidden="true">
        <g:if test="${project.videoUrl}">
            <div class="modal-dialog modal-embed-with-video">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        </button>
                        <h4 class="modal-title"><b>Embed this widget into your website</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-7">
                                <p>Video preview</p>
                                    <textarea class="textarea-embed-video">${embedVideoCode}</textarea><br><br>
                                    <iframe src="${project.videoUrl}" class="embed-video-in-modal"></iframe><br>
                                    <p>After choosing a video size, copy and paste the embed code above.</p>
                                    <div class="row desktop-video-play">
                                        <div class="col-sm-2 margin-sm-left video-play video-play-sm video-play-hover selected text-center">
                                            <span class="glyphicon glyphicon-play glyphicon-play-bg-color glyphicon-play-padding-sm"></span><br>
                                            <label class="lbl-width">480 x 360</label>
                                        </div>
                                        <div class="col-sm-2 margin-md-left video-play video-play-md video-play-hover text-center">
                                            <span class="glyphicon glyphicon-play glyphicon-play-bg-color glyphicon-play-padding-md"></span><br>
                                            <label>640 x 480</label>
                                        </div>
                                        <div class="col-sm-2 margin-lg-left video-play video-play-lg video-play-hover text-center">
                                            <span class="glyphicon glyphicon-play glyphicon-play-bg-color glyphicon-play-padding-lg"></span><br>
                                            <label>800 x 600</label>
                                        </div>
                                        <div class="col-sm-4 margin-custom-left video-play video-play-custom video-play-hover">
                                            <label>Custom size</label><br>
                                            <input type="text" class="customSizeText video-play-width" value="480"> x <input type="text" class="customSizeText video-play-height" value="360">
                                        </div>
                                    </div>
                                    <div class="tabs-video-play">
                                        <div class="row">
                                            <div class="col-sm-offset-1 col-sm-3 video-play video-play-sm video-play-hover selected text-center">
                                                 <span class="glyphicon glyphicon-play glyphicon-play-bg-color glyphicon-play-padding-sm"></span><br>
                                                 <label class="lbl-width">480 x 360</label>
                                            </div>
                                            <div class="col-sm-4 margin-md-left video-play video-play-md video-play-hover text-center">
                                                <span class="glyphicon glyphicon-play glyphicon-play-bg-color glyphicon-play-padding-md"></span><br>
                                                <label>640 x 480</label>
                                            </div>
                                            <div class="col-sm-4 margin-md-left video-play video-play-lg video-play-hover text-center">
                                                <span class="glyphicon glyphicon-play glyphicon-play-bg-color glyphicon-play-padding-lg"></span><br>
                                                <label>800 x 600</label>
                                            </div>
                                            <div class="clear"></div>
                                            <div class="clear"></div>
                                            <div class="tab-clear"></div>
                                            <div class="col-sm-6 margin-custom-left video-play video-play-custom video-play-hover">
                                                <label>Custom size</label><br>
                                                <input type="text" class="customSizeText video-play-width" value="480"> x <input type="text" class="customSizeText video-play-height" value="360">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-5">
                                    <p>Widget preview</p>
                                    <textarea class="textarea-embed-tile">${embedCode}</textarea><br><br>
                                    <g:render template="manageproject/embedTile"/>
                                </div>
                            </div>
                        </div>
                    </div>
               </div>
          </g:if>
          <g:else>
              <div class="modal-dialog modal-tile">
                  <div class="modal-content">
                      <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">
                              <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                          </button>
                          <h4 class="modal-title"><b>Embed this widget into your website</b></h4>
                      </div>
                      <div class="modal-body only-tile-embed-modal text-center">
                          <p>Widget preview</p>
                          <textarea class="textarea-of-embed-tile">${embedCode}</textarea><br><br>
                          <g:render template="manageproject/embedTile"/>
                      </div>
                  </div>
              </div>
          </g:else>
      </div>

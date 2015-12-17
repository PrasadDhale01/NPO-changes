<!-- Comments -->
<%
    def base_url = grailsApplication.config.crowdera.BASE_URL
    def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+project.user.username
    def fundRaiser = user.username
    def shareUrl = base_url+'/c/'+shortUrl;
    def vimeoInt
    def campaignVideoUrl
    if (project.videoUrl){
        if (project.videoUrl.contains('vimeo.com')) {
            def video = project.videoUrl.split('/')
            vimeoInt = video[video.length - 1]
            campaignVideoUrl = 'https://player.vimeo.com/video/'+vimeoInt
        } else {
            campaignVideoUrl = project.videoUrl;
        }
    }
    def embedTileUrl = base_url+'/campaign/'+vanityTitle+'/'+vanityUsername+'/embed/tile'
    def embedCode = '<iframe src="'+embedTileUrl+'" width="310px" height="451px" frameborder="0" scrolling="no" class="embedTitleUrl"></iframe>'
    def embedVideoCode = '<iframe src="'+campaignVideoUrl+'" width="480" height="360" frameborder="0" scrolling="no"></iframe>'
%>

<div class="col-xs-12 col-md-4 col-sm-4 mobileview-top">
    <g:render template="/project/manageproject/tilesanstitle" />
    <g:if test="${project.validated}">
        <span class="btn btn-default fbShareForSmallDevices manage-fb-color fbshare-header">
            <i class="fa fa-facebook"></i> SHARE ON FACEBOOK
        </span>
    </g:if>
    <g:if test="${project.draft}">
        <div class="submitForApprovalSection">
            <g:if test="${project.organizationIconUrl && project.webAddress && (project.charitableId || project.paypalEmail || project.payuEmail) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                <g:form controller="project" action="saveasdraft" id="${project.id}">
                    <g:if test="${!project.touAccepted}">
                        <div class="form-group">
                            <input type="checkbox" name="submitForApprovalcheckbox" id="agreetoTermsandUse">  I accept <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
                        </div>
                    </g:if><br/>
                    <div class="clear"></div>
                    <button class="btn btn-block btn-primary mange-submitapp-margin">
                        <i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval
                    </button>
                </g:form>
            </g:if>
            <g:else>
                <button class="btn btn-block btn-primary mange-submitapp-margin" id="submitForApprovalBtnMobile">
                    <i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval
                </button>
            </g:else>
        </div>
    </g:if>
    <br>
</div>

<div class="col-md-8 col-sm-8">
    <div class="blacknwhite campaignupdatedimages pull-left" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
        <g:render template="/project/manageproject/projectimagescarousel" model="['images': projectimages]"/>
    </div>
    <br>
</div>
<div class="col-xs-12 col-md-4 col-sm-4 mobileview-bottom-mange">
    <g:render template="/project/manageproject/tilesanstitle" />
    <g:if test="${project.validated}">
        <span class="btn btn-default fbShareForLargeDevices manage-fb-color mange-size-FBbtn" id="fbshare">
            <i class="fa fa-facebook"></i> SHARE ON FACEBOOK
        </span>
    </g:if>
    <g:if test="${project.draft}">
        <div class="submitForApprovalSectionbtm" id="submitForApprovalSectionbtm">
            <g:if test="${project.organizationIconUrl && project.webAddress && (project.charitableId || project.paypalEmail || project.payuEmail) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                <g:form controller="project" action="saveasdraft" id="${project.id}">
                    <g:if test="${!project.touAccepted}">
                        <div class="form-group">
                            <input type="checkbox" name="submitForApprovalcheckbox1">  I accept <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
                        </div>
                    </g:if>
                    <div class="clear"></div>
                    <button class="btn btn-block btn-primary"><i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval</button>
                </g:form>
            </g:if>
            <g:else>
                <button class="btn btn-block btn-primary" id="submitForApprovalBtn"><i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval</button>
            </g:else>
        </div>
    </g:if>
    <br>
</div>

    <%-- Social features --%>
    <g:hiddenField name="fbShareUrl" id="fbShareUrl" value="${fbShareUrl}"/>
    <g:hiddenField name="shareUrl" id="shareUrl" value="${shareUrl}"/>
    <g:hiddenField name="embedTileUrl" id="embedTileUrl" value="${embedTileUrl}"/>
    <g:if test="${project.validated}">
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 manage-social hidden-xs">
<%--        <div class="shared pull-left mng-sharing-icon-alignment">--%>
<%--            <span><label>SHARE:</label></span>--%>
<%--        </div>--%>
<%--        <a target="_blank" class="fb-like pull-left social fbShareForLargeDevices" id="fbshare">--%>
<%--            <img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">--%>
<%--        </a>--%>
<%--        <a target="_blank" class="fb-like pull-left social fbShareForSmallDevices" href="http://www.facebook.com/sharer/sharer.php?s=100&amp;&p[url]=${fbShareUrl}">--%>
<%--            <img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">--%>
<%--        </a>--%>
        <a class="share-mail pull-left social" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail">
            <img src="//s3.amazonaws.com/crowdera/assets/show-e-mail-light-gray.png" class="show-email" alt="Email Share">
        </a>
        <a class="twitter-share pull-left social" id="twitterShare" target="_blank">
            <img src="//s3.amazonaws.com/crowdera/assets/show-twitter-gray.png" class="show-twitter" alt="Twitter Share">
        </a>
<%--       	<a class="social like-share pull-left" id="likeShare" data-url="${base_url}/campaigns/${vanityTitle}/${vanityUsername}" target="_blank">--%>
<%--            		<img src="//s3.amazonaws.com/crowdera/assets/like-share-icon.png" alt="Like Share"/>--%>
<%--        </a>--%>
        <a class="social share-linkedin pull-left" href="https://www.linkedin.com/cws/share?url=${shareUrl}"  id="share-linkedin" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
            <img src="//s3.amazonaws.com/crowdera/assets/show-linkedin-gray.png" class="show-linkedin" alt="LinkedIn Share">
        </a>
        <a class="social google-plus-share pull-left" id="googlePlusShare" href="https://plus.google.com/share?url=${shareUrl}" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
            <img src="//s3.amazonaws.com/crowdera/assets/show-google-gray.png" class="show-google" alt="Google+ Share">
        </a>
        <a href="#" data-toggle="modal" data-target="#embedTilemodal" target="_blank" class="pull-left embedIcon-manage-left social hidden-xs"><img src="//s3.amazonaws.com/crowdera/assets/embedicon-grey.png" class="show-embedIcon" alt="embedicon"></a>
        <div class="popoverClassManagePage">
            <span data-title="Copy this short url and share &nbsp;&nbsp;&nbsp;" class="shortUrlglyphicon pull-left glyphicon glyphicon-link glyphicon-design glyphicon-show-link-color"></span>
            <div id="popoverConent" class="hidden">
                <button type="button" class="close">&times;</button>
                <p>${shareUrl}</p>
            </div>
        </div>
        <div class="popoverClassMobManagePage">
            <span data-title="Copy this short url and share &nbsp;&nbsp;&nbsp;" class="shortUrlglyphiconMob pull-left glyphicon glyphicon-link glyphicon-design glyphicon-show-link-color"></span>
            <div id="popoverConentMob" class="hidden">
                <button type="button" class="close">&times;</button>
                <p>${shareUrl}</p>
            </div>
        </div>
    </div>
    </g:if>

    <div class="col-md-8 col-sm-8 col-xs-12">
        <p class="campaignDescription justify">${raw(project.description)}</p>
        <p class="campaignStory justify">${raw(project.story)}</p>
    </div>

    <!-----Embed modal----->
    <div class="modal fade" id="embedTilemodal" tabindex="-1" role="dialog" aria-hidden="true">
        <g:if test="${project.videoUrl}">
            <div class="modal-dialog modal-embed-with-video hidden-xs">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        </button>
                        <h4 class="modal-title text-center"><b>Embed this widget into your website</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-7">
                                <p>Video preview</p>
                                    <textarea class="textarea-embed-video form-control" onclick="this.select()">${embedVideoCode}</textarea><br><br>
                                    <iframe src="${campaignVideoUrl}" class="embed-video-in-modal"></iframe><br>
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
                                    <textarea class="textarea-embed-tile form-control" onclick="this.select()">${embedCode}</textarea><br><br>
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
                          <textarea class="textarea-of-embed-tile form-control" onclick="this.select()">${embedCode}</textarea><br><br>
                          <g:render template="manageproject/embedTile"/>
                      </div>
                  </div>
              </div>
          </g:else>
      </div>

	<div class="col-sm-12">
	    <!-- Modal -->
		<div class="modal fade" id="sendmailmodal" tabindex="-1" role="dialog" aria-hidden="true">
			<g:form action="sendemail" id="${project.id}" class="sendMailFormMng">
		        <div class="modal-dialog">
				    <div class="modal-content">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal">
							    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title">Recipient Email ID's</h4>
						</div>
						<div class="modal-body">
						    <g:hiddenField name="amount" value="${project.amount}" />
						    <g:hiddenField name="ismanagepage" value="managepage" />
						    <g:hiddenField name="fr" value="${fundRaiser}" />
                                                   <g:hiddenField name="vanityTitle" value="${vanityTitle}"/>
						    <div class="form-group">
							    <label>Your Name</label> <input type="text" class="form-control all-place" name="name" placeholder="Name" />
						    </div>
							<div class="form-group">
						        <label>Email ID's (separated by comma)</label>
								<textarea class="form-control all-place" name="emails" rows="4" placeholder="Email ID's"></textarea>
							</div>
							<div class="form-group">
							    <label>Message (Optional)</label>
								<textarea class="form-control all-place" name="message" rows="4" placeholder="Message"></textarea>
							</div>
						</div>
						<div class="modal-footer">
						    <button type="submit" class="btn btn-primary btn-block" id="btnSendMailMng">Send Email</button>
						</div>
				    </div>
			    </div>
	        </g:form>
		</div>
	</div>



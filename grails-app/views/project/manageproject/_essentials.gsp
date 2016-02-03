<%-- Comments --%>
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
        <span class="btn btn-default fbShareForSmallDevices manage-fb-color fbshare-header mange-mobile-fb">
            <i class="fa fa-facebook manage-fb-padding"></i> SHARE ON FACEBOOK
        </span>
    </g:if>
    <g:if test="${project.draft}">
        <div class="submitForApprovalSection">
            <g:if test="${project.organizationIconUrl && project.webAddress && (project.charitableId || project.paypalEmail || project.payuEmail) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                <g:form controller="project" action="saveasdraft" id="${project.id}">
                    <g:if test="${!project.touAccepted}">
                        <div class="form-group manage-check-box-ondraft">
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
                <button class="btn btn-block btn-primary" id="submitForApprovalBtnMobile">
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
        <div class="manage-socials-facebook"></div>
        <span class="btn btn-default fbShareForLargeDevices manage-fb-color mange-size-FBbtn" id="fbshare">
            <i class="fa fa-facebook manage-fb-padding"></i> SHARE ON FACEBOOK
        </span>
    </g:if>
    <g:if test="${!project.draft && !project.validated}">
        <div class="manage-socials-facebook"></div>
        <span class="btn btn-default fbShareForLargeDevices manage-fb-color mange-size-FBbtn show-pointer-not">
            <i class="fa fa-facebook manage-fb-padding"></i> SHARE ON FACEBOOK
        </span>
    </g:if>
    <g:if test="${project.draft}">
        <div class="submitForApprovalSectionbtm" id="submitForApprovalSectionbtm">
            <g:if test="${project.organizationIconUrl && project.webAddress && (project.charitableId || project.paypalEmail || project.payuEmail) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                <g:form controller="project" action="saveasdraft" id="${project.id}">
                    <g:if test="${!project.touAccepted}">
                        <div class="form-group manage-check-box-ondraft">
                            <input type="checkbox" name="submitForApprovalcheckbox1">  I accept <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
                        </div>
                    </g:if>
                    <div class="clear"></div>
                    <div class="mange-btn-submitapproval"></div>
                    <button class="btn btn-block btn-primary"><i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval</button>
                </g:form>
            </g:if>
            <g:else>
                <div class="mange-btn-submitapproval"></div>
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
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 hidden-xs">
        <div class="col-xs-12 <g:if test="${hashTagsDesktop || hashTagsTabs}">managecampaign-hashtag </g:if> manage-social">
	        <a class="share-mail pull-left social" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail">
	            <img src="//s3.amazonaws.com/crowdera/assets/show-e-mail-light-gray.png" class="show-email" alt="Email Share">
	        </a>
	        <a class="twitter-share pull-left social" id="twitterShare" target="_blank">
	            <img src="//s3.amazonaws.com/crowdera/assets/show-twitter-gray.png" class="show-twitter" alt="Twitter Share">
	        </a>
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
	        <span class="showing-hashtags showing-hashtags-desktop hashtags-padding-left">${hashTagsDesktop}</span>
            <span class="showing-hashtags showing-hashtags-tabs hashtags-padding-left">${hashTagsTabs}</span>
        </div>
    </div>
</g:if>
<g:else>
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 hidden-xs">
        <div class="col-xs-12 <g:if test="${hashTagsDesktop || hashTagsTabs}">managecampaign-hashtag </g:if> manage-social">
            <span class="pull-left social show-pointer-not" href="#">
                <img src="//s3.amazonaws.com/crowdera/assets/show-e-mail-light-gray.png" class="show-email" alt="Email Share">
            </span>
            <span class="pull-left social show-pointer-not">
                <img src="//s3.amazonaws.com/crowdera/assets/show-twitter-gray.png" class="show-twitter" alt="Twitter Share">
            </span>
            <span class="social share-linkedin pull-left show-pointer-not">
                <img src="//s3.amazonaws.com/crowdera/assets/show-linkedin-gray.png" class="show-linkedin" alt="LinkedIn Share">
            </span>
            <span class="social google-plus-share pull-left show-pointer-not">
                <img src="//s3.amazonaws.com/crowdera/assets/show-google-gray.png" class="show-google" alt="Google+ Share">
            </span>
            <span href="#" class="pull-left embedIcon-manage-left social hidden-xs show-pointer-not"><img src="//s3.amazonaws.com/crowdera/assets/embedicon-grey.png" class="show-embedIcon" alt="embedicon"></span>
            <div class="popoverClassManagePage">
                <span data-title="Copy this short url and share &nbsp;&nbsp;&nbsp;" class="pull-left glyphicon glyphicon-link glyphicon-design glyphicon-show-link-color show-pointer-not"></span>
            </div>
            <div class="popoverClassMobManagePage">
            </div>
            <span class="showing-hashtags showing-hashtags-desktop hashtags-padding-left">${hashTagsDesktop}</span>
            <span class="showing-hashtags showing-hashtags-tabs hashtags-padding-left">${hashTagsTabs}</span>
        </div>
    </div>
</g:else>

<div class="clear"></div>

<div class="col-md-8 col-sm-8 col-xs-12 mange-story-imgs">
    <div class="panel panel-default managecampaignDescription">
        <div class="panel-body">
            <p class="campaignDescription justify">${raw(project.description)}</p>
        </div>
    </div>
    <p class="campaignStory justify">${raw(project.story)}</p>
    
    <g:if test="${spendCauseList && spendAmountPerList}">
        <h4><b>Campaign money will be used as</b></h4>
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
    
    <div class="hidden-xs">
        <g:if test="${remainingTagsDesktop}">
            <h3 class="moretags-desktop"><b>#Tags</b></h3>
            <p class="moretags-desktop">${remainingTagsDesktop}</p>
        </g:if>
        <g:if test="${remainingTagsTabs}">
            <h3 class="moretags-tabs"><b>#Tags</b></h3>
            <p class="moretags-tabs">${remainingTagsTabs}</p>
        </g:if>
    </div>
    
</div>

<div class="col-sm-4 col-xs-12">
    <g:if test="${project.impactNumber > 0 && project.impactAmount > 0}">
        <div class="impactassessment">
            <g:render template="show/impactstatement"/>
        </div>
    </g:if>
    
    <g:if test="${reasons}">
        <div class="modal-footer tile-footer perks-style reasons-title">
            <h2 class="rewardsectionheading text-center">3 Reasons to Fund Our Campaign</h2>
        </div>
        <g:if test="${reasons.reason1}">
            <div class="reasonsToFund">
                <div class="reasonspadding">
                    <div class="col-xs-2 col-plr-0">
                        <span class="badge1">#1</span>
                    </div>
                    <div class="col-xs-10 col-p-5">
                        ${reasons.reason1}
                    </div>
                </div>
            </div>
        </g:if>
        <g:if test="${reasons.reason2}">
            <div class="reasonsToFund">
                <div class="reasonspadding">
                    <div class="col-xs-2 col-plr-0">
                        <span class="badge1">#2</span>
                    </div>
                    <div class="col-xs-10 col-p-5">
                        ${reasons.reason2}
                    </div>
                </div>
            </div>
        </g:if>
        <g:if test="${reasons.reason3}">
            <div class="reasonsToFund">
                <div class="reasonspadding">
                    <div class="col-xs-2 col-plr-0">
                        <span class="badge1">#3</span>
                    </div>
                    <div class="col-xs-10 col-p-5">
                        ${reasons.reason3}
                    </div>
                </div>
            </div>
        </g:if>
    </g:if>
    
    <br>
    <div class="visible-xs">
        <g:if test="${project.hashtags}">
            <h3 class="moretags-tabs"><b>#Tags</b></h3>
            <p class="moretags-tabs">${project.hashtags}</p>
        </g:if>
    </div>
</div>

<%--   Embed modal--%>
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
    <%--  Modal --%>
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
                            <label>Your Name</label> <input type="text" class="form-control all-place" name="name" placeholder="Name">
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

<%-- Comments --%>
<%
    def base_url = grailsApplication.config.crowdera.BASE_URL
    def fbShareUrl = base_url+"/campaigns/campaignShare"+project.id+"?fr="+project.user.username
    def fundRaiser = user.username
    def shareUrl = base_url+'/c/'+shortUrl;
    def vimeoInt
    def campaignVideoUrl
    def projectTitle = project.title
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
        <span class="btn btn-default fbShareForSmallDevices manage-fb-color fbshare-header mange-mobile-fb sh-social-fbEllipsis">
            <i class="fa fa-facebook manage-fb-padding"></i> I Support ${projectTitle}
        </span>
    </g:if>
    <g:if test="${project.draft}">
        <div class="submitForApprovalSection">
            <g:if test="${project.organizationIconUrl && project.webAddress && ((project.charitableId || project.paypalEmail) || (project.payuEmail || project.citrusEmail)) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                <g:form controller="project" action="saveasdraft" id="${project.id}">
                    <g:if test="${!project.touAccepted}">
                        <div class="form-group manage-check-box-ondraft">
                            <input type="checkbox" name="submitForApprovalcheckbox" id="agreetoTermsandUse">  I accept <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
                        </div>
                    </g:if><br/>
                    <div class="clear"></div>
                    <button class="btn btn-block btn-primary mange-submitapprovs  mange-submitapp-margin manage-submintappro-checkbox">
                        <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
                    </button>
                </g:form>
            </g:if>
            <g:else>
                <button class="btn btn-block btn-primary mange-submitapprovs " id="submitForApprovalBtnMobile">
                    <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
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
    <g:render template="/project/manageproject/manageTilesansTitle" />
    <g:if test="${project.validated && !project.draft}">
        <div class="manage-socials-facebook"></div>
        <span class="btn btn-default fbShareForLargeDevices manage-fb-color mange-size-FBbtn sh-social-fbEllipsis" id="fbshare">
            <i class="fa fa-facebook manage-fb-padding"></i> I Support ${projectTitle}
        </span>
    </g:if>
    <g:if test="${!project.draft && !project.validated}">
        <div class="manage-socials-facebook"></div>
        <span class="btn btn-default fbShareForLargeDevices manage-fb-color mange-size-FBbtn show-pointer-not sh-social-fbEllipsis">
            <i class="fa fa-facebook manage-fb-padding"></i> I Support ${projectTitle}
        </span>
    </g:if>
    <g:if test="${project.draft}">
        <div class="submitForApprovalSectionbtn managepage-bottom-margin" id="submitForApprovalSectionbtn">
            <g:if test="${project.organizationIconUrl && project.webAddress && (project.charitableId || project.paypalEmail || project.payuEmail || project.citrusEmail) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                <g:form controller="project" action="saveasdraft" id="${project.id}">
                    <g:if test="${!project.touAccepted}">
                        <div class="form-group manage-check-box-ondraft">
                            <input type="checkbox" name="submitForApprovalcheckbox1">  I accept <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
                        </div>
                    </g:if>
                    <div class="clear"></div>
                    <div class="mange-btn-submitapproval"></div>
                    <button class="btn btn-block btn-primary mange-submitapprovs manage-submintappro-checkbox"><i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL</button>
                </g:form>
            </g:if>
            <g:else>
                <div class="mange-btn-submitapproval"></div>
                <button class="btn btn-block btn-primary mange-submitapprovs manage-submit" id="submitForApprovalBtn"><i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL</button>
            </g:else>
        </div>
    </g:if>
    <br>
</div>

<%-- Social features --%>
<g:hiddenField name="fbShareUrl" id="fbShareUrl" value="${fbShareUrl}"/>
<g:hiddenField name="shareUrl" id="shareUrl" value="${shareUrl}"/>
<g:hiddenField name="embedTileUrl" id="embedTileUrl" value="${embedTileUrl}"/>


<div class="col-md-8 col-sm-8 col-xs-12 mange-story-imgs">


<g:if test="${project.validated}">
    <div class="hidden-xs">
        <div class="<g:if test="${hashTagsDesktop || hashTagsTabs}">managecampaign-hashtag </g:if> manage-social">
            <div class="show-social-icons">
            <a class="share-mail pull-left social" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail">
                <img src="//s3.amazonaws.com/crowdera/assets/82677812-3c6f-404d-80c2-7e3f77c60cf9.png" class="show-email" alt="Email Share">
            </a>
            <a class="twitter-share pull-left social" id="twitterShare" target="_blank">
                <img src="//s3.amazonaws.com/crowdera/assets/823f1cf6-49fe-4ec2-a0dd-2d2a437ad081.png" class="show-twitter" alt="Twitter Share">
            </a>
            <a class="social share-linkedin pull-left" href="https://www.linkedin.com/cws/share?url=${shareUrl}"  id="share-linkedin" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                <img src="//s3.amazonaws.com/crowdera/assets/8a7fbe36-68f8-401e-8644-5780d656d298.png" class="show-linkedin" alt="LinkedIn Share">
            </a>
            <a class="social google-plus-share pull-left" id="googlePlusShare" href="https://plus.google.com/share?url=${shareUrl}" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                <img src="//s3.amazonaws.com/crowdera/assets/ccda789b-4001-4c95-a65f-38c0b9a7a474.png" class="show-google" alt="Google+ Share">
            </a>
            <a href="#" data-toggle="modal" data-target="#embedTilemodal" target="_blank" class="pull-left embedIcon-manage-left social hidden-xs"><img src="//s3.amazonaws.com/crowdera/assets/264961c1-5e35-4357-a68b-8494e63ac04e.png" class="show-embedIcon" alt="embedicon"></a>
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
            
            <span class="showing-hashtags showing-hashtags-desktop hashtags-padding-left">${hashTagsDesktop}</span>
            <span class="showing-hashtags showing-hashtags-tabs hashtags-padding-left">${hashTagsTabs}</span>
        </div>
    </div>
</g:if>
<g:else>
    <div class="hidden-xs">
        <div class="<g:if test="${hashTagsDesktop || hashTagsTabs}">managecampaign-hashtag </g:if> manage-social">
            <div class="show-social-icons">
            <span class="pull-left social show-pointer-not" href="#">
                <img src="//s3.amazonaws.com/crowdera/assets/82677812-3c6f-404d-80c2-7e3f77c60cf9.png" class="show-email" alt="Email Share">
            </span>
            <span class="pull-left social show-pointer-not">
                <img src="//s3.amazonaws.com/crowdera/assets/823f1cf6-49fe-4ec2-a0dd-2d2a437ad081.png" class="show-twitter" alt="Twitter Share">
            </span>
            <span class="social share-linkedin pull-left show-pointer-not">
                <img src="//s3.amazonaws.com/crowdera/assets/8a7fbe36-68f8-401e-8644-5780d656d298.png" class="show-linkedin" alt="LinkedIn Share">
            </span>
            <span class="social google-plus-share pull-left show-pointer-not">
                <img src="//s3.amazonaws.com/crowdera/assets/ccda789b-4001-4c95-a65f-38c0b9a7a474.png" class="show-google" alt="Google+ Share">
            </span>
            <span href="#" class="pull-left embedIcon-manage-left social hidden-xs show-pointer-not"><img src="//s3.amazonaws.com/crowdera/assets/264961c1-5e35-4357-a68b-8494e63ac04e.png" class="show-embedIcon" alt="embedicon"></span>
            <div class="popoverClassManagePage">
                <span data-title="Copy this short url and share &nbsp;&nbsp;&nbsp;" class="pull-left glyphicon glyphicon-link glyphicon-design glyphicon-show-link-color show-pointer-not"></span>
            </div>
            <div class="popoverClassMobManagePage">
            </div>
            </div>
            <span class="showing-hashtags showing-hashtags-desktop hashtags-padding-left">${hashTagsDesktop}</span>
            <span class="showing-hashtags showing-hashtags-tabs hashtags-padding-left">${hashTagsTabs}</span>
            
        </div>
    </div>
</g:else>




    <div class="manage-Descriptions">
       
            <p class="campaignDescription justify">${raw(project.description)}</p>
            <div class="checkStory read-more">
                <p class="campaignStory justify">${raw(project.story)}</p>
             </div>
    </div>
   
    
    <div class="hidden-xs visible-sm manage-extra-moretags">
        <g:if test="${remainingTagsDesktop}">
            <h4 class="moretags-desktop col-lg-3 col-sm-3 col-md-3 tags-managepagewidth"><b>More tags:</b></h4>
            <p class="moretags-desktop col-lg-9 col-sm9 col-md-9">${remainingTagsDesktop}</p>
        </g:if>
        <g:if test="${remainingTagsTabs}">
            <h4 class="moretags-tabs col-lg-3 col-sm-3 col-md-3 tags-managepagewidth"><b>More tags:</b></h4>
            <p class="moretags-tabs col-lg-9 col-sm-9 col-md-9">${remainingTagsTabs}</p>
        </g:if>
    </div>
   
    <br>
    <div class="visible-xs mobile-mngcmpg-tags">
        <g:if test="${project.hashtags}">
            <h3 class="moretags-tabs"><b>#More tags</b></h3>
            <p class="moretags-tabs">${project.hashtags}</p>
        </g:if>
    </div>
    
    <div class="show-matrix-bg">
        <g:if test="${spendCauseList && spendAmountPerList}">
            <h4><b>Campaign money will be used as</b></h4>
            <div id="chart-container">
                <g:hiddenField name="spendCauseList" value="${spendCauseList}" id="spendCauseList"/>
                <g:hiddenField name="spendAmountPerList" value="${spendAmountPerList}" id="spendAmountPerList"/>
    <%--            <g:hiddenField name="payuStatus" id="payuStatus" value="${project.payuStatus}"/>--%>
                <div id="graph"></div>
            </div>
            <script src="/js/raphel-pie/raphael-min.js"></script>
            <script src="/js/raphel-pie/g.raphael.js"></script>
            <script src="/js/raphel-pie/g.pie.js"></script>
        </g:if>
    </div>
    <br>
</div>

<div class="col-sm-4 col-xs-12">
    <g:if test="${project.impactNumber > 0}">
        <div class="show-impact">
            <g:render template="show/showImpactstatement"/>
        </div>
    </g:if>
    
    <div class="show-reasons-fund-bgpadding">
        <g:if test="${reasons && (reasons.reason1 || reasons.reason2 || reasons.reason3)}">
            <div class="tile-footer reasons-title">
                <h2 class="rewardsectionheading text-center">3 Reasons to Fund Our Campaign</h2>
            </div>
            <g:if test="${reasons.reason1}">
                <div class="reasonsToFund">
                    <div class="reasonspadding">
                        <div class="col-xs-2 col-plr-0">
                            <span class="badge1">#1</span>
                        </div>
                        <div class="manage-reasons-des">
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
                        <div class="manage-reasons-des">
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
                        <div class="manage-reasons-des">
                            ${reasons.reason3}
                        </div>
                    </div>
                </div>
            </g:if>
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
                                <g:link  target="_blank" controller="project" action="show" params="['fr': vanityUsername, 'projectTitle':vanityTitle]">
                                      <img class="embed-logo" id="embedHover"  alt="Crowdera" src="https://s3.amazonaws.com/crowdera/project-images/7054ed14-deb4-4be9-a273-43b49c9a3d18.png"/>
                                 </g:link>
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

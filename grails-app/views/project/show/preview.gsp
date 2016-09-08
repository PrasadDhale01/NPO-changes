<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    def beneficiary = project?.user
    def beneficiaryUserName = beneficiary?.username
    def fundRaiserName
    if(currentFundraiser.email == project.beneficiary.email){
        if (project.beneficiary?.lastName)
            fundRaiserName = (project.beneficiary?.firstName + " " + project.beneficiary?.lastName).toUpperCase()
        else 
            fundRaiserName = (project.beneficiary?.firstName).toUpperCase()
    } else {
        fundRaiserName = (currentFundraiser?.firstName + " " + currentFundraiser?.lastName).toUpperCase()
    }
    def username = currentFundraiser?.username
    
    def projectTitle = project.title
    if (projectTitle) {
        projectTitle = projectTitle.toUpperCase(Locale.ENGLISH)
    }
    def imageUrl = project.imageUrl
    if (imageUrl) {
        imageUrl = project.imageUrl[0].getUrl()
    }
    def fbShareUrl = base_url+"/project/campaignShare?id="+project.id+"&fr="+username
    def fbShareUrlupdatePage = base_url+"/project/updateShare?id="+project.id+"&fr="+username
    
    def currentTeamAmount = currentTeam?.amount
    def shareUrl = base_url+'/c/'+shortUrl
    
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
    
    boolean videoFlag=false;
    if(isCampaignAdmin || (currentTeam?.user == project?.user)){
        if(campaignVideoUrl != null && !campaignVideoUrl.isEmpty() )
        {
            videoFlag=true;
        }
    }else{
        if(currentTeam.videoUrl != null && !currentTeam.videoUrl.isEmpty()){
            videoFlag=true;
            campaignVideoUrl =currentTeam.videoUrl;
        }
       
    }
    
    def embedTileUrl = base_url+'/campaign/'+vanityTitle+'/'+vanityUsername+'/embed/tile'
    def embedCode = '<iframe width="310px" height="451px" src="'+embedTileUrl+'" scrolling="no" frameborder="0"  class="embedTitleUrl"></iframe>'
    def embedVideoCode = '<iframe width="480" height="360" frameborder="0" src="'+campaignVideoUrl+'" scrolling="no"></iframe>'
    
    def ss = '/layouts/show_teamtileInfo'
%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="https://www.facebook.com/2008/fbml">
<head>
    <title>Crowdera- ${project.title}</title>
    <meta name="title" content="${project.title} - Crowdera" />
    <g:if test="${project.description}">
        <meta name="description" content="${project.description}" />
    </g:if>
    <meta name="keywords" content="Crowdera, crowdfunding, contribute online, raise funds free, film crowdfunding, raise money online, fundraising site, fundraising website, fundraising project, online fundraising, raise money for a cause, global crowdfunding, (${project.organizationName}, ${project.beneficiary.country}, ${project.category} ,${project.usedFor})" />
    
    <meta property="og:site_name" content="Crowdera" />
    <meta property="og:type" content="website" />
    <meta property="og:title" content="${project.title} by ${project?.beneficiary?.firstName}" />
    <g:if test="${project.description}">
        <meta property="og:description" content="${project.description} Crowdfunding is a practical and inspiring way to support the fundraising needs of a cause or community. Do some good. Make a Contribution Today!" />
    </g:if>
    <g:if test="${project.organizationIconUrl}">
        <meta property="og:image" content="${project.organizationIconUrl}" />
    </g:if>
    <g:elseif test="${imageUrl}">
        <meta property="og:image" content="${imageUrl}" />
    </g:elseif>
    <meta property="og:url" content="${fbShareUrl}" />
    
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:site" content="@gocrowdera" />
    <meta name="twitter:domain" content="${base_url}" />
    <meta name="twitter:title" content="${project.title}" />
    <g:if test="${project.description}">
       <meta name="twitter:description" content="${project.description}" />
    </g:if>
    
    <g:if test="${project.organizationIconUrl}">
        <meta property="twitter:image" content="${project.organizationIconUrl}" />
    </g:if>
    <g:elseif test="${imageUrl}">
        <meta property="twitter:image" content="${imageUrl}" />
    </g:elseif>
    
    <meta name="layout" content="main" />
    
    
    <r:require modules="projectshowjs"/>
    <g:javascript>
        $(function() {
            $('.redactorEditor').redactor({
                imageUpload:'/project/getRedactorImage',
                imageResizable: true,
                plugins: ['video','fontsize', 'fontfamily', 'fontcolor'],
                buttonsHide: ['indent', 'outdent', 'horizontalrule', 'deleted']
            });
       });
    </g:javascript>
    <script>
        function submitCampaignShowForm(key,projectId, fr){
            $.ajax({
                type    :'post',
                url     : $("#b_url").val()+'/project/urlBuilder',
                data    : "projectId="+projectId+"&fr="+fr+"&pkey="+key,
                success : function(response){
                         $(location).attr('href', response);
                }
            }).error(function(){
                console.log("Error in redirecting");
            });
        }
    </script>
    
</head>
<body>
<div class="feducontent campaign-bg-color">
    <g:if test="${isPreview}">
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <div class="preview-banner-margin" id="preview-banner">
                You are in preview mode. This is how your campaign will look like once it is live. Please note some links might not work in preview mode. If you like how your campaign has shaped up, Submit it for approval! 
            </div><br>
       </g:if>
       <g:else>
           <div class="preview-banner" id="preview-banner">
               You are in preview mode. This is how your campaign will look like once it is live. Please note some links might not work in preview mode. If you like how your campaign has shaped up, Submit it for approval! 
           </div><br>
       </g:else>
    </g:if> 
    <div class="container show-cmpgn-container">
        <g:hiddenField name="teamId" id="teamId" value="${currentTeam.id}"/>
        <g:hiddenField name="campaignId" id="campaignId" value="${project.id }"/>
        <g:hiddenField name="fbShareUrl" id="fbShareUrl" value="${fbShareUrl}"/>
        <g:hiddenField name="pieList" value="${pieList}" id="pieList"/>
        <g:hiddenField name="projectamount" value="${project?.amount.round()}" id="projectamount"/>
        <g:hiddenField name="fbShareUrlupdatePage" value="${fbShareUrlupdatePage}" id="fbShareUrlupdatePage"/>
        <g:hiddenField id="payuStatus" name="payuStatus" value="${project.payuStatus}"/>
        
        <g:if test="${project}">
        	<g:hiddenField name="currentEnv" value="${currentEnv}" id="currentEnv"/>
            <div class="redirectUrl">
                <g:link controller="project" action="show" params="['fr': vanityUsername, 'projectTitle':vanityTitle]"></g:link>
            </div>
            
            <div class="row">
            	<g:if test="${flash.prj_mngprj_message}">
                    <div class="alert alert-success show-msz" align="center">
                        ${flash.prj_mngprj_message}
                    </div>
                </g:if>
                
                <g:if test="${flash.teamUpdatemessage}">
                    <div class="alert alert-success show-msz" align="center">
                        ${flash.teamUpdatemessage}
                    </div>
                </g:if>
                
                <g:if test="${flash.add_campaign_supporter}">
                    <div class="alert alert-success show-msz" align="center">
                        ${flash.add_campaign_supporter}
                    </div>
                </g:if>
                
                 <g:if test="${isPreview}">
                    <g:if test="${tile == 'false'}">
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 backToCreatePage">
                            <a href="/campaign/start/${vanityTitle}">&lt;&lt; Back to Create Page</a>
                        </div>
                    </g:if>
                    <div class="<g:if test="${tile == 'false'}">col-lg-8 col-md-8 col-sm-8 col-xs-12 hidden-xs </g:if>green-heading text-center campaignTitle">
                        <h1>${projectTitle}</h1>
                    </div>
                </g:if>
                
                <g:if test="${user || beneficiary}">
                    <div class="col-md-12 col-sm-12 col-xs-12 text-right campaignFundRaiser hidden-xs">
                        <h4 class="green-heading col-lg-4 pull-right">
                            <img class="show-location hidden" alt="location" src="//s3.amazonaws.com/crowdera/assets/show-page-locations.png">
                            <span class="hidden"><g:if test="${project?.user?.city}">${project?.user?.city},</g:if> ${project.beneficiary.country}</span>
                            <g:if test = "${project.fundsRecievedBy != null }">
                                <img class="show-location sh-none-pft" alt="location" src="//s3.amazonaws.com/crowdera/assets/1d4fda56-5ee2-41f7-99a3-0528eda93aed.png">
                                <span class="show-nonpft">${project.fundsRecievedBy}</span>
                            </g:if>
                            <g:if test="${project?.webAddress}">
                                <a href="${webUrl}" target="_blank" class="show-web-address">
                                    <img src="//s3.amazonaws.com/crowdera/assets/76ed02b5-f6f2-4d60-a583-7833998b3d5a.png" alt="website">
                                    <span class="show-nonpft">Website</span>
                                </a> 
                            </g:if>
                        </h4>
                    </div>
                </g:if>
                
                <g:if test="${currentFundraiser != beneficiary}">
                    <div class="col-xs-12 visible-xs text-center">
                        <label class="text-center">Fundraiser : </label>
                            <h5><b class="text-center">${currentFundraiser?.firstName} ${currentFundraiser?.lastName}</b></h5>
                    </div>
                </g:if>
                
                <div class="col-xs-12 col-md-4 mobileview-top sh-mobiles-top campaign-tile-xs">
                	<div class="visible-xs">
                        <g:render model="['project': project]" template="/layouts/tile_for_mobile"></g:render>
                    </div>
                    
                     <g:if test="${isPreview && !project.validated}">
                        <div class="show-tilemobile visible-xs">
                            <g:render template="/user/user/tilemobile" model="['project': project]"></g:render>
                        </div>
                        
                        <div class="submitForApprovalSection">
                            <g:if test="${project.organizationIconUrl && project.webAddress && (project.charitableId || project.paypalEmail || project.payuEmail) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                                <g:form controller="project" action="saveasdraft" id="${project.id}">
                                    <g:if test="${!project.touAccepted}">
                                        <div class="form-group hidden">
                                            <input type="checkbox" name="submitForApprovalcheckbox" id="agreetoTermsandUse">  I accept <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
                                        </div>
                                    </g:if>
                                    <div class="clear"></div>
                                    <div class="show-mobile-button">
                                        <button class="btn btn-block btn-lg sh-submitapproval  show-mob-mobile">
                                            <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
                                        </button>
                                    </div>
                                </g:form>
                            </g:if>
                            <g:else>
                                <div class="show-mobile-button">
                                    <button class="btn btn-block btn-lg show-mob-mobile" id="submitForApprovalBtnMobile">
                                        <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
                                    </button>
                                </div>
                            </g:else>
                        </div>
                        
                        <div class="hidden-xs">
                            <g:render template="/layouts/show_tilesanstitle" model="['currentTeamAmount':currentTeamAmount]"/>
                        </div>
                    </g:if>
                    
                    <div class="panel-body show-mobile-slogn visible-xs">
                        <p>Crowdera is free, we do not charge any fee Payments are securely made via Paypal</p>
                   </div>
                   
                   <%-- Mobile share FB--%>
                   <g:if test="${isPreview}">
                       <a class="btn btn-social btn-facebook show-mobilebt-fb mob-show-fb sho-fb-color hidden">
                           <i class="fa fa-facebook fa-facebook-styles sh-fb-icons"></i>Share on Facebook
                       </a>
                   </g:if>
                   
                </div><!-- Mobile view -->
                
                
                <div class=" hidden-xs navbar navbar-default show1-Primary show-header-navtabs">
                	
                	<div class="navbar-header show-header-height">
                        <div class="sh-secandary-header-showpage">        
                            <a href="/" class="navbar-brand show-secandarylog-top sh-logo-color">
                                <img alt="Crowdera" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo.png" class="sh-safari2header-padding">
                            </a>
                        </div>
                    </div>
                    
                    <div class="collapse navbar-collapse col-lg-8 col-sm-8 col-md-8 show-header-tabsmanage show-tabsDesktop-headers">
                        <ul class="nav nav-pills nav-justified nav-justi sh-tabs show-pages-width">
                        
                            <li><span class="active show-tbs-right-borders  hidden-xs">
                                    <a href="#essentials" data-toggle="tab" class="show-tabs-text essentials showStoryTemplate show-all-icons-header-tabs show-story">
                                        <span class="tab-text sh-tabs-font hidden-xs"> STORY</span>
                                    </a>
                                </span>
                            </li>
                            <g:if test="${!project?.projectUpdates.isEmpty() }">
                                <li><span class="show-tbs-right-borders hidden-xs">
                                        <a href="#projectupdates" data-toggle="tab"  class="show-tabs-text projectupdates showUpdateTemplate show-all-icons-header-tabs">
                                            <span class="tab-text sh-tabs-font hidden-xs"> UPDATES</span> 
                                        </a>
                                        <span class="show-tabs-count hidden-xs">
                                            <g:if test="${project?.projectUpdates?.size() > 0}">${project?.projectUpdates?.size()}</g:if>
                                        </span>
                                    </span>
                                </li>
                            </g:if>
                            <li><span class="show-tbs-right-borders hidden-xs">
                                    <a href="#manageTeam" data-toggle="tab"  class="show-tabs-text manageTeam showTeamTemplate show-all-icons-header-tabs">
                                        <span class="tab-text sh-tabs-font"> TEAMS</span>
                                    </a>
                                </span>
                            </li>
                            <li><span class="show-tbs-right-borders hidden-xs">
                                    <a href="#contributions" data-toggle="tab"  class="show-tabs-text contributions showContributionTemplate show-all-icons-header-tabs">
                                        <span class="tab-text sh-tabs-font"> CONTRIBUTIONS</span>
                                    </a>
                                    <span class="show-tabs-count hidden-xs">
                                        <g:if test="${totalContributions?.size() > 0}">${totalContributions?.size()}</g:if>
                                    </span>
                                </span>
                            </li>
                            <li><span class="show-comit-lft hidden-xs">
                                   <a href="#essentials" data-toggle="tab"  class="show-tabs-text comments showCommentTemplate navComment scrollToComment">
                                       <span class="tab-text hidden-xs sh-tabs-font"> COMMENTS</span>
                                   </a>
                                </span>
                            </li>
                        </ul>
                    </div>
                    
                    <g:if test="${isPreview && !project.validated}">
                        <ul class="nav navbar-nav navbar-right col-lg-6 col-sm-6 col-md-6 show-paddingsbtn-submitapprov">
                            <li class="show-margin-right">
                                <div class="submitForApprovalSectionbtn show-headerApproval-tooltip show-submit-tabs">
                                    <g:if test="${project.organizationIconUrl && project.webAddress && (project.charitableId || project.paypalEmail || project.payuEmail) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                                        <g:form controller="project" action="saveasdraft" id="${project.id}">
                                            <g:if test="${!project.touAccepted}">
                                                <div class="form-group hidden">
                                                    <input type="checkbox" name="submitForApprovalcheckbox1">  I accept <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
                                                </div>
                                            </g:if>
                                            <div class="clear"></div>
                                                        
                                            <button class="btn btn-block btn-lg btn-primary sh-submitaproval-2header-btn sh-aproval-btn hidden-xs">
                                                <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
                                            </button>
                                        </g:form>
                                    </g:if>
                                    <g:else>
                                        <button class="btn btn-block btn-lg btn-primary sh-submitaproval-2header-btn sh-aproval-btn hidden-xs" id="submitForApprovalBtnright">
                                            <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
                                        </button>
                                    </g:else>
                                </div>
                            </li>
                        </ul>
                    </g:if>
                </div><!-- mobile navbar -->
                
                
                <div class="show-socialheads">
                	
                	<div class="navbar navbar-default col-lg-12 hidden-sm col-md-12 sh-tabs hidden-xs sh-shareicons-Fixedtophead">
                		
                		<div class="col-lg-6 col-lg-push-3 col-sm-6 col-md-push-3 col-md-6 <g:if test="${project?.projectUpdates}">show-share-headerpadding
                		</g:if><g:else>show-headered-without-update</g:else> show-headers-icons">
                		
                			 <%-- Social features --%>
                           <g:if test="${isPreview}">
                               <a class="share-mail pull-left show-icons-secandheader show-email-hover show-pointer-not">
                                   <img src="//s3.amazonaws.com/crowdera/assets/0fea8e3c-7e84-4369-a5a0-451585c06492.png" class="show-email" alt="Mail Share">
                               </a>
                               <a class=" pull-left show-icons-secandheader show-pointer-not">
                                   <img src="//s3.amazonaws.com/crowdera/assets/543485b8-21d6-4144-9c30-c0e49c95c4e6.png" class="show-twitter" alt="Twitter Share">
                               </a>
                               <a class="pull-left show-icons-secandheader show-pointer-not">
                                   <img src="//s3.amazonaws.com/crowdera/assets/c8836846-373f-45af-a660-ece7f1110ba0.png" class="show-like" alt="campaign-supporter">
                               </a>
                               <a class="social share-linkedin pull-left show-icons-secandheader show-pointer-not" target="_blank">
                                   <img src="//s3.amazonaws.com/crowdera/assets/0d661ddc-4d08-4ad9-a707-cf2e22349989.png" class="show-linkedin" alt="LinkedIn Share">
                               </a>
                               <a class="social google-plus-share pull-left show-icons-secandheader show-pointer-not">
                                   <img src="//s3.amazonaws.com/crowdera/assets/0c536e08-376d-4965-a901-ca42a4b6c4d5.png" class="show-google" alt="Google+ Share">
                               </a>
                               <span class="pull-left show-icons-secandheader show-pointer-not"><img src="//s3.amazonaws.com/crowdera/assets/75ed76bc-3275-4b00-a534-9c4a324cc04e.png" alt="embedicon" class="show-embedIcon"></span>
                               <span class="shortUrlglyphicon glyphicon glyphicon-link glyphicon-show-design-ract glyphicon-show-link-color show-ispriview-headurl show-pointer-not"></span>
                           </g:if>
                		
                		</div><!-- projectupdate -->
                		
                		<div class="col-lg-6 col-md-6 hidden-sm show-share-FB">
                           <g:if test="${isPreview}">
                               <a class="btn btn-block btn-social btn-facebook sh-head-fb-over hidden-xs sho-fb-color show-2ndhead-btnFB ss3 show-pointer-not">
                                   <i class="fa fa-facebook fa-facebook-styles sh-fb-icons sh-iconsfb-header"></i> Share on Facebook
                               </a>
                           </g:if>
                       </div>
                	</div><!-- navbar -->
                </div><!-- show-socialHeads -->
                
                 <%--Tab code for whatsapp, facebook and twitter --%>
               <div class="visible-sm visible-xs sh-tabs-social sh-shareicons-Fixedtophead">
               	
               		<div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
                       <g:if test="${isPreview}">
                           <a class="btn btn-block btn-social btn-facebook sh-head-fb-over show-Allsocialtabs-size show-whats-paddingmobile">
                                <i class="fa fa-facebook show-tabsfooter-fb"></i> 
                           </a>
                       </g:if>
                   </div>
                   
                   <div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
                      <g:if test="${isPreview}">
                          <a href="whatsapp://send?text=${shareUrl}" data-action="share/whatsapp/share" class="btn btn-block btn-social btn-facebook sh-head-fb-over shTabs-whatsapp-color show-Allsocialtabs-size show-whats-paddingmobile">
                              <img src="//s3.amazonaws.com/crowdera/assets/show-tabs-whatsapp-icons.png" class=" show-tabsfooter-fb show-small-whatsappmobile" alt="whatsapp"> 
                          </a>
                      </g:if>
                      <g:elseif test="${isDeviceMobileOrTab}">
                          <a href="whatsapp://send?text=${shareUrl}" data-action="share/whatsapp/share" class="btn btn-block btn-social btn-facebook sh-head-fb-over shTabs-whatsapp-color show-Allsocialtabs-size show-whats-paddingmobile">
                              <img src="//s3.amazonaws.com/crowdera/assets/show-tabs-whatsapp-icons.png" class=" show-tabsfooter-fb show-small-whatsappmobile" alt="whatsapp"> 
                          </a>
                      </g:elseif>
                  </div>
                  
                  <div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
                       <g:if test="${isPreview}">
                           <a class="btn btn-block btn-social btn-facebook sh-head-fb-over shTabs-twitter-color show-Allsocialtabs-size show-whats-paddingmobile">
                               <i class="fa fa-fw fa-twitter show-tabsfooter-fb"></i> 
                           </a>
                       </g:if>
                  </div>
               </div><!-- whatsapp -->
               
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 borders  hidden-xs">
                 	
                 	<g:set var="screen" id="screen" value="false"></g:set>
                    <ul class="nav nav-pills">
                          <li id="show-headeridA"></li> 
                    </ul>
                    
                    <ul class="nav nav-pills nav-justified nav-justi show-marginbottoms sh-tabs mng-safari-mobile show-new-tabs-alignments<g:if test="${!project?.projectUpdates.isEmpty()}"> TW-show-updateTab-width </g:if><g:else> mng-dt-tabs </g:else>">
                        
                        <li class="show-tabs"><span class="active show-tbs-right-borders  hidden-xs">
                                <a href="#essentials" data-toggle="tab" class="show-tabs-text show-js-fileA essentials showStoryTemplate show-campaigndetails-font">
                                    <span class="tab-text hidden-xs"> Story</span>
                                </a>
                                <span class="show-ids-header"></span>
                            </span>
                        </li>
                        <g:if test="${!project?.projectUpdates.isEmpty() }">
                            <li><span class="show-tbs-right-borders hidden-xs">
                                    <a href="#projectupdates" data-toggle="tab" class="show-tabs-text projectupdates showUpdateTemplate show-campaigndetails-font">
                                        <span class="tab-text hidden-xs"> Updates</span> 
                                    </a>
                                    <span class="show-tabs-count hidden-xs">
                                        <g:if test="${project?.projectUpdates?.size() > 0}">${project?.projectUpdates?.size()}</g:if>
                                    </span>
                                    <span class="show-ids-header"></span>
                                </span>
                            </li>
                        </g:if>
                        <li><span class="show-tbs-right-borders hidden-xs">
                                <a href="#manageTeam" data-toggle="tab"  class="show-tabs-text show-js-fileB manageTeam showTeamTemplate ss show-campaigndetails-font">
                                    <span class="tab-text"> Teams</span>
                                </a>
                                <span class="show-ids-header"></span>
                            </span>
                        </li>
                        <li><span class="show-tbs-right-borders hidden-xs">
                                <a href="#contributions" data-toggle="tab"  class="show-tabs-text show-js-fileC contributions showContributionTemplate show-campaigndetails-font">
                                    <span class="tab-text"> Contributions</span>
                                </a>
                                <span class="show-tabs-count hidden-xs">
                                    <g:if test="${totalContributions?.size() > 0 && screen == 'false'}">${totalContributions?.size()}</g:if>
                                </span>
                                <span class="show-ids-header"></span>
                            </span>
                        </li>
                        <li><span class="show-comit-lft hidden-xs">
                                <a href="#essentials" data-toggle="tab"  class="show-tabs-text comments scrollToComment showCommentTemplate show-campaigndetails-font">
                                    <span class="tab-text hidden-xs"> Comments</span>
                                </a>
                                <span class="show-ids-header"></span>
                            </span>
                        </li>
                    </ul>
                </div><!-- Hidden xs end -->
                
                 <div class="visible-xs sh-mobiletabs sh-tabs">
                    <span class="sh-mobile-tabs">
                        <a href="#manageTeam" data-toggle="tab" class="show-tabs-text show-tbs-right-borders manageTeamMob">
                            <span class="tab-text"> TEAMS</span>
                        </a>
                    </span>
                    <span class="sh-mobile-tabs">
                        <a href="#contributions" data-toggle="tab"  class="show-tabs-text  contributionsMob">
                            <span class="tab-text"> CONTRIBUTIONS</span>
                        </a>
                    </span>
                </div> 
                
                <div class="col-xs-12 col-md-8 col-sm-8 Top-tabs-mobile show-tops-corsal">
                
                    <%-- Tab panes --%>
                    <div class="tab-content">
                        <div class="tab-pane tab-pane-active active hidden-xs" id="essentials">
                            <g:render template="show/story"/>
                        </div>
                        <div class="tab-pane tab-pane-active hidden-xs" id="projectupdates">
                            <g:render template="show/projectupdates"/>
                        </div>
                        <div class="tab-pane tab-pane-active show-teamspage" id="manageTeam">
                                <g:render template="show/manageteam"/>
                        </div>
                        <div class="tab-pane tab-pane-active" id="contributions">
                            <g:render template="show/contributions" model="['team':currentTeam]"/>
                        </div>
                    </div>
                </div>  
                
                
               <div class="col-xs-12 col-md-4 col-sm-4 show-desk-org-tile show-tops-corsal">
                    <div class="submitForApprovalSectionbtn" id="submitForApprovalSectionbtn">
                        <g:if test="${project?.organizationIconUrl && project?.webAddress && (project?.charitableId || project?.paypalEmail || project?.payuEmail) && (!project?.imageUrl.isEmpty()) && project?.organizationName && project?.beneficiary?.country && (projectService.getRemainingDay(project) > 0)}">
                            inside if
                            <g:form controller="project" action="saveasdraft" id="${project.id}">
                                <g:if test="${!project?.touAccepted}">
                                    <div class="form-group show-submit-margin hidden-xs">
                                        <input type="checkbox" name="submitForApprovalcheckbox1">  I accept <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
                                    </div>
                                    <div class="show-A-fund"></div>
                                    <button class="btn btn-block btn-lg btn-primary show-submitapproval-in-check-box hidden-xs">
                                        <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
                                    </button>
                                 </g:if>
                                 <g:else>
                                     <div class="clear"></div>
                                     <div class="show-A-fund"></div>
                                     <button class="btn btn-block btn-lg btn-primary sh-submitapproval hidden-xs">
                                         <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
                                     </button>
                                  </g:else>
                             </g:form>
                        </g:if>
                        <g:else>
                            <button class="btn btn-block btn-lg btn-primary sh-submitaproval-2header sh-aproval-btn hidden-xs" id="submitForApprovalBtnright">
                                <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
                           </button>
                        </g:else>
                    </div>
                     <%--  user profile code  --%>
                   <div class="col-lg-12 col-sm-12 col-md-12 show-profile-padding show-org-profiletile hidden-xs">
	                   <div class="col-lg-4 col-sm-4 col-md-4 show-profile-imagewidth">
		                   <g:if test="${user.userImageUrl}">
		                        <div id="partnerImageEditDeleteIcon">
		                            <span  class="show-image-dp">
		                                <img src="${user.userImageUrl}" alt="avatar">
		                            </span>
		                        </div>
		                    </g:if>
		                    <g:else>
		                        <div id="userAvatarUploadIcon">
		                            <span id="useravatar">
		                                <img class="show-user-profile-hw" src="https://s3.amazonaws.com/crowdera/assets/profile_image.jpg" alt="' '">
		                            </span>
		                        </div>
		                    </g:else> 
	                    </div>
	                    <div class="col-lg-8 col-sm-8 col-md-8 show-profile-padding show-tabs-profiledesp">
	                        <div class="show-lbl-orgname">
	                            <label class="col-lg-5 col-sm-5 col-md-5 show-profile">Campaign by:</label>
	                            <g:if test="${project.organizationName && currentFundraiser == beneficiary}">
                                    <span class="col-lg-8 col-sm-8 col-md-8 show-org-name">${project?.organizationName}</span>
                                </g:if>
                                <g:if test="${currentFundraiser != beneficiary}">
                                    <span class="col-lg-8 col-sm-8 col-md-8 show-org-name">${currentFundraiser?.firstName} ${currentFundraiser?.lastName}</span>
                                </g:if>
                            </div>
                            <div class="show-contact-profilefixes col-lg-12 col-sm-12 col-md-12">
                                <div class="col-lg-2 col-sm-2 col-md-2 show-email-profileIcons">
                                    <img class="show-profile-imgs" src="//s3.amazonaws.com/crowdera/assets/1c19404a-4627-4479-94b0-46e49e62471b.png" alt="emails">
                                </div>
                                <div class="col-lg-10 col-sm-10 col-md-10 show-contact-profilefixes">
                                    <span class="col-lg-12 col-sm-12 col-md-12 show-contact-ofOwner">Contact Campaign of Owner</span>
                                </div>
                            </div>
	                    </div> 
                    </div>
                    <div class="clear"></div>
                    
                    <div class="hidden-xs" id="organizationTemplateId"></div>
                        
                   <g:if test="${isPreview}">
                       <div class="clear" ></div>
                       <a class="btn btn-block btn-social btn-facebook show-btn-sh-fb sho-fb-color hidden-xs show-pointer-not">
                           <i class="fa fa-facebook fa-facebook-styles sh-fb-icons"></i>Share on Facebook
                       </a>
                   </g:if>
                          
                    <g:if test="${currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'testIndia'}">
                       <g:if test="${project.impactNumber > 0 && project?.impactAmount > 0}">
                           <div class="show-impact">
                               <g:render template="show/showImpactstatement"/>
                           </div>
                       </g:if>
                    </g:if>
                    
                    <g:if test="${project.hashtags}">
                          <div class="show-more-tags">
	                          <h3 class="moretags-tabs visible-xs"><b>More tags</b></h3>
                              <p class="moretags-tabs visible-xs">
                                  ${project.hashtags}
                              </p>
                          </div>
                      </g:if>
                      
                      <div class="show-reasons">
                      
                      	 <g:if test="${reasons && (reasons.reason1 || reasons.reason2 || reasons.reason3)}">
                      	 		
                      	 	<div class="show-reasons-fund-bgpadding">
                      	 		
                      	 		<span class="show-tri-reasons-to-fund text-center">3 Reasons to Fund Our Campaign</span>
                          		<g:if test="${reasons.reason1}">
                              		<div class="show-reasonsToFund">
                                  		<div class="reasonspadding">
                                      		<span class="badge1 col-lg-2 col-md-2 col-sm-2 col-xs-2">#1</span>
                                      		<div class="show-reasons-des">
                                           		${reasons.reason1}
                                     		</div>
                                  		</div>
                              		</div>
                          		</g:if>
                          		
                          		<g:if test="${reasons.reason2}">
                              		<div class="show-reasonsToFund">
                                  		<div class="reasonspadding">
                                      		<span class="badge1 col-lg-2 col-md-2 col-sm-2 col-xs-2">#2</span>
                                      		<div class="show-reasons-des">
                                          		${reasons.reason2}
                                      		</div>
                                  		</div>
                              		</div>
                          		</g:if>
                          		<g:if test="${reasons.reason3}">
                              		<div class="show-reasonsToFund">
                                  		<div class="reasonspadding">
                                      		<span class="badge1 col-lg-2 col-md-2 col-sm-2 col-xs-2">#3</span>
                                      		<div class="show-reasons-des">
                                          		${reasons.reason3}
                                      		</div>
                                  		</div>
                              		</div>
                          		</g:if>
                      	 	</div><!-- fund bgpadding end -->
                      	 </g:if>
                      	 <g:else>
                      	 		<div class="show-reasons-fund-bgpadding">
                      	 		
                      	 			<span class="show-tri-reasons-to-fund text-center">3 Reasons to Fund Our Campaign</span>
                      	 			<div class="show-reasonsToFund">
                                  		<div class="reasonspadding">
                                  			<span class="badge1 col-lg-2 col-md-2 col-sm-2 col-xs-2">#</span>
                                  		</div>
                              		</div>
                      	 		
                      	 		</div>
                      	 </g:else>
                      </div><!-- show reason end -->
                      
                      <g:if test="${isPreview && !project.validated}">
                          <div class="hidden-xs">
                              <g:if test="${project?.rewards?.size()>1}">
                                  <div class="sh-perks-preview">
                                      <g:render template="show/rewards" model="['username':username, 'isPreview':true]"/>
                                  </div>
                              </g:if>
                          </div>
                      </g:if>
                      
                      <div class="visible-xs show-mobile-update">
                          <g:render template="show/projectupdates"/>
                      </div>
                      
                      <div class="visible-xs sh-mobperks">
                          <g:if test="${isPreview && !project.validated}">
                              <g:if test="${project?.rewards?.size()>1}">
                                  <div class="sh-perks-preview">
                                      <g:render template="show/rewards" model="['username':username, 'isPreview':true]"/>
                                  </div>
                              </g:if>
                          </g:if>
                      </div>
                      
                      <div class="sh-mobperks">    
                          <g:if test="${(project?.rewards?.size()>1 && !isPreview) || (project?.rewards?.size()>1 && project?.validated) }">
                              <g:if test="${project.paypalEmail || project.charitableId || project.payuEmail}">
                                  <g:render template="show/rewards" model="['username':username, 'isPreview':false]"/>
                              </g:if>
                          </g:if>
                      </div>
                      <div class="visible-xs sh-comments-align">
                          <div id="comment-mobile">
                              <g:render template="show/comments"/>
                          </div>
                      </div>
       
                        
               </div><!--desk org end -->
           </div><!-- row end -->
        </g:if><!-- project if end -->
       
    </div><!-- container end -->
</div><!-- feducontent end -->
</body>
</html>
                         
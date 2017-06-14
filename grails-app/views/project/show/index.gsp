<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def baseUrl = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    def base_url = baseUrl.substring(0, (baseUrl.length() - 1))
    
	def country_code = projectService.getCountryCodeForCurrentEnv(request)
	def beneficiary = project?.user
    def beneficiaryUserName = beneficiary?.username
	def managecomments = "show"
    def fundRaiserName
    if(currentFundraiser.email == project.beneficiary.email){
        if (project.beneficiary?.lastName)
            fundRaiserName = (project.beneficiary?.firstName + " " + project.beneficiary?.lastName)?.toUpperCase()
        else 
            fundRaiserName = (project.beneficiary?.firstName)?.toUpperCase()
    } else {
        fundRaiserName = (currentFundraiser?.firstName + " " + currentFundraiser?.lastName)?.toUpperCase()
    }
    def username = currentFundraiser?.username
	def loggedInUser = userService.getCurrentUser() 
    
    def projectTitle = project.title
    if (projectTitle) {
        projectTitle = projectTitle?.toUpperCase(Locale.ENGLISH)
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
    <title>${project.title} by ${project?.beneficiary?.firstName} - Crowdera</title>
    <link rel="canonical" href="${base_url}/campaigns"/>
    <meta name="title" content="${project.title} - Crowdera" />
    <meta name="keywords" content="Crowdera, crowdfunding, contribute online, raise funds free, film crowdfunding, raise money online, fundraising site, fundraising website, fundraising project, online fundraising, raise money for a cause, global crowdfunding, (${project.organizationName}, ${project.beneficiary.country}, ${project.category} ,${project.usedFor})" />
    

    
    <!-------------- Open Graph Data  -------------->
	<meta property="og:site_name" content="GoCrowdera" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="${project.title} by ${project?.beneficiary?.firstName}" />
	<meta property="og:url" content="${fbShareUrl}" />
	<meta name="keywords" content="Simple, secure and easy online fundraising website for all things that matter for individuals and non-profits. Get started for free now! " />
	<g:if test="${project.organizationIconUrl}">
        <meta property="og:image:url" content="${project.organizationIconUrl}" />
    </g:if>
    <g:elseif test="${imageUrl}">
        <meta property="og:image:url" content="${imageUrl}" />
    </g:elseif>
	<g:if test="${project.organizationIconUrl}">
        <meta property="og:image:url" content="${project.organizationIconUrl}" />
    </g:if>
    <g:elseif test="${imageUrl}">
        <meta property="og:image:url" content="${imageUrl}" />
    </g:elseif>
    <g:else>
        <meta property="og:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
    </g:else>
    <g:if test="${project.description}">
        <meta property="og:description" content="${project.description} Crowdera is a free crowdfunding platform. It is a practical and inspiring way to support the fundraising needs of a cause or community. Make a Contribution Today! " />
    </g:if>

    
	<!-------------- Twitter Card Data  -------------->
	
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:site" content="@gocrowdera" />
	<meta property="twitter:title" content="${project.title} by ${project?.beneficiary?.firstName}" />
	<meta name="twitter:domain" content="${fbShareUrl}"/>
	<meta property="twitter:url" content="${fbShareUrl}" />
    <g:if test="${project.organizationIconUrl}">
        <meta property="twitter:image" content="${project.organizationIconUrl}" />
    </g:if>
    <g:elseif test="${imageUrl}">
        <meta property="twitter:image" content="${imageUrl}" />
    </g:elseif>
    <g:else>
        <meta property="twitter:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
    </g:else>
    <g:if test="${project.description}">
       <meta name="twitter:description" content="${project.description} Crowdera is a free crowdfunding platform. It is a practical and inspiring way to support the fundraising needs of a cause or community. Make a Contribution Today! " />
    </g:if>
    <g:else>
    	<meta name="twitter:description" content="Crowdera is a free crowdfunding platform. It is a practical and inspiring way to support the fundraising needs of a cause or community. Make a Contribution Today! " />
    </g:else>
    
    <meta name="layout" content="main" />
    
    <r:require modules="projectshowjs"/>
    <g:javascript>
        $(function() {
            $('.redactorEditor').redactor({
                imageUpload:'/project/getRedactorImage',
                imageResizable: true,
                plugins: ['video','fontsize', 'fontfamily', 'fontcolor'],
                buttonsHide: ['indent', 'outdent', 'horizontalrule', 'deleted', 'formatting']
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
<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
<a href="javascript:" id="returnTotop"> <i class="icon-chevron-up"></i></a>
<div class="feducontent new-mob-height campaign-bg-color">
    <g:if test="${isPreview}">
        <g:if test="${'in'.equalsIgnoreCase(country_code)}">
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
        
        <g:hiddenField name="projectTitle" value="${projectTitle}" id="projectTitle"/>
        <g:if test="${project}">
            <g:hiddenField name="currentEnv" value="${currentEnv}" id="currentEnv"/>
            <g:hiddenField name="campaignOwner" value="${project.user}" id="campaignOwner"/>
            <g:hiddenField name="loggedInUser" value="${loggedInUser}" id="loggedInUser"/>
            <div class="redirectUrl">
                <g:link controller="project" action="show" params="['fr': vanityUsername, 'projectTitle':vanityTitle,'country_code':project.country.countryCode,category:project.fundsRecievedBy.toLowerCase()]" id="redirectLinkShow"></g:link>
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
                <g:else>
                <div class="col-md-12 green-heading campaignTitle text-center hidden-xs">
                    <h1><a href="javascript:void(0)">
                         ${projectTitle}
                    </a></h1>
                </div>
                </g:else>
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
                                    <img src="//s3.amazonaws.com/crowdera/assets/76ed02b5-f6f2-4d60-a583-7833998b3d5a.png" alt="fb-icons">
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
                  
                    <div class="visible-xs loadmobileCampaignTile">
                        <g:render template="/layouts/tile_for_mobile"  model="['project': project]"/>
                    </div>
                    
                    <div class="hidden-xs">
                        <g:render template="/layouts/orgDetails"/>
                    </div>
                    
                    <g:if test="${isPreview && !project.validated}">
                        <div class="show-tilemobile visible-xs">
                            <g:render template="/user/user/tilemobile" model="['project': project]"></g:render>
                        </div>
                        
                        <div class="submitForApprovalSection">
                            <g:if test="${project?.organizationIconUrl && project?.webAddress && (project?.charitableId || project?.paypalEmail || project?.payuEmail || (project?.citrusEmail && project?.sellerId) || (project?.wepayEmail && project?.wepayAccountId != 0) ) && (!project?.imageUrl?.isEmpty()) && project?.organizationName && project?.beneficiary?.country && (projectService?.getRemainingDay(project) > 0)}">
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
                    <g:elseif test="${percentage == 999}">
                        <button type="button" class="btn btn-success btn-lg btn-block mob-show-sucessend" disabled>SUCCESSFULLY FUNDED</button>
                    </g:elseif>
                    <g:elseif test="${ended}">
                        <button type="button" class="btn btn-warning btn-lg btn-block mob-show-sucessend" disabled>CAMPAIGN ENDED!</button>
                    </g:elseif>
                    <g:else>
                        <div class="show-mobile-button">
                            <g:if test="${project.paypalEmail || project.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
                                <g:form controller="fund" action="fund" id="${project.id}" params="['fr': vanityUsername, 'projectTitle':vanityTitle]" class="fundFormMobile">
                                    <button name="submit" class="btn btn-show-fund btn-lg btn-block mob-show-fund show-mobile-fund sh-fund-donate-contri"  id="btnFundMobile">DONATE NOW</button>
                                </g:form>
                            </g:if>
                            <g:elseif test="${(project.payuEmail || project.citrusEmail) && !('in'.equalsIgnoreCase(country_code))}">
                            	<button name="inactiveContributeButton" class="btn btn-show-fund btn-lg btn-block mob-show-fund show-mobile-fund sh-fund-donate-contri">DONATE NOW</button>
                            </g:elseif>
                            <g:else>
                                <button name="contributeButton" class="btn btn-show-fund btn-lg btn-block mob-show-fund show-mobile-fund sh-fund-donate-contri">DONATE NOW</button>
                            </g:else>
                        </div>
                    </g:else>

                   <div class="panel-body show-mobile-slogn visible-xs">
                        <p>Crowdera is free, we do not charge any fee Payments are securely made via Paypal</p>
                   </div>
                   
                   <div class="visible-xs">
                       <g:if test="${!isTeamExist && project.validated}">
                           <g:if test="${!ended}">
                               <g:form controller="project" action="addTeam" id="${project.id}">
                                   <input type="submit" value="Join our Team" class=" col-xs-12 show-mob-btnJoinOur text-center btn btn-block ">
                               </g:form> 
                           </g:if>
                           <g:else>
                               <input type="submit" value="Join our Team" class=" col-xs-12 show-mob-btnJoinOur text-center btn btn-block ">
                           </g:else>
                      </g:if>
                   </div>
                   
                   <%-- Mobile share FB--%>
                   <g:if test="${isPreview}">
                       <a class="btn btn-social btn-facebook show-mobilebt-fb mob-show-fb sho-fb-color hidden">
                           <i class="fa fa-facebook fa-facebook-styles sh-fb-icons"></i>Share (${facebookShare})
                       </a>
                   </g:if>
                   <g:else>
                        <a class="btn btn-social btn-facebook show-mobilebt-fb mob-show-fb sho-fb-color hidden"  id="fbshare-mobile" href="#">
                            <i class="fa fa-facebook fa-facebook-styles sh-fb-icons"></i> Share (${facebookShare})
                        </a>
                   </g:else>
                 
                   <g:if test="${!isPreview || project.validated}">
                       <div class="hidden-xs">
                           <g:render template="/layouts/show_tilesanstitle" model="['currentTeamAmount':currentTeamAmount]"/>
                       </div>
                   </g:if>
                   
                   <div class="hidden-xs">
                       <g:if test="${(project?.rewards?.size()>1 && !isPreview) || (project?.rewards?.size()>1 && project?.validated) }">
                           <g:if test="${project.paypalEmail || project.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
                               <g:render template="show/rewards" model="['username':username, 'isPreview':false]"/>
                           </g:if>
                       </g:if>
                   </div>
                </div>
            
                <div class=" hidden-xs navbar navbar-default show1-Primary show-header-navtabs">  
                    <div class="navbar-header show-header-height">
                        <div class="sh-secandary-header-showpage">        
                            <a href="/" class="navbar-brand show-secandarylog-top sh-logo-color">
                                <img alt="Crowdera" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo.png" class="sh-safari2header-padding">
                            </a>
                        </div>
<%--                        <div class="rightBorder-logo"></div>--%>
                    </div>
                    <div class="collapse navbar-collapse col-lg-8 col-sm-8 col-md-8 show-header-tabsmanage show-tabsDesktop-headers new-nav-align">
                        <ul class="nav nav-pills nav-justified nav-justi sh-tabs show-pages-width">
                                              
                        <li><span class="active show-tbs-right-borders  hidden-xs">
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
                                <span class="show-tabs-count hidden-xs">
                                    <g:if test="${totalteams?.size() > 0}">${totalteams?.size()}</g:if>
                                </span>
                            </span>
                        </li>
                        <li><span class="show-tbs-right-borders hidden-xs">
                                <a href="#contributions" data-toggle="tab"  class="show-tabs-text show-js-fileC contributions showContributionTemplate show-campaigndetails-font">
                                    <span class="tab-text"> Contributions</span>
                                </a>
                                <span class="show-tabs-count hidden-xs">
                                        <g:if test="${totalContributions?.size() > 0}">${totalContributions?.size()}</g:if>
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
               
                    </div>
               
                    <g:if test="${isPreview && !project.validated}">
                        <ul class="nav navbar-nav navbar-right col-lg-6 col-sm-6 col-md-6 show-paddingsbtn-submitapprov">
                            <li class="show-margin-right">
                                <div class="submitForApprovalSectionbtn show-headerApproval-tooltip show-submit-tabs">
                                     <g:if test="${project.organizationIconUrl && project.webAddress && (project.charitableId || project.paypalEmail || project.payuEmail || (project.citrusEmail && project?.sellerId) || (project?.wepayEmail && project?.wepayAccountId != 0) ) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                                        <g:form controller="project" action="saveasdraft" id="${project.id}">
                                            <g:if test="${!project.touAccepted}">
                                                <div class="form-group hidden">
                                                    <input type="checkbox" name="submitForApprovalcheckbox1">  I accept <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
                                                </div>
                                            </g:if>
                                            <div class="clear"></div>
                                                        
                                            <button class="btn btn-block btn-lg btn-primary sh-submitaproval-2header sh-aproval-btn hidden-xs">
                                                <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
                                            </button>
                                        </g:form>
                                    </g:if>
                                    <g:else>
                                        <button class="btn btn-block btn-lg btn-primary sh-submitaproval-2header sh-aproval-btn hidden-xs" id="submitForApprovalBtnright">
                                            <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
                                        </button>
                                    </g:else>
                                </div>
                            </li>
                        </ul>
                    </g:if>
                    <g:else>
                        <g:if test="${percentage!=999 && !ended}">
                            <ul class="nav navbar-nav navbar-right col-lg-6 col-sm-6 col-md-6 show-paddingsbtn">
                                <li class="show-margin-right">
                                     <g:if test="${project?.paypalEmail || project?.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || project?.payuEmail || project?.citrusEmail}">
                                        <g:if test="${!'in'.equalsIgnoreCase(project.country?.countryCode) && 'in'.equalsIgnoreCase(country_code)}">
                                            <div class="redirectCampaign">
                                                <g:link class="btn btn-show-fund btn-lg btn-block mob-show-fund sh-fund-2header show-btn-js sh-fund-donate-contri" controller="fund" action="fund" params="['fr': vanityUsername, 'projectTitle':vanityTitle]" id="btnFundDesktop">DONATE NOW</g:link>
                                            </div>
                                        </g:if>
                                        <g:else>
                                        	<g:if test="${project.paypalEmail || project.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
	                                            <g:form controller="fund" action="fund" id="${project.id}" params="['fr': vanityUsername, 'projectTitle':vanityTitle]" class="fundFormMobile">
	                                                <button name="submit" class="btn btn-show-fund btn-lg btn-block mob-show-fund sh-fund-2header show-btn-js sh-fund-donate-contri">DONATE NOW</button>
	                                            </g:form>
                                            </g:if>
                                            <g:elseif test="${(project.payuEmail || project.citrusEmail) && !('in'.equalsIgnoreCase(country_code))}">
				                            	<button name="inactiveContributeButton" class="btn btn-show-fund btn-lg btn-block sh-fund-2header mob-show-fund show-btn-js sh-fund-donate-contri">DONATE NOW</button>
				                            </g:elseif>
                                        </g:else>
                                    </g:if>
                                    <g:else>
                                        <button name="contributeButton" class="btn btn-show-fund btn-lg btn-block sh-fund-2header mob-show-fund show-btn-js sh-fund-donate-contri">DONATE NOW</button>
                                    </g:else>
                                </li>
                            </ul>
                        </g:if>
                    </g:else>
                </div>
                    
               <div class="show-socialheads">
                   <div class="navbar navbar-default col-lg-12 hidden-sm col-md-12 sh-tabs hidden-xs sh-shareicons-Fixedtophead">
                       <div class="col-lg-6 col-lg-push-3 col-sm-6 col-md-push-3 col-md-6 <g:if test="${project?.projectUpdates}">show-share-headerpadding</g:if><g:else>show-headered-without-update</g:else> show-headers-icons">
                       
                           <%-- Social features --%>
                           <g:if test="${isPreview}">
                               <a class="share-mail pull-left show-icons-secandheader show-email-hover show-pointer-not">
                                   <img src="//s3.amazonaws.com/crowdera/assets/82677812-3c6f-404d-80c2-7e3f77c60cf9.png" class="show-email" alt="Mail Share">
                               </a>
                               <a class=" pull-left show-icons-secandheader show-pointer-not">
                                   <img src="//s3.amazonaws.com/crowdera/assets/823f1cf6-49fe-4ec2-a0dd-2d2a437ad081.png" class="show-twitter" alt="Twitter Share">
                               </a>
                               <a class="pull-left show-icons-secandheader show-pointer-not">
                                   <img src="//s3.amazonaws.com/crowdera/assets/9520477b-5b92-475a-ba79-9b35c1a16d3c.png" class="show-like" alt="campaign-supporter">
                               </a>
                               <a class="social share-linkedin pull-left show-icons-secandheader show-pointer-not" target="_blank">
                                   <img src="//s3.amazonaws.com/crowdera/assets/8a7fbe36-68f8-401e-8644-5780d656d298.png" class="show-linkedin" alt="LinkedIn Share">
                               </a>
                               <a class="social google-plus-share pull-left show-icons-secandheader show-pointer-not">
                                   <img src="//s3.amazonaws.com/crowdera/assets/ccda789b-4001-4c95-a65f-38c0b9a7a474.png" class="show-google" alt="Google+ Share">
                               </a>
                               <span class="pull-left show-icons-secandheader show-pointer-not"><img src="//s3.amazonaws.com/crowdera/assets/264961c1-5e35-4357-a68b-8494e63ac04e.png" alt="embedicon" class="show-embedIcon"></span>
                               <span class="shortUrlglyphicon glyphicon glyphicon-link glyphicon-show-design-ract glyphicon-show-link-color show-ispriview-headurl show-pointer-not"></span>
                           </g:if>
                           <g:else>
                               <a class="share-mail pull-left show-icons-secandheader" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" >
                                   <img src="//s3.amazonaws.com/crowdera/assets/82677812-3c6f-404d-80c2-7e3f77c60cf9.png" alt="Mail Share" class="show-email">
                               </a>
                               <a class="twitter-share pull-left show-icons-secandheader" data-url="${shareUrl}" target="_blank">
                                   <img src="//s3.amazonaws.com/crowdera/assets/823f1cf6-49fe-4ec2-a0dd-2d2a437ad081.png" class="show-twitter" alt="Twitter Share">
                               </a>
                               <g:link absolute="true" uri="/campaign/supporter/${project.id}/${username}" class="pull-left show-icons-secandheader">
                                   <img src="//s3.amazonaws.com/crowdera/assets/9520477b-5b92-475a-ba79-9b35c1a16d3c.png" class="show-like" alt="campaign-supporter" >
                               </g:link>
                               <a class="social-header share-linkedin pull-left show-icons-secandheader" href="https://www.linkedin.com/cws/share?url=${shareUrl}" target="_blank"  onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                                   <img src="//s3.amazonaws.com/crowdera/assets/8a7fbe36-68f8-401e-8644-5780d656d298.png" class="show-linkedin" alt="LinkedIn Share">
                               </a>
                               <a class="social-header google-plus-share pull-left show-icons-secandheader" href="https://plus.google.com/share?url=${shareUrl}" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                                    <img src="//s3.amazonaws.com/crowdera/assets/ccda789b-4001-4c95-a65f-38c0b9a7a474.png" class="show-google" alt="Google+ Share">
                               </a>
                               <a href="#" data-toggle="modal" data-target="#embedTilemodal" target="_blank" class="pull-left show-icons-secandheader"><img src="//s3.amazonaws.com/crowdera/assets/264961c1-5e35-4357-a68b-8494e63ac04e.png" class="show-embedIcon" alt="embedicon"></a>
                               <div class="popoverClass">
                                    <span data-title="Copy this short url and share &nbsp;&nbsp;&nbsp;" class="shortUrlglyphiconheader glyphicon glyphicon-link glyphicon-show-design-ract glyphicon-show-link-color show-shortUrlheader-top"></span>
                                    <div class="hidden popoverConent">
                                        <button type="button" class="close">&times;</button>
                                        <p>${shareUrl}</p>
                                    </div>
                               </div>
                           </g:else>
                       </div>
                            
                       <div class="col-lg-6 col-md-6 hidden-sm show-share-FB">
                           <g:if test="${isPreview}">
                               <a class="btn btn-block btn-social btn-facebook show-fb-height sh-head-fb-over hidden-xs sho-fb-color ss3 show-pointer-not sh-social-fbEllipsis new-upper-fb" style="padding-left: 0px">
<%--                                   <i class="fa fa-facebook sh-iconsfb-header"></i> --%>
                                    I Support this Campaign
<%--                                   Share (${facebookShare})--%>
                               </a>
                           </g:if>
                           <g:else>
                                <a class="btn btn-block btn-social btn-facebook show-fb-height sh-head-fb-over hidden-xs sho-fb-color ss3 fbshare-header sh-social-fbEllipsis new-upper-fb" style="padding-left: 0px" href="#">
<%--                                   <i class="fa fa-facebook sh-iconsfb-header"></i>--%>
                                     I Support this Campaign
<%--                                   Share (${facebookShare})--%>
                                </a>
                           </g:else>
                       </div>
                  </div>
               </div>
               
               <%--Tab code for whatsapp, facebook and twitter --%>
               <div class="visible-sm visible-xs sh-tabs-social sh-shareicons-Fixedtophead">
                   <div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
                       <g:if test="${isPreview}">
                           <a class="btn btn-block btn-social btn-facebook sh-head-fb-over show-Allsocialtabs-size show-whats-paddingmobile">
                                <i class="fa fa-facebook show-tabsfooter-fb"></i> 
                           </a>
                       </g:if>
                       <g:else>
                           <a class="btn btn-block btn-social btn-facebook sh-head-fb-over show-Allsocialtabs-size fbshare-header show-whats-paddingmobile" href="#">
                               <i class="fa fa-facebook show-tabsfooter-fb"></i> 
                           </a>
                       </g:else>
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
                      <g:else>
                          <a href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" class="btn btn-block btn-social btn-facebook sh-head-fb-over shTabs-whatsapp-color show-Allsocialtabs-size show-whats-paddingmobile" >
                              <img src="//s3.amazonaws.com/crowdera/assets/show-tabs-whatsapp-icons.png" class=" show-tabsfooter-fb show-small-whatsappmobile" alt="whatsapp"> 
                          </a>
                      </g:else>
                  </div>

                  <div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
                       <g:if test="${isPreview}">
                           <a class="btn btn-block btn-social btn-facebook sh-head-fb-over shTabs-twitter-color show-Allsocialtabs-size show-whats-paddingmobile">
                               <i class="fa fa-fw fa-twitter show-tabsfooter-fb"></i> 
                           </a>
                       </g:if>
                       <g:else>
                           <a class="btn btn-block btn-social twitter-share btn-facebook sh-head-fb-over <g:if test="${ended}">shTabs-twitter-color-b</g:if><g:else>shTabs-twitter-color</g:else> show-Allsocialtabs-size show-whats-paddingmobile" data-url="${shareUrl}" target="_blank">
                               <i class="fa fa-fw fa-twitter show-tabsfooter-fb"></i> 
                           </a>
                       </g:else>
                  </div>
               </div>
               
               
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
                                 <span class="show-tabs-count hidden-xs">
                                    <g:if test="${totalteams?.size() > 0}">${totalteams?.size()}</g:if>
                                </span>
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
                </div>
                
                
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
               
               
                <div class="col-xs-12 col-md-8 col-sm-8 Top-tabs-mobile show-tops-corsal mob-x-corsal new-gau-width-details new-tab-carousel">
                
                    <%-- Tab panes --%>
                    <div class="tab-content">
                        <div class="tab-pane tab-pane-active active hidden-xs" id="essentials">
                            <g:render template="show/story" model="['managecomments':managecomments]"/>
                        </div>
                        <div class="tab-pane tab-pane-active hidden-xs" id="projectupdates">
                            <g:render template="show/projectupdates"/>
                        </div>
                        <div class="tab-pane tab-pane-active show-teamspage mob-team-tabz new-nav-width new-tem-tab-width" id="manageTeam">
                                <g:render template="show/manageteam"/>
                        </div>
                        <div class="tab-pane tab-pane-active new-nav-width mob-contributions-modal" id="contributions">
                            <g:render template="show/contributions" model="['team':currentTeam]"/>
                        </div>
                    </div>
                    
                    <div class="row"> 
                    <%-- Modal --%>
                        <div class="modal fade" id="sendmailmodal" tabindex="-1" role="dialog" aria-hidden="true">
                            <g:form action="sendemail" id="${project.id}" params="['fr': username]"  class="sendMailForm">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                            <h4 class="modal-title">Recipient Email ID's</h4>
                                        </div>
                                        <div class="modal-body">
                                            <g:hiddenField name="amount" value="${project?.amount}" id="campaign-amount"/>
                                            <g:hiddenField name="vanityTitle" value="${vanityTitle}" id="campaign-vanityTitle"/>
                                            <g:hiddenField name="vanityUsername" value="${vanityUsername}" id="campaign-vanityUsername"/>
                                            <div class="form-group">
                                                <label>Your Name</label>
                                                <input type="text" class="form-control all-place" name="name" placeholder="Name">
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
                                            <button type="submit" class="btn btn-primary btn-block" id="btnSendMail">Send Email</button>
                                        </div>
                                    </div>
                                </div>
                            </g:form>
                        </div>
                    </div>
                </div>             
                
                <%--Embed modal--%>
                <div class="modal fade embedTilemodal" id="embedTilemodal" tabindex="-1" role="dialog" aria-hidden="true">
                  
                    <g:if test="${videoFlag}">
                        <div class="modal-dialog modal-embed-with-video">
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
                                                  <g:link target="_blank" controller="project" action="show" params="['fr': vanityUsername, 'projectTitle':vanityTitle,'country_code':project.country.countryCode,category:project.fundsRecievedBy.toLowerCase()]">
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
                                                <g:if test="${percentage == 999}">
												    <button type="button" class="btn btn-success show-campaign-sucessbtn wid-btn mob-show-sucessend" disabled>SUCCESSFULLY FUNDED!</button>
												</g:if>
												<g:elseif test="${ended}">
												    <div class="show-A-fund"> </div>
												    <button type="button" class="btn btn-warning show-campaign-sucess-endedbtn wid-btn mob-show-sucessend  show-campaign-ended-funded" disabled>CAMPAIGN ENDED!</button>
												</g:elseif>
												<g:else>
												      
												    <g:if test="${project.paypalEmail || project.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
												        <g:form controller="fund" action="fund" params="['fr': vanityUsername, 'projectTitle':vanityTitle]" class="fundFormDesktop">
												            <div class="show-A-fund"> </div>
												            <button name="submit" class="btn btn-show-fund show-fund-size mob-show-fund wid-btn sh-fund-donate-contri" id="btnFundDesktop">DONATE NOW</button>
												        </g:form>
												    </g:if>
												    <g:elseif test="${(project.payuEmail || project.citrusEmail) && !('in'.equalsIgnoreCase(country_code))}">
												      	<button name="inactiveContributeButton" class="btn btn-show-fund show-fund-size mob-show-fund wid-btn sh-fund-donate-contri">DONATE NOW</button>
												    </g:elseif>
												    <g:else>
												        <div class="show-A-fund"> </div>
												        <button name="contributeButton" class="btn btn-show-fund show-fund-size mob-show-fund wid-btn sh-fund-donate-contri">DONATE NOW</button>
												    </g:else>
												</g:else>
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
                                      <g:if test="${percentage == 999}">
									    <button type="button" class="btn btn-success show-campaign-sucessbtn wid-btn-video-off mob-show-sucessend" disabled>SUCCESSFULLY FUNDED!</button>
									</g:if>
									<g:elseif test="${ended}">
									    <div class="show-A-fund"> </div>
									    <button type="button" class="btn btn-warning show-campaign-sucess-endedbtn wid-btn-video-off mob-show-sucessend show-campaign-ended-funded" disabled>CAMPAIGN ENDED!</button>
									</g:elseif>
									<g:else>
									      
									    <g:if test="${project.paypalEmail || project.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
									        <g:form controller="fund" action="fund" params="['fr': vanityUsername, 'projectTitle':vanityTitle]" class="fundFormDesktop">
									            <div class="show-A-fund"> </div>
									            <button name="submit" class="btn btn-show-fund show-fund-size mob-show-fund wid-btn-video-off sh-fund-donate-contri" id="btnFundDesktop">DONATE NOW</button>
									        </g:form>
									    </g:if>
									    <g:elseif test="${(project.payuEmail || project.citrusEmail) && !('in'.equalsIgnoreCase(country_code))}">
									      	<button name="inactiveContributeButton" class="btn btn-show-fund show-fund-size mob-show-fund wid-btn-video-off sh-fund-donate-contri">DONATE NOW</button>
									    </g:elseif>
									    <g:else>
									        <div class="show-A-fund"> </div>
									        <button name="contributeButton" class="btn btn-show-fund show-fund-size mob-show-fund wid-btn-video-off sh-fund-donate-contri">DONATE NOW</button>
									    </g:else>
									</g:else>
                                  </div>
                              </div>
                          </div>
                      </g:else>
                  </div>
               
                  <div class="col-xs-12 col-md-4 col-sm-4 show-desk-org-tile show-tops-corsal  new-show-gau-width show-tab-org">
<%--                      <div class="hidden-xs">--%>
<%--                          <g:render template="/layouts/orgDetails"/>--%>
<%--                      </div>--%>
                 
                      <g:if test="${isPreview && !project?.validated}">
                          <div class="submitForApprovalSectionbtn" id="submitForApprovalSectionbtn">
                              <g:if test="${project?.organizationIconUrl && project?.webAddress && (project?.charitableId || project?.paypalEmail || project?.payuEmail || (project?.citrusEmail && project?.sellerId) || (project?.wepayEmail && project?.wepayAccountId != 0)) && (!project?.imageUrl?.isEmpty()) && project?.organizationName && project?.beneficiary?.country && (projectService?.getRemainingDay(project) > 0)}">
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
                                  <div class="show-A-fund"></div>
                                  <button class="btn btn-block btn-lg btn-primary sh-submitapproval hidden-xs" id="submitForApprovalBtn">
                                      <i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL
                                  </button>
                              </g:else>
                          </div>
                        
                          <div class="hidden-xs">
                              <g:render template="/layouts/showTilesanstitleForOrg" model="['currentTeamAmount':currentTeamAmount]"/>
                          </div>
                        
                          <g:if test="${isPreview}">
                              <div class="showfacebooksAA"></div>
                              <a class="btn btn-block btn-social btn-facebook show-btn-sh-fb sho-fb-color hidden-xs show-pointer-not">
                                  <i class="fa fa-facebook fa-facebook-styles sh-fb-icons"></i>Share (${facebookShare})
                              </a>
                          </g:if>
                          <g:else>
                              <div class="showfacebooksAA"></div>
                              <a class="btn btn-block btn-social btn-facebook show-btn-sh-fb sho-fb-color hidden-xs" id="fbshare" href="#">
                                  <i class="fa fa-facebook fa-facebook-styles sh-fb-icons"></i>Share (${facebookShare})
                              </a>
                          </g:else>
                           
                      </g:if>
                      <g:elseif test="${percentage == 999}">
                          <div class="show-A-fund"> </div>
                          <button type="button" class="btn btn-success btn-lg btn-block show-campaign-sucessbtn mob-show-sucessend hidden-xs" disabled>SUCCESSFULLY FUNDED!</button>
                      </g:elseif>
                      <g:elseif test="${ended}">
                          <div class="show-A-fund"> </div>
                          <button type="button" class="btn btn-warning btn-lg btn-block show-campaign-sucess-endedbtn mob-show-sucessend hidden-xs show-campaign-ended-funded" disabled>CAMPAIGN ENDED!</button>
                      </g:elseif>
                      <g:else>
                            
                          <g:if test="${project.paypalEmail || project.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
                              <g:form controller="fund" action="fund" params="['fr': vanityUsername, 'projectTitle':vanityTitle]" class="fundFormDesktop">
                                  <div class="show-A-fund"> </div>
                                  <button name="submit" class="btn btn-show-fund btn-lg btn-block show-fund-size mob-show-fund hidden-xs sh-fund-donate-contri" id="btnFundDesktop">DONATE NOW</button>
                              </g:form>
                          </g:if>
                          <g:elseif test="${(project.payuEmail || project.citrusEmail) && !('in'.equalsIgnoreCase(country_code))}">
                            	<button name="inactiveContributeButton" class="btn btn-show-fund btn-lg btn-block show-fund-size mob-show-fund hidden-xs sh-fund-donate-contri">DONATE NOW</button>
                          </g:elseif>
                          <g:else>
                              <div class="show-A-fund"> </div>
                              <button name="contributeButton" class="btn btn-show-fund btn-lg btn-block show-fund-size mob-show-fund hidden-xs sh-fund-donate-contri">DONATE NOW</button>
                          </g:else>
                      </g:else>
                      
                      <%--  user profile code  --%>
                      <div class="col-lg-12 col-sm-12 col-md-12 show-profile-padding show-org-profiletile hidden-xs">
                       <div class="col-lg-4 col-sm-4 col-md-4 show-profile-imagewidth">
                           <g:if test="${user?.userImageUrl}">
                                <div id="partnerImageEditDeleteIcon">
                                    <span  class="show-image-dp">
                                        <img src="${user?.userImageUrl}" alt="avatar" class="img-responsive"/>
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
                                <label class="col-lg-8 col-sm-8 col-md-8 show-profile">Campaign by:</label>
                                <g:if test="${project.organizationName && currentFundraiser == beneficiary}">
                                    <span class="col-lg-12 col-sm-12 col-md-12 show-org-name">${project?.organizationName}</span>
                                </g:if>
                                <g:if test="${currentFundraiser != beneficiary}">
                                    <span class="col-lg-12 col-sm-12 col-md-12 show-org-name">${currentFundraiser?.firstName} ${currentFundraiser?.lastName}</span>
                                </g:if>
                            </div>
<%--                            <div class="show-contact-profilefixes col-lg-12 col-sm-12 col-md-12">--%>
<%--                                <div class="col-lg-2 col-sm-2 col-md-2 show-email-profileIcons">--%>
<%--                                    <img class="show-profile-imgs" src="//s3.amazonaws.com/crowdera/assets/1c19404a-4627-4479-94b0-46e49e62471b.png" alt="emails">--%>
<%--                                </div>--%>
<%--                                <div class="col-lg-10 col-sm-10 col-md-10 show-contact-profilefixes">--%>
<%--                                    <span class="col-lg-12 col-sm-12 col-md-12 show-contact-ofOwner">Contact Campaign of Owner</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
                        </div> 
                    </div>
                    <div class="clear"></div>
                    
                      <g:if test="${!isPreview || project.validated}">
<%--                          <div class="hidden-xs" id="organizationTemplateId"></div>--%>
                          <div class="hidden-xs">
                              <g:render template="/layouts/showTilesanstitleForOrg" model="['currentTeamAmount':currentTeamAmount]"/>
                          </div>
                          <g:if test="${isDeviceMobileOrTab==false}">
                         <g:if test="${loggedInUser.equals("") || loggedInUser==null}">
                         	  <div class="joinusRedirect">
								<g:form controller="project" action="addTeam" params="[id:project.id,country_code:project.country.countryCode]">
									
									<button type="submit" value="Join Our Team" class="btn btn-show-bannerslogantext btn-lg btn-block join-us sh-mission-script-height">JOIN OUR TEAM <br> <span class="show-sub-titleJointeam">fundraise for us</span></button>
    							</g:form> 
    						 </div>	
                           </g:if>
                            <g:elseif test="${loggedInUser.equals(project.user)|| isCampaignAdmin}">
                            	<g:if test="${!ended}">
	                            	  <div class="redirectCampaign">
	                            		<a class="btn btn-show-bannerslogantext btn-lg btn-block sh-mission-script sh-mission-script-height" href="#" data-toggle="modal" onclick="javascript:window.open('/project/redirectToInviteMember?projectId=${project.id}&page=show','', 'menubar=no,toolbar=no,resizable=0,scrollbars=yes,height=500,width=786');return false;"><span class="glyphicon glyphicon-user"></span> &nbsp;&nbsp;Invite Members </a>
		    						</div>	
	    						</g:if>
                            </g:elseif>
                            <g:elseif test="${!loggedInUser.equals(project.user) && !isTeamExist && project.validated}" >
                            	  <div class="redirectCampaign">
									<g:if test="${!ended}">
										<g:form controller="project" action="addTeam" params="[id:project.id,country_code:project.country.countryCode]">	
											<button type="submit" value="Join Our Team" class="btn btn-show-bannerslogantext btn-lg btn-block join-us sh-mission-script-height">JOIN OUR TEAM <br> <span class="show-sub-titleJointeam">fundraise for us</span></button>
										</g:form>
									</g:if>
									<g:else>
										 <div class="joinusRedirect">
										<g:link controller="login" action="auth" params="[country_code: country_code]">
											<button type="submit" value="Join Our Team" class="btn btn-show-bannerslogantext btn-lg btn-block join-us sh-mission-script-height">JOIN OUR TEAM <br> <span class="show-sub-titleJointeam">fundraise for us</span></button>
	    								</g:link>	
	    								</div>
	             					</g:else>
             					</div>
                            </g:elseif>
                         </g:if>
                        <div class="clear"></div>
                          <g:if test="${isPreview}">
                              <div class="showfacebooksAA"></div>                              
							  <button class="btn btn-block btn-social show-fb-height btn-facebook tab-fb-padding show-btn-sh-fb hidden-xs sho-fb-color sh-social-fbEllipsis" style="padding: 0px"id="fbshare">
<%--                                   <i class="fa fa-facebook sh-iconsfb-header"></i>--%>
                             			 I Support this Campaign
                              </button>  
                          </g:if>
                          <g:else>
                              <div class="showfacebooksAA"></div>
                             <button class="btn btn-block btn-social show-fb-height btn-facebook tab-fb-padding show-btn-sh-fb hidden-xs sho-fb-color sh-social-fbEllipsis" style="padding: 0px"id="fbshare">
<%--                                   <i class="fa fa-facebook sh-iconsfb-header"></i>--%>
                             			 I Support this Campaign
                              </button>
                          </g:else>
                      </g:if>
                      
                      <g:if test="${project?.impactNumber > 0}">
                          <div class="show-impact">
                              <g:render template="show/showImpactstatement"/>
<%--                              impactassessment--%>
                          </div>
                      </g:if>
                      
                      <g:if test="${project.hashtags}">
                          <div class="show-more-tags new-mob-perk">
                              <h3 class="moretags-tabs visible-xs"><b>More tags</b></h3>
                              <g:if test="${project.validated}">
                                  <p class="moretags-tabs visible-xs">
                                      <g:each in="${hashtagsList}" var="hashtag">
                                          <g:link class="searchablehastag" controller="project" action="search" params="['q': hashtag]">${hashtag}</g:link>
                                      </g:each>
                                  </p>
                              </g:if>
                              <g:else>
                                  <p class="moretags-tabs visible-xs">
                                      ${project.hashtags}
                                  </p>
                              </g:else>
                          </div>
                      </g:if>
                      <div class="show-reasons new-mob-perk">
                      <g:if test="${reasons && (reasons.reason1 || reasons.reason2 || reasons.reason3)}">
<%--                          <div class="tile-footer show-perks-style-reasons">--%>
<%--                              --%>
<%--                          </div>--%>
                          <div class="show-reasons-fund-bgpadding">
                          <span class="show-tri-reasons-to-fund">3 REASONS TO FUND THIS CAMPAIGN</span>
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
                          </div>
                      </g:if>
                      </div>
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
                      
                      <div class="visible-xs sh-mobperks new-mob-perk">
                          <g:if test="${isPreview && !project.validated}">
                              <g:if test="${project?.rewards?.size()>1}">
                                  <div class="sh-perks-preview">
                                      <g:render template="show/rewards" model="['username':username, 'isPreview':true]"/>
                                  </div>
                              </g:if>
                          </g:if>
                      </div>
                    
                      <div class="sh-mobperks new-mob-perk">    
                          <g:if test="${(project?.rewards?.size()>1 && !isPreview) || (project?.rewards?.size()>1 && project?.validated) }">
                              <g:if test="${project.paypalEmail || project.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
                                  <g:render template="show/rewards" model="['username':username, 'isPreview':false]"/>
                              </g:if>
                          </g:if>
                      </div>
                      
                      
                      <div class="visible-xs sh-comments-align">
                          <div id="comment-mobile">
                              <g:render template="show/comments"/>
                          </div>
                      </div>
                  </div>
              </div>
        </g:if>
        <g:else>
            <h1>Campaign not found</h1>
            <div class="alert alert-danger">Oh snap! Looks like that campaign doesn't exist.</div>
        </g:else>
    </div>
</div>
<script type="text/javascript">
	$(window).scroll(function() {
	    if ($(this).scrollTop() >= 50) {        
	        $('#returnTotop').fadeIn(200);   
	    } else {
	        $('#returnTotop').fadeOut(200);   
	    }
	});
	
	$('#returnTotop').click(function() {      
	    $('body,html').animate({
	        scrollTop : 0                       
	    }, 500);
	});
	
</script>
</body>
</html>

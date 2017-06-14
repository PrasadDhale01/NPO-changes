<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<g:set var="isStoryTabActive" value="${false}" />
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def baseUrl = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    def base_url = baseUrl.substring(0, (baseUrl.length() - 1))
    
	def country_code = projectService.getCountryCodeForCurrentEnv(request)
	def beneficiary = project?.user
    def beneficiaryUserName = beneficiary?.username
	def campaign_country_code = params.country_code
	def isTeamAdmin = projectService.isTeamAdmin(project)
	def managecomments = "manageCampaign"
	
	
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
    
	if(project!=null){
	    if (project.videoUrl){
	        if (project.videoUrl.contains('vimeo.com')) {
	            def video = project.videoUrl.split('/')
	            vimeoInt = video[video.length - 1]
	            campaignVideoUrl = 'https://player.vimeo.com/video/'+vimeoInt
	        } else {
	            campaignVideoUrl = project.videoUrl;
	        }
	    }
	}
    
    boolean videoFlag=false;
    if(isCampaignAdmin || (currentTeam?.user == project?.user)){
        if(campaignVideoUrl != null && !campaignVideoUrl.isEmpty() )
        {
            videoFlag=true;
        }
    }else{
	if(currentTeam!=null){
        if(currentTeam.videoUrl != null && !currentTeam.videoUrl.isEmpty()){
            videoFlag=true;
            campaignVideoUrl =currentTeam.videoUrl;
        }
	}	
       
    }
    
    def embedTileUrl = base_url+'/campaign/'+vanityTitle+'/'+vanityUsername+'/embed/tile'
    def embedCode = '<iframe width="310px" height="451px" src="'+embedTileUrl+'" scrolling="no" frameborder="0"  class="embedTitleUrl"></iframe>'
    def embedVideoCode = '<iframe width="480" height="360" frameborder="0" src="'+campaignVideoUrl+'" scrolling="no"></iframe>'
    
    def ss = '/layouts/show_teamtileInfo'
	//def isStoryTabActive = false;
%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#"
	xmlns:fb="https://www.facebook.com/2008/fbml">
<head>
<title>Crowdera- ${project.title}</title>
<link rel="canonical" href="${base_url}/campaigns" />
<meta name="title" content="${project.title} - Crowdera" />
<g:if test="${project.description}">
	<meta name="description" content="${project.description}" />
</g:if>
<meta name="keywords"
	content="Crowdera, crowdfunding, contribute online, raise funds free, film crowdfunding, raise money online, fundraising site, fundraising website, fundraising project, online fundraising, raise money for a cause, global crowdfunding, (${project.organizationName}, ${project.beneficiary.country}, ${project.category} ,${project.usedFor})" />

<meta property="og:site_name" content="Crowdera" />
<meta property="og:type" content="website" />
<meta property="og:title"
	content="${project.title} by ${project?.beneficiary?.firstName}" />
<g:if test="${project.description}">
	<meta property="og:description"
		content="${project.description} Crowdfunding is a practical and inspiring way to support the fundraising needs of a cause or community. Do some good. Make a Contribution Today!" />
</g:if>
<g:if test="${project.organizationIconUrl}">
	<meta property="og:image:url" content="${project.organizationIconUrl}" />
</g:if>
<g:elseif test="${imageUrl}">
	<meta property="og:image:url" content="${imageUrl}" />
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


<r:require modules="projectshowjs" />
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

</head>
<body>
	<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
	
	<a href="javascript:" id="returnTotop"> <i class="icon-chevron-up"></i></a>
	<div class="feducontent new-mob-height campaign-bg-color">
		<div class="container show-cmpgn-container">
			<g:hiddenField name="campaignId" id="campaignId"
				value="${project.id }" />
			<g:hiddenField name="fbShareUrl" id="fbShareUrl"
				value="${fbShareUrl}" />
			<g:hiddenField name="pieList" value="${pieList}" id="pieList" />
			<g:hiddenField name="projectamount"
				value="${project?.amount.round()}" id="projectamount" />
			<g:hiddenField name="fbShareUrlupdatePage"
				value="${fbShareUrlupdatePage}" id="fbShareUrlupdatePage" />
			<g:hiddenField id="payuStatus" name="payuStatus"
				value="${project.payuStatus}" />

			<g:hiddenField name="projectTitle" value="${projectTitle}"
				id="projectTitle" />
			<g:if test="${project}">
				<g:hiddenField name="currentEnv" value="${currentEnv}"
					id="currentEnv" />
				<g:hiddenField name="campaignOwner" value="${project.user}"
					id="campaignOwner" />
				<g:hiddenField name="loggedInUser" value="${loggedInUser}"
					id="loggedInUser" />
				<g:hiddenField id="isStoryTabActive" name="isStoryTabActive"
				value="${false}" />	
				
				
				<g:if test="${project.validated}">
					<div class="col-md-12 green-heading campaignTitle text-center hidden-xs managepage-campaign-title">
                        <g:link mapping="showCampaign" params="['country_code': project.country.countryCode?.toLowerCase(),'projectTitle':vanityTitle,'fr': vanityUsername,'category':project.fundsRecievedBy.toLowerCase()]">
                            ${projectTitle}
                        </g:link>
                    </div>
				</g:if>
				<g:else>
				    <div class="col-md-12 green-heading campaignTitle text-center hidden-xs managepage-campaign-title">
                        <g:link mapping="managecampaign" params="[country_code: project.country.countryCode, title:project.title,id: project.id]">
                            ${projectTitle}
                        </g:link>
                    </div>
				</g:else>
				<div class="clear"></div>
				<div class="row">
					<g:if test="${flash.prj_mngprj_message}">
						<div class="alert alert-success show-msz show-alertMsz" align="center">
							${flash.prj_mngprj_message}
						</div>
					</g:if>
					<g:if test="${flash.teamUpdatemessage}">
						<div class="alert alert-success show-msz show-alertMsz" align="center">
							${flash.teamUpdatemessage}
						</div>
					</g:if>
					<g:if test="${flash.add_campaign_supporter}">
						<div class="alert alert-success show-msz show-alertMsz" align="center">
							${flash.add_campaign_supporter}
						</div>
					</g:if>
					<g:if test="${flash.deleteUpdateSuccessMsg}">
                       <div class="alert alert-success show-msz show-alertMsz" align="center">
                          ${flash.deleteUpdateSuccessMsg}
                       </div>
                    </g:if>
					<div class="col-xs-12 col-md-4 mobileview-top sh-mobiles-top campaign-tile-xs">

						<div class="visible-xs loadmobileCampaignTile">
							<g:render template="/layouts/tile_for_mobile"
								model="['project': project]" />
						</div>

						<div class="hidden-xs">
							<g:render template="/layouts/orgDetails" />
						</div>
					</div>

					<div
						class=" hidden-xs navbar navbar-default show1-Primary show-header-navtabs">
						<div class="navbar-header show-header-height">
							<div class="sh-secandary-header-showpage">
								<a href="/"
									class="navbar-brand show-secandarylog-top sh-logo-color"> <img
									alt="Crowdera"
									src="//s3.amazonaws.com/crowdera/assets/crowdera-logo.png"
									class="sh-safari2header-padding">
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
                                <a href="#rewards" data-toggle="tab"  class="show-tabs-text show-js-fileB manageTeam showTeamTemplate ss show-campaigndetails-font">
                                    <span class="tab-text"> Perks</span>
                                </a>
                                <span class="show-tabs-count hidden-xs">
                                    <g:if test="${project?.rewards?.size() > 0}">${project?.rewards?.size()}</g:if>
                                </span>
                            </span>
                        </li>
                        <g:if test="${project.payuStatus}">
						<li><span class="show-tbs-right-borders hidden-xs">
								 <a	href="#payments" data-toggle="tab"	class="show-tabs-text show-js-fileB payments ss show-campaigndetails-font">
											<span class="tab-text">Payments</span>
									</a> <span class="show-ids-header"></span>
								</span></li>
							</g:if>	
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
					</div>

					<div class="show-socialheads">
						<div
							class="navbar navbar-default col-lg-12 hidden-sm col-md-12 sh-tabs hidden-xs sh-shareicons-Fixedtophead">
							<div
								class="col-lg-6 col-lg-push-3 col-sm-6 col-md-push-3 col-md-6 <g:if test="${project?.projectUpdates}">show-share-headerpadding</g:if><g:else>show-headered-without-update</g:else> show-headers-icons">

								<%-- Social features --%>
								<a class="share-mail pull-left show-icons-secandheader"
										href="#" data-toggle="modal" data-target="#sendmailmodal"
										target="_blank"> <img
										src="//s3.amazonaws.com/crowdera/assets/82677812-3c6f-404d-80c2-7e3f77c60cf9.png"
										alt="Mail Share" class="show-email">
									</a>
									<a class="twitter-share pull-left show-icons-secandheader"
										data-url="${shareUrl}" target="_blank"> <img
										src="//s3.amazonaws.com/crowdera/assets/823f1cf6-49fe-4ec2-a0dd-2d2a437ad081.png"
										class="show-twitter" alt="Twitter Share">
									</a>
									<g:link absolute="true"
										uri="/campaign/supporter/${project.id}/${username}"
										class="pull-left show-icons-secandheader">
										<img
											src="//s3.amazonaws.com/crowdera/assets/9520477b-5b92-475a-ba79-9b35c1a16d3c.png"
											class="show-like" alt="campaign-supporter">
									</g:link>
									<a
										class="social-header share-linkedin pull-left show-icons-secandheader"
										href="https://www.linkedin.com/cws/share?url=${shareUrl}"
										target="_blank"
										onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
										<img
										src="//s3.amazonaws.com/crowdera/assets/8a7fbe36-68f8-401e-8644-5780d656d298.png"
										class="show-linkedin" alt="LinkedIn Share">
									</a>
									<a
										class="social-header google-plus-share pull-left show-icons-secandheader"
										href="https://plus.google.com/share?url=${shareUrl}"
										onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
										<img
										src="//s3.amazonaws.com/crowdera/assets/ccda789b-4001-4c95-a65f-38c0b9a7a474.png"
										class="show-google" alt="Google+ Share">
									</a>
									<a href="#" data-toggle="modal" data-target="#embedTilemodal"
										target="_blank" class="pull-left show-icons-secandheader"><img
										src="//s3.amazonaws.com/crowdera/assets/264961c1-5e35-4357-a68b-8494e63ac04e.png"
										class="show-embedIcon" alt="embedicon"></a>
									<div class="popoverClass">
										<span
											data-title="Copy this short url and share &nbsp;&nbsp;&nbsp;"
											class="shortUrlglyphiconheader glyphicon glyphicon-link glyphicon-show-design-ract glyphicon-show-link-color show-shortUrlheader-top"></span>
										<div class="hidden popoverConent">
											<button type="button" class="close">&times;</button>
											<p>
												${shareUrl}
											</p>
										</div>
									</div>
							</div>

							<div class="col-lg-6 col-md-6 hidden-sm show-share-FB">
								<a
										class="btn btn-block btn-social btn-facebook sh-head-fb-over hidden-xs sho-fb-color show-2ndhead-btnFB ss3 fbshare-header sh-social-fbEllipsis new-upper-fb"
										href="#"> <i
										class="fa fa-facebook fa-facebook-styles sh-fb-icons sh-iconsfb-header"></i>
										I SUPPORT THIS CAMPAIGN <%--                                   Share (${facebookShare})--%>
									</a>
							</div>
						</div>
					</div>

					<%--Tab code for whatsapp, facebook and twitter --%>
					<div
						class="visible-sm visible-xs sh-tabs-social sh-shareicons-Fixedtophead">
						<div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
							<g:if test="${isPreview}">
								<a
									class="btn btn-block btn-social btn-facebook sh-head-fb-over show-Allsocialtabs-size show-whats-paddingmobile">
									<i class="fa fa-facebook show-tabsfooter-fb"></i>
								</a>
							</g:if>
							<g:else>
								<a
									class="btn btn-block btn-social btn-facebook sh-head-fb-over show-Allsocialtabs-size fbshare-header show-whats-paddingmobile"
									href="#"> <i class="fa fa-facebook show-tabsfooter-fb"></i>
								</a>
							</g:else>
						</div>
						<div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
							<g:if test="${isDeviceMobileOrTab}">
								<a href="whatsapp://send?text=${shareUrl}"
									data-action="share/whatsapp/share"
									class="btn btn-block btn-social btn-facebook sh-head-fb-over shTabs-whatsapp-color show-Allsocialtabs-size show-whats-paddingmobile">
									<img
									src="//s3.amazonaws.com/crowdera/assets/show-tabs-whatsapp-icons.png"
									class=" show-tabsfooter-fb show-small-whatsappmobile"
									alt="whatsapp">
								</a>
							</g:if>
							<g:else>
								<a href="#" data-toggle="modal" data-target="#sendmailmodal"
									target="_blank"
									class="btn btn-block btn-social btn-facebook sh-head-fb-over shTabs-whatsapp-color show-Allsocialtabs-size show-whats-paddingmobile">
									<img
									src="//s3.amazonaws.com/crowdera/assets/show-tabs-whatsapp-icons.png"
									class=" show-tabsfooter-fb show-small-whatsappmobile"
									alt="whatsapp">
								</a>
							</g:else>
						</div>

						<div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
							<a
									class="btn btn-block btn-social twitter-share btn-facebook sh-head-fb-over <g:if test="${ended}">shTabs-twitter-color-b</g:if><g:else>shTabs-twitter-color</g:else> show-Allsocialtabs-size show-whats-paddingmobile"
									data-url="${shareUrl}" target="_blank"> <i
									class="fa fa-fw fa-twitter show-tabsfooter-fb"></i>
								</a>
						</div>
					</div>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 borders  hidden-xs">
						<g:set var="screen" id="screen" value="false"></g:set>
						<ul class="nav nav-pills">
							<li id="show-headeridA"></li>
						</ul>
						<ul class="nav nav-pills nav-justified nav-justi show-marginbottoms sh-tabs mng-safari-mobile show-new-tabs-alignments
							<g:if test="${!project?.projectUpdates.isEmpty()}">
								 TW-show-updateTab-width
							</g:if>
							<g:else> mng-dt-tabs </g:else>">
							<li class="active show-tabs">
							<g:set var="isStoryTabActive" value="${true}" />
								 <span class="active show-tbs-right-borders  hidden-xs"> <a
									href="#essentials" data-toggle="tab"
									class="show-tabs-text show-js-fileA essentials showStoryTemplate show-campaigndetails-font">
										<span class="tab-text hidden-xs"> Story</span>
										</a> <span class="show-ids-header"></span>
									</span>
							</li>
							<g:if test="${project.validated}">
								<li>
								    <span class="show-tbs-right-borders hidden-xs">
											<a href="#projectupdates" data-toggle="tab"
											class="show-tabs-text projectupdates showUpdateTemplate show-campaigndetails-font">
												<span class="tab-text hidden-xs"> Updates</span>
										</a> 
										<span class="show-tabs-count hidden-xs"></span>
											 <g:if test="${project?.projectUpdates?.size() > 0}">
														${project?.projectUpdates?.size()}
											</g:if>
									</span>
									<span class="show-ids-header"></span>
								</li>
							</g:if>
							<li>
								<span class="show-tbs-right-borders hidden-xs"> <a
									href="#manageTeam" data-toggle="tab"
									class="show-tabs-text show-js-fileB manageTeam showTeamTemplate ss show-campaigndetails-font">
										<span class="tab-text"> Teams</span>
									</a> <span class="show-ids-header"></span>
								</span>
							</li>
							<li><span class="show-tbs-right-borders hidden-xs"> <a
									href="#rewards" data-toggle="tab"
									class="show-tabs-text show-js-fileB rewards ss show-campaigndetails-font">
										<span class="tab-text"> Perks</span>
								</a> <span class="show-ids-header"></span>
							</span></li>
							<g:if test="${project.payuStatus}">
								
							<li>
							<span class="show-tbs-right-borders hidden-xs"> 
							    <a href="#payments" data-toggle="tab" class="show-tabs-text show-js-fileB payments ss show-campaigndetails-font">
									<span class="tab-text">Payments</span>
								</a> 
								    <span class="show-ids-header"></span>
							</span>
							</li>
							</g:if>	
							
							<li>
								<span class="show-tbs-right-borders hidden-xs"> 
								   <a href="#contributions" data-toggle="tab" class="show-tabs-text show-js-fileC contributions showContributionTemplate show-campaigndetails-font">
										<span class="tab-text"> Contributions</span>
								   </a> 
									<span class="show-tabs-count hidden-xs"> 
										<g:if test="${totalContributions?.size() > 0 && screen == 'false'}">
													${totalContributions?.size()}
										</g:if>
									</span> 
									<span class="show-ids-header"></span>
								</span>
							</li>
							
							<li>
								<span class="show-comit-lft hidden-xs"> 
								    <a href="#essentials" data-toggle="tab"	class="show-tabs-text comments scrollToComment showCommentTemplate show-campaigndetails-font">
										 <span class="tab-text hidden-xs"> Comments</span>
									</a> <span class="show-ids-header"></span>
								</span>
							</li>
						</ul>
					</div>

					<div class="col-xs-12 col-md-8 col-sm-8 Top-tabs-mobile show-tops-corsal mob-x-corsal new-gau-width-details new-tab-carousel">
						<%-- Tab panes --%>
						<div class="tab-content">
							<div class="tab-pane active tab-pane-active active hidden-xs" id="essentials">
								<g:render template="show/story" model="['managecomments':managecomments,'campaign_country_code':campaign_country_code ]"/>
							</div>
							<div class="tab-pane tab-pane-active hidden-xs"	id="projectupdates">
								<g:render template="/project/manageproject/projectupdates" />
							</div>
							<div class="tab-pane tab-pane-active show-teamspage mob-team-tabz new-nav-width new-tem-tab-width" id="manageTeam">
								<g:render template="/project/manageproject/manageteam" />
							</div>
							<div class="tab-pane mange-pane-active manage-mobile-margine" id="rewards">
                                <g:render template="/project/manageproject/rewards" />
                            </div>
                            <g:if test="${project.payuStatus}">
                                <div class="tab-pane mange-pane-active" id="payments">
                                    <g:render template="/project/manageproject/payments"/>
                                </div>
                            </g:if>
							<div class="tab-pane tab-pane-active new-nav-width mob-contributions-modal"	id="contributions">
								<g:render template="/project/manageproject/contributions" model="['team':currentTeam]" />
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
				<div class="col-xs-12 col-md-4 col-sm-4 show-desk-org-tile show-tops-corsal  new-show-gau-width show-tab-org">
					<div class="show-A-fund"></div>
						<div class="row manage-edit-delete-btn">
							<g:if test="${!project.draft || project.validated}">
						      <div class="fullwidth pull-right manage-edit-mobilebtns">
						         <g:if test="${username.equals('campaignadmin@crowdera.co') || isAdmin &&  !project.validated}">
						               <g:link mapping="editCampaign" params="[country_code: project.country.countryCode,fr:username,id: project.id]" class="manage-edit-draft-left col-lg-6 col-md-6 col-sm-6 col-xs-6">
						                 <span class="btn btn-default manage-btn-width manage-btn-back-color" aria-label="Edit project"><i class="fa fa-pencil-square-o edit-space"></i>EDIT
						                 </span>
						          		</g:link>   
						             <g:form controller="project" action="projectdelete" method="post" id="${project.id}" params="[country_code: project.country.countryCode,id: project.id]" class="col-lg-6 col-md-6 col-sm-6 col-xs-6 manage-btn-padding">
						                 <button class="btn btn-danger manage-deletebtn-width" aria-label="Edit project" id="projectdelete" onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);">
						                 <i class="fa fa-trash edit-space"></i>DELETE</button>
						             </g:form>
						         </g:if>
						         <g:else>
						             <g:if test="${!project.validated && percentage <= 999}">
						                <g:link mapping="editCampaign" params="[country_code: project.country.countryCode,fr:username,id: project.id]" class="manage-edit-draft-left col-lg-6 col-md-6 col-sm-6 col-xs-6">
						                     <span class="btn btn-default manage-btn-width manage-btn-back-color"  aria-label="Edit project"><i class="fa fa-pencil-square-o edit-space"></i>EDIT
						                     </span>
						                </g:link>
						             </g:if>
						             <g:if test="${!project.validated}">
						                 <g:form controller="project" action="projectdelete" method="post" id="${project.id}" params="[country_code: project.country.countryCode,id: project.id]" class="col-lg-6 col-md-6 col-sm-6 col-xs-6 manage-btn-padding">
						                     <button class="btn btn-danger manage-deletebtn-width" aria-label="Edit project" id="projectdelete" onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);">
						                     <i class="fa fa-trash edit-space"></i>DELETE</button>
						                 </g:form>
						             </g:if>
						         </g:else>
						    </div>
						</g:if>
						<g:if test="${project.draft || project.validated && percentage <= 999 && (loggedInUser.equals(project.user)|| username.equals('campaignadmin@crowdera.co') || isAdmin || isTeamAdmin)}">
					         <g:link mapping="editCampaign" params="[country_code: project.country.countryCode,fr:username,id: project.id]" class="manage-edit-left">
					                 <span class="btn btn-default manage-btn-width-aft-validated manage-btn-back-color"  aria-label="Edit project" ><i class="fa fa-pencil-square-o edit-space"></i>EDIT CAMPAIGN
					                 </span>
				              </g:link>
						</g:if>
						</div>
						<%--               user profile code  --%>
						<div class="col-lg-12 col-sm-12 col-md-12 show-profile-padding show-org-profiletile hidden-xs">
							<div class="col-lg-4 col-sm-4 col-md-4 show-profile-imagewidth">
								<g:if test="${user?.userImageUrl}">
									<div id="partnerImageEditDeleteIcon">
										<span class="show-image-dp"> <img
											src="${user?.userImageUrl}" alt="avatar">
										</span>
									</div>
								</g:if>
								<g:else>
									<div id="userAvatarUploadIcon">
										<span id="useravatar"> <img
											class="show-user-profile-hw"
											src="https://s3.amazonaws.com/crowdera/assets/profile_image.jpg"
											alt="' '">
										</span>
									</div>
								</g:else>
							</div>
							<div class="col-lg-8 col-sm-8 col-md-8 show-profile-padding show-tabs-profiledesp">
								<div class="show-lbl-orgname">
									<label class="col-lg-8 col-sm-8 col-md-8 show-profile">Campaign
										by:</label>
									<g:if test="${project.organizationName && currentFundraiser == beneficiary}">
										<span class="col-lg-12 col-sm-12 col-md-12 show-org-name">
											${project?.organizationName}
										</span>
									</g:if>
									<g:elseif test="${currentFundraiser != beneficiary}">
										<span class="col-lg-12 col-sm-12 col-md-12 show-org-name">
											${currentFundraiser?.firstName} ${currentFundraiser?.lastName}
										</span>
									</g:elseif>
								</div>
	                        </div> 
                    </div>
                    <div class="clear"></div>
                    
                      <g:if test="${!isPreview || project.validated}">
                          <div class="hidden-xs">
                              <g:render template="/layouts/showTilesanstitleForOrg" model="['currentTeamAmount':currentTeamAmount]"></g:render>
                          </div>
                        <g:if test="${isDeviceMobileOrTab==false}">
                         <g:if test="${loggedInUser.equals("") || loggedInUser==null}">
                         	  <div class="redirectCampaign">
    							<g:link controller="login" action="auth">
    								<button name="submit" class="btn btn-show-bannerslogantext btn-lg btn-block sh-mission-script sh-mission-script-height">JOIN US</button>
    							</g:link>
    						 </div>	
                          </g:if>
                          <g:elseif test="${loggedInUser.equals(project.user)|| isCampaignAdmin}">
                            	<g:if test="${!ended}">
	                            	<div class="redirectCampaign">
		    						   <a class="btn btn-show-bannerslogantext btn-lg btn-block sh-mission-script sh-mission-script-height" href="#" data-toggle="modal" onclick="javascript:window.open('/project/redirectToInviteMember?projectId=${project.id}&page=show','', 'menubar=no,toolbar=no,resizable=0,scrollbars=yes,height=500,width=786');return false;"><span class="glyphicon glyphicon-user"></span> &nbsp;&nbsp;Invite Members </a>
		    						</div>	
	    						</g:if>
	    						<g:if test="${!ended && project.validated}">
	    						    <div class="showfacebooksAA"></div>                              
							        <button class="btn btn-block btn-social show-fb-height btn-facebook tab-fb-padding show-btn-sh-fb hidden-xs sho-fb-color sh-social-fbEllipsis" style="padding: 0px"id="fbshare">
<%--                                   <i class="fa fa-facebook sh-iconsfb-header"></i>--%>
                             			 I Support this Campaign
                                    </button>
	    						</g:if>
                           </g:elseif>
                           <g:elseif test="${!loggedInUser.equals(project.user) && !isTeamExist && project.validated}" >
                            	<div class="redirectCampaign">
									<g:if test="${!ended}">
										<g:form controller="project" action="addTeam" params="[id:project.id,country_code:project.country.countryCode]">
											<button type="submit" value="Join Our Team" class="btn btn-show-bannerslogantext btn-lg btn-block join-us sh-mission-script-height">Join Our Team <br> <span class="show-sub-titleJointeam">fundraise for us</span></button>
										</g:form>
									</g:if>
									<g:else>
										<g:link controller="login" action="auth">
	    									<button name="submit" class="btn btn-show-bannerslogantext btn-lg btn-block sh-mission-script sh-mission-script-height">JOIN US</button>
	    								</g:link>	
	             					</g:else>
             					</div>
                            </g:elseif>
                         </g:if>
                        <div class="clear"></div>
                        
                        <g:if test="${project.draft}">
                            <div class="submitForApprovalSectionbtn">
                                 <g:if test="${project.organizationIconUrl && project.webAddress && (project.charitableId || project.paypalEmail || project.payuEmail || (project.citrusEmail && project?.sellerId) || (project?.wepayEmail && project?.wepayAccountId != 0)) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                                     <g:form controller="project" action="saveasdraft" id="${project.id}">
                                         <button type="submit" class="btn btn-block btn-primary manage-submitaprroval mange-btnsubmitapprov-size"><i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL</button>
                                     </g:form>
                                 </g:if>
                                 <g:else>
                                     <button class="btn btn-block btn-primary manage-submitaprroval mange-btnsubmitapprov-size" id="submitForApprovalBtnright"><i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL</button>
                                 </g:else>
                            </div>
                        </g:if>
                        <g:if test="${!project.draft && !project.validated}">
                            <div class="pendingCampaign-btn">
                                <g:if test="${project.organizationIconUrl && project.webAddress && (project.charitableId || project.paypalEmail || project.payuEmail || (project.citrusEmail && project?.sellerId) || (project?.wepayEmail && project?.wepayAccountId != 0)) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                                    <g:form controller="project" action="saveasdraft" id="${project.id}">
                                        <button class="btn btn-pendingCampaign btn-block btn-primary manage-submitaprroval mange-btnsubmitapprov-size" disabled>PENDING FOR APPROVAL</button>
                                    </g:form>
                                </g:if>
                                <g:else>
                                    <button class="btn btn-block btn-primary manage-submitaprroval mange-btnsubmitapprov-size" id="submitForApprovalBtnright">PENDING FOR APPROVAL</button>
                                </g:else>
                              </div>
                          </g:if>
                          
                      </g:if>
                      
                      
            
                       <g:if test="${project?.impactNumber > 0}">
                          <div class="show-impact">
                              <g:render template="show/showImpactstatement"/>
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

                          <div class="show-reasons-fund-bgpadding">
                          <span class="show-tri-reasons-to-fund">3 Reasons to Fund Our Campaign</span>
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
                              <g:if test="${project.paypalEmail || project.charitableId || project.payuEmail || project.citrusEmail}">
                                  <g:render template="show/rewards" model="['username':username, 'isPreview':false]"/>
                              </g:if>
                          </g:if>
                      </div>
                      <div class="visible-xs sh-comments-align">
                          <div id="comment-mobile">
                                <g:render template="/project/manageproject/comments" />
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
                         
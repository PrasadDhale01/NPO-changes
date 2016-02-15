<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    def user = project.user
    def username = user.username
	def projectTitle = project.title
	if (projectTitle) {
		projectTitle = projectTitle.toUpperCase(Locale.ENGLISH)
	}
	def imageUrl = project.imageUrl
	if (imageUrl) {
		imageUrl = project.imageUrl[0].getUrl()
	}
    def fbShareUrl = base_url+"/campaigns/campaignShare?id="+project.id+"?fr="+username
   
    def fbShareUrlupdatePage = base_url+"/campaigns/updateShare?id="+project.id+"&fr="+username
   
    def fundRaiser = userService.getCurrentUser()
    def fundRaiserName
    if (fundRaiser) {
        if (fundRaiser.email == project.beneficiary.email){
            if (project.beneficiary.lastName)
                fundRaiserName = (project.beneficiary.firstName + " " + project.beneficiary.lastName).toUpperCase()
            else 
                fundRaiserName = (project.beneficiary.firstName).toUpperCase()
        } else {
            fundRaiserName = (fundRaiser.firstName+" "+fundRaiser.lastName).toUpperCase()
        }
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="https://www.facebook.com/2008/fbml">
<head>
	<meta property="og:title" content="Crowdera : ${project.title}" />
	<meta property="og:url" content="${fbShareUrl}" />
	<g:if test="${project.organizationIconUrl}">
	    <meta property="og:image" content="${project.organizationIconUrl}" />
	</g:if>
	<g:elseif test="${imageUrl}">
	     <meta property="og:image" content="${imageUrl}" />
	</g:elseif>
	<g:if test="${project.description}">
	     <meta property="og:description" content="${project.description}" />
	</g:if>
	<meta property="og:type" content="website" />
	<meta name="layout" content="main" />
	<r:require modules="projectshowjs" />
	<r:require modules="rewardjs" />
	
</head>
<body>
    <g:hiddenField id="projectamount" name="projectamount" value="${project.amount.round()}"/>
    <g:hiddenField id="payuStatus" name="payuStatus" value="${project.payuStatus}"/>
	<g:hiddenField id="b_url" name="b_url" value="${base_url}"/>
	<g:hiddenField name="fbShareUrlupdatePage" value="${fbShareUrlupdatePage}" id="fbShareUrlupdatePage"/>
	
	<div class="feducontent">
		<div class="container manage-container-page show-css">
			<g:if test="${project}">
				<div class="row">
					<g:if test="${flash.prj_mngprj_message}">
						<div class="alert alert-success" align="center">
							${flash.prj_mngprj_message}
						</div>
					</g:if>
					<g:if test="${project.rejected}">
						<div class="alert alert-info">
							<h2 class="text-center">Sorry, but this project is not
								validated by admin</h2>
						</div>
					</g:if>
					<g:if test="${flash.teamvalidationmessage}">
						<div class="alert alert-success text-center">
							${flash.teamvalidationmessage}
						</div>
					</g:if>
					<g:if test="${flash.teamdiscardedmessage}">
						<div class="alert alert-success text-center">
							${flash.teamdiscardedmessage}
						</div>
					</g:if>
					<g:if test="${flash.perkupdate}">
						<div class="alert alert-success text-center">
							${flash.perkupdate}
						</div>
					</g:if>
					<g:if test="${flash.saveEditUpdateSuccessMsg}">
					    <div class="alert alert-success text-center">
							${flash.saveEditUpdateSuccessMsg}
						</div>
					</g:if>
                    <div class="col-md-12">
                        <g:if test="${!project.validated}">
                            <div class="mange-campaigntitle-mobile">
                                <h1 class="green-heading text-center"><g:link controller="project" action="manageCampaign" id="${project.id}" title="${project.title}">${projectTitle}</g:link></h1>
                            </div>
                        </g:if>
                        <g:else>
                            <div class="mange-campaigntitle-mobile">
                                <h1 class="green-heading text-center"><g:link controller="project" action="showCampaign" id="${project.id}" title="${project.title}" params="['fr': username]">${project.title}</g:link></h1>
                            </div>
                        </g:else>
					</div>
					<g:if test="${fundRaiser}">
                        <div class="col-md-12 col-sm-12 col-xs-12 text-center campaignFundRaiser">
                            <h4 class="green-heading"> by ${fundRaiserName}</h4>
                        </div>
                    </g:if>
                    <div class="col-xs-12">
                        <div class="col-xs-12 mange-borders">
                            <ul class="nav nav-pills manage-projects nav-justified mobile-justified sh-tabs nav-justi mng-safari-mobile mng-safari-tabs <g:if test="${!project.payuStatus}"> manage-bottom-top</g:if><g:else>mange-tabs-payu</g:else>">
                                <li class="active show-tabs">
                                    <span class="manage-tbs-right-borders ">
                                        <a href="#essentials" data-toggle="tab" class="show-tabs-text essentials"><span class="hidden-xs">STORY</span> 
                                            <span class="glyphicon glyphicon-leaf visible-xs show-tab-right-border"></span>
                                        </a>
                                    </span>
                                </li>
                                <li>
                                    <span class="manage-tbs-right-borders ">
                                        <a href="#projectupdates" data-toggle="tab" class="show-tabs-text projectupdates"><span class="hidden-xs">UPDATES</span> 
                                            <span class="glyphicon glyphicon-asterisk visible-xs"></span>
                                        </a>
                                        <span class="show-tabs-count hidden-xs"><g:if test="${project.projectUpdates.size() > 0}">${project.projectUpdates.size()}</g:if></span>
                                    </span>
                                </li>
                                <li>
                                    <span class="manage-tbs-right-borders ">
                                        <a href="#manageTeams" data-toggle="tab" class="show-tabs-text manageTeams"><span class="hidden-xs">TEAMS</span>
                                             <span class="fa fa-users visible-xs"></span>
                                        </a>
                                    </span>
                                </li>
                                <li>
                                    <span class="manage-tbs-right-borders ">
                                        <a href="#rewards" data-toggle="tab" class="show-tabs-text rewards"><span class="hidden-xs">PERKS</span>
                                            <span class="fa fa-gift fa-lg visible-xs"></span>
                                        </a>
                                    </span>
                                </li>
                                <g:if test="${project.payuStatus}">
                                    <li>
                                        <span class="manage-tbs-right-borders ">
                                            <a href="#payments" data-toggle="tab" class="show-tabs-text payments"><span class="hidden-xs">PAYMENTS</span>
                                                <span class="glyphicon glyphicon-credit-card visible-xs"></span>
                                            </a>
                                        </span>
                                    </li>
                                </g:if>
                                <li>
                                    <span class="manage-tbs-right-borders ">
                                        <a href="#contributions" data-toggle="tab" class="show-tabs-text contributions"><span class="hidden-xs">CONTRIBUTIONS</span>
                                            <span class="glyphicon glyphicon-tint visible-xs"></span>
                                        </a> 
                                        <span class="show-tabs-count hidden-xs"><g:if test="${project.contributions.size() > 0}">${project.contributions.size()}</g:if></span>
                                    </span>
                                </li>
                                <li>
                                    <span class="manage-comit-lft">
                                        <a href="#comments" data-toggle="tab" class="show-tabs-text comments"><span class="hidden-xs">COMMENTS</span>
                                            <span class="glyphicon glyphicon-comment visible-xs"></span>
                                        </a> 
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 manage-Top-tabs-mobile ">
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane active mange-pane-active row" id="essentials">
                                <g:render template="/project/manageproject/essentials" />
                            </div>
                            <div class="tab-pane mange-pane-active row" id="projectupdates">
                                <g:render template="/project/manageproject/projectupdates" />
                            </div>
                            <div class="tab-pane mange-pane-active" id="manageTeams">
                                <g:render template="/project/manageproject/manageteam" />
                            </div>
                            <div class="tab-pane mange-pane-active" id="rewards">
                                <g:render template="/project/manageproject/rewards" />
                            </div>
                            <g:if test="${project.payuStatus}">
                                <div class="tab-pane mange-pane-active" id="payments">
                                    <g:render template="/project/manageproject/payments"/>
                                </div>
                            </g:if>
                            <div class="tab-pane mange-pane-active" id="contributions">
                                <g:render template="/project/manageproject/contributions" />
                            </div>
                            <div class="tab-pane mange-pane-active" id="comments">
                                <g:render template="/project/manageproject/comments" />
                            </div>
                        </div>

                    </div>
                </div>
            </g:if>
			<g:else>
				<h1>Project not found</h1>
				<div class="alert alert-danger">Oh snap! Looks like that
					project doesn't exist.</div>
			</g:else>
		</div>
	</div>
</body>
</html>

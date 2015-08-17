<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    def beneficiary = project.user
    def beneficiaryUserName = beneficiary.username
    def fundRaiserName
    if(currentFundraiser.email == project.beneficiary.email){
		if (project.beneficiary.lastName)
            fundRaiserName = (project.beneficiary.firstName + " " + project.beneficiary.lastName).toUpperCase()
		else 
            fundRaiserName = (project.beneficiary.firstName).toUpperCase()
    } else {
        fundRaiserName = (currentFundraiser.firstName + " " + currentFundraiser.lastName).toUpperCase()
    }
    def username = currentFundraiser.username
    
    def projectTitle = project.title
    if (projectTitle) {
        projectTitle = projectTitle.toUpperCase(Locale.ENGLISH)
    }
	
    def imageUrl = project.imageUrl
    if (imageUrl) {
        imageUrl = project.imageUrl[0].getUrl()
    }
    def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+username
    def currentTeamAmount = currentTeam.amount
%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="https://www.facebook.com/2008/fbml">
<head>
	<meta property="og:title" content="Crowdera : ${project.title}" />
	<meta property="og:url" content="${fbShareUrl}" />
	<g:if test="${project.organizationIconUrl}">
	    <meta property="og:image" content="${project.organizationIconUrl}"/>
	</g:if>
	<g:elseif test="${imageUrl}">
	    <meta property="og:image" content="${imageUrl}" />
	</g:elseif>
	<g:if test="${project.description}">
	    <meta property="og:description" content="${project.description}"/>
	</g:if>
	<meta property="og:type" content="website" />
	
	<meta name="layout" content="main" />
	<r:require modules="projectshowjs"/>
    <g:javascript>
        $(function() {
            $('.redactorEditor').redactor({
                imageUpload:'/project/getRedactorImage',
                focus: true,
                plugins: ['video'],
                buttonsHide: ['indent', 'outdent', 'horizontalrule']
            });
       });
    </g:javascript>
</head>
<body>
<div class="feducontent">
	<div class="container">
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
                <div class="col-md-12 green-heading campaignTitle text-center">
	                <h1><g:link controller="project" action="showCampaign" id="${project.id}" title="${project.title}" params="['fr': beneficiaryUserName]">
		            	 ${projectTitle} 
	                </g:link></h1>
	            </div>
                <g:if test="${user || beneficiary}">
	                <div class="col-md-12 col-sm-12 col-xs-12 text-center campaignFundRaiser">
	                	<h4 class="green-heading"> by ${fundRaiserName}</h4>
	                </div>
                </g:if>
	            <div class="col-xs-12 col-md-4 mobileview-top">
                    <g:render template="/layouts/organizationdetails"/>
                    <g:if test="${percentage == 999}">
                        <button type="button" class="btn btn-success btn-lg btn-block" disabled>SUCCESSFULLY FUNDED</button>
                    </g:if>
                    <g:elseif test="${ended}">
                        <button type="button" class="btn btn-warning btn-lg btn-block" disabled>PROJECT ENDED!</button>
                    </g:elseif>
                    <g:else>
                        <g:if test="${project.paypalEmail || project.charitableId || project.payuEmail}">
	                        <g:form controller="fund" action="fund" id="${project.id}" params="['fr': vanityUsername, 'projectTitle':vanityTitle]" class="fundFormMobile">
	                            <button name="submit" class="btn btn-success btn-lg btn-block"  id="btnFundMobile">Fund this Campaign</button>
	                        </g:form>
                        </g:if>
                        <g:else>
                            <button name="contributeButton" class="btn btn-success btn-lg btn-block">Fund this Campaign</button>
                        </g:else>
                    </g:else>
                    <g:render template="/layouts/tilesanstitle" model="['currentTeamAmount':currentTeamAmount]"/>
                    <g:if test="${project.rewards.size()>1}">
                    	<g:render template="show/rewards" model="['username':username]"/>
                    </g:if>
                </div>
                <div class="col-xs-12 col-md-8 Top-tabs-mobile">
                    <ul class="nav nav-tabs nav-justified show-marginbottoms">
                        <li class="active"><a href="#essentials" data-toggle="tab">
                            <span class="glyphicon glyphicon-leaf"></span><span class="tab-text hidden-xs"> Story</span>
                        </a></li>
                        <g:if test="${!project.projectUpdates.isEmpty() }">
                            <li><a href="#projectupdates" data-toggle="tab">
							    <span class="glyphicon glyphicon-asterisk"></span><span class="tab-text hidden-xs"> Updates</span>
                            </a></li>
                        </g:if>
                        <li><a href="#manageTeam" data-toggle="tab">
                            <span class="fa fa-users"></span><span class="tab-text hidden-xs"> Teams</span>
						</a></li>
                        <li><a href="#contributions" data-toggle="tab">
                            <span class="glyphicon glyphicon-tint"></span><span class="tab-text hidden-xs"> Contributions</span>
                        </a></li>
                        <li><a href="#comments" data-toggle="tab">
                            <span class="glyphicon glyphicon-comment"></span><span class="tab-text hidden-xs"> Comments</span>
                        </a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" id="essentials">
                            <g:render template="show/essentials"/>
                        </div>
                        <div class="tab-pane" id="projectupdates">
                            <g:render template="show/projectupdates"/>
                        </div>
                        <div class="tab-pane" id="manageTeam">
							<g:render template="show/manageteam"/>
						</div>
                        <div class="tab-pane" id="contributions">
                            <g:render template="show/contributions" model="['team':currentTeam]"/>
                        </div>
                        <div class="tab-pane" id="comments">
                            <g:render template="show/comments"/>
                        </div>
                    </div>
                    
                    <div class="row"> 
				        <!-- Modal -->
				        <div class="modal fade" id="sendmailmodal" tabindex="-1" role="dialog" aria-hidden="true">
				            <g:form action="sendemail" id="${project.id}" params="['fr': username]" role="form" class="sendMailForm">
				                <div class="modal-dialog">
				                    <div class="modal-content">
				                        <div class="modal-header">
				                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				                            <h4 class="modal-title">Recipient Email ID's</h4>
				                        </div>
				                        <div class="modal-body">
                                            <g:hiddenField name="amount" value="${project.amount}"/>
                                            <g:hiddenField name="vanityTitle" value="${vanityTitle}"/>
                                            <g:hiddenField name="vanityUsername" value="${vanityUsername}"/>
				                            <div class="form-group">
				                                <label>Your Name</label>
				                                <input type="text" class="form-control" name="name" placeholder="Name"></input>
				                            </div>
				                            <div class="form-group">
				                                <label>Email ID's (separated by comma)</label>
				                                <textarea class="form-control" name="emails" rows="4" placeholder="Email ID's"></textarea>
				                            </div>
				                            <div class="form-group">
				                                <label>Message (Optional)</label>
				                                <textarea class="form-control" name="message" rows="4" placeholder="Message"></textarea>
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
                <div class="col-xs-12 col-md-4 mobileview-bottom">
                    <g:render template="/layouts/organizationdetails"/>
                    <g:if test="${percentage == 999}">
                        <button type="button" class="btn btn-success btn-lg btn-block" disabled>SUCCESSFULLY FUNDED</button>
                    </g:if>
                    <g:elseif test="${ended}">
                        <button type="button" class="btn btn-warning btn-lg btn-block" disabled>CAMPAIGN ENDED!</button>
                    </g:elseif>
                    <g:else>
                        <g:if test="${project.paypalEmail || project.charitableId || project.payuEmail}">
                            <g:if test="${(project.payuStatus == false) && (currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia')}">
	                            <div class="redirectCampaign">
	                                <g:link controller="fund" action="fund" params="['fr': vanityUsername, 'projectTitle':vanityTitle]"><button name="submit" class="btn btn-success btn-lg btn-block" id="btnFundDesktop">Fund this Campaign</button></g:link>
	                            </div>
	                        </g:if>
	                        <g:else>
	                            <g:form controller="fund" action="fund" params="['fr': vanityUsername, 'projectTitle':vanityTitle]" class="fundFormDesktop">
	                                <button name="submit" class="btn btn-success btn-lg btn-block" id="btnFundDesktop">Fund this Campaign</button>
	                            </g:form>
	                        </g:else>
                        </g:if>
                        <g:else>
                            <button name="contributeButton" class="btn btn-success btn-lg btn-block">Fund this Campaign</button>
                        </g:else>
                    </g:else>
                    <g:render template="/layouts/tilesanstitle" model="['currentTeamAmount':currentTeamAmount]"/>
                    <g:if test="${project.rewards.size()>1}">
                        <g:if test="${project.paypalEmail || project.charitableId || project.payuEmail}">
                    	    <g:render template="show/rewards" model="['username':username]"/>
                    	</g:if>
                    </g:if>
                </div>
            </div>
		</g:if>
		<g:else>
            <h1>Campaign not found</h1>
			<div class="alert alert-danger">Oh snap! Looks like that campaign doesn't exist.</div>
		</g:else>
	</div>
</div>
</body>
</html>

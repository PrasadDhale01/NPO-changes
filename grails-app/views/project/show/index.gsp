<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
    def base_url = grailsApplication.config.crowdera.BASE_URL
    def fundRaiserName
	def beneficiary = project.user
    def username
	def currentFundraiser
    if (user) {
		currentFundraiser = user
	    def fundRaiser = user.firstName + " " + user.lastName
	    fundRaiserName = fundRaiser.toUpperCase()
	    username = user.username
    } else {
	    currentFundraiser = beneficiary
	    def fundRaiser = beneficiary.firstName + " " + beneficiary.lastName
	    fundRaiserName = fundRaiser.toUpperCase()
	    username = beneficiary.username
	}
	def projectTitle = project.title
	if (projectTitle) {
		projectTitle = projectTitle.toUpperCase(Locale.ENGLISH)
	}
	
	def imageUrl = project.imageUrl
	if (imageUrl) {
		imageUrl = project.imageUrl[0].getUrl()
	}
    def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+username
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
	<meta property="og:description" content="${project.description}" />
	<meta property="og:type" content="website" />
	
	<meta name="layout" content="main" />
	<r:require modules="projectshowjs"/>
</head>
<body>
<div class="feducontent">
	<div class="container">
		<g:if test="${project}">
            <div class="row">
             	<g:if test="${flash.prj_mngprj_message}">
                    <div class="alert alert-success show-msz" align="center">
                        ${flash.prj_mngprj_message}
                    </div>
                </g:if>
                <g:if test="${user || beneficiary}">
	                <div class="col-md-12 col-sm-12 col-xs-12 text-center">
	                	<h4 class="green-heading"> FUNDRAISER: ${fundRaiserName}</h4>
	                </div>
                </g:if>
	            <div class="col-md-12 green-heading text-center">
	                <g:link controller="project" action="show" id="${project.id}" title="${project.title}" params="['fr': username]">
		            	<h1> ${projectTitle} </h1>
	                </g:link>
	            </div>
	            <div class="col-md-4 mobileview-top">
					<g:render template="/layouts/organizationdetails"/>
                    <g:render template="/layouts/tilesanstitle"/>
                    <g:if test="${percentage == 999}">
                        <button type="button" class="btn btn-success btn-lg btn-block" disabled>SUCCESSFULLY FUNDED</button>
                    </g:if>
                    <g:elseif test="${ended}">
                        <button type="button" class="btn btn-warning btn-lg btn-block" disabled>PROJECT ENDED!</button>
                    </g:elseif>
                    <g:else>
                        <a href="/campaigns/${project.id}/fund" class="btn btn-success btn-lg btn-block" role="button">Fund this Campaign</a>
                    </g:else>
                    <g:if test="${project.rewards.size()>1}">
                    	<g:render template="show/rewards"/>
                    </g:if>
                </div>
                <div class="col-md-8">
<%--                    <h4 class="lead">Beneficiary: ${projectService.getBeneficiaryName(project)}</h4>--%>
               
                    <ul class="nav nav-tabs nav-justified show-marginbottoms">
                        <li class="active"><a href="#essentials" data-toggle="tab">
                            <span class="glyphicon glyphicon-leaf"></span><span class="tab-text"> Story</span>
                        </a></li>
                        <li><a href="#projectupdates" data-toggle="tab">
							<span class="glyphicon glyphicon-asterisk"></span><span class="tab-text"> Updates</span>
                        </a></li>
                        <li><a href="#manageTeam" data-toggle="tab">
                            <span class="fa fa-users"></span><span class="tab-text"> Team</span>
						</a></li>
                        <li><a href="#contributions" data-toggle="tab">
                            <span class="glyphicon glyphicon-tint"></span><span class="tab-text"> Contributions</span>
                        </a></li>
                        <li><a href="#comments" data-toggle="tab">
                            <span class="glyphicon glyphicon-comment"></span><span class="tab-text"> Comments</span>
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
							<g:render template="show/manageteam" model="['currentFundraiser':currentFundraiser]"/>
						</div>
                        <div class="tab-pane" id="contributions">
                            <g:render template="show/contributions"/>
                        </div>
                        <div class="tab-pane" id="comments">
                            <g:render template="show/comments"/>
                        </div>
                    </div>
                    
                    <div class="row"> 
				        <!-- Modal -->
				        <div class="modal fade" id="sendmailmodal" tabindex="-1" role="dialog" aria-hidden="true">
				            <g:form action="sendemail" id="${project.id}" params="['fr': username]" role="form">
				                <div class="modal-dialog">
				                    <div class="modal-content">
				                        <div class="modal-header">
				                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				                            <h4 class="modal-title">Recipient Email ID's</h4>
				                        </div>
				                        <div class="modal-body">
				                            <g:hiddenField name="amount" value="${project.amount}"/>
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
				                            <button type="submit" class="btn btn-primary btn-block">Send Email</button>
				                        </div>
				                    </div>
				                </div>
				            </g:form>
				        </div>
				    </div>
				    
                </div>
                <div class="col-md-4 mobileview-bottom">
					<g:render template="/layouts/organizationdetails"/>
                    <g:render template="/layouts/tilesanstitle"/>
                    <g:if test="${percentage == 999}">
                        <button type="button" class="btn btn-success btn-lg btn-block" disabled>SUCCESSFULLY FUNDED</button>
                    </g:if>
                    <g:elseif test="${ended}">
                        <button type="button" class="btn btn-warning btn-lg btn-block" disabled>CAMPAIGN ENDED!</button>
                    </g:elseif>
                    <g:else>
                        <form action="/campaigns/${project.id}/fund">
                            <g:hiddenField name="fundraiserUsername" value="${username}" />
                            <g:submitButton name="submit" value="Fund this Campaign" class="btn btn-success btn-lg btn-block"/>
                        </form>                    
                    </g:else>
                    <g:if test="${project.rewards.size()>1}">
                    	<g:render template="show/rewards"/>
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

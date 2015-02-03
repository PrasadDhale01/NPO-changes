<g:set var="userService" bean="userService"/>
<g:set var="projectService" bean="projectService"/>
<% 
    def contributionId= contribution.id
    def fundraiserId= fundraiser.id
    def contribution = projectService.getDataType(contribution.amount)
	def imageUrl = project.imageUrl
	if (imageUrl) {
		imageUrl = project.imageUrl[0].getUrl()
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="https://www.facebook.com/2008/fbml">
<head>
    <meta property="og:title" content="Crowdera : ${project.title}" />
    <meta property="og:url" content="{base_url}/projects/${project.id}" />
    <g:if test="${project.organizationIconUrl}">
        <meta property="og:image" content="${project.organizationIconUrl}" />
    </g:if>
    <g:elseif test="${imageUrl}">
        <meta property="og:image" content="${imageUrl}" />
    </g:elseif>
    <meta property="og:description" content="${project.description}" />
    <meta property="og:type" content="website" />
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <h1>Thank you!</h1>
                <p>You have funded this campaign. You will receive your chosen perk soon.</p>

                <h3>Funding confirmation.</h3>
                <table class="table table-bordered table-hover table-condensed">
                    <tbody>
                    <tr>
                        <td>Campaign</td>
                        <td><g:link controller="project" action="show" id="${project.id}">${project.title}</g:link></td>
                    </tr>
                    <tr>
                        <td>Beneficiary</td>
                        <td>${projectService.getBeneficiaryName(project)}</td>
                    </tr>
                    <g:if test="${fundraiser != project.user}">
                        <tr>
                            <td>Fundraiser</td>
                            <td>${fundraiser.firstName} ${fundraiser.lastName}</td>
                        </tr>
                    </g:if>
                    <g:if test ="${userService.isAnonymous(user)}">
                        <tr>
                            <td>Contributor</td>
                            <td>Anonymous</td>
                        </tr>
                    </g:if>
                    <g:else>
                        <tr>
                            <td>Contributor</td>
                            <td>${user.firstName} ${user.lastName}</td>
                        </tr>
                    </g:else>
                        <tr>
                            <td>Amount</td>
                            <td>$${contribution}</td>
                        </tr>
                    </tbody>
                </table>
                <g:if test ="${userService.isAnonymous(user)}">
                    <g:if test = "${project.charitableId}">
                	   <div class="alert alert-success">Receipt is sent over email from FirstGiving</div>
                    </g:if>
                    <g:else>
                         <div class="alert alert-success">Receipt is sent over email from Paypal</div>
                    </g:else>
                </g:if>
                <g:elseif test="${flash.sentmessage}">
                            <div class="alert alert-success">
                                ${flash.sentmessage}
                            </div>
                </g:elseif>
                <g:else>
                	<div class="alert alert-success">Receipt has been sent over email to ${user.email}</div>
                </g:else>
                <div class="row">
                        <div class="col-sm-12">
                            <a class="share-mail pull-right" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail" data-url="${base_url}/projects/${project.id}" data-name="${project.title}">
                                <img src="${resource(dir: 'images', file: 'mail-share@2x.png')}" style="padding: 0; width:30px; bottom-margin:4px; margin:2px;" alt="Mail Share"/>
                            </a>
                            <a class="twitter-share pull-right" href="https://twitter.com/share?text=Hey check this project at crowdera.co!"  data-url="${base_url}/fund/acknowledge/${project.id}" target="_blank">
                                <img src="${resource(dir: 'images', file: 'tw-share@2x.png')}" style="padding: 0; width:30px; bottom-margin:4px; margin:2px;" alt="Twitter Share"/>
                            </a>
                            <a class="fb-like pull-right" href="http://www.facebook.com/sharer.php?s=100&p[url]=${base_url}/projects/${project.id}&p[title]=${project.title} &p[summary]=${project.story}" data-url="${base_url}/projects/${project.id}" data-share="true">
                                <img src="${resource(dir: 'images', file: 'fb-share@2x.png')}" style="padding: 0; width:30px; bottom-margin:4px; margin:2px;" alt="Facebook Share"/>
                            </a>
                            <span style="float:right; margin:5px;"><label>Share this Contribution</label></span>
                        </div>
                        
                        <!-- Modal -->
                        <div class="modal fade" id="sendmailmodal" tabindex="-1" role="dialog" aria-hidden="true">
                            <g:form action="sendemail" controller="fund" id="${project.id}" role="form">
                              <input type="hidden" name="cb" id="${contributionId }" value="${contributionId }"/>
                              <input type="hidden" name="fr" id="${fundraiserId }" value="${fundraiserId }"/>
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
                                                <input type="text" class="form-control" name="name" placeholder="Name"/>
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
            <div class="col-md-4">
                <g:if test="${project.rewards.size()>1 }">
                    <g:render template="rewardtile"/>
                </g:if>
                <g:render template="/layouts/tile"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

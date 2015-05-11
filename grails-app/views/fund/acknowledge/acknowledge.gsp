<g:set var="userService" bean="userService"/>
<g:set var="projectService" bean="projectService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<% 
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def contributionId= contribution.id
    def fundraiserId= fundraiser.id
	def imageUrl = project.imageUrl
	if (imageUrl) {
		imageUrl = project.imageUrl[0].getUrl()
	}
    def base_url = grailsApplication.config.crowdera.BASE_URL
    def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+fundraiser.username+"#contributions"
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
    <r:require modules="fundjs" />
</head>
<body>
<g:hiddenField name="fbShareUrl" value="${fbShareUrl}" id="fbShareUrl"/>
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
                        <td>${project.user.firstName}&nbsp;${project.user.lastName}</td>
                    </tr>
                    <g:if test="${fundraiser != project.user}">
                        <tr>
                            <td>Fundraiser</td>
                            <td>${fundraiser.firstName} ${fundraiser.lastName}</td>
                        </tr>
                    </g:if>
                    <g:if test ="${contribution.isAnonymous}">
                        <tr>
                            <td>Contributor</td>
                            <td>Anonymous</td>
                        </tr>
                    </g:if>
                    <g:else>
                        <tr>
                            <td>Contributor</td>
                            <td>${contribution.contributorName}</td>
                        </tr>
                    </g:else>
                        <tr>
                            <td>Amount</td>
                            <td>$${contribution.amount.round()}</td>
                        </tr>
                    </tbody>
                </table>
                <g:if test="${flash.sentmessage}">
                    <div class="alert alert-success">
                        ${flash.sentmessage}
                    </div>
                </g:if>
                <g:else>
                	<div class="alert alert-success">Receipt has been sent over email to ${contribution.contributorEmail}</div><br>
                </g:else>
                <g:if test="${contribution.comments == null || editedComment}">
                    <h4 class="lead">Leave a comment</h4>
                    <div id="commentBox">
                        <g:form controller="fund" action="saveContributionComent" id="${contribution.id}" params="['fr': fundraiser.id]">
                            <div class="form-group">
                                <textarea class="form-control" name="comment" rows="4" required><g:if test="${editedComment}">${editedComment}</g:if></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary btn-sm pull-right">Post comment</button>
                            <div class="clear"></div>
                        </g:form>
                    </div><br>
                </g:if>
                <g:else>
                    <%
                        def date = dateFormat.format(new Date())
                     %>
                    <h3>Contributor Comment</h3>
                    <div class="modal-body tile-footer show-comments-date">
                        <h6>By ${contribution.contributorName}, on ${date}</h6>
                        <p><b>${contribution.comments}</b></p>
                        <g:link controller="fund" name="deletecomment" action="deleteContributionComment" method="post" id="${contribution.id}" params="['fr': fundraiser.id]">
                            <button type="submit" class="projectedit close pull-right" id="projectdelete"
                                 onclick="return confirm(&#39;Are you sure you want to delete this comment?&#39;);">
                                 <i class="glyphicon glyphicon-trash"></i>
                             </button>
                        </g:link>
                        <g:link controller="fund" name="editcomment" action="editContributionComment" method="post" id="${contribution.id}" params="['fr': fundraiser.id]">
                            <i class="glyphicon glyphicon-edit glyphicon-lg projectedit close pull-right"></i>
                        </g:link>
                       <div class="clear"></div>
                    </div>
                </g:else>
                <div class="row">
					<div class="col-sm-12 shared contributionShare">
					    <a class="share-mail pull-right social" href="#" data-toggle="modal" data-target="#sendmailmodal">
					        <img src="//s3.amazonaws.com/crowdera/assets/mail-share@2x.png" alt="Mail Share">
					    </a>
					    <a class="twitter-share pull-right social" id="twitterShare" target="_blank">
					        <img src="//s3.amazonaws.com/crowdera/assets/tw-share@2x.png" alt="Twitter Share">
					    </a>
					    <a target="_self" class="fb-like pull-right social fbShareForLargeDevices" href="#" id="fbshare">
					        <img src="//s3.amazonaws.com/crowdera/assets/fb-share@2x.png" alt="Facebook Share">
					    </a>
                        <a target="_blank" class="fb-like pull-right social fbShareForSmallDevices" href="http://www.facebook.com/sharer/sharer.php?s=100&amp;p[url]=${fbShareUrl}">
                            <img src="//s3.amazonaws.com/crowdera/assets/fb-share@2x.png" alt="Facebook Share">
                        </a>
					    <span><label>Share this Contribution</label></span>
					</div>
                        
                    <!-- Modal -->
                    <div class="modal fade" id="sendmailmodal" tabindex="-1" role="dialog" aria-hidden="true">
                        <g:form action="sendemail" controller="fund" id="${project.id}" role="form">
                            <input type="hidden" name="cb" id="${contributionId }" value="${contributionId }"></input>
                            <input type="hidden" name="fr" id="${fundraiserId }" value="${fundraiserId }"></input>
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

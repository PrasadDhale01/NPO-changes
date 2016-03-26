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
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+fundraiser.username
	def beneficiaryName = (project.beneficiary.lastName) ? project.beneficiary.firstName + ' ' + project.beneficiary.lastName : project.beneficiary.firstName;
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
    <meta property="og:description" content="I just helped ${beneficiaryName}to achieve a great cause. Please share or contribute towards this cause.   ${project.description}" />
    <meta property="og:type" content="website" />
    <meta name="layout" content="main" />
    <r:require modules="fundjs" />
</head>
<body>
<g:hiddenField name="fbShareUrl" value="${fbShareUrl}" id="fbShareUrl"/>
<g:hiddenField name="beneficiaryName" value="${beneficiaryName}" id="beneficiaryName"/>
<g:hiddenField name="campaignTitle" value="${project.title}" id="campaignTitle"/>
<g:hiddenField name="twitterShareUrl" value="${twitterShareUrl}" id="twitterShareUrl"/>
<div class="feducontent">
    <div class="container ack-thousands-thankyoupage">
        <div class="row">
            <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
                <h1><b>Thank you!</b></h1>
                <p>You have funded this campaign. You will receive your chosen perk soon.</p>
            </div>
            
            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-12">
                <div class="panel panel-default panel-thankupage ">
                    <h4 class="ack-funding-panel">Funding confirmation</h4>
                </div>
                <table class="table panel panel-default table-hover table-condensed">
                   
                    <tbody>
                    <tr class="ack-table-color-green">
                        <td class="ack-table-heading-padding">Campaign</td>
                        <td><g:link controller="project" action="showCampaign" id="${project.id}">${project.title}</g:link></td>
                    </tr>
                    <tr>
                        <td class="ack-table-heading-padding">Beneficiary</td>
                        <td>${beneficiaryName}</td>
                    </tr>
                    <g:if test="${fundraiser != project.user}">
                        <tr class="ack-table-color-green">
                            <td class="ack-table-heading-padding">Fundraiser</td>
                            <td>${fundraiser.firstName} ${fundraiser.lastName}</td>
                        </tr>
                    </g:if>
                    <g:if test ="${contribution.isAnonymous}">
                        <tr class="ack-table-color-green">
                            <td class="ack-table-heading-padding">Contributor</td>
                            <td>Anonymous</td>
                        </tr>
                    </g:if>
                    <g:else>
                        <tr class="ack-table-color-green">
                            <td class="ack-table-heading-padding">Contributor</td>
                            <td>${contribution.contributorName}</td>
                        </tr>
                    </g:else>
                        <tr class="ack-table-color-red">
                            <td class="ack-table-heading-padding">Amount</td>
                            <td><g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${contribution.amount.round()}</td>
                        </tr>
                    </tbody>
                </table>
<%--                <g:if test="${flash.sentmessage}">--%>
<%--                    <div class="alert alert-success">--%>
<%--                        ${flash.sentmessage}--%>
<%--                    </div><br>--%>
<%--                </g:if>--%>
<%--                <g:else>--%>
                	<div class="panel panel-default padding-panel text-center">Receipt has been sent over email to<a href="mailto:${contribution.contributorEmail}" class="thankyou-textdeco"> ${contribution.contributorEmail}</a></div><br>
<%--                </g:else>--%>
                <div class="row">
                    <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12 ack-socialmedia-padding shared contributionShare">
                        <div class="shared ack-socialicon pull-left">
                            <span><label>SHARE:</label></span>
                        </div>
                        <a target="_self" class="fb-like pull-left social fbShareForLargeDevices ack-socialicon-size" href="#" id="fbshare">
                            <img src="//s3.amazonaws.com/crowdera/assets/contribution-fb-share.png" alt="Facebook Share">
                        </a>
                        <a class="share-mail pull-left social glyphicon glyphicon-envelope glyphicon-design-acknowledge glyphicon-envelope-color ack-social-mail-icons" href="#" data-toggle="modal" data-target="#sendmailmodal"></a>
                        <a class="twitter-share pull-left social ack-socialicon-size" id="twitterShare" target="_blank">
                            <img src="//s3.amazonaws.com/crowdera/assets/contribution-twitter-share.png" alt="Twitter Share">
                        </a>
                        <a class="social share-linkedin pull-left ack-socialicon-size" href="https://www.linkedin.com/cws/share?url=${twitterShareUrl}"  id="share-linkedin" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                            <img src="//s3.amazonaws.com/crowdera/assets/contribution-linked-in-share.png" alt="LinkedIn Share">
                        </a>
                        <a class="social google-plus-share pull-left ack-socialicon-size" id="googlePlusShare" href="https://plus.google.com/share?url=${twitterShareUrl}" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                            <img src="//s3.amazonaws.com/crowdera/assets/contribution-google-plus-share.png" alt="Google+ Share">
                        </a> 
                    </div>
                    <!-- Modal -->
                    <div class="modal fade sendmailmodal" id="sendmailmodal" tabindex="-1" role="dialog" aria-hidden="true">
                        <g:form action="sendemail" controller="fund" id="${project.id}">
                            <input type="hidden" name="cb" id="${contributionId }" value="${contributionId }" >
                            <input type="hidden" name="fr" id="${fundraiserId }" value="${fundraiserId }">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                        <h4 class="modal-title">Recipient Email ID's</h4>
                                    </div>
                                    <div class="modal-body">
                                        <g:hiddenField name="amount" value="${project.amount}"/>
                                        <g:hiddenField name="projectTitle" value="${projectTitle}"/>
                                        <div class="form-group">
                                            <label>Your Name</label>
                                            <input type="text" class="form-control" name="name" placeholder="Name">
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

            <div class="col-lg-4 col-sm-4 col-md-4 col-xs-12 <g:if test="${project.rewards.size()>1 }">acknowledge-tile-tag ack-tile-height</g:if><g:else>ack-panel-tile</g:else>">
                <g:if test="${project.rewards.size()>1 }">
                    <g:render template="rewardtile"/>
                </g:if>
                <g:render template="fund/fundTile"/>
                <%--<g:render template="/layouts/tile"/>--%>
            </div>
                <%
                    def commentId
                    def commentVal
                    def teamCommentId
                    def teamCommentVal
                    if(comment) {
                        commentId = comment.id
                        commentVal = comment.comment
                    }
                    if(teamComment) {
                        teamCommentId = teamComment.id
                        commentVal = teamComment.comment
                    }
                %>
                <g:if test="${commentVal == null || value}">
                    <div class="col-lg-8 col-sm-8 col-md-8 col-xs-12  ack-panel-spacing-mobile">
                    <h4 class="ack-funding-panel panel panel-default">Leave a comment</h4>
                </div>
                    <div id="commentBox" class="col-lg-8 col-sm-8 col-md-8 col-xs-12">
                        <g:form controller="fund" action="saveContributionComent" id="${contribution.id}" params="['fr': fundraiser.id, 'projectTitle':projectTitle]">
                            <g:hiddenField name='commentId' value="${commentId}"/>
                            <g:hiddenField name='teamCommentId' value="${teamCommentId}"/>
                            <div class="form-group ack-textareabottom">
                                <textarea class="form-control ack-textareaheghit" name="comment" rows="4" required><g:if test="${commentVal}">${commentVal}</g:if></textarea>
                            </div>
                            <g:if test="${commentVal}">
                                <button type="submit" class="btn btn-ackfund btn-sm pull-right">UPDATE COMMENT</button>
                            </g:if>
                            <g:else>
                                <button type="submit" class="btn btn-ackfund btn-sm pull-right">POST COMMENT</button>
                            </g:else>
                            <div class="clear"></div>
                        </g:form>
                    </div>
                </g:if>
                <g:else>
                    <%
                        def date = dateFormat.format(new Date())
                     %>
                    <div class="modal-body show-comments-date TW-ack-commentBox ack-width-padding col-lg-8 col-sm-8 col-md-8 col-xs-12">
                        <h6>By ${contribution.contributorName}, on ${date}</h6>
                        <p><b>${commentVal}</b></p>
                        <g:link controller="fund" name="deletecomment" action="deleteContributionComment" method="post" id="${contribution.id}" params="['fr': fundraiser.id, 'projectTitle':projectTitle, 'commentId': commentId, 'teamCommentId': teamCommentId]">
                            <button type="submit" class="projectedit close pull-right" id="projectdelete"
                                 onclick="return confirm(&#39;Are you sure you want to delete this comment?&#39;);">
                                 <i class="glyphicon glyphicon-trash"></i>
                            </button>
                        </g:link>
                        <g:form controller="fund" name="editcomment" action="editContributionComment" method="post" id="${contribution.id}" params="['fr': fundraiser.id, 'projectTitle':projectTitle]">
                            <g:hiddenField name='commentId' value="${commentId}"/>
                            <g:hiddenField name='teamCommentId' value="${teamCommentId}"/>
                            <button type="submit" class="projectedit close pull-right" id="projectedit">
                                <i class="glyphicon glyphicon-edit glyphicon-lg projectedit"></i>
                            </button>
                        </g:form>
                        <div class="clear"></div>
                    </div>
                </g:else>

            </div>
           
        </div>
    </div>

</body>
</html>

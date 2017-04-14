<%-- Comments --%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def manageCampaign = "manageCampaign"
	def fundRaiser
	def team
	def beneficiary = project?.user
	if (user) {
		fundRaiser = user?.username
		team = userService.getTeamByUser(user, project)
	} else {
		fundRaiser = beneficiary?.username
		team = userService.getTeamByUser(beneficiary, project)
	}
	def isAdmin=userService.isAdmin()
	List listcomment=[]
	if(project?.user==team?.user || userService.isAdmin()){
		listcomment= projectComments
	}else{
		listcomment= teamComments
	}
	
	def projectId=project.id
	def teamCommentId
	def commentId
	if(projectComment) {
		commentval = projectComment.comment
		commentId = projectComment?.id
	}
	if(teamcomment) {
		commentval = teamcomment.comment
		teamCommentId = teamcomment?.id
	}
	
	def userObj = userService.getCurrentUser()

%>

<div class="<g:if test="${project.comments.empty}">col-md-12</g:if><g:else>col-md-offset-1 col-md-10</g:else> col-sm-12 col-xs-12 mange-comments-bottom">
	<g:if test="${!project.comments.empty}">
        <br>
        <div class="commentsoncampaign">
            <div class="list-group" id="uniqueId">
                <g:set var="i" value="1"></g:set>
                <g:each in="${project.comments.reverse()}" var="comment">
                    <div class="modal-body tile-footer manage-comments-footer">
                        <%
                            def date = dateFormat.format(comment.date)
                            def isAnonymous = userService.isAnonymous(comment.user)
                        %>
                        <g:if test="${isAnonymous}">
                           <span class="dt">By ${comment.userName}, on ${date}</span>
                        </g:if>
                        <g:else>
                            <span class="dt">By ${userService.getFriendlyFullName(comment.user)}, on ${date}</span>
                        </g:else>
                        <br><span class="dd">${comment.comment}</span><br>
                        <input type="checkbox" name="link" id="${i}" value="${comment.id}" 
                            <g:if test="${comment.status }">checked="checked"</g:if>><span id="check${i}"> Hide</span>
                        <% i++ %>
                        
                        <div class="editAndDeleteBtn deleteComment">
	                       <div class="pull-right">
                               <g:form controller="project" action="commentdelete" method="post" params="['projectId':projectId, 'fr': fundRaiser,'managecomments': managecomments ,'campaign_country_code':campaign_country_code]">
                   	                <input type="hidden" name="manageCampaign" value="${manageCampaign}"/>
                   	                <input type="hidden" name='commentId' value="${comment.id}" />
                       	            <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this comment?&#39;);">
                                 	   <i class="glyphicon glyphicon-trash"></i>
                       	            </button>
                   	           </g:form>
                           </div>
                       	</div>
                    </div>
                </g:each>
            </div>
        </div>
	</g:if>
	<g:else>
	    <div class="alert alert-info">No comments yet</div>
	</g:else>
	<div id="test"></div>
</div>

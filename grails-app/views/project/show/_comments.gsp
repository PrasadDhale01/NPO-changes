<!-- Comments -->
<g:set var="userService" bean="userService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
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

    List listcomment=[]
    if(project?.user==team?.user){
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
%>

<g:if test="${flash.commentmessage}">
    <div class="alert alert-danger">${flash.commentmessage}</div>
</g:if>

<g:if test="${project.validated}">
    <h3><b>Comments</b></h3>
    <g:if test="${projectComment || teamcomment}">
        <div id="commentBox">
            <g:form controller="project" action="editCommentSave" role="form" params="['projectTitle': vanityTitle, 'fr': fundRaiser]">
                <g:hiddenField name='teamCommentId' value="${teamCommentId}"></g:hiddenField>
                <g:hiddenField name='commentId' value="${commentId}"></g:hiddenField>

                <div class="form-group">
                    <textarea class="form-control" name="comment" rows="4" required>${commentval}</textarea>
                </div>
                <button type="submit" class="btn btn-primary btn-sm pull-right">Save comment</button>
                <div class="clear"></div>
            </g:form>
        </div>
    </g:if>
	<g:else>
	     <div id="commentBox">
	         <g:if test="${team?.user!=project?.user}">
	             <g:form controller="project" action="teamcomment"  id="${project.id}" params="['fr': fundRaiser]">
	                 <div class="form-group">
	                     <textarea class="form-control" name="comment" rows="4" placeholder="Leave a comment" required></textarea>
	                 </div>
	                 <button type="submit" class="btn btn-primary btn-sm pull-right">Post comment</button>
	                 <div class="clear"></div>
	             </g:form>
	        </g:if>
	        <g:else>
	            <g:form controller="project" action="comment"  id="${project.id}" params="['fr':fundRaiser]">
	                <div class="form-group">
	                    <textarea class="form-control" name="comment" rows="4" placeholder="Leave a comment" required></textarea>
	                </div>
	                <button type="submit" class="btn btn-primary btn-sm pull-right">Post comment</button>
	                <div class="clear"></div>
	            </g:form>
	        </g:else>
	    </div>
	</g:else>
</g:if>
<g:else>
    <h3 class="hidden-xs"><b>Comments</b></h3>
    <div class="alert alert-info sh-comnt-align hidden-xs">No Comments yet.</div>
</g:else>
     
<g:if test="${!listcomment.isEmpty()}">
    <div class="panel panel-default show-comments-details">
        <div class="panel-body commentsoncampaign">
            <div class="list-group">
                <g:each in="${listcomment}" var="comment">
                    <%
                        def date = dateFormat.format(comment.date)
                        def isAnonymous = userService.isAnonymous(comment?.user)
                    %>
                    <g:if test="${user== project?.user}">
                        <g:if test="${!comment.status}">
                            <div class="modal-body tile-footer show-comments-date">
				                <g:if test="${isAnonymous}">
                                    <dt>By ${comment?.userName}, on ${date}</dt>
                                </g:if>
                                <g:else>
                                    <dt>By ${userService.getFriendlyFullName(comment?.user)}, on ${date}</dt>
                                </g:else>
				                <dd>${comment.comment}</dd>
                                <g:if test="${comment?.user == currentUser || project?.user == currentUser}">
                                    <div class="editAndDeleteBtn deleteComment">
                                        <g:form controller="project" action="commentdelete" method="post" params="['projectId':projectId, 'fr': fundRaiser]">
                                            <g:hiddenField name='commentId' value="${comment.id}"></g:hiddenField>
                                            <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this comment?&#39;);">
                                            <i class="glyphicon glyphicon-trash"></i>
                                            </button>
                                        </g:form>
                                        <g:if test="${comment?.user == currentUser}">
                                            <g:form controller="project" name="editComment" action="editComment" method="post" params="['projectTitle': vanityTitle, 'fr': fundRaiser]">
                                                <g:hiddenField name='commentId' value="${comment.id}"></g:hiddenField>
                                                <button type="submit" class="projectedit close" id="projectedit">
                                                    <i class="glyphicon glyphicon-edit glyphicon-lg projectedit"></i>
                                                </button>
                                            </g:form>
                                        </g:if>
                                    </div>
                                </g:if>
			                </div>
			            </g:if>
                    </g:if>
                    <g:else>
                        <div class="modal-body tile-footer show-comments-date">
                            <g:if test="${isAnonymous}">
                                <dt>By ${comment?.userName}, on ${date}</dt>
                            </g:if>
                            <g:else>
                                <dt>By ${userService.getFriendlyFullName(comment?.user)}, on ${date}</dt>
                            </g:else>
                            <dd>${comment.comment}</dd>
                            <g:if test="${team?.user!=project?.user || comment?.user == currentUser}">
                                <g:if test="${team?.user == currentUser || comment?.user == currentUser}">
                                    <div class="editAndDeleteBtn deleteComment">
                                        <g:form controller="project" action="commentdelete" method="post" params="['projectId':projectId, 'fr': fundRaiser]">
                                            <g:hiddenField name='teamCommentId' value="${comment.id}"></g:hiddenField>
                                            <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this comment?&#39;);">
                                            <i class="glyphicon glyphicon-trash"></i>
                                            </button>
                                        </g:form>
                                        <g:if test="${comment?.user == currentUser}">
                                            <g:form controller="project" name="editcomment" action="editComment" method="post" params="['projectTitle': vanityTitle, 'fr': fundRaiser]">
                                                <g:hiddenField name='teamCommentId' value="${comment.id}"></g:hiddenField>
                                                    <button type="submit" class="projectedit close pull-right" id="projectedit">
                                                        <i class="glyphicon glyphicon-edit glyphicon-lg projectedit"></i>
                                                    </button>
                                            </g:form>
                                        </g:if>
                                    </div>
                                </g:if>
                            </g:if>
                        </div>
                    </g:else>
                </g:each>
            </div>
        </div>
    </div>
</g:if>

<!-- Comments -->
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<sec:ifLoggedIn>
    <g:if test="${flash.commentmessage}">
        <div class="alert alert-danger">${flash.commentmessage}</div>
    </g:if>
    <h4 class="lead">Leave a comment</h4>
    <g:form controller="project" action="savecomment" role="form" id="${project.id}">
        <div class="form-group">
            <textarea class="form-control" name="comment" rows="4" required="true"></textarea>
        </div>
        <button type="submit" class="btn btn-primary btn-sm pull-right">Post comment</button>
        <div class="clear"></div>
    </g:form>
</sec:ifLoggedIn>
<sec:ifNotLoggedIn>
    <div class="alert alert-warning">Please login to comment.</div>
</sec:ifNotLoggedIn>

<g:if test="${!project.comments.empty}">
    <div class="panel panel-default" style="margin-top: 30px;">
        <div class="panel-heading">
            <h3 class="panel-title">Project Comments</h3>
        </div>
        <div class="panel-body commentsoncampaign">
            <div class="list-group">
                <g:each in="${project.comments.reverse()}" var="comment">
                    <%
		                def date = dateFormat.format(comment.date)
		            %>
                    
                    <g:if test="${!comment.status}">
                        <div class="modal-body tile-footer" style="text-align: left;">
				            <dt>By ${userService.getFriendlyFullName(comment.user)}, on ${date}</dt>
				            <dd>${comment.comment}</dd>
			            </div>
			        </g:if>
                </g:each>
            </div>
        </div>
    </div>
</g:if>

<!-- Comments -->
<g:set var="userService" bean="userService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def fundRaiser
    def team
    def currentUser= userService.getCurrentUser()
    def beneficiary = project.user 
    if (user) {
        fundRaiser = user.username
        team = userService.getTeamByUser(user, project)
    } else {
        fundRaiser = beneficiary.username
        team = userService.getTeamByUser(beneficiary, project)
    }

    List listcomment=[]
    if(project.user==team.user){
        listcomment= project.comments
    }else{
        listcomment= team.comments
    }
    def projectId=project.id
%>
<sec:ifLoggedIn>
    <g:if test="${flash.commentmessage}">
        <div class="alert alert-danger">${flash.commentmessage}</div>
    </g:if>
    <h4 class="lead">Leave a comment</h4>
    <div id="commentBox">
        <g:if test="${team.user!=project.user}">
            <g:form controller="project" action="saveteamcomment" role="form" id="${project.id}" params="['fr': fundRaiser]">
                <div class="form-group">
                    <textarea class="form-control" name="comment" rows="4" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary btn-sm pull-right">Post comment</button>
                <div class="clear"></div>
            </g:form>
        </g:if>
        <g:else>
            <g:form controller="project" action="savecomment" role="form" id="${project.id}" params="fragment: 'comments'">
                <div class="form-group">
                    <textarea class="form-control" name="comment" rows="4" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary btn-sm pull-right">Post comment</button>
                <div class="clear"></div>
            </g:form>
        </g:else>
    </div>
</sec:ifLoggedIn>
<sec:ifNotLoggedIn>
    <div class="alert alert-warning">Please login to comment.</div>
</sec:ifNotLoggedIn>

<g:if test="${!listcomment.empty}">
    <div class="panel panel-default show-comments-details">
        <div class="panel-heading">
            <h3 class="panel-title">Campaign Comments</h3>
        </div>
        <div class="panel-body commentsoncampaign">
            <div class="list-group">
                <g:each in="${listcomment.reverse()}" var="comment">
                    <%
		                def date = dateFormat.format(comment.date)
		            %>
                    <g:if test="${user== project.user}">
                        <g:if test="${!comment.status}">
                            <div class="modal-body tile-footer show-comments-date">
				                <dt>By ${userService.getFriendlyFullName(comment.user)}, on ${date}</dt>
				                <dd>${comment.comment}</dd>
			                </div>
			            </g:if>
                    </g:if>
                    <g:else>
                        <div class="modal-body tile-footer show-comments-date">
                            <dt>By ${userService.getFriendlyFullName(comment.user)}, on ${date}</dt>
                            <dd>${comment.comment}</dd>
                            <g:if test="${team.user!=project.user}">
                            <g:if test="${team.user==currentUser}">
                                <div class="editAndDeleteBtn deleteComment">
                                    <div class="pull-right">
                                        <g:form controller="project" action="commentdelete" method="post" id="${comment.id}" params="['projectId':projectId, 'fr': fundRaiser]">
                                            <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this comment?&#39;);">
                                            <i class="glyphicon glyphicon-trash"></i>
                                            </button>
                                        </g:form>
                                    </div>
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

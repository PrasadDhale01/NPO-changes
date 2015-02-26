<!-- Comments -->
<%@ page import="java.text.SimpleDateFormat" %>
<%
	def user = userService.getCurrentUser()
	def fundRaiser = user.username
	def	team = userService.getTeamByUser(user, project)
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<g:if test="${user || beneficiary}">
    <div id="commentForm">
        <g:form controller="project" action="saveteamcomment" role="form" id="${project.id}" params="['fr': fundRaiser]">
            <g:hiddenField name="ismanagepage" value="managepage" />
            <div class="form-group">
                <textarea class="form-control" name="comment" rows="4" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary btn-sm pull-right">Post comment</button>
            <div class="clear"></div>
        </g:form>
    </div>
    
    <g:if test="${team}">
		<g:if test="${team.comments}">
			<g:if test="${!team.comments.empty}">
			    <div class="panel panel-default team-comments-css">
			        <div class="panel-heading">
			            <h3 class="panel-title">Team Comments</h3>
			        </div>
			        <div class="panel-body commentsoncampaign">
			            <div class="list-group">
			                <g:each in="${team.comments.reverse()}" var="comment">
					            <%
					                def date = dateFormat.format(comment.date)
					            %>
					            <div class="modal-body tile-footer manage-comments-footer">
						            <dt>By ${userService.getFriendlyFullName(comment.user)}, on ${date}</dt>
						            <dd>${comment.comment}</dd>
					            </div>
					        </g:each>
			            </div>
			        </div>
			    </div>
			</g:if>
		</g:if>
    </g:if>
    <g:else>
        <div class="col-md-12 col-sm-12 col-xs-12 alert alert-info">No comments</div>
    </g:else>
</g:if>

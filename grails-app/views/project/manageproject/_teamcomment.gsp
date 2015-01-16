<!-- Comments -->
<%
	def user = userService.getCurrentUser()
	def fundRaiser = user.username
	def	team = userService.getTeamByUser(user, project)
%>
<g:if test="${user || beneficiary}">
    <g:form controller="project" action="saveteamcomment" role="form" id="${project.id}" params="['fundRaiser': fundRaiser]">
        <div class="form-group">
            <textarea class="form-control" name="comment" rows="4" required="true"></textarea>
        </div>
        <button type="submit" class="btn btn-primary btn-sm pull-right">Post comment</button>
    </g:form>
	<g:if test="${team.comments}">
		<g:if test="${!team.comments.empty}">
		    <h4 class="lead">Comments</h4>
		    <dl class="dl">
		        <g:each in="${team.comments}" var="comment">
		            <hr>
		            <dt>${userService.getFriendlyFullName(comment.user)}</dt>
		            <dd>${comment.comment}</dd>
		        </g:each>
		    </dl>
		</g:if>
	</g:if>
    
</g:if>

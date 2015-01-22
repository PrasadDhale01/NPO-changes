<!-- Comments -->
<%
    def fundRaiser
	def team
	def beneficiary = project.user 
    if (user) {
	    fundRaiser = user.username
		team = userService.getTeamByUser(user, project)
    } else {
	    fundRaiser = beneficiary.username
		team = userService.getTeamByUser(beneficiary, project)
	}
	
%>
<g:if test="${user || beneficiary}">
	<sec:ifLoggedIn>
	    <g:if test="${flash.commentmessage}">
	        <div class="alert alert-danger">${flash.teamcommentmessage}</div>
	    </g:if>
	    <h4 class="lead">Leave a comment</h4>
	    <g:form controller="project" action="saveteamcomment" role="form" id="${project.id}" params="['fundRaiser': fundRaiser]">
	        <div class="form-group">
	            <textarea class="form-control" name="comment" rows="4" required="true"></textarea>
	        </div>
	        <button type="submit" class="btn btn-primary btn-sm pull-right">Post comment</button>
	    </g:form>
	</sec:ifLoggedIn>
	<sec:ifNotLoggedIn>
	    <div class="alert alert-warning">Please login to comment.</div>
	</sec:ifNotLoggedIn>

	<g:if test="${team.comments}">
		<g:if test="${!team.comments.empty}">
		    <h4 class="lead">Comments</h4>
		    <dl class="dl">
		        <g:each in="${team.comments.reverse()}" var="comment">
		            <hr>
		            <dt>${userService.getFriendlyFullName(comment.user)}</dt>
		            <dd>${comment.comment}</dd>
		        </g:each>
		    </dl>
		</g:if>
	</g:if>
</g:if>

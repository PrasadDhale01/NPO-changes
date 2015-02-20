<!-- Comments -->
<%@ page import="java.text.SimpleDateFormat" %>
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
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<g:if test="${user || beneficiary}">
	<sec:ifLoggedIn>
	    <g:if test="${flash.commentmessage}">
	        <div class="alert alert-danger">${flash.teamcommentmessage}</div>
	    </g:if>
	    <h4 class="lead">Leave a comment</h4>
	    <g:form controller="project" action="saveteamcomment" role="form" id="${project.id}" params="['fr': fundRaiser]">
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
	
    <g:if test="${team}">
		<g:if test="${team.comments}">
			<g:if test="${!team.comments.empty}">
			    <div class="panel panel-default show-team-comments">
			        <div class="panel-heading">
			            <h3 class="panel-title">Team Comments</h3>
			        </div>
			        <div class="panel-body commentsoncampaign">
			            <div class="list-group">
			                <g:each in="${team.comments.reverse()}" var="comment">
					            <%
					                def date = dateFormat.format(comment.date)
					            %>
					            <div class="modal-body tile-footer show-team-footer">
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
    	<div class="col-md-12 col-sm-12 col-xs-12 alert alert-info">No Comments.</div>
	</g:else>
</g:if>

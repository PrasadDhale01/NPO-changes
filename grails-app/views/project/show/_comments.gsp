<!-- Comments -->
<sec:ifLoggedIn>
    <g:if test="${flash.commentmessage}">
        <div class="alert alert-danger">${flash.commentmessage}</div>
    </g:if>
    <h4 class="lead">Leave a comment</h4>
    <g:form controller="project" action="savecomment" role="form" id="${project.id}">
        <div class="form-group">
            <textarea class="form-control" name="comment" rows="4" required="true"></textarea>
        </div>
        <button type="submit" class="btn btn-default pull-right">Post comment</button>
    </g:form>
</sec:ifLoggedIn>

<g:if test="${!project.comments.empty}">
    <h4 class="lead">Comments</h4>
    <dl class="dl">
        <g:each in="${project.comments}" var="comment">
            <hr>
            <dt>${comment.user.username}</dt>
            <dd>${comment.comment}</dd>
        </g:each>
    </dl>
</g:if>
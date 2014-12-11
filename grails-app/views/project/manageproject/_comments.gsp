<!-- Comments -->

<g:if test="${!project.comments.empty}">
    <div class="panel panel-default" style="margin-top: 30px;">
        <div class="panel-heading">
            <h3 class="panel-title">Project Comments</h3>
        </div>
        <div class="panel-body">
            <div class="list-group">
                <g:each in="${project.comments}" var="comment">
                    <div class="list-group-item">
                        <dt>${userService.getFriendlyFullName(comment.user)}</dt>
                        <dd>${comment.comment}</dd>
                        <input type="checkbox" name="link" id="${comment.id}" value="${comment.id}" 
                            <g:if test="${comment.status }">checked="checked"</g:if>><span id="check${comment.id}"> Hide</span>
                        </input>
                    </div>
                </g:each>
            </div>
        </div>
    </div>
</g:if>
<g:else>
    <div class="alert alert-info">No comments yet</div>
</g:else>
<div id="test"></div>

<!-- Comments -->

<g:if test="${!project.comments.empty}">
    <div class="panel panel-default" style="margin-top: 30px;">
        <div class="panel-heading">
            <h3 class="panel-title">Project Comments</h3>
        </div>
        <div class="panel-body">
            <div class="list-group" id="uniqueId">
                <g:set var="i" value="1"></g:set>
                <g:each in="${project.comments.reverse()}" var="comment">
                    <div class="list-group-item">
                        <dt>${userService.getFriendlyFullName(comment.user)}</dt>
                        <dd>${comment.comment}</dd>
                        <input type="checkbox" name="link" id="${i}" value="${comment.id}" 
                            <g:if test="${comment.status }">checked="checked"</g:if>><span id="check${i}"> Hide</span>
                        </input>
                        <% i++ %>
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

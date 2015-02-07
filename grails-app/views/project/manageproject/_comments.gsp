<!-- Comments -->
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<g:if test="${!project.comments.empty}">
    <div class="panel panel-default manage-comments">
        <div class="panel-heading">
            <h3 class="panel-title">Project Comments</h3>
        </div>
        <div class="panel-body commentsoncampaign">
            <div class="list-group" id="uniqueId">
                <g:set var="i" value="1"></g:set>
                <g:each in="${project.comments.reverse()}" var="comment">
                    <div class="modal-body tile-footer manage-comments-footer">
                        <%
                            def date = dateFormat.format(comment.date)
                        %>
                        <dt>By ${userService.getFriendlyFullName(comment.user)}, on ${date} </dt>
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

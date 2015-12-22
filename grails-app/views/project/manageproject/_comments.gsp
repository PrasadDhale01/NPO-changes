<%-- Comments --%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def projectId=project.id
    def manageCampaign = "manageCampaign"
%>
<div class="<g:if test="${project.comments.empty}">col-md-12</g:if><g:else>col-md-offset-1 col-md-10</g:else> col-sm-12 col-xs-12 mange-comments-bottom">
	<g:if test="${!project.comments.empty}">
        <br>
        <div class="commentsoncampaign">
            <div class="list-group" id="uniqueId">
                <g:set var="i" value="1"></g:set>
                <g:each in="${project.comments.reverse()}" var="comment">
                    <div class="modal-body tile-footer manage-comments-footer">
                        <%
                            def date = dateFormat.format(comment.date)
                            def isAnonymous = userService.isAnonymous(comment.user)
                        %>
                        <g:if test="${isAnonymous}">
                            <dt>By ${comment.userName}, on ${date}</dt>
                        </g:if>
                        <g:else>
                            <dt>By ${userService.getFriendlyFullName(comment.user)}, on ${date}</dt>
                        </g:else>
                        <dd>${comment.comment}</dd>
                        <input type="checkbox" name="link" id="${i}" value="${comment.id}" 
                            <g:if test="${comment.status }">checked="checked"</g:if>><span id="check${i}"> Hide</span>
                        <% i++ %>
                        <div class="editAndDeleteBtn deleteComment">
	                       <div class="pull-right">
                               <g:form controller="project" action="commentdelete" method="post" params="['projectId':projectId]">
                   	                <g:hiddenField name="manageCampaign" value="${manageCampaign}" id="comments${comment.id}"></g:hiddenField>
                   	                <g:hiddenField name='commentId' value="${comment.id}" id="commentId${comment.id}"></g:hiddenField>
                       	            <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this comment?&#39;);">
                                 	   <i class="glyphicon glyphicon-trash"></i>
                       	            </button>
                   	           </g:form>
                           </div>
                       	</div>
                    </div>
                </g:each>
            </div>
        </div>
	</g:if>
	<g:else>
	    <div class="alert alert-info">No comments yet</div>
	</g:else>
	<div id="test"></div>
</div>

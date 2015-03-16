<!-- Comments -->
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def projectId=project.id
    def manageCampaign = "manageCampaign"
%>
<div class="col-md-8 col-sm-8 col-xs-12">
	<g:if test="${!project.comments.empty}">
	    <div class="panel panel-default">
	        <div class="panel-heading">
	            <h3 class="panel-title">Campaign Comments</h3>
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
	                        <div class="editAndDeleteBtn deleteComment">
		                   <div class="pull-right">
                                       <g:form controller="project" action="commentdelete" method="post" id="${comment.id}" params="['projectId':projectId]">
                                	  <g:hiddenField name="manageCampaign" value="${manageCampaign}"></g:hiddenField>
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
	    </div>
	</g:if>
	<g:else>
	    <div class="alert alert-info">No comments yet</div>
	</g:else>
	<div id="test"></div>
</div>

<div class="col-md-4 col-sm-4 col-xs-12">
	<g:render template="/project/manageproject/tilesanstitle" />
	<g:if test="${project.draft}">
		<g:form controller="project" action="saveasdraft" id="${project.id}">
			<button class="btn btn-block btn-primary">
				<i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval
			</button>
		</g:form>
	</g:if>
</div>

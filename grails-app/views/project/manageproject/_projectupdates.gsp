<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>

<div class="<g:if test="${!project.validated || ended || project.projectUpdates.empty}">col-md-12</g:if><g:else>col-md-offset-2 col-md-8</g:else> col-sm-12 col-xs-12">
    <g:if test="${project.validated}">
        <g:if test="${ended}">
	    	<div class="alert alert-info">Campaign Ended.</div>
	    </g:if>
	    <g:if test="${project.projectUpdates.empty}">
		    <g:if test="${!ended}">
		    	<div class="alert alert-info">No updates yet.</div>
		    </g:if>
		</g:if>
        <g:if test="${!ended}">
	        <g:uploadForm class="form-horizontal" controller="project" action="projectupdate" id="${project.id}" role="form">
	            <button type="submit" class="btn btn-sm btn-primary pull-right" name="button" value="draft"><i class="fa fa-plus-circle"></i> Create Update</button>
	        </g:uploadForm>
		    <div class="clear"></div>
		</g:if>
		
		<g:if test="${!project.projectUpdates.empty}">
		    <%
		        def projectUpdates = project.projectUpdates.reverse()
		        def i = projectUpdates.size()
		        def count = projectUpdates.size()
			    def rows = projectUpdates.size()
			    def index = 0
			%>
		    <g:each in="${(1..rows).toList()}" var="row">
			    <div class="col-md-12 col-sm-12 col-xs-12 campaignupdate">
	                <% if (index < count) { %>
	                    <g:render template="/project/manageproject/campaigngrid" model="['projectUpdate': projectUpdates.get(index++), 'manageProject':'manageProject','i': i--]"></g:render>
	                <% } %>
			    </div>
			</g:each>
		</g:if>
	</g:if>
	<g:else>
	        <div class="alert alert-info">You can post updates after the campaign is published.</div>
	</g:else>
</div>

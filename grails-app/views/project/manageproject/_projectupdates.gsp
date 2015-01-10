<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>

<div class="col-md-12 col-sm-12 col-xs-12">
    <g:if test="${project.validated}">
		<div class="row">
		    <div class="col-xs-12">
		        <g:uploadForm class="form-horizontal" controller="project" action="projectupdate" id="${project.id}" role="form">
		            <button type="submit" class="btn btn-sm btn-primary pull-right" name="button" value="draft"><i class="fa fa-plus-circle"></i> Create Update</button>
		        </g:uploadForm>
		    </div>
		</div>
	    
		<g:if test="${!project.projectUpdates.empty}">
		    <%
		        def projectUpdates = project.projectUpdates.reverse()
		        def i = projectUpdates.size()
		        def count = projectUpdates.size()
			    def rows = projectUpdates.size()
			    def index = 0
			%>
		    <g:each in="${(1..rows).toList()}" var="row">
			    <div class="row campaignupdate">
	                <% if (index < count) { %>
	                    <g:render template="/project/manageproject/campaigngrid" model="['projectUpdate': projectUpdates.get(index++), 'i': i--]"></g:render>
	                <% } %>
			    </div>
			</g:each>
		</g:if>
		<g:else>
		    <br/>
		    <div class="alert alert-info">No updates yet.</div>
		</g:else>
	</g:if>
	<g:else>
	    <div class="row">
		    <div class="alert alert-info">You can post updates after the project is published.</div>
		</div>
	</g:else>
</div>

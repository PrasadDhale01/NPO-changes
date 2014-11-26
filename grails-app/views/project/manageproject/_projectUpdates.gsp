<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>

<div class="feducontent">
	<div class="row">
	    <div class="col-xs-12">
	        <h1 class="text-success text-center">Recent Updates</h1>
	    </div>
	    <div class="col-xs-12">
	        <g:uploadForm class="form-horizontal" controller="project" action="projectupdate" id="${project.id}" role="form">
	            <button type="submit" class="btn btn-primary pull-right" name="button" value="draft"><i class="fa fa-plus-circle"></i> Updates</button>
	        </g:uploadForm>
	    </div>
	</div>
	
	<g:if test="${!project.projectUpdates.empty}">
	    <%
	        def projectUpdates = project.projectUpdates.reverse()
	        def i = projectUpdates.size()
	    %>
	    <g:each in="${projectUpdates}" var="projectUpdate">
	        <br/>
	        <p class="text-success">Update #${i--} &nbsp;<i class="fa fa-info-circle"></i></p>
	        <span class="project-story-span">${raw(projectUpdate.story)}</span>
	    </g:each>
	</g:if>
	<g:else>
	    <br/>
	    <div class="alert alert-info">No updates yet.</div>
	</g:else>
</div>

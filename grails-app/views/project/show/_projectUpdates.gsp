<div class="feducontent">
    <h1 class="text-success text-center">Recent Updates</h1>

    <g:if test="${!project.projectUpdates.empty}">
	    <%
	        def projectUpdates = project.projectUpdates.reverse()
	        def i = projectUpdates.size()
	    %>
	    <g:each in="${projectUpdates}" var="projectUpdate">
	        <br/>
	        <a href="#">Update #${i--}</a>
	        <span class="project-story-span">${raw(projectUpdate.story)}</span>
	    </g:each>
	</g:if>
	<g:else>
	    <br/>
	    <div class="alert alert-info">No updates yet.</div>
	</g:else>
</div>


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
	    <div class="alert alert-info">No updates yet.</div>
	</g:else>

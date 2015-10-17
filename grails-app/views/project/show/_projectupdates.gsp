<div class="col-md-12">
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
		<div class="row">
			<div class="alert alert-info hidden-xs">No updates yet.</div>
		</div>
	</g:else>
</div>

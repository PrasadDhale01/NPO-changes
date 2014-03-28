<g:if test="${projects.size() == 0}">
    <div class="alert alert-warning">
        You haven't created any projects yet. You can create one <g:link controller="project" action="create">here</g:link>.
    </div>
</g:if>
<g:else>
    <g:render template="/project/list/grid" model="['projects': projects]"></g:render>
</g:else>

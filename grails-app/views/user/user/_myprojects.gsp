<g:if test="${projects.size() == 0}">
    <div class="alert alert-warning">
        You haven't created any campaigns yet. You can create one <g:link controller="project" action="create">here</g:link>.
    </div>
</g:if>
<g:else>
    <g:render template="/user/user/grid" model="['projects': projects]"></g:render>
</g:else>

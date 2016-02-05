<g:if test="${totalprojects.size() == 0}">
    <div class="alert alert-warning">
        You haven't created any campaigns yet. You can create one <g:link controller="project" action="create">here</g:link>.
    </div>
</g:if>
<g:else>
    <div id="adminCampaignGrid">
        <g:render template="/user/user/grid" model="['projects': totalprojects]"></g:render>
    </div>
</g:else>

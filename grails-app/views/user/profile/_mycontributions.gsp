<g:if test="${contributions.size() == 0}">
    <div class="alert alert-warning">
        You haven't contributed to any project yet. You can start contributing <g:link controller="project" action="list">here</g:link>.
    </div>
</g:if>
<g:else>
    You have made ${contributions.size()} contribution(s).
</g:else>

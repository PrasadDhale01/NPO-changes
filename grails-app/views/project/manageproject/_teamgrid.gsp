<div class="row">
    <ul class="thumbnails list-unstyled">
        <g:each in="${validatedTeam}" var="team">
            <li class="col-md-3 col-sm-6 col-xs-12">
                <g:render template="/project/manageproject/teamtile" model="['team': team]"></g:render>
            </li>
        </g:each>
    </ul>
</div>
<g:if test="${totalteams.size() > validatedTeam.size()}">
    <div class="showmoreteams col-md-3 col-sm-6 col-xs-12 text-center">
        <g:link class="btn btn-primary btn-sm showteambtn" action="showteams" controller="project" params="['teamOffset': teamOffset, 'projectTitle':vanityTitle]">Show more</g:link>
    </div>
</g:if>

<div class="row">
    <ul class="thumbnails list-unstyled">
        <g:each in="${teams}" var="team">
            <li class="col-md-4 col-sm-6 col-xs-12">
                <g:render template="/project/manageproject/teamtile" model="['team': team]"></g:render>
            </li>
        </g:each>
    </ul>
</div>

<g:if test="${totalteams.size() > teams.size()}">
    <div class="showmoreteams col-md-4 col-sm-6 col-xs-12 text-center">
        <g:link class="btn btn-primary btn-sm showteambtn" action="showMoreteam" controller="project" params="['teamOffset': teamOffset, 'projectTitle':vanityTitle,'fr': vanityUsername]">Show more</g:link>
    </div>
</g:if>

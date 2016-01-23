<%
    projectId = project.id
%>

<ul class="thumbnails list-unstyled">
    <g:each in="${validatedTeam}" var="team">
        <li class="col-lg-3 col-md-4 col-sm-4 col-xs-12 col-xs-p-0">
            <g:render template="/project/manageproject/teamtile" model="['team': team]"></g:render>
        </li>
    </g:each>
</ul>

<div class="showmoreteams manage-teamgridTabs col-md-12 col-sm-12 col-xs-12">
    <g:if test="${totalteams.size() > teamOffset}">
        <g:link class="btn btn-primary btn-sm showteambtn" action="teamList" controller="project" params="['teamOffset': teamOffset, 'projectId':projectId]">Show more</g:link>
    </g:if>
</div>
<script>
    $('.showmoreteams a').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var grid = $('.showmoreteams');

        $.ajax({
            type: 'GET',
            url: url,
            success: function(data) {
               // $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                $('#teamList').append(data);
                $('#teamList').find('.showmoreteams').first().remove();
            }
        });
    });
</script>

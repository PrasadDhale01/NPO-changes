<%
    def projectId = project.id
    boolean isshow = true;
%>
<div class="row show-widht-team">
    <ul class="thumbnails list-unstyled sh-mobs-teams show-teams-width">
        <g:each in="${teams}" var="team">
            <li class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
                <g:render template="/project/manageproject/teamtile" model="['team': team, isshow: isshow]"></g:render>
            </li>
        </g:each>
    </ul>
</div>

<div class="showmoreteams col-md-4 col-sm-6 col-xs-12 text-center">
    <g:if test="${totalteams.size() > teamOffset}">
        <g:link class="btn btn-primary btn-sm showteambtn" action="teamsList" controller="project" params="['teamOffset': teamOffset, 'projectId':projectId,'fr': vanityUsername]">Show more</g:link>
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

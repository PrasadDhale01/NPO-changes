<g:if test="${projects.size() == 0}">
    <g:if test="${dashboard}">
        <div class="col-sm-12">
            <div class="alert alert-info">
                You haven't created any campaigns yet. You can create one <g:link controller="project" action="create">here</g:link>.
            </div>
        </div>
    </g:if>
    <g:else>
        <div class="alert alert-warning">
            You haven't created any campaigns yet. You can create one <g:link controller="project" action="create">here</g:link>.
        </div>
    </g:else>
</g:if>
<g:else>
    <g:if test="${dashboard}">
        <g:render template="/user/user/grid" model="['projects': totalCampaings]"></g:render>
    </g:if>
    <g:else>
        <div id="adminCampaignGrid">
            <g:render template="/user/user/grid" model="['projects': projects]"></g:render>
        </div>
    </g:else>
</g:else>
<g:if test="${dashboard && activeTab == 'campaigns'}">
    <g:hiddenField name="dashboard" value="${dashboard}" id="dashboard"/>
    <div class="usersCampaignsPagination pull-right" id="userCampaignsPagination">
        <g:paginate controller="user" max="4" maxsteps= "5" action="campaignpagination" total="${projects.size()}"/>
    </div>

    <script>
        if ($('#dashboard').val()) {
            $('#userCampaignsPagination a').click(function(event) {
                event.preventDefault();
                var url = $(this).attr('href');
                var grid = $(this).parents('#userDashboardcampaigns');
                ajaxCall(url, grid);
            });
        
            function ajaxCall(url, grid) {
                $.ajax({
                    type: 'GET',
                    url: url,
                    success: function(data) {
                        $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                    }
                });
            }
        }
    </script>
</g:if>

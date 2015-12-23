<div class="metricsTabTop">
    <div class="table table-responsive">
        <table class="table table-bordered">
            <thead>
                <tr class="alert alert-title">
                    <th>Id</th>
                    <th class="col-sm-2 text-center">Email</th>
                    <th class="col-sm-2 text-center">Campaigns Created</th>
                    <th class="col-sm-2 text-center">Campaigns Contributed to</th>
                    <th class="col-sm-2 text-center">Category Supported to</th>
                    <th class="col-sm-2 text-center">Avg Contribution</th>
                    <th class="col-sm-2 text-center">Min Contribution</th>
                    <th class="col-sm-2 text-center">Max Contribution</th>
                </tr>
            </thead>
            <tbody>
                <g:render template="/user/metrics/userListGrid" model="['users': verifiedUsers]"></g:render>
            </tbody>
        </table>
    </div><br>
</div>
<div class="row domainUsersPagination" id="domainUsersPagination">
    <g:paginate controller="user" max="12" maxsteps="5" action="usersList" total="${totalUsers.size()}"/>
</div>

<script>
$('.domainUsersPagination a').click(function(event) {
    event.preventDefault();
    var url = $(this).attr('href');
    var grid = $(this).parents('#domainusers');
    $.ajax({
        type: 'GET',
        url: url,
        success: function(data) {
            $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
        }
    });
});
</script>

<div class="row metricsTabTop">
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

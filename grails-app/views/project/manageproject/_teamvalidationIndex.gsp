<div class="col-md-12 col-sm-12 col-xs-12 mange-team-bottem"><br>
    <h2><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-validated.png" alt="Teams Validation"/>&nbsp;Teams Validation</h2>
    <br>
    <g:if test="${unValidatedTeam.size() > 0}">
        <div class="table table-responsive">
            <table class="table table-bordered">
                <thead>
                    <tr class="alert alert-title ">
                        <th class="text-center">Id</th>
                        <th class="text-center">First Name</th>
                        <th class="text-center">Last Name</th>
                        <th class="text-center">Email</th>
                        <th class="text-center">Requested On</th>
                        <th class="text-center">Validate</th>
                        <th class="text-center">Discard</th>
                    </tr>
                </thead>
                <tbody>
                    <g:render template="manageproject/teamvalidationgrid"></g:render>
                </tbody>
             </table>
        </div>
    </g:if>
    <g:else>
        <div class="alert alert-info">No team request to review.</div>
    </g:else>
</div>

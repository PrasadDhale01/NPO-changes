<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">

        <h2>Admin Dashboard</h2>

        <h4>Vital Stats</h4>
        <g:render template="admin/vitals"/>

        <hr>

        <h4>Control Panel</h4>
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <i class="fa fa-users"></i> Manage all the communities here.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="community" action="manageall">
                            <button class="btn btn-block btn-primary"><i class="fa fa-users"></i> Manage Communities</button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <i class="fa fa-gift fa-lg"></i> Manage all the rewards here.
                    </div>
                    <div class="panel-footer">
                        <button class="btn btn-block btn-primary"><i class="fa fa-gift fa-lg"></i> Manage Rewards</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>

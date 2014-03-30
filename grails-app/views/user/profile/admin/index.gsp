<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">

        <h2>Admin Dashboard</h2>
        <ul class="nav nav-tabs nav-justified" style="margin-bottom: 10px;">
            <li class="active"><a href="#manage-community" data-toggle="tab">
                <i class="fa fa-users"></i></span> Manage Communities
            </a></li>
            <li><a href="#account-settings" data-toggle="tab">
                <span class="glyphicon glyphicon-user"></span> Account
            </a></li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane active" id="manage-community">
                <g:render template="profile/admin/managecommunity"/>
            </div>
            <div class="tab-pane" id="account-settings">
                <g:render template="profile/accountsettings"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

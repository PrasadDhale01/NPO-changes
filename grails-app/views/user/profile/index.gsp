<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="container">

    <h2>User Profile</h2>
    <ul class="nav nav-tabs" style="margin-bottom: 10px;">
        <li class="active"><a href="#myprojects" data-toggle="tab">My Projects</a></li>
        <li><a href="#my-contributions" data-toggle="tab">My Contributions</a></li>
        <li><a href="#account-settings" data-toggle="tab">Account</a></li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div class="tab-pane active" id="myprojects">
            <g:render template="profile/myprojects"/>
        </div>
        <div class="tab-pane" id="my-contributions">
            <g:render template="profile/mycontributions"/>
        </div>
        <div class="tab-pane" id="account-settings">
            <g:render template="profile/accountsettings"/>
        </div>
    </div>

</div>
</body>
</html>

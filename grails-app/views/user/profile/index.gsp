<g:set var="userService" bean="userService"/>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">

        <h2>User Profile</h2>
        <ul class="nav nav-tabs nav-justified" style="margin-bottom: 10px;">
            <li class="active"><a href="#myprojects" data-toggle="tab">
                <span class="glyphicon glyphicon-home"></span> My Projects
            </a></li>
            <li><a href="#my-contributions" data-toggle="tab">
                <span class="glyphicon glyphicon-tint"></span> My Contributions
            </a></li>
            <g:if test="${userService.isCommunityManager()}">
                <li><a href="#my-community" data-toggle="tab">
                    <i class="fa fa-users"></i></span> My Community
                </a></li>
            </g:if>
            <li><a href="#account-settings" data-toggle="tab">
                <span class="glyphicon glyphicon-user"></span> Account
            </a></li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane active" id="myprojects">
                <g:render template="profile/myprojects"/>
            </div>
            <div class="tab-pane" id="my-contributions">
                <g:render template="profile/mycontributions"/>
            </div>
            <g:if test="${userService.isCommunityManager()}">
                <div class="tab-pane" id="my-community">
                    Please go to <g:link controller="community" action="manage">Manage Communities</g:link>
                </div>
            </g:if>
            <div class="tab-pane" id="account-settings">
                <g:render template="profile/accountsettings"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

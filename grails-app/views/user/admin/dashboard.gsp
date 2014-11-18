<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${flash.message}">
    <div class="alert alert-info">
        ${flash.message}
    </div>
</g:if>
<div class="feducontent">
    <div class="container">

        <h2><i class="fa fa-unlock"></i> Admin Dashboard</h2>

        <h4>Vital Stats</h4>
        <g:render template="/user/admin/vitals"/>

        <hr>

        <%--
        <div class="btn-group btn-toggle"> 
            <g:link class="btn btn-primary" action="invite" controller="login">Invite only mode</g:link>
            <g:link class="btn btn-default active" action="openRegister" controller="login">Open Registration</g:link>
        </div>
        <hr>
        --%>
        

        <h4>Control Panel</h4>
        <%--
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
                        <g:link controller="reward" action="list">
                            <button class="btn btn-block btn-primary"><i class="fa fa-gift fa-lg"></i> Manage Rewards</button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <i class="fa fa-gift fa-lg"></i> Manage all shipping pending items here.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="reward" action="shipping">
                            <button class="btn btn-block btn-primary"><i class="fa fa-gift fa-lg"></i> Manage shipping pending items</button>
                        </g:link>
                    </div>
                </div>
            </div>
        </div>
        --%>

	    <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <i class="glyphicon glyphicon-check"></i> Validate projects here.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="project" action="validateList">
                            <button class="btn btn-block btn-primary"><i class="glyphicon glyphicon-check"></i> Validate Projects</button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <i class="glyphicon glyphicon-user"></i> Manage all the invite requests here.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="login" action="list">
                            <button class="btn btn-block btn-primary"><span class="fa fa-user fa-lg"></span> Manage Invites</button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <i class="fa fa-leaf fa-lg"></i> Bulk import projects here.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="project" action="importprojects">
                            <button class="btn btn-block btn-primary"><i class="fa fa-gift fa-lg"></i> Bulk Import Projects</button>
                        </g:link>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>

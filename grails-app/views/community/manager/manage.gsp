<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="communityjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <h2>Manage Communities</h2>

        <g:each in="${communities}" var="community">
            <div class="panel panel-primary">
                <div class="panel-heading"><i class="fa fa-users"></i> ${community.title}</div>
                <div class="panel-body">
                    <g:render template="manager/boards" model="[community: community]"/>

                    <div class="row">
                        <div class="col-md-6">
                            <g:render template="manager/members" model="[community: community]"/>
                        </div>
                        <div class="col-md-6">
                            <g:render template="manager/transactions" model="[community: community]"/>
                        </div>
                    </div>
                </div>
            </div>
        </g:each>
    </div>
</div>
</body>
</html>

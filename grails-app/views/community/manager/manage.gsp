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
            <div class="panel panel-default">
                <div class="panel-heading">${community.title}</div>
                <div class="panel-body">
                    <g:render template="manager/boards" model="[community: community]"/>
                    <g:render template="manager/moredetails" model="[community: community]"/>
                </div>
            </div>
        </g:each>
    </div>
</div>
</body>
</html>

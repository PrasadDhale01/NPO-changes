<html>
<head>
    <meta name="layout" content="main"/>
</head>

<body>
<div class="feducontent">
    <div class="container">
        <h1>Error</h1>
        <g:if test="${facelogoutmsg}">
            <div class="alert alert-danger">
                ${facelogoutmsg}
            </div>
        </g:if>
        <g:if test="${message}">
            <div class="alert alert-danger">
                ${message}
            </div>
        </g:if>
    </div>
</div>
</body>
</html>

<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <h2>Error</h2>
        <div class="alert alert-danger">
            <g:if test="${flash}">
                <ul>
                    <li>${flash.message}</li>
                </ul>
            </g:if>
        </div>

        <g:if env="development">
            <g:renderErrors bean="${user}"/>
        </g:if>
    </div>
</div>
</body>
</html>

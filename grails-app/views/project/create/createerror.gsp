<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
    <div class="container">
        <h2>Error</h2>
        <div class="alert alert-danger">
            Oh snap! Something went wrong creating the project.
            <g:if test="${flash}">
                <ul>
                    <li>${flash.message}</li>
                </ul>
            </g:if>
        </div>

        <g:if env="development">
            <g:renderErrors bean="${project}"/>
        </g:if>
    </div>
</body>
</html>

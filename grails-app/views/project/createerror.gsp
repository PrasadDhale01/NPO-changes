<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
    <div class="container">
        <h2>Error</h2>
        <p><div class="alert alert-danger">Oh snap! Something went wrong creating the project.</div></p>
        <g:if env="development">
            <g:renderErrors bean="${project}"/>
        </g:if>
    </div>
</body>
</html>

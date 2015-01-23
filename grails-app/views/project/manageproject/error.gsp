<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <h2>Error</h2>
        <div class="alert alert-danger">
            Oh snap! Something went wrong.
            <g:if test="${flash.prj_mngprj_message}">
                <ul>
                    <li>${flash.prj_mngprj_message}</li>
                </ul>
            </g:if>
        </div>

        <g:if env="development">
            <g:renderErrors bean="${project}"/>
        </g:if>
    </div>
</div>
</body>
</html>

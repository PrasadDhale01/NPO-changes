<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <h2>Error</h2>
        <div class="alert alert-danger">
            <p>Oh snap! Looks like that project is not validated by Administrator.</p>
            <g:if test="${flash.prj_validate_err_message}">
                <ul>
                    <li>${flash.prj_validate_err_message}</li>
                </ul>
            </g:if>
        </div>

        <g:if env="development">
            <g:renderErrors bean="${projects}"/>
        </g:if>
    </div>
</div>
</body>
</html>

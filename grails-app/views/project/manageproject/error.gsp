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
            <g:if test="${flash.session_message}">
                <ul>
                    <li>${flash.session_message}</li>
                </ul>
                <g:javascript>
                    alert('Session timeout, please login!');
                    window.location.href = '/logout';
                </g:javascript>
            </g:if>
            <g:elseif test="${flash.prj_mngprj_message}">
                <ul>
                    <li>${flash.prj_mngprj_message}</li>
                </ul>
            </g:elseif>
        </div>

        <g:if env="development">
            <g:renderErrors bean="${project}"/>
        </g:if>
    </div>
</div>
</body>
</html>

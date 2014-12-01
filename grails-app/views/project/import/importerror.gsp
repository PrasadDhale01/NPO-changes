<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <h2>Error</h2>
        <div class="alert alert-danger">
            Oh snap! Something went wrong importing the campaigns.
            <g:if test="${flash && flash.projecterror}">
                <div class="alert alert-danger">
                    <p>Error while validating campaign with title: ${flash.projecterror.title}</p>
                    <p>${flash.projecterror.error}</p>
                    <g:if test="${flash.projecterror.note}">
                        <p>NOTE: ${flash.projecterror.error}</p>
                    </g:if>
                </div>
            </g:if>
        </div>

        <g:if env="development">
            <g:renderErrors bean="${project}"/>
        </g:if>
    </div>
</div>
</body>
</html>

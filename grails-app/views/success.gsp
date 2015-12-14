<html>
	<head>
		<title>Success</title>
		<meta name="layout" content="main">
	</head>
	<body>
        <div class="feducontent">
            <div class="container">
                <h2>Success</h2>
                <g:if test="${flash.sucess_message}">
                    <div class="alert alert-success">
                        ${flash.success_message}
                    </div>
                </g:if>
                <g:elseif test="${sucess_message}">
                    <div class="alert alert-success">
                        ${sucess_message}
                    </div>
                </g:elseif>
                <g:else>
                    <div class="alert alert-success">
                        Success.
                    </div>
                </g:else>
            </div>
        </div>
	</body>
</html>

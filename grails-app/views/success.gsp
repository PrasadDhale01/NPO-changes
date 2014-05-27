<html>
	<head>
		<title>Success</title>
		<meta name="layout" content="main">
	</head>
	<body>
        <div class="feducontent">
            <div class="container">
                <h2>Success</h2>
                <g:if test="${flash.message}">
                    <div class="alert alert-success">
                        ${flash.message}
                    </div>
                </g:if>
                <g:else>
                    <div class="alert alert-success">
                        Success.
                    </div>
                </g:else>
            </div>
        </div>
	</body>
</html>

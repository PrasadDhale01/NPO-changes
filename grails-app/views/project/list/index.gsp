<html>
<head>
<meta name="layout" content="main" />
</head>
<body>

	<div class="container">
		<h1>Contribute</h1>

        <%--
        <ul>
	        <g:each in="${projects}">
	            <li>${it.title}</li>
	        </g:each>
        </ul>
        --%>

        <!-- Search -->
        <g:render template="list/search"></g:render>

		<!-- Carousel -->
		<g:render template="list/contribute"></g:render>
	</div>
</body>
</html>

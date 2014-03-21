<html>
<head>
<meta name="layout" content="main" />
<r:require module="projectlistjs"/>

</head>
<body>

	<div class="container">
		<h1>Contribute</h1>

        <!-- Search -->
        <%-- <g:render template="list/search"></g:render> --%>

        <!-- Carousel -->
		<g:render template="list/grid" model="['projects': projects]"></g:render>
	</div>
</body>
</html>

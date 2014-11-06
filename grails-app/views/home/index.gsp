<html>
<head>
<meta name="layout" content="main" />
<r:require modules="homejs"/>
</head>
<body>
	<div onmouseover="showNavigation()" onmouseleave="hideNavigation()">
    	<g:render template="jumbotron"></g:render><br>
    </div>

    <!-- Call to action buttons -->
    <%-- <g:render template="createfund"></g:render> --%>

    <g:render template="banner"></g:render><br>
    
    <!-- Ask/Contribute/Enable grid -->
    <g:render template="ace"></g:render><br><br>

    <!-- Carousel -->
    <g:render template="projects"></g:render>

</body>
</html>

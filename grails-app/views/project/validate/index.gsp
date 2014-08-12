<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="projectService" bean="projectService"/>

<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectshowjs"/>
</head>
<body>
    <div class="feducontent">
        <div class="container">
       	    <h1>Validating Projects</h1>
            <div class="row">
                <div class="col-md-12">
                    <g:render template="validate/validategrid" model="['projects': projects]"></g:render>
                </div>
            </div>
        </div>
    </div>
</body>
</html>           
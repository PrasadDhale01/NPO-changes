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
            <div class="row">
                <div class="col-md-12">
                    <h1><img class="img-circle" src="/images/icon-validated.png" alt="Campaigns to be validated"/> Campaigns to be validated</h1><br>
                    <g:render template="validate/validategrid" model="['projects': projects]"></g:render>
                </div>
            </div>
        </div>   
    </div>
</body>
</html>

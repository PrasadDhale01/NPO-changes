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
                <div class="col-sm-12 text-center">
                    <g:if test="${flash.prj_validate_message}">
                        <div class="alert alert-success">
                            ${flash.prj_validate_message}
                        </div>
                    </g:if>
                </div>
                <div class="col-md-12">
                    <h1 class="text-center"><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-validated.png" alt="Campaigns to be validated"/> Campaigns to be validated</h1><br>
                    <g:render template="validate/validategrid" model="['projects': projects]"></g:render>
                </div>
            </div>
        </div>   
    </div>
</body>
</html>

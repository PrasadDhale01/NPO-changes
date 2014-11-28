<g:set var="userService" bean="userService"/>
<%
    def userCommunities = userService.getCommunitiesUserIn()
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="timelinecss"/>
    <r:require modules="userjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">

        <h2>My Projects</h2>
        <g:if test="${flash}">
            <div class="alert alert-success">
                <li>${flash.message}</li>
            </div>
        </g:if>
        <div class="row">
            <div class="col-md-12">
               <g:render template="user/myprojects"></g:render>
            </div>
        </div>
    </div>
</div>
</body>
</html>

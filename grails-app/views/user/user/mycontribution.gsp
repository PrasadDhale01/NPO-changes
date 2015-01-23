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

        <h2>My Contributions</h2>
        <g:if test="${flash.user_mycontri_message}">
            <div class="alert alert-success">
                <li>${flash.user_mycontri_message}</li>
            </div>
        </g:if>
        <div class="row">
            <div class="col-md-12">
               <g:render template="user/mycontributions"></g:render>
            </div>
        </div>
    </div>
</div>
</body>
</html>

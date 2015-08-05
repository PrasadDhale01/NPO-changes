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
<div class="feducontent text-center">
    <div class="container">
        <g:hiddenField name='currentEnv' value='${environment}' id='currentEnv'/>
        <h2>My Campaigns</h2>
        <g:if test="${flash.user_message}">
            <div class="alert alert-success" align="center">
                ${flash.user_message}
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

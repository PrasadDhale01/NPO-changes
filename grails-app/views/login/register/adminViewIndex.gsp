<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectcreatejs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">
        <h1>User Request</h1><br>
            <g:if test="${flash.login_message}">
                <div class="alert alert-success">
                    ${flash.login_message}
                </div>
            </g:if>
            <table class="table table-bordered">
            <thead>
                <tr class="info">
                    <th>NAME</th>
                    <th>EMAIL</th>
                    <th>INVITE</th>
                    <th>REJECT</th>                
                </tr>
            </thead>
            <tbody>
            </tbody>
                 <g:render template="register/adminViewGrid" model="['users': users]"></g:render>
            </table>
        </div>
    </div>    
</div>
</body>
</html>
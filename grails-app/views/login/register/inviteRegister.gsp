<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="bootstrapsocialcss, registrationjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <g:form class="form-signin" controller="login" action="createAccount" id="${users.id}" role="form">
            <h2 class="form-signin-heading">Please register</h2>
           
           <hr/>
            <div class="form-group">
                <input type="fn" name="firstName" class="form-control"  value="${users.firstName}">
            </div>
            <div class="form-group">
                <input type="ln" name="lastName" class="form-control"  value="${users.lastName}">
            </div>
            <div class="form-group">
                <input type="email" name="username" class="form-control"  value="${users.email}" disabled>
            </div>
            <div class="form-group">
                <input type="password" name="password" class="form-control" placeholder="Password">
            </div>
            <button class="btn btn-primary btn-block" type="submit">Register</button>
        </g:form>

    </div>
</div>
</body>
</html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="container">
    <g:form class="form-signin" controller="registration" action="reset_password" id="${code}" role="form">
        <h2 class="form-signin-heading">New Password</h2>

        <g:if test='${flash.message}'>
            <div class="alert alert-danger">${flash.message}</div>
        </g:if>

        <input type="password" name="new_password" class="form-control" placeholder="Password" required autofocus>
        <input type="password" name="new_password_2" class="form-control" placeholder="Re-enter Password" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Update</button>
    </g:form>
</div>
</body>
</html>

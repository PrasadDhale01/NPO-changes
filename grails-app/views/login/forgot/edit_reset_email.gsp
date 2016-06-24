<html>
<head>
    <title>Crowdera- Forgot password</title>
    <meta name="layout" content="main" />
    <r:require modules="loginjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container reset-password-bottom">
        <g:form class="form-signin" controller="login" action="send_reset_email" role="form">
            <h2 class="form-signin-heading">Reset Password</h2>

            <div class="form-group">
                <input type="reset_email" name="username" class="form-control all-place" placeholder="Email address">
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Reset Password</button>
        </g:form>
    </div>
</div>
</body>
</html>

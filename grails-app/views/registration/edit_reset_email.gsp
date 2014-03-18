<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="container">
    <g:form class="form-signin" controller="registration" action="send_reset_email" role="form">
        <h2 class="form-signin-heading">Reset Password</h2>

        <input type="reset_email" name="username" class="form-control" placeholder="Email address" required autofocus>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Reset Password</button>
    </g:form>
</div>
</body>
</html>

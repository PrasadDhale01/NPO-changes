<html>
<head>
    <meta name='layout' content='main'/>
</head>
<body>
<div class="container">

    <form class="form-signin" role="form" action="${postUrl}" method="POST" id="loginForm">
        <h2 class="form-signin-heading">Please sign in</h2>
        <g:if test='${flash.message}'>
            <div class="alert alert-danger">${flash.message}</div>
        </g:if>

        <input type="email" class="form-control" placeholder="Email address" name="j_username" id="username" required autofocus>
        <input type="password" class="form-control" placeholder="Password" name="j_password" id="password" required>
        <label class="checkbox">
            <input type="checkbox" value="remember-me" id="remember_me" name='${rememberMeParameter}' <g:if test='${hasCookie}'>checked='checked'</g:if> />
            Remember me
        </label>
        <button class="btn btn-lg btn-primary btn-block" type="submit" id="submit">Sign in</button>
        <g:link controller="registration" action="edit_reset">Forgot your password?</g:link>
    </form>

</div>

</body>
</html>

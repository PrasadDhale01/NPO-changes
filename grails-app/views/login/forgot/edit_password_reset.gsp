<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="registrationjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <g:form class="form-signin" controller="login" action="reset_password" id="${code}" role="form">
            <h2 class="form-signin-heading">Reset Password</h2>
            <div class="form-group">
                <input type="password" name="password" id="password" class="form-control" placeholder="Password" autofocus>
            </div>
            <div class="form-group">
                <input type="password" name="confirmPassword"  class="form-control" placeholder="Confirm Password">
            </div>
            <button class="btn btn-primary btn-block" type="submit">Update</button>
        </g:form>
    </div>
</div>
</body>
</html>

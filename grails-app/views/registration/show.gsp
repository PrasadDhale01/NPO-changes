<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="container">
    <g:form class="form-signin" controller="registration" action="update" role="form">
        <h2 class="form-signin-heading">User Profile</h2>
        <input type="fn" name="firstName" class="form-control" value="${user.firstName}" required autofocus>
        <input type="ln" name="lastName" class="form-control" value="${user.lastName}" required>
        <input type="password" name="password" class="form-control" placeholder="New Password" required>
        <button class="btn btn-lg btn-primary btn-block" type="submcit">Update</button>
    </g:form>
</div>
</body>
</html>
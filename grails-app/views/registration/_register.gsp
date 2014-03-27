<div class="container">

    <g:form class="form-signin" controller="registration" action="create" role="form">
        <h2 class="form-signin-heading">Please register</h2>
        <div class="form-group">
            <input type="fn" name="firstName" class="form-control" placeholder="First name" autofocus>
        </div>
        <div class="form-group">
            <input type="ln" name="lastName" class="form-control" placeholder="Last name">
        </div>
        <div class="form-group">
            <input type="email" name="username" class="form-control" placeholder="Email address">
        </div>
        <div class="form-group">
            <input type="password" name="password" class="form-control" placeholder="Password">
        </div>
        <button class="btn btn-primary btn-block" type="submit">Register</button>
    </g:form>

</div>

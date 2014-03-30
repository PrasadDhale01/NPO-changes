<g:set var="userService" bean="userService"/>
<g:if test="${userService.isFacebookUser()}">
    <div class="form-signin">
        <h2><i class="fa fa-facebook-square"></i> Facebook user</h2>
        <div class="alert alert-success">
            As a Facebook user, you cannot update your profile details on FEDU.
        </div>
    </div>
</g:if>
<g:else>
    <g:form class="form-signin" controller="login" action="update" role="form">
        <h2 class="form-signin-heading">Account Settings</h2>

        <g:if test='${flash.message}'>
            <div class="alert alert-success">${flash.message}</div>
        </g:if>

        <div class="form-group">
            <input type="fn" name="firstName" class="form-control" value="${user.firstName}" placeholder="New First name" autofocus>
        </div>
        <div class="form-group">
            <input type="ln" name="lastName" class="form-control" value="${user.lastName}" placeholder="New Last name">
        </div>
        <div class="form-group">
            <input type="password" name="password" class="form-control" placeholder="New Password (Optional)">
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Update</button>
    </g:form>
</g:else>

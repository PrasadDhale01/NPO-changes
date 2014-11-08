<g:set var="userService" bean="userService"/>
<%
    def imageUrl = user.userImageUrl
%>
<div class="col-md-4">
    <g:if test="${imageUrl != null}">
        <div style="height: 200px; width:200px; overflow: hidden;" class="blacknwhite">
            <img alt="Profile Image" style="width: 100%;" src="${imageUrl}">
        </div>
    </g:if>
    <g:else>
        <div style="height: 200px; width:200px; overflow: hidden;" class="blacknwhite">
            <img src="${resource(dir: 'images', file: 'profile_image.jpg')}" style="padding: 0; width: 100%;" alt="Upload Photo"/>
        </div>
        <g:uploadForm controller="user" action="upload_avatar" id="${user.id}" role="form">
            <input type="file" name="avatar" id="avatar">
            <input type="submit" class="buttons" value="Upload"/>
        </g:uploadForm>
    </g:else>
</div>

<div class="col-md-4">
    <g:if test="${userService.isFacebookUser()}">
        <div class="form-signin">
            <h2><i class="fa fa-facebook-square"></i> Facebook user</h2>
            <div class="alert alert-success">
                As a Facebook user, you cannot update your profile details on Crowdera.
            </div>
        </div>
    </g:if>
    <g:else>
        <g:form class="form-signin" controller="login" action="update" role="form">
            <div class="form-group">
                <input type="fn" name="firstName" required class="form-control" value="${user.firstName}" placeholder="New First name" autofocus>
            </div>
            <div class="form-group">
                <input type="ln" name="lastName" required class="form-control" value="${user.lastName}" placeholder="New Last name">
            </div>
            <div class="form-group">
                <input type="password" name="password" class="form-control" placeholder="New Password (Optional)">
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Update</button>
        </g:form>
    </g:else>
</div>

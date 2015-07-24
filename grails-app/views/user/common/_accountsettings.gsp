<g:set var="userService" bean="userService"/>
<%
    def imageUrl = user.userImageUrl
%>

<div class="col-sm-6">
	<div class="form-signin">
	    <g:if test="${imageUrl != null}">
	        <div class="profileavatar" class="blacknwhite">
	            <g:if test="${userService.isFacebookUser()}">
	                <img alt="Profile Image" class="profileimage" src="${imageUrl}"/>
	            </g:if>
	            <g:else>
	                <img alt="Profile Image" class="profileimage" src="${imageUrl}"/>
	            </g:else>
	            <div class="deleteavatar">
	               <g:link action="deleteavatar" controller="user" id="${user.id}"><img alt="Delete" onclick="return confirm(&#39;Are you sure you want to deleted this avatar?&#39;);" src="//s3.amazonaws.com/crowdera/assets/delete.ico"/></g:link>
	            </div>
	        </div>
		    <g:uploadForm controller="user" action="edit_avatar" id="${user.id}" role="form">
		        <button class="btn btn-primary btn-sm" type="button" id="editavatarbutton">Edit Avatar</button>
	            <input class="hidden" type="file" name="profile" id="editavatar" accept="image/*"/>
	            <input type="submit" class="hidden buttons" value="Upload" id="editbutton" accept="image/*"/>
	            <div class="clear"></div>
                <label class="docfile-orglogo-css" id="editProfileImg">Please select image file only.</label>
                <label class="docfile-orglogo-css" id="editProfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
	        </g:uploadForm>
	    </g:if>
	    <g:else>
	        <div class="uploadimage" class="blacknwhite">
	            <img src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" class="profileimage" alt="Upload Photo"/>
	        </div>
	        <g:uploadForm controller="user" action="upload_avatar" id="${user.id}" role="form">
	            <button class="btn btn-primary btn-sm" type="button" id="uploadavatar">Upload Avatar</button>
	            <input class="hidden" type="file" name="avatar" id="avatar" accept="image/*"/>
	            <input type="submit" class="hidden buttons" value="Upload" id="uploadbutton" accept="image/*"/>
	            <div class="clear"></div>
                <label class="docfile-orglogo-css" id="uploadProfileImg">Please select image file only.</label>
                <label class="docfile-orglogo-css" id="uploadProfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
	        </g:uploadForm> 
	    </g:else>
	</div>
</div>
<div class="col-sm-6">
    <g:if test="${userService.isFacebookUser()}">
        <div class="form-signin">
            <h2><i class="fa fa-facebook-square"></i> Facebook user</h2>
            <div class="form-group">
                <input type="text" name="firstName" class="form-control" value="${user.firstName}" readonly>
            </div>
            <div class="form-group">
                <input type="text" name="lastName" class="form-control" value="${user.lastName}" readonly>
            </div>
        </div>
    </g:if>
    <g:if test="${userService.isGooglePlusUser()}">
        <div class="form-signin">
            <h2><i class="fa fa-google-plus-square"></i> Google Plus User</h2>
            <div class="form-group">
                <input type="text" name="firstName" class="form-control" value="${user.firstName}" readonly>
            </div>
            <div class="form-group">
                <input type="text" name="lastName" class="form-control" value="${user.lastName}" readonly>
            </div>
        </div>
    </g:if>
    <g:else>
        <div id="validpass">
            <g:form class="form-signin" controller="login" action="update" role="form">
                <div class="form-group">
                    <input type="text" name="firstName" required class="form-control" value="${user.firstName}" placeholder="New First name" autofocus>
                </div>
                <div class="form-group">
                    <input type="text" name="lastName" required class="form-control" value="${user.lastName}" placeholder="New Last name">
                </div>
                <div class="form-group">
                    <input type="password" id="password" name="password" class="form-control" placeholder="New Password (Optional)">
                </div>
                <div class="form-group">
                    <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm Password">
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="submit">Update</button>
            </g:form>
        </div>
    </g:else>
</div>

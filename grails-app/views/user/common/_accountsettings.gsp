<g:set var="userService" bean="userService"/>
<%
    def imageUrl = user.userImageUrl
	def isAccountMerged = false
    if (user.email == user.username){
        isAccountMerged = true
    }
	
	def fbUser = userService.isFacebookUser()
	def googlePlusUser = userService.isGooglePlusUser()
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
		    <g:uploadForm controller="user" action="edit_avatar" id="${user.id}">
		        <button class="btn btn-primary btn-sm" type="button" id="editavatarbutton">Edit Avatar</button>
	            <input class="hid-input-type-file" type="file" name="profile" id="editavatar" accept="image/*"/>
	            <input type="submit" class="hidden buttons" value="Upload" id="editbutton"/>
	            <div class="clear"></div>
                <label class="docfile-orglogo-css image-margin-top" id="editProfileImg">Please select image file only.</label>
                <label class="docfile-orglogo-css image-margin-top" id="editProfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
	        </g:uploadForm>
	    </g:if>
	    <g:else>
	        <div class="uploadimage" class="blacknwhite">
	            <img src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" class="profileimage" alt="Upload Photo"/>
	        </div>
	        <g:uploadForm controller="user" action="upload_avatar" id="${user.id}">
	            <button class="btn btn-primary btn-sm" type="button" id="uploadavatar">Upload Avatar</button>
	            <input class="hid-input-type-file" type="file" name="avatar" id="avatar" accept="image/*"/>
	            <input type="submit" class="hidden buttons" value="Upload" id="uploadbutton"/>
                <label class="docfile-orglogo-css image-margin-top" id="uploadProfileImg">Please select image file only.</label>
                <label class="docfile-orglogo-css image-margin-top" id="uploadProfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
	        </g:uploadForm> 
	    </g:else>
	</div>
</div>
<div class="col-sm-6">
    <g:if test="${fbUser && !isAccountMerged}">
        <div class="form-signin">
            <h2><i class="fa fa-facebook-square"></i> Facebook user</h2>
            <div class="form-group">
                <input type="text" name="firstName" class="form-control all-place" value="${user.firstName}" readonly>
            </div>
            <div class="form-group">
                <input type="text" name="lastName" class="form-control all-place" value="${user.lastName}" readonly>
            </div>
        </div>
    </g:if>
    <g:elseif test="${googlePlusUser && !isAccountMerged}">
        <div class="form-signin">
            <h2><i class="fa fa-google-plus-square"></i> Google Plus User</h2>
            <div class="form-group">
                <input type="text" name="firstName" class="form-control all-place" value="${user.firstName}" readonly>
            </div>
            <div class="form-group">
                <input type="text" name="lastName" class="form-control all-place" value="${user.lastName}" readonly>
            </div>
        </div>
    </g:elseif>
    <g:else>
        <div id="validpass">
            <g:form class="form-signin" controller="login" action="update">
                <div class="form-group">
                    <input type="text" name="firstName" required class="form-control all-place" value="${user.firstName}" placeholder="New First name" autofocus>
                </div>
                <div class="form-group">
                    <input type="text" name="lastName" required class="form-control all-place" value="${user.lastName}" placeholder="New Last name">
                </div>
                <div class="form-group">
                    <input type="password" id="password" name="password" class="form-control all-place" placeholder="New Password (Optional)">
                </div>
                <div class="form-group">
                    <input type="password" name="confirmPassword" class="form-control all-place" placeholder="Confirm Password">
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="submit">Update</button>
            </g:form>
        </div>
    </g:else>
</div>

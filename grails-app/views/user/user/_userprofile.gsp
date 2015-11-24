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

<div class="col-sm-12 dashboarduserprofile">
    <g:if test="${fbUser && !isAccountMerged}">
        <div class="form-signin">
            <h2><i class="fa fa-facebook-square"></i> Facebook user</h2>
        </div>
    </g:if>
    <g:elseif test="${googlePlusUser && !isAccountMerged}">
        <div class="form-signin">
            <h2><i class="fa fa-google-plus-square"></i> Google Plus User</h2>
        </div>
    </g:elseif>
</div>
<div class="dashboarduserprofile">
    <g:if test="${userprofile}">
        <div class="my-campaign-heading text-center hidden-xs"><h1><img src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="' '"> <b>Edit User</b></h1></div>
        <div class="my-campaign-heading text-center visible-xs"><h3><img src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="' '"> <b>Edit User</b></h3></div>
    </g:if>
    <g:form controller="user" action="update">
        <div class="col-sm-6 col-md-6 col-xs-12">
            <g:if test="${fbUser && !isAccountMerged}">
                <div class="form-group">
                    <input type="text" name="firstName" class="form-control all-place" value="${user.firstName}" readonly>
                </div>
                <div class="form-group">
                    <input type="text" name="lastName" class="form-control all-place" value="${user.lastName}" readonly>
                </div>
            </g:if>
            <g:elseif test="${googlePlusUser && !isAccountMerged}">
                <div class="form-group">
                    <input type="text" name="firstName" class="form-control all-place" value="${user.firstName}" readonly>
                </div>
                <div class="form-group">
                    <input type="text" name="lastName" class="form-control all-place" value="${user.lastName}" readonly>
                </div>
            </g:elseif>
            <g:else>
                <div class="form-group">
                    <input type="text" name="firstName" required class="form-control all-place" value="${user.firstName}" placeholder="New First name" autofocus>
                </div>
                <div class="form-group">
                    <input type="text" name="lastName" required class="form-control all-place" value="${user.lastName}" placeholder="New Last name">
                </div>
            </g:else>
            <div class="form-group">
                <input type="password" id="password" name="password" class="form-control all-place" placeholder="New Password (Optional)">
            </div>
            <div class="form-group">
                <input type="password" name="confirmPassword" class="form-control all-place" placeholder="Confirm Password">
            </div>
        </div>
        <div class="col-sm-6 col-md-6 col-xs-12 userseditlocation">
            <div class="form-group">
                <textarea name="biography" class="form-control all-place" rows="2" placeholder="Bio" autofocus>${user.biography}</textarea>
            </div>
            <div class="form-group">
                <div class="input-group col-md-12">
                    <g:if test="${user.country}">
                        <g:select class="selectpicker" name="country" from="${country}" value="${user.country}" optionKey="key" optionValue="value"/>
                    </g:if>
                    <g:else>
                        <g:select class="selectpicker" id="country" name="country" from="${country}" optionKey="key" optionValue="value" noSelection="['null':'Country']"/>
                    </g:else>
                </div>
            </div>
            <div class="form-group">
                <div class="input-group col-md-12">
                    <g:if test="${user.state}">
                        <g:select class="selectpicker" name="state" id="state" from="${state}" value="${user.state}" optionKey="key" optionValue="value"/>
                    </g:if>
                    <g:else>
                        <g:select class="selectpicker" id="state" name="state" from="${state}" optionKey="key" optionValue="value" noSelection="['null':'City']"/>
                    </g:else>
                </div>
            </div>
            <div class="form-group" id="ostate">
                <div class="input-group col-md-12">
                    <input class="form-control" type="text" placeholder="Other State" name="otherstate" id="dashboard_otherstate">
                </div>
            </div>
            <div class="form-group">
                <input type="text" name="city" required class="form-control all-place" value="${user.city}" placeholder="City" autofocus>
            </div>
        </div>
        <div class="clear"></div>
        <div class="col-md-12 userInfoUpdateBtn">
            <button class="btn btn-primary btn-md pull-right" type="submit" id="userInfoUpdateBtn">Update</button>
        </div>
    </g:form>
</div>

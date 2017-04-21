<g:set var="userService" bean="userService" />
<g:if test="${users.enabled == true}">
    <tr>
	    <td>${index}</td>
        <td class="col-sm-2">${users.email}</td>
        <td class="col-sm-2">${users.firstName}</td>
        <td class="col-sm-2">${users.lastName}</td>
        <td class="col-sm-2">${userService.getUserRole(users)}</td>
        <td class="col-sm-2">${users.dateCreated}</td>
        <td class="col-sm-2">${users.lastUpdated}</td>
        <td class="text-center ul-ad-thrash-center">
            <g:form controller="user" action="deleteVerifiedUsers" method="post"  id="${users.id}">
                <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to delete this user?&#39;);">
                    <i class="glyphicon glyphicon-trash" ></i>
                </button>
            </g:form>
        </td>
    </tr>
</g:if>
<g:else>
    <tr class="nonverifiedUserList">
	    <td>${index}</td>
        <td class="col-sm-2">${users.email}</td>
        <td class="col-sm-2">${users.firstName}</td>
        <td class="col-sm-2">${users.lastName}</td>
        <td class="col-sm-2">${userService.getUserRole(users)}</td>
        <td class="col-sm-2">${users.dateCreated}</td>
        <td class="col-sm-2 text-center">
        <g:link action="resendConfirmMailByAdmin" id="${users.id}" role="button">
            <div class="sendMail btn btn-sm sendMailbtn" ><span class="glyphicon glyphicon-envelope"></span> Send Mail</div>
        </g:link>
        </td>
        <td class="text-center">
            <g:form controller="user" action="deleteUser" method="post"  id="${users.id}">
                <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to delete this user?&#39;);">
                    <i class="glyphicon glyphicon-trash" ></i>
                </button>
            </g:form>
        </td>
    </tr>
</g:else>

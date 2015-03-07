<g:set var="userService" bean="userService" />
<html>
<body>
    <g:if test="${users.enabled == true}">
        <tr>
    	    <td>${index}</td>
            <td>${users.email}</td>
            <td>${users.firstName}</td>
            <td>${users.lastName}</td>
            <td>${userService.getUserRole(users)}</td>
            <td>${users.dateCreated}</td>
            <td>${users.lastUpdated}</td>
        </tr>
    </g:if>
    <g:else>
        <tr>
    	    <td>${index}</td>
            <td>${users.email}</td>
            <td>${users.firstName}</td>
            <td>${users.lastName}</td>
            <td>${userService.getUserRole(users)}</td>
            <td>${users.dateCreated}</td>
            <td class="text-center">
            <g:link action="resendConfirmMailByAdmin" id="${users.id}" role="button">
               <button class="sendMail" ><span class="glyphicon glyphicon-envelope"></span> Send Mail</button>
            </g:link>
            </td>
        </tr>
    </g:else>
    
    
</body>
</html>

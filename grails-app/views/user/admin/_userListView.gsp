<g:set var="userService" bean="userService" />
<html>
<body>
    <g:if test="${users.enabled == true}">
        <tr>
    	    <td>${index}</td>
            <td class="col-sm-2">${users.email}</td>
            <td class="col-sm-2">${users.firstName}</td>
            <td class="col-sm-2">${users.lastName}</td>
            <td class="col-sm-2">${userService.getUserRole(users)}</td>
            <td class="col-sm-2">${users.dateCreated}</td>
            <td class="col-sm-2">${users.lastUpdated}</td>
        </tr>
    </g:if>
    <g:else>
        <tr>
    	    <td>${index}</td>
            <td class="col-sm-2">${users.email}</td>
            <td class="col-sm-2">${users.firstName}</td>
            <td class="col-sm-2">${users.lastName}</td>
            <td class="col-sm-2">${userService.getUserRole(users)}</td>
            <td class="col-sm-2">${users.dateCreated}</td>
            <td class="col-sm-2 text-center">
            <g:link action="resendConfirmMailByAdmin" id="${users.id}" role="button">
               <button class="sendMail" ><span class="glyphicon glyphicon-envelope"></span> Send Mail</button>
            </g:link>
            </td>
        </tr>
    </g:else>
    
    
</body>
</html>

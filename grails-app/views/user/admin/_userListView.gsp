<g:set var="userService" bean="userService" />
<html>
<body>
    <g:if test="${users.enabled == true}">
        <tr>
    	    <td>${users.id}</td>
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
    	    <td>${users.id}</td>
            <td>${users.email}</td>
            <td>${users.firstName}</td>
            <td>${users.lastName}</td>
            <td>${userService.getUserRole(users)}</td>
            <td>${users.dateCreated}</td>
            <td><center>
            <g:link action="resendConfirmMailByAdmin" id="${users.id}" role="button">
               <button class="sendMail" ><span class="glyphicon glyphicon-envelope"></span> Send Mail</button>
            </g:link>
            </center></td>
        </tr>
    </g:else>
    
    
</body>
</html>

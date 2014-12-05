<g:set var="userService" bean="userService" />
<html>
<body>
    <tr>
    	<td>${users.id}</td>
        <td>${users.email}</td>
        <td>${users.firstName}</td>
        <td>${users.lastName}</td>
        <td>${userService.getUserRole(users)}</td>
        <td>${users.dateCreated}</td>
        <td>${users.lastUpdated}</td>
    </tr>
</body>
</html>

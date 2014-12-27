<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<html>
<body>
	<g:set var="user" value="transaction.user"/>
    <tr>
    	<td>${transaction.id}</td>
    	<td>${transaction.transactionId}</td>
        <td>${transaction.project.title}</td>
        <g:if test="${transaction.user.firstName == "anonymousFirstName"}">
        	<td>By Anonymous</td>
        </g:if>
        <g:else>
        	<td>${transaction.user.firstName} ${transaction.user.lastName}</td>
        </g:else>
        <td>${transaction.project.amount}</td>
        <td>${projectService.getContributedAmount(transaction)}</td>
    </tr>
</body>
</html>

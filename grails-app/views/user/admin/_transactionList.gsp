<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<html>
<body>
	<g:set var="user" value="transaction.user"/>
    <tr>
    	<td>${transaction.id}</td>
    	<td>${transaction.transactionId}</td>
    	<td>${transaction.contribution.date}</td>
        <td>${transaction.project.title}</td>
        <td>${transaction.contribution.contributorName}</td>
        <td>${transaction.project.amount}</td>
        <td>${projectService.getContributedAmount(transaction)}</td>
    </tr>
</body>
</html>

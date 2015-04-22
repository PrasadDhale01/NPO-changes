<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<%@ page import="java.text.SimpleDateFormat" %>
<%  
    SimpleDateFormat dateFormat = new SimpleDateFormat("d MMM, YYYY");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss");
    def date = dateFormat.format(transaction.contribution.date); 
    def time = timeFormat.format(transaction.contribution.date);
 %>
<html>
<body>
	<g:set var="user" value="transaction.user"/>
    <tr>
    	<td class="text-center">${transaction.id}</td>
    	<td class="text-center">${transaction.transactionId}</td>
    	<td class="text-center">${date}</td>
    	<td class="text-center">${time}</td>
        <td class="text-center">${transaction.project.title}</td>
        <td class="text-center">${transaction.contribution.contributorName}</td>
        <td class="text-center">
            <g:if test="${transaction.contribution.isAnonymous}">
                Anonymous
            </g:if>
            <g:else>
                Non Anonymous
            </g:else>
        </td>
        <td class="text-center">${transaction.project.amount}</td>
        <td class="text-center">${projectService.getContributedAmount(transaction)}</td>
    </tr>
</body>
</html>

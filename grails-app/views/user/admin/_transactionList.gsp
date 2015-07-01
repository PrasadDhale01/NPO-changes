<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<%@ page import="java.text.SimpleDateFormat" %>
<%  
    SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY:MM:dd");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss");
    def date = dateFormat.format(transaction.contribution.date);
    def time = timeFormat.format(transaction.contribution.date);
 %>
<html>
<body>
	<g:set var="user" value="transaction.user"/>
    <tr>
    	<td class="text-center col-sm-1">${transaction.id}</td>
    	<td class="col-sm-2">${transaction.transactionId}</td>
    	<td class="text-center col-sm-2">${date}</td>
    	<td class="text-center col-sm-2">${time}</td>
        <td class="col-sm-1">${transaction.project.title}</td>
        <td class="col-sm-2">${transaction.contribution.contributorName}</td>
        <td class="text-center">
            <g:if test="${transaction.contribution.isAnonymous}">
                Anonymous
            </g:if>
            <g:else>
                Non Anonymous
            </g:else>
         </td>
         <td class="text-center">${transaction.project.amount}</td>
         <td class="col-sm-2">${projectService.getContributedAmount(transaction)}</td>
    </tr>
</body>
</html>

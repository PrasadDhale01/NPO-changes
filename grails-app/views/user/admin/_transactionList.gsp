<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<%@ page import="java.text.SimpleDateFormat" %>
<%  
    SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY:MM:dd hh:mm:ss");
    def date = dateFormat.format(transaction.contribution.date);
 %>
<g:set var="user" value="transaction.user"/>
<tr>
    <td class="text-center col-sm-1">${index}</td>
    <td class="text-center col-sm-2">${transaction.transactionId}</td>
    <td class="text-center col-sm-2">${date}</td>
    <td class="text-center col-sm-2">${transaction.project.title}</td>
    <td class="text-center col-sm-2">${transaction.contribution.contributorName}</td>
    <td class="text-center">
        <g:if test="${transaction.contribution.isAnonymous}">Anonymous</g:if>
        <g:else>Non Anonymous</g:else>
    </td>
    <td class="text-center col-sm-1">${transaction.project.amount}</td>
    <td class="text-center col-sm-2">${projectService.getContributedAmount(transaction)}</td>
</tr>

<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<%@ page import="java.text.SimpleDateFormat" %>
<%  
    SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY:MM:dd hh:mm:ss");
    def date = dateFormat.format(contribution.date);
 %>
<g:set var="user" value="transaction.user"/>
<tr>
    <td class="text-center col-sm-1">${index}</td>
    <td class="text-center col-sm-2">${date}</td>
    <td class="text-center col-sm-3">${contribution.project.title}</td>
    <td class="text-center col-sm-2">${contribution.contributorName}</td>
    <td class="text-center">
        <g:if test="${contribution.isAnonymous}">Anonymous</g:if>
        <g:else>Non Anonymous</g:else>
    </td>
    <td class="text-center col-sm-2">${contribution.amount.round()}</td>
    <td class="text-center col-sm-2">${contribution.contributorEmail}</td>
    <td class="text-center">
        <g:if test="${contribution.isContributionOffline}">Offline</g:if>
        <g:else>Online</g:else>
    </td>
</tr>

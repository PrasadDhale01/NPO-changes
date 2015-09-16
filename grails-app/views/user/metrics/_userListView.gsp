<g:set var="userService" bean="userService" />
<%
    def userContribution = userService.getAvgMinMaxContributionForUser(user)
%>
<tr>
    <td>${index}</td>
    <td class="col-sm-2 text-center">${user.email}</td>
    <td class="col-sm-2 text-center">${userService.getNumberOfCampaignsForUser(user)}</td>
    <td class="col-sm-2 text-center">${userService.getNumberOfCampaignsContributedTo(user)}</td>
    <td class="col-sm-2 text-center">${userService.getCategorySupportedTo(user)}</td>
    <td class="col-sm-2 text-center">${userContribution.avgAmount}</td>
    <td class="col-sm-2 text-center">${userContribution.minAmount}</td>
    <td class="col-sm-2 text-center">${userContribution.maxAmount}</td>
</tr>

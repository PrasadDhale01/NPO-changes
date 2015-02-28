<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService" />
<%
    def projectAmount = project.amount
	def teamAmount = team.amount
	def achievedAmount = contributionService.getTotalContributionForUser(team.contributions)
	def amountLeft = teamAmount-achievedAmount
	def joiningDate = team.joiningDate
	def endDate = projectService.getProjectEndDate(project)
	SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d yyyy");
 %>
<tr>
	<td>${team.id}</td>
	<td>${team.user.firstName} ${team.user.lastName}</td>
	<td>${dateFormat.format(joiningDate.getTime())}</td>
	<td>${dateFormat.format(endDate.getTime())}</td>
	<td>$${teamAmount}</td>
	<td>$${achievedAmount}</td>
	<td>$${amountLeft}</td>
	<td class="teamStatusButton" id="teamStatusButton">
        <input type="checkbox" name="link" id="${team.id}" value="${team.id}" 
            <% if(!team.enable) { %> checked="checked" <% } %> <% if(team.user == project.user) { %> disabled="true" <% } %>><span id="check${team.id}"> Disable</span>
        </input>
    </td>
</tr>

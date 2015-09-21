<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService" />
<%
    def projectAmount = project.amount.round()
	def teamAmount = team.amount.round()
	def achievedAmount = contributionService.getTotalContributionForUser(team.contributions)
	def amountLeft = teamAmount-achievedAmount
	def joiningDate = team.joiningDate
	SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d yyyy");
 %>
<tr>
	<td>${index}</td>
	<td>${team.user.firstName} ${team.user.lastName}</td>
	<td>${dateFormat.format(joiningDate.getTime())}</td>
	<td>${dateFormat.format(endDate.getTime())}</td>
	<td><g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${teamAmount}</td>
	<td><g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${achievedAmount}</td>
	<td>
	    <g:if test="${amountLeft > 0}">
	    <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${amountLeft}
	    </g:if>
	    <g:else>Achieved
	    </g:else></td>
	<td class="teamStatusButton" id="teamStatusButton">
	    <input type="checkbox" name="link" id="${team.id}" value="${team.id}" 
	        <% if(!team.enable) { %> checked="checked" <% } %> <% if(team.user == project.user) { %> disabled="true" <% } %>><span id="checkteam${team.id}"> Disable</span>
	    </input>
	</td>
</tr>

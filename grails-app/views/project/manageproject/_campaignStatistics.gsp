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
    def conversionMultiplier = multiplier
    if (!conversionMultiplier) {
        conversionMultiplier = projectService.getCurrencyConverter();
    }
%>
<tr>
    <td>${index}</td>
    <td>${team.user.firstName} ${team.user.lastName}</td>
    <td>${dateFormat.format(joiningDate.getTime())}</td>
    <td>${dateFormat.format(endDate.getTime())}</td>
    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
        <td><span class="fa fa-inr"></span><g:if test="${project.payuStatus}">${teamAmount}</g:if><g:else>${teamAmount * conversionMultiplier}</g:else></td>
        <td><span class="fa fa-inr"></span><g:if test="${project.payuStatus}">${achievedAmount}</g:if><g:else>${achievedAmount * conversionMultiplier}</g:else></td>
        <td>
            <g:if test="${amountLeft > 0}">
                <span class="fa fa-inr"></span><g:if test="${project.payuStatus}">${amountLeft}</g:if><g:else>${amountLeft * conversionMultiplier}</g:else>
            </g:if>
            <g:else>Achieved</g:else>
        </td>
    </g:if>
    <g:else>
        <td>$${teamAmount}</td>
        <td>$${achievedAmount}</td>
        <td>
            <g:if test="${amountLeft > 0}">
                $${amountLeft}
            </g:if>
            <g:else>Achieved</g:else>
        </td>
    </g:else>
    <td class="teamStatusButton">
        <input type="checkbox" name="link" id="${team.id}" value="${team.id}" 
        <% if(!team.enable) { %> checked="checked" <% } %> <% if(team.user == project.user) { %> disabled="true" <% } %>><span id="checkteam${team.id}"> Disable</span>
    </td>
</tr>

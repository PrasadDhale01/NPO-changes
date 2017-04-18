<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService" />
<%
    def projectAmount = project.amount.round()
    def teamAmount = team.amount.round()
    def achievedAmount = contributionService.getTotalContributionForUser(project?.country?.countryCode, team.contributions, project?.country?.currency?.dollar)
    def amountLeft = teamAmount-achievedAmount
    def joiningDate = team.joiningDate
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d yyyy");
%>
<tr>
    <td>${index}</td>
    <td>${team.user.firstName} ${team.user.lastName}</td>
    <td>${dateFormat.format(joiningDate.getTime())}</td>
    <td>${dateFormat.format(endDate.getTime())}</td>
    <td>
        <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span>${teamAmount}</g:if><g:else>$${teamAmount}</g:else>
    </td>
    <td>
        <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span>${achievedAmount}</g:if><g:else>$${achievedAmount}</g:else>
    <td>
        <g:if test="${amountLeft > 0}">
            <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span>${amountLeft}</g:if><g:else>$${amountLeft}</g:else>
        </g:if>
        <g:else>Achieved</g:else>
    </td>
    <td class="teamStatusButton">
        <input type="checkbox" class="disableTeam" name="link" id="${team.id}" value="${team.id}" 
        <% if(!team.enable) { %> checked="checked" <% } %> <% if(team.user == project.user) { %> disabled <% } %>><span id="checkteam${team.id}"> Disable</span>
    </td>
</tr>

<script type="text/javascript">
	$('.disableTeam').change(function(){
	    if($(this).prop('checked') == true)
	    {
	        var confirmMsg = window.confirm("Are you sure, you want to disable current team ?");
	        if(confirmMsg == true)
	        {
	            $(this).prop('checked', true);
	            alert("Team disabled successfully...!");
	        }
	        else
	        {
	            $(this).prop('checked', false);
	        }
	    }
	    else if($(this).prop('checked') == false)
	    {
	        var confirmMsg = window.confirm("Are you sure, you want to enable current team ?");
	        if(confirmMsg == true)
	        {
	            $(this).prop('checked', false);
	            alert("Team enabled successfully...!");
	        }
	        else
	        {
	            $(this).prop('checked', true);
	        }
	    }
	});
</script>

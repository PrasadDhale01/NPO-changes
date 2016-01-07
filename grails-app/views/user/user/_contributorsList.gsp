<%@ page import="java.text.SimpleDateFormat" %>
<%  
    SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY:MM:dd hh:mm:ss");
    def date = dateFormat.format(contribution.date);
 %>
<tr>
	<td class="text-center">${index}</td>
	<td class="text-center">
	    <g:if test="${contribution.contributorEmail}">
            <input type="checkbox" name="select" class="contributor-checkbox-select" id="${contribution.id}">
	    </g:if>
	    <g:else>
            <input type="checkbox" name="select" id="${contribution.id}" disabled>
	    </g:else>
	</td>
	<td class="text-center col-sm-3">${contribution.contributorName}</td>
	<td class="text-center col-sm-3">${contribution.contributorEmail}</td>
	<td class="text-center">
		<g:if test="${environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia'}">Rs. </g:if>
		<g:else>$</g:else>${contribution.amount.round()}
    </td>
	<td class="text-center">${date}</td>
</tr>

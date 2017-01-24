<%@ page import="java.text.SimpleDateFormat" %>
<%  
    SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY:MM:dd");
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
		<g:if test="${'in'.equalsIgnoreCase(contribution.project?.country?.countryCode)}">
			<g:if test="${'usd'.equalsIgnoreCase(contribution.currency)}">
				$ 
			</g:if>
			<g:else>
				Rs.
			</g:else>
		</g:if>
		<g:else>
			$
		</g:else>
		${contribution.amount.round()}
    </td>
	<td class="text-center">${date}</td>
	<td class="text-center">
	    <g:if test="${contribution.receiptSent}">
	        <button class="btn btn-primary btn-xs" onclick="sendOrResendEmailToContributor(${contribution.id})" id = "sendEmailBtn${contribution.id}">Resend</button>
	    </g:if>
	    <g:else>
	    	<button class="btn btn-primary btn-xs" onclick="sendOrResendEmailToContributor(${contribution.id})" id="sendEmailBtn${contribution.id}">Send Now</button>
	    </g:else>
	</td>
</tr>

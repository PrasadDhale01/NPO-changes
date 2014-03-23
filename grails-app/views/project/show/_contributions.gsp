<!-- Contributions -->
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<g:if test="${!project.contributions.empty}">
    <dl class="dl">
        <g:each in="${project.contributions}" var="contribution">
            <dt>$${contribution.reward.price}</dt>
            <dd>By ${contribution.user.username}, on ${dateFormat.format(contribution.date)}</dd>
            <hr>
        </g:each>
    </dl>
</g:if>
<g:else>
    <div class="alert alert-warning">No contributions yet. Yours can be the first one.</div>
</g:else>

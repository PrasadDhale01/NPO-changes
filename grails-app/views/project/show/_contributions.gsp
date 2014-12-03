<!-- Contributions -->
<g:set var="userService" bean="userService"/>
<g:set var="facebookService" bean="facebookService"/>
<g:set var="projectService" bean="projectService" />
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<g:if test="${!project.contributions.empty}">
    <dl class="dl">
        <g:each in="${project.contributions}" var="contribution">
            <%
                def date = dateFormat.format(contribution.date)
                def friendlyName = userService.getFriendlyName(contribution.user)
                def isFacebookUser = userService.isFacebookUser(contribution.user)
                def userFacebookUrl = facebookService.getUserFacebookUrl(contribution.user)
                def amount = projectService.getDataType(contribution.amount)
            %>
            <dt>$${amount}</dt>
            <g:if test="${isFacebookUser}">
                <dd>By <a href="${userFacebookUrl}">${friendlyName}</a>, on ${date}</dd>
            </g:if>
            <g:else>
                <dd>By ${friendlyName}, on ${date}</dd>
            </g:else>
            <hr>
        </g:each>
    </dl>
</g:if>
<g:else>
    <div class="alert alert-info">No contributions yet. Yours can be the first one.</div>
</g:else>

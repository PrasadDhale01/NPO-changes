<!-- Contributions -->
<g:set var="userService" bean="userService"/>
<g:set var="facebookService" bean="facebookService"/>
<g:set var="projectService" bean="projectService" />
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    List list = []
    if(project.user == team.user) {
        list = project.contributions
    }else {
        list = team.contributions
    }
%>
<g:if test="${!list.empty}">
    <dl class="dl">
        <g:each in="${list}" var="contribution">
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

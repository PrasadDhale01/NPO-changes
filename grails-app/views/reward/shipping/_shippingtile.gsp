<g:set var="user" value="${contribution.user}"/>
<g:set var="reward" value="${contribution.reward}"/>
<g:set var="shippingDone" value="${contribution.shippingDone}"/>

<g:if test="${shippingDone == false}">
    <g:if test="${contribution}">
        <tr>
            <td>${contribution.id}</td>
            <td>${user.firstName}&nbsp;${user.lastName}</td>
            <td>${user.email}</td>
            <td></td>
            <td>${reward.description}</td>
            <td>
                <form action="update" method="post">
                    <g:hiddenField name="contributionId" value="${contribution.id}"/>
                    <g:hiddenField name="shippingdone" value="${shippingDone}"/>
                    <g:link controller="reward" action="update">
                        <button class="btn btn-block btn-primary">Pending &nbsp;<i class=" fa fa-exclamation-circle"></i></button>
                    </g:link>
                </form>
            </td>
        </tr>
    </g:if>
</g:if>
<g:else>
    <g:if test="${contribution}">
        <tr>
            <td>${contribution.id}</td>
            <td>${user.firstName}&nbsp;${user.lastName}</td>
            <td> ${user.email}</td>
            <td> </td>
            <td>${reward.description}</td>
            <td>Done</td>
        </tr>
    </g:if>
</g:else>

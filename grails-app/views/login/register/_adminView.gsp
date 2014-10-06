<g:set var="enabled" value="${users.enabled}"/>
<g:set var="confirmed" value="${users.confirmed}"/>
<html>
<body>
<%if (enabled == false && confirmed == false){ %>
    <tr class="active">
        <td>${users.firstName}&nbsp;${users.lastName}</td>
        <td>${users.email}</td>
        <td><g:link class="btn btn-primary" action="request_accept" controller="login" id="${users.id}"><i class="fa fa-plus-square"></i>&nbsp;&nbsp;Invite&nbsp;&nbsp;</g:link></td>
		<td>
		    <g:form action="delete" controller="login" id="${users.id}" method="post" >
		        <button class="btn btn-danger" name="_action_delete" value="Delete" onclick="return confirm(&#39;Are you sure you want to Delete this request?&#39;);" style="width:180"><i class="fa fa-trash-o"></i> Discard
	            </button>
            </g:form>
		</td>
    </tr>
<% } %>
</body>
</html>

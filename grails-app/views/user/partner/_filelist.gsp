<%
    def trashUrl = baseUrl+'/user/trashdrivefile?id='+file.id+'&userId='+user.id
%>
<tr>
    <td class="col-sm-1">${index}</td>
    <td class="col-sm-8"><g:if test="${file.title}">${file.title}</g:if><g:else>Untitled</g:else></td>
    <td class="col-sm-2"><a href="${file.alternateLink}" target="_blank">Explore</a></td>
    <td class="col-sm-1 text-center drivetrash"><a href="${trashUrl}"><i class="glyphicon glyphicon-trash" ></i></a></td>
</tr>

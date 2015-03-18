<%@ page import="java.text.SimpleDateFormat" %>
<%
    def joiningDate = team.joiningDate
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d yyyy");
%>
<tr>
    <td class="text-center">${index}</td>
    <td class="text-center">${team.user.firstName}</td>
    <td class="text-center">${team.user.lastName}</td>
    <td class="text-center">${team.user.email}</td>
    <td class="text-center">${dateFormat.format(joiningDate.getTime())}</td>
    <td class="text-center">
        <g:form action="validateteam" controller="project" id="${project.id}" method="post">
            <g:hiddenField name="teamId" value="${team.id}"/>
            <button type="submit" class="btn btn-sm btn-primary">Validate</button>
        </g:form>
   </td>
   <td class="text-center">
       <g:form action="discardteam" controller="project" id="${project.id}" method="post">
           <g:hiddenField name="teamId" value="${team.id}"/>
           <g:link controller="reward" action="update">
               <button type="submit" class="btn btn-sm btn-danger">Discard</button>
           </g:link>
       </g:form>
    </td>
</tr>

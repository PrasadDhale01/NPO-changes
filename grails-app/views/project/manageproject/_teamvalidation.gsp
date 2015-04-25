<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="userService" bean="userService" />
<%
    def joiningDate = team.joiningDate
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d yyyy");
	def user = userService.getCurrentUser()
%>
<tr>
    <td class="text-center">${index}</td>
    <td class="text-center">${team.user.firstName}</td>
    <td class="text-center">${team.user.lastName}</td>
    <td class="text-center">${team.user.email}</td>
    <td class="text-center">${dateFormat.format(joiningDate.getTime())}</td>
    <td class="text-center">
        <g:form action="validateteam" controller="project" method="post" params="['fundraiser': user.firstName,'projectTitle':project.title.replaceAll(' ', '-')]" fragment='manageTeam'>
            <g:hiddenField name="teamId" value="${team.id}"/>
            <g:hiddenField name="id" value="${project.id}"/>
            <g:hiddenField name="fr" value="${user.username}"/>
            <button type="submit" class="btn btn-sm btn-primary">Validate</button>
        </g:form>
   </td>
   <td class="text-center">
       <g:form action="discardteam" controller="project" id="${project.id}" method="post">
           <g:hiddenField name="teamId" value="${team.id}"/>
           <g:link controller="reward" action="update">
               <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm(&#39;Are you sure you want to discard this team?&#39;);">Discard</button>
           </g:link>
       </g:form>
    </td>
</tr>

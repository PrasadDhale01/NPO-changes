<g:set var="userService" bean="userService" />
<g:set var="projectService" bean="projectService" />
<%
	def project = projectService.getValidatedProjects()
 %>
 <g:each var="prj"  in="${project}"> 
<tr>
    <td class="col-sm-2 text-center">${ prj.user.firstName} ${prj.user.lastName}</td>
    <td class="col-sm-2 text-center">${prj.title}</td>
    <td class="col-sm-2 text-center"><a href="/project/getFeedBackCSV?projectId=${prj.id}" class="btn btn-default btn-sm btn-primary" >Download CSV</a></td>
</tr>
</g:each>

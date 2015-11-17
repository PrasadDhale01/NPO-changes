<g:set var="userService" bean="userService" />
<g:set var="projectService" bean="projectService" />
<%
	def project = projectService.getValidatedProjects()
 %>
 <g:each var="prj"  in="${project}"> 
 <%
 	def user = userService.getUserById(prj.user.id)
	def feedback=userService.getFeedbackByUser(user)
  %> 
  <g:if test="${feedback}">
	<tr>
	    <td class="col-sm-2 text-center">${ prj.user.firstName} ${prj.user.lastName}</td>
	    <td class="col-sm-2 text-center">${prj.title}</td>
	    <td class="col-sm-2 text-center"><a href="/project/getFeedBackCSV?projectId=${prj.id}" class="btn btn-default btn-sm btn-primary" >Export CSV</a>
    		&nbsp;<a href="/user/previewUserFeedBack?projectId=${prj.id}" class="btn btn-default btn-sm btn-primary" >Preview</a>
    	</td>
	</tr>
 </g:if>
</g:each>

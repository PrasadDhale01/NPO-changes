<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<g:set var="loggedInUser" value="${userService.getCurrentUser()}" scope="session" />
<%
    String currentEnvironment = projectService.getCurrentEnvironment();
	def loggedInUser = userService.getCurrentUser() ;
	
%>
<g:if test="${currentEnvironment == "production" && loggedInUser!=null}">
<g:set var="loggedInUser" value="${userService.getCurrentUser()}" scope="session" />
<script>
			window.mySettings = {
			// TODO: The current logged in user's email address.
			email: "${loggedInUser.email}",
			first_name: "${loggedInUser.firstName}",
			last_name:"${loggedInUser.lastName}",
			// TODO: The current logged in user's sign-up date in Unix epoch time.
			created_at: 1356978600,
			app_id: '0d5f42147e9211929adc0170a61e129b',
			// Sending Custom Hash with unique_id
			purchase : {
			unique_id : 127, //required for custom hashes otherwise the custom data is rejected // Unique String or Integer
			order_id : 30222
			}
			};
</script>
</g:if>
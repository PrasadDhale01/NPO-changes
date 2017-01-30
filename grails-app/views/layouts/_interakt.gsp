<g:set var="projectService" bean="projectService"/>
<%
    String currentEnvironment = projectService.getCurrentEnvironment();
%>
		<script>
		  (function() {
		  var interakt = document.createElement('script');
		  interakt.type = 'text/javascript'; interakt.async = true;
		  interakt.src = "//cdn.interakt.co/interakt/0d5f42147e9211929adc0170a61e129b.js";
		  var scrpt = document.getElementsByTagName('script')[0];
		  scrpt.parentNode.insertBefore(interakt, scrpt);
		  })()
		</script>
		<script>
			window.mySettings = {
			// TODO: The current logged in user's email address.
			email: '',
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

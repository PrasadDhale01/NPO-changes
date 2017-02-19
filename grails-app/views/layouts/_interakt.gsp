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
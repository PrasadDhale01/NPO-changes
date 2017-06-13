<g:set var="projectService" bean="projectService"/>
<%
    def country_code = projectService.getCountryCodeForCurrentEnv(request)
	def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
	def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 + country_code: grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
    <meta name="layout" content="main" />
    <title>How free crowdfunding works? - Crowdera </title>
    	<!-------------- Open Graph Data  -------------->
	<meta property="og:site_name" content="GoCrowdera" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="Simple, secure and free fundraising for things that matter! " />
	<meta property="og:url" content="${base_url}howitworks" />
	<meta property="og:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta name="description" content="Crowdera is a free crowdfunding platform that helps individuals, non-profits & independent filmmakers to raise money online. We offer flexible goals, deadlines and our teams tool helps multiply crowdfunding results."/>
	<meta name="keywords" content="fundraising for non profits, crowdsourcing, crowdfunding success" />
	
	<!-------------- Twitter Card Data  -------------->
	
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:site" content="@gocrowdera" />
	<meta property="twitter:title" content="Simple, secure and free fundraising for things that matter! " />
	<meta name="twitter:domain" content="${base_url}howitworks" />
	<meta property="twitter:description" content="Simple, secure and easy online fundraising website for all things that matter for individuals and non-profits. Get started for free now! " />
	<meta property="twitter:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta property="twitter:url" content="${base_url}howitworks" />
</head>
<body>
<div class="feducontents">
    <g:render template="/howitworks/howtocreate"></g:render>
    <g:render template="/howitworks/howitworks"></g:render>
</div>
</body>
</html>

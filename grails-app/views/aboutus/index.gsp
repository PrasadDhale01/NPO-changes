<g:set var="projectService" bean="projectService"/>
<%
    def country_code = projectService.getCountryCodeForCurrentEnv(request)
	def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
	def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 + country_code: grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="crowderajs"/>
    <title>Crowdera - About Us </title>
    <!-------------- Open Graph Data  -------------->
	<meta property="og:site_name" content="GoCrowdera" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="Online Fundraising for Individuals, Non-profits & Charities | About Crowdera " />
	<meta property="og:url" content="${base_url}aboutus" />
	<meta property="og:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta name="description" content="Crowdera is a fundraising site to raise money free and with ease. We offer flexible goals, deadline and our teams tool helps multiply results."/>
	<meta name="keywords" content="crowdfunding for non profits " />
	
	<!-------------- Twitter Card Data  -------------->
	
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:site" content="@gocrowdera" />
	<meta property="twitter:title" content="Online Fundraising for Individuals, Non-profits & Charities | About Crowdera " />
	<meta name="twitter:domain" content="${base_url}aboutus" />
	<meta property="twitter:description" content="Crowdera is a fundraising site to raise money free and with ease. We offer flexible goals, deadline and our teams tool helps multiply results." />
	<meta property="twitter:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta property="twitter:url" content="${base_url}aboutus" />
</head>
<body>
    <g:render template="/aboutus/aboutusgrid"></g:render>
    <g:render template="/aboutus/alumni"></g:render>
</body>
</html>

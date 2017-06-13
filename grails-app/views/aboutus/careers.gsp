<g:set var="projectService" bean="projectService"/>
<% 
	def country_code = projectService.getCountryCodeForCurrentEnv(request)
	def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
    <title>Why join Crowdera ?</title>
    <meta name="layout" content="main" />
    <!-------------- Open Graph Data  -------------->
	<meta property="og:site_name" content="GoCrowdera" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="Join our growing and passionate global team | Crowdera " />
	<meta property="og:url" content="${base_url}careers" />
	<meta property="og:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta name="description" content="Crowdera is hiring. Join us to spread abundance and the joy of giving! View our open jobs. "/>
	<meta name="keywords" content="Simple, secure and easy online fundraising website for all things that matter for individuals and non-profits. Get started for free now! " />
	
	<!-------------- Twitter Card Data  -------------->
	
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:site" content="@gocrowdera" />
	<meta property="twitter:title" content="Join our growing and passionate global team | Crowdera " />
	<meta name="twitter:domain" content="${base_url}careers" />
	<meta property="twitter:description" content="Crowdera is hiring. Join us to spread abundance and the joy of giving! View our open jobs. " />
	<meta property="twitter:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta property="twitter:url" content="${base_url}careers" />
</head>
<body>
<div class="container mentor-container">
    <div class="abt-careers">
	    <h1 class="text-center">Careers</h1>
	    <div class="crew-scripts">
	        <script data-startup="crowdera" src="https://angel.co/javascripts/embed_jobs.js" id="angellist_embed" async></script>
	    </div>
    </div>
</div>
</body>
</html>

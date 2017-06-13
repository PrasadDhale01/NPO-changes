<g:set var="projectService" bean="projectService"/>
<%
    def base_url = grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Crowdfunding FAQs and Tips </title>
    <!-------------- Open Graph Data  -------------->
	<meta property="og:site_name" content="GoCrowdera" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="Frequently Asked Questions | Crowdera" />
	<meta property="og:url" content="http://support.gocrowdera.com/#/" />
	<meta property="og:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta name="description" content="Have questions? We've got the answers! Our self help is full of information about your frequently asked questions about Crowdera and crowdfunding! "/>
	<meta name="keywords" content="Simple, secure and easy online fundraising website for all things that matter for individuals and non-profits. Get started for free now! " />
	
	<!-------------- Twitter Card Data  -------------->
	
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:site" content="@gocrowdera" />
	<meta property="twitter:title" content="Frequently Asked Questions | Crowdera" />
	<meta name="twitter:domain" content="http://support.gocrowdera.com/#/" />
	<meta property="twitter:description" content="Have questions? We've got the answers! Our self help is full of information about your frequently asked questions about Crowdera and crowdfunding! " />
	<meta property="twitter:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta property="twitter:url" content="http://support.gocrowdera.com/#/" />
</head>
<body>
<div class="feducontent">
    <g:render template="/faq/faq"></g:render>
</div>
</body>
</html>

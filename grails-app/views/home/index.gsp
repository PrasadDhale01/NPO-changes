<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="https://www.facebook.com/2008/fbml">
<head>
<meta name="layout" content="main" />
<meta name="description" content="Crowdera is a FREE crowdfunding platform that helps individuals, non-profits & independent filmmakers to raise money online. Create your fundraiser." />
<meta name="keywords" content="Crowdera, crowdfunding, contribute online, raise funds free, film crowdfunding, raise money online, fundraising site, fundraising website, fundraising project, online fundraising, raise money for a cause, global crowdfunding" />

<meta property="og:type" content="website" />
<meta property="og:site_name" content="Crowdera"/>
<meta property="og:title" content="Crowdera: Future of funding for things that matter" />
<meta property="og:description" content="Crowdera is a free crowdfunding platform that helps individuals, non-profits & independent filmmakers to raise money online. We offer flexible goals, deadlines and our teams tool helps multiply crowdfunding results." />
<meta property="og:image" content="//s3.amazonaws.com/crowdera/assets/crowdera-logo.png"/>
<meta property="og:url" content="${base_url}"/>

<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:site" content="@gocrowdera" />
<meta name="twitter:domain" content="${base_url}" />
<meta name="twitter:title" content="Crowdera- The Free Global Crowdfunding & Fundraising Website" />
<meta name="twitter:description" content="Crowdera is a free global crowdfunding platform for you to make an impact, innovate for social good, follow your passion or fulfil personal needs." />
<g:if test="${currentEnv == 'production'}">
    <meta name="google-site-verification" content="JHphWifUPH5pLuIpLDBo0qa_czJdqETbDP2x40wJBUM" />
</g:if>
<g:elseif test="${currentEnv == 'prodIndia'}">
    <meta name="google-site-verification" content="TXxVJF5ILRgRnuB5n2ZSRTCWI1v1hQVu1Jb9kZQeLyI" />
</g:elseif>
<r:require modules="homejs"/>

<style type="text/css" media="screen">
    @import url(https://s3.amazonaws.com/assets.freshdesk.com/widget/freshwidget.css);
</style>
</head>
<body>
	<g:hiddenField id="b_url" name="b_url" value="${base_Url}" />
	<g:hiddenField id="fbUser-login" name="fbUser-login" value="${fb}"/>
	<g:hiddenField id="googlPlusUser-login" name="googlPlusUser-login" value="${isDuplicate}"/>
	<g:hiddenField id="userEmail" name='userEmail' value="${email}"/>
	<g:hiddenField name='currentEnv' value='${currentEnv}' id='currentEnv'/>
	<g:hiddenField name="contributorEmail" value="${contributorEmail}" id="contributorEmail"/>

    <div onmouseover="showNavigation()" onmouseleave="hideNavigation()">
    	<g:render template="jumbotron"></g:render>
    </div>
    <g:render template="banner"></g:render>
    
    <g:render template="ace"></g:render>
    <div class="greycolorbg">
    	<g:render template="projects"></g:render>
    </div>
    <div class="whycrowderacontainer">
        <g:render template="whycrowdera"></g:render>
    </div>
    <div class="success-stories-container">
        <g:render template="success-stories"></g:render>
    </div>
    <div class="proudassociates-container">
        <g:render template="association"></g:render>
    </div>
    <div class="customer-support hidden-xs">
        <div class="willSlide customer-support-btn" id="customer-support-btn">
            <a class='customer-support-a btn btn-primary'>Support</a>
        </div>
        <div class="willSlide text-center support" id="support">
            <iframe class="freshwidget-embedded-form" id="freshwidget-embedded-form" src="https://crowdera.freshdesk.com/widgets/feedback_widget/new?&widgetType=embedded&formTitle=Crowdera+Customer+Help+&submitThanks=Your+Query+has+been+submitted.+We+will+get+back+to+you+soon.&screenshot=no" scrolling="no" height="600" width="100%" frameborder="0" >
            </iframe>
        </div>
    </div>

    <script type="text/javascript" src="https://s3.amazonaws.com/assets.freshdesk.com/widget/freshwidget.js"></script>
</body>
</html>

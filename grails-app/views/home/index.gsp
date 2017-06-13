<g:set var="projectService" bean="projectService"/>
<%	
	def country_code = projectService.getCountryCodeForCurrentEnv(request)
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 + country_code: grailsApplication.config.crowdera.BASE_URL + country_code
%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="https://www.facebook.com/2008/fbml">
<head>
    <title>Crowdera - The Free Global Crowdfunding & Fundraising Website </title>
    
    <meta name="layout" content="main" />
	<!-------------- Open Graph Data  -------------->
	
	<g:if test="${'in'.equalsIgnoreCase(country_code)}">
		<meta name="google-site-verification" content="TXxVJF5ILRgRnuB5n2ZSRTCWI1v1hQVu1Jb9kZQeLyI" />
	</g:if>
	<g:else>
	    <meta name="google-site-verification" content="1pvQXdD4EfbP-qcUAfTfXFKDngMT3LA5GuAX6Xkoxu4" />
	</g:else>
	<meta property="og:site_name" content="GoCrowdera" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="Crowdera: Future of funding for things that matter" />
	<meta property="og:url" content="${base_url}" />
	<meta property="og:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta name="description" content="Crowdera is a free crowdfunding platform that helps individuals, non-profits & independent filmmakers to raise money online. We offer flexible goals, deadlines and our teams tool helps multiply crowdfunding results."/>
	<meta name="keywords" content="Crowdera, crowdfunding, raise funds free, film crowdfunding, raise money online, fundraising site, fundraising website, fundraising project, online fundraising, raise funds for a cause, global crowdfunding, free fundraising,  nonprofit crowdfunding " />
	
	<!-------------- Twitter Card Data  -------------->
	
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:site" content="@gocrowdera" />
	<meta property="twitter:title" content="Crowdera: Future of funding for things that matter" />
	<meta name="twitter:domain" content="${base_url}" />
	<meta property="twitter:description" content="Crowdera is a free crowdfunding platform that helps individuals, non-profits & independent filmmakers to raise money online. We offer flexible goals, deadlines and our teams tool helps multiply crowdfunding results." />
	<meta property="twitter:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta property="twitter:url" content="${base_url}" />

<%--<meta name="google-site-verification" content="JHphWifUPH5pLuIpLDBo0qa_czJdqETbDP2x40wJBUM" />--%>
<r:require modules="homejs"/>

<style type="text/css" media="screen">
    @import url(https://s3.amazonaws.com/assets.freshdesk.com/widget/freshwidget.css);
</style>
<script>
    function submitCampaignShowForm(pkey, projectId, fr){
        $.ajax({
            type    :'post',
            url     : $("#b_url").val()+'/project/urlBuilder',
            data    : "projectId="+projectId+"&fr="+fr+"&pkey="+pkey,
            success : function(response){
                $(location).attr('href', response);
            }
        }).error(function(){
            console.log("Error in redirecting");
        });
    }
</script>
</head>
<body>
	<g:hiddenField id="b_url" name="b_url" value="${base_Url}" />
	<g:hiddenField id="fbUser-login" name="fbUser-login" value="${fb}"/>
	<g:hiddenField id="googlPlusUser-login" name="googlPlusUser-login" value="${isDuplicate}"/>
	<g:hiddenField id="userEmail" name='userEmail' value="${email}"/>
	<g:hiddenField name='currentEnv' value='${currentEnv}' id='currentEnv'/>
	<g:hiddenField id="country_code" name="country_code" value="${country_code}"/>
	<%--<g:hiddenField name="contributorEmail" value="${contributorEmail}" id="contributorEmail"/>
    
     --%><div id="homepage-carousel"></div>
     <div class="hm-image-header"></div>  
    <div class="hidden-xs">
       <g:render template="banner"></g:render>
    </div>
    <g:render template="ace"></g:render>
    
<%--    <div class="hm-section-top"></div>--%>
    <div class="row text-center hm-fontfamily visible-xs">
        <p class="hm-slogn-mobile">Always Free! Instant Disbursal</p>
        <a href="${resource(dir: '/'+"${country_code}"+'/campaign/create')}" class="btn btn-block hm-raisemony-btn">Raise Money Free</a>
        <p class="hm-slogn-mobile">Flexible Goals Unlimited Teams</p>
    </div>
    
    <div class="greycolorbg hmmobile-back-color">
        <div id="campaignsId" onmouseover="showNavigation()" onmouseleave="hideNavigation()"></div>
    </div>
    <div class="row visible-xs">
        <div class="text-center explorebtn">
<%--            <a href="${resource(dir: '/${test}/campaigns')}" class="btn btn-default btn-block hm-explorecampaign">Explore Campaigns</a>--%>
          <a href="${country_code}/campaigns" class="btn btn-default btn-block hm-explorecampaign">Explore Campaigns</a>
        </div>
    </div>
    <div class="hidden-xs">
        <div class="whycrowderacontainer many-reasons" id="loadWhyCrowdera"></div>
        <div class="success-stories-container">
            <g:render template="success-stories"></g:render>
        </div>
        <g:render template="succesfullcampaignlogos"></g:render>
<%--        <div class="proudassociates-container">--%>
<%--            <g:render template="association"></g:render>--%>
<%--        </div>--%>
    </div>
    <div class="media-stript-container" id="loadMediaStrip"></div>
<%--Removing Freshdesk code--%>
        
    <%--<div class="customer-support hidden-xs">
        <div class="willSlide customer-support-btn" id="customer-support-btn">
            <a class='customer-support-a btn btn-primary'>Support</a>
        </div>
        <div class="willSlide text-center support" id="support">
            <iframe class="freshwidget-embedded-form" id="freshwidget-embedded-form" src="https://crowdera.freshdesk.com/widgets/feedback_widget/new?&widgetType=embedded&formTitle=Crowdera+Customer+Help+&submitThanks=Your+Query+has+been+submitted.+We+will+get+back+to+you+soon.&screenshot=no" scrolling="no" height="600" width="100%" frameborder="0" >
            </iframe>
        </div>
    </div>
    <script type="text/javascript" src="https://s3.amazonaws.com/assets.freshdesk.com/widget/freshwidget.js"></script>
--%>

</body>
</html>

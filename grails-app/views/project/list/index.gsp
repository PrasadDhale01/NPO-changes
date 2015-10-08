<g:set var="projectService" bean="projectService"/>
<% 
	def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
	def base = "/campaign?"
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="projectlistjs"/>
</head>
<body>
    <div class="bg-color" id="TW-discover-banner-padding">
        <div class="container discover-container">
        	<div class="row" >
        		<g:render template="list/discoverbanner"></g:render>
        	</div>
        </div>
        <div class="container discover-inner-container">
            <g:hiddenField name='currentEnv' value='${currentEnv}' id='currentEnv'/>
            <div class="text-center TW-discover-title">
            	<h1><span class="TW-discover-title"><img src="//s3.amazonaws.com/crowdera/assets/discover-arrow.png" alt="Discover title">&nbsp;&nbsp;Explore Campaigns Raising Money for</span></h1>
            </div>
            <div class="row">
            	<div class="col-md-2 col-lg-2 col-sm-2 categoryList list-category TW-dis-tab-padding panel-body TW-discover-select-width left-select-margin">
                    <g:form action="category" controller="project" name="categoryForm">
                        <g:select class="selectpicker" id="category" name="country" from="${countryOptions}" value="${params.country}" optionKey="value" optionValue="value" noSelection="['Country':'Country']" onchange="selectedCategory()"/>
                    </g:form>
                </div>
                <div class="col-xs-12 visible-xs categoryList list-category TW-dis-tab-padding panel-body TW-discover-select-width">
					<g:form action="category" controller="project" name="campaigncategoryForm">
						<g:select class="selectpicker" id="category" name="category" from="${discoverLeftCategoryOptions}" value="${params.category}" optionKey="value" optionValue="value" noSelection="['Campaign Category':'Campaign category']" onchange="selectedCampaignCategory()"/>
					</g:form>
            	</div>
				<div class="btn-group col-sm-8 col-lg-8 TW-dis-tab-padding">
					<g:link controller="project" action="category" params="[usedfor:'PASSION']" class="btn btn-default TW-discover-tab-decoration text-center col-sm-3 col-xs-12 TW-padding-align"><span class="cr-pay-rd TW-cr-pay-rd">Following my</span><span class="cr-reci-siz TW-cr-reci-siz">&nbsp;Passion</span></g:link>  
					<g:link controller="project" action="category" params="[usedfor:'IMPACT']" class="btn btn-default  col-sm-2 col-xs-12 TW-discover-tab-decoration TW-padding-align"> <span class="cr-pay-rd TW-cr-pay-rd">Making an</span><span class="cr-reci-siz TW-cr-reci-siz">&nbsp;Impact</span></g:link> 
					<g:link controller="project" action="category" params="[usedfor:'SOCIAL_NEEDS']" class="btn btn-default  col-sm-3 col-xs-12 TW-discover-tab-decoration TW-padding-align innovatingtab-padding"><span class="cr-reci-siz TW-cr-reci-siz">Innovating&nbsp;</span><span class="cr-pay-rd TW-cr-pay-rd">for social good</span></g:link>
					<g:link controller="project" action="category" params="[usedfor:'PERSONAL_NEEDS']" class="btn btn-default col-sm-2 col-xs-12 cr-mob-payments TW-discover-tab-decoration TW-padding-align"><span class="cr-reci-siz TW-cr-reci-siz">Personal&nbsp;</span><span class="cr-pay-rd TW-cr-pay-rd">need</span></g:link>
				</div>
                <!-- Search -->
                <g:render template="list/search"></g:render>
            </div>
            <br>
            <div class="row TW-Container-alignment">
            	<div class="col-lg-2 col-xs-12  col-sm-2 hidden-xs TW-discover-leftpane-menu TW-discover-pane-width">
					<g:each in="${discoverLeftCategoryOptions}" var="categories">
						<ul>
							<li><g:link controller="project" action="category" params='[category:"${categories.value}"]' >${categories.value}</g:link></li>
						</ul>
					</g:each>
            	</div>
                <div class="col-md-10 col-lg-12 col-sm-10 col-xs-12 TW-discover-campaign-centering">
                    <g:if test="${flash.catmessage}">
                        <div class="alert alert-danger flashmsg-width">
                            ${flash.catmessage}
                        </div>
                    </g:if>
                    <g:else>
                        <!-- Carousel -->
                        <g:render template="list/grid" model="['projects': projects]"></g:render>
                    </g:else>
                </div>
                <div class="TW-discover-pane-width"></div>
            </div>
        </div>
    </div>
</body>
</html>

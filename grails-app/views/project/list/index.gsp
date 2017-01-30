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
    <title>Crowdera- Fundraising Campaigns</title>
</head>
<body>
    <div class="bg-color" id="TW-discover-banner-padding">
        <div class="container discover-container bottomPadding-discover">
        	<div class="row" >
        		<g:render template="list/discoverbanner"></g:render>
        		 <div class="container visible-xs">
                    <img class="img-responsive mob-discoverBanner" src="//s3.amazonaws.com/crowdera/project-images/178e8473-1d94-46e6-a321-dfab845039d6.jpg" title="Discover banner for Mobile.jpg">
                 </div>
        	</div>
        </div>
        <div class="container discover-inner-container">
            <g:hiddenField name='currentEnv' value='${currentEnv}' id='currentEnv'/>
            	<div class="TW-discover-topTab">
           	</div>
<%--            	<h1><span class="TW-discover-title"><img src="//s3.amazonaws.com/crowdera/assets/discover-arrow.png" alt="Discover title">&nbsp;&nbsp;Explore Campaigns Raising Money for</span></h1>--%>
            <%--<div class="TW-discover-topTab">
            	<div class="col-md-2 col-lg-2 col-sm-2 categoryList list-category TW-dis-tab-padding panel-body TW-discover-select-width left-select-margin TW-discover-drpdwn-right-border">
                    <g:form action="category" controller="project" name="categoryForm">
                        <g:select class="selectpicker" id="category" name="country" from="${countryOptions}" value="${selectedCategory}" optionKey="value" optionValue="value" noSelection="['Country':'Country']" onchange="selectedCategory()"/>
                    </g:form>
                </div>
                <div class="col-xs-12 visible-xs categoryList list-category TW-dis-tab-padding panel-body TW-discover-select-width">
		    <g:form action="category" controller="project" name="campaigncategoryForm">
		        <g:select class='selectpicker campaignCategory' id="campaignCategory" name="category" from="${discoverLeftCategoryOptions}" value="${params.category}" optionKey="value" optionValue="value" noSelection="['Campaign Category':'Campaign category']" onchange="selectedCampaignCategory()"/>
		    </g:form>
            	</div>
				<div class="btn-group col-sm-8 col-lg-8 TW-dis-tab-padding">
					<g:link controller="project" action="category" params="[usedfor:'Passion']" class="btn btn-default passionTab ${params.usedfor == 'Passion' ? 'TW-Discover-selected-usedfor':''} TW-discover-tab-decoration text-center col-sm-3 col-xs-12 TW-padding-align"><span class="cr-pay-rd TW-cr-pay-rd">Following</span><span class="cr-reci-siz TW-cr-reci-siz">&nbsp;Passion</span></g:link>  
					<g:link controller="project" action="category" params="[usedfor:'Impact']" class="btn btn-default  ${params.usedfor == 'Impact' ? 'TW-Discover-selected-usedfor':''} col-sm-2 col-xs-12 TW-discover-tab-decoration TW-padding-align"> <span class="cr-pay-rd TW-cr-pay-rd">Making an</span><span class="cr-reci-siz TW-cr-reci-siz">&nbsp;Impact</span></g:link> 
					<g:link controller="project" action="category" params="[usedfor:'Social-Innovation']" class="btn btn-default ${params.usedfor == 'Social-Innovation' ? 'TW-Discover-selected-usedfor':''}  col-sm-3 col-xs-12 TW-discover-tab-decoration TW-padding-align innovatingtab-padding"><span class="cr-pay-rd TW-cr-pay-rd">Social</span><span class="cr-reci-siz TW-cr-reci-siz">&nbsp;Innovation</span></g:link>
					<g:link controller="project" action="category" params="[usedfor:'Personal-Needs']" class="btn btn-default ${params.usedfor == 'Personal-Needs' ? 'TW-Discover-selected-usedfor':''} col-sm-2 col-xs-12 cr-mob-payments TW-discover-tab-decoration TW-padding-align"><span class="cr-pay-rd TW-cr-pay-rd">Personal&nbsp;</span><span  class="cr-reci-siz TW-cr-reci-siz">Needs</span></g:link>
				</div>
                <g:render template="list/search"></g:render>
            </div>
            --%><br>
          <div class="row TW-Container-alignment">
          
            <div class="col-lg-2 col-xs-12  col-sm-2 hidden-xs TW-discover-leftpane-menu TW-discover-pane-width">
            	  <div  class="allCategories">
            	      <img class="img-responsive " src="//s3.amazonaws.com/crowdera/project-images/0b2f7d15-24ac-4273-9311-67f9e2f7d118.png" title="All-Categories - Icon.png">
            	      <p><a href="/campaigns/category/All-Categories">All Categories</a></p>
            	   </div>
            		<ul class="allCategoriesSortd">
					    <g:each in="${discoverLeftCategoryOptions}" var="categories">
					        <li>
						        <a 
						        	<g:if test="${selectedCategory == categories.value}">class="categorylink"</g:if> 
						        	href="/campaigns/category/${categories.value.replace(' ','-')}" >${categories.value}
						        </a>
					        </li>
					    </g:each>
					</ul>
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
             <div class="TW-discover-pane-width-right nevlftSortby">
                   <div  class="allCategoriesSortby">
            	      <img class="img-responsive " src="//s3.amazonaws.com/crowdera/project-images/f3f4ec2e-7efc-4cc6-8ec2-f81ed6fa90a1.png" title="Sort-by - Icon.png">
            	      <p>Sort By</p>
            	   </div>
                  <ul class="allCategoriesSortd">
                      <li>
                         <g:link controller="project" action="campaignsSorts" name="sortsForm" method="POST" params="[sorts:'Live']">Recently Launched</g:link>  
                      </li>
                      <li>
                      	 <g:link controller="project" action="campaignsSorts" name="sortsForm" method="POST" params="[sorts:'Latest']">Trending</g:link>  
                      </li>
                      <li>
                      	 <g:link controller="project" action="campaignsSorts" name="sortsForm" method="POST" params="[sorts:'Most-Funded']">Most Funded</g:link>  
                      </li>
                      <li>
                          <g:link controller="project" action="campaignsSorts" name="sortsForm" method="POST" params="[sorts:'Offering-Perks']">Offering Perks</g:link>  
                      </li>
                      <li>
                        <g:link controller="project" action="campaignsSorts" name="sortsForm" method="POST" params="[sorts:'Ending-Soon']">Ending Soon</g:link>  
                      </li>
                      <li>
                         <g:link controller="project" action="campaignsSorts" name="sortsForm" method="POST" params="[sorts:'Ended']">Ended</g:link>  
                      </li>
                   </ul>
                </div>
            </div>
        </div>
       </div> 
</body>
</html>

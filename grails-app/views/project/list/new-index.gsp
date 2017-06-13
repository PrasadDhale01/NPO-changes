<g:set var="projectService" bean="projectService"/>
<% 
    def country_code = projectService.getCountryCodeForCurrentEnv(request)
	def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
	def base = "/campaign?"
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="projectlistjs"/>
    <title>Explore crowdfunding campaigns - Crowdera </title>
        	<!-------------- Open Graph Data  -------------->
	<meta property="og:site_name" content="GoCrowdera" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="Crowdera: Explore Causes " />
	<meta property="og:url" content="${base_url+country_code}/campaigns" />
	<meta property="og:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta name="description" content="Crowdera is a free crowdfunding platform that helps individuals, non-profits & independent filmmakers to raise money online. Explore the various causes we support!"/>
	<meta name="keywords" content="Simple, secure and easy online fundraising website for all things that matter for individuals and non-profits. Get started for free now! " />
	
	<!-------------- Twitter Card Data  -------------->
	
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:site" content="@gocrowdera" />
	<meta property="twitter:title" content="Crowdera: Explore Causes " />
	<meta name="twitter:domain" content="${base_url+country_code}/campaigns" />
	<meta property="twitter:description" content="Crowdera is a free crowdfunding platform that helps individuals, non-profits & independent filmmakers to raise money online. Explore the various causes we support!" />
	<meta property="twitter:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta property="twitter:url" content="${base_url+country_code}/campaigns" />
    <g:hiddenField name="query" id="query" value="${query}"/>
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script>

        $(document).ready(function () {
            console.log('query=='+$("#query").val());
            var query = $("#query").val();
            var documentLoaded= true;
            var currentPageNumber =0;
            var pageSize = 6;
            $(window).scroll(function(){
                if($(window).scrollTop()==$(document).height()-$(window).height()) {
                    currentPageNumber += 1;
                    loadProjects();
                    documentLoaded= false;
                }
            });
            function loadProjects(){
                if($("#query").val()==null || $("#query").val().length === 0){
                    console.log("Listing all campaigns from List function");
                	$.ajax({
                        url:'/$country_code/campaigns',
                        type: "GET",
                        data: 'currentPageNumber='+ currentPageNumber+'&pageSize='+ pageSize,
                        success:function(data) {
                            $('.TW-discover-campaign-centering').append(data);
                        }

                    }).error(function(){
                        alert('An error occured during sorting');
                    });
                }else{
                    console.log("Listing all campaigns from sortby function for the query=" + $("#query").val());
                	$.ajax({
                        url:'/$country_code/campaign/sortby/'+query,
                        type: "GET",
                        data: 'currentPageNumber='+ currentPageNumber+'&pageSize='+ pageSize+'&documentLoaded='+documentLoaded,
                        success:function(data) {
                            $('.TW-discover-campaign-centering').append(data);
                        }

                    }).error(function(){
                        alert('An error occured during listing campaigns');
                    });
               }
            }
        });
    </script>
</head>
<body>
    <div class="bg-color" id="TW-discover-banner-padding">
        <div class="container discover-container bottomPadding-discover">
        	<div class="row" >
        		<g:render template="list/discoverbanner"></g:render>
        		 <div class="container visible-xs">
                    <img class="img-responsive mob-discoverBanner" src="//s3.amazonaws.com/crowdera/project-images/178e8473-1d94-46e6-a321-dfab845039d6.jpg" alt="Chet Jain's thought on creating a giving economy where abundance starts with giving.">
                 </div>
        	</div>
        </div>
        <div class="visible-xs sortBy-mobile">
               <div class="allCategoriesSortby collapsed" data-toggle="collapse" data-target="#demo">
		           		<img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/f3f4ec2e-7efc-4cc6-8ec2-f81ed6fa90a1.png" alt="Sort-by - Icon.png">
		           		<p>Sort By</p>
               </div>
	            <div id="demo" class="collapse">
	    			<ul class="allCategoriesSortd allCategoriesSortbyMobile">
	                      <li>
	                         <g:link controller="project" action="campaignsSorts" name="sortsForm" method="POST" params="[sorts:'Live']">Live</g:link>  
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
	            <div class="visible-sm visible-md sortBy-mobile">
               <div class="allCategoriesSortby collapsed" data-toggle="collapse" data-target="#demo1">
		           		<img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/f3f4ec2e-7efc-4cc6-8ec2-f81ed6fa90a1.png" alt="Sort-by - Icon.png">
		           		<p>Sort By</p>
               </div>
	            <div id="demo1" class="collapse">
	    			<ul class="allCategoriesSortd allCategoriesSortbyMobile">
	                      <li>
	                         <g:link controller="project" action="campaignsSorts" name="sortsForm" method="POST" params="[sorts:'Live']">Live</g:link>  
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
        <div class="container discover-inner-container">
<%--            	<h1><span class="TW-discover-title"><img src="//s3.amazonaws.com/crowdera/assets/discover-arrow.png" alt="Discover title">&nbsp;&nbsp;Explore Campaigns Raising Money for</span></h1>--%>
           	<%--<div class="TW-discover-topTab">
           	</div>
            --%><div class="row TW-Container-alignment">
            	<div class="col-lg-2 col-xs-12  col-sm-2 hidden-xs hidden-sm hidden-md TW-discover-leftpane-menu TW-discover-pane-width">
            	  <div  class="allCategories">
            	      <img class="img-responsive " src="//s3.amazonaws.com/crowdera/project-images/0b2f7d15-24ac-4273-9311-67f9e2f7d118.png" alt="All-Categories - Icon.png">
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
                
                <div class="col-md-10 col-lg-12 col-sm-10 col-xs-12 TW-discover-campaign-centering discover-campaign-centeringnev tab-center">
                    <g:if test="${flash.catmessage}">
                        <div class="alert alert-danger flashmsg-width">
                            ${flash.catmessage}
                        </div>
                    </g:if>
                    <g:else>
                        <!-- Carousel -->
                        <g:render template="list/new-grid" model="['projects': projects]"></g:render>
                    </g:else>
                </div>
                <div class="TW-discover-pane-width-right hidden-xs  hidden-sm hidden-md">
                   <div  class="allCategoriesSortby">
            	      <img class="img-responsive " src="//s3.amazonaws.com/crowdera/project-images/f3f4ec2e-7efc-4cc6-8ec2-f81ed6fa90a1.png" alt="Sort-by - Icon.png">
            	      <p>Sort By</p>
            	   </div>
                   <ul class="allCategoriesSortd nevlftSortby">
                      <li>
                         <g:link controller="project" action="campaignsSorts" name="sortsForm" method="POST" params="[sorts:'Live']">Live</g:link>  
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

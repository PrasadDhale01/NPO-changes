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
    <div class="feducontent bg-color" id="TW-discover-banner-padding">
        <div class="container discover-container">
        	<div class="row" >
        		<g:render template="list/discoverbanner"></g:render>
        	</div>
            <g:hiddenField name='currentEnv' value='${currentEnv}' id='currentEnv'/>
            <div class="text-center TW-discover-title">
            	<h1><span class="TW-discover-title"><img src="//s3.amazonaws.com/crowdera/assets/discover-arrow.png" alt="Discover title">&nbsp;&nbsp;Explore Campaigns Raising Money for</span></h1>
            </div>
            <div class="row">
            	<div class="col-md-2 col-lg-2 col-sm-2 categoryList list-category TW-dis-tab-padding panel-body TW-discover-select-width left-select-margin">
                    <g:form action="category" controller="project" name="categoryForm">
                        <g:select class="selectpicker" name="category" from="${categoryOptions}" id="category" optionKey="value" optionValue="value" value="${params.category}" onchange="selectedCategory()"/>
                    </g:form>
                </div>
                <div data-toggle="buttons" class="btn-group col-sm-8 col-lg-8 TW-dis-tab-padding TW-discover-tab-width">
						<label id="followingMyPassion" class="btn btn-default TW-discover-tab-decoration text-center col-sm-3 col-xs-12 TW-padding-align"><span class="cr-pay-rd TW-cr-pay-rd">Following my</span><span class="cr-reci-siz TW-cr-reci-siz">&nbsp;Passion</span></label>  
						<label id="makingAnImpact" class="btn btn-default cr-check-btn col-sm-2 col-xs-12 TW-discover-tab-decoration TW-padding-align"> <span class="cr-pay-rd TW-cr-pay-rd">Making an</span><span class="cr-reci-siz TW-cr-reci-siz">&nbsp;Impact</span></label> 
						<label id="innoForSocialGood" class="btn btn-default cr-check-btn col-sm-3 col-xs-12 TW-discover-tab-decoration TW-padding-align"><span class="cr-reci-siz TW-cr-reci-siz">Innovating&nbsp;</span><span class="cr-pay-rd TW-cr-pay-rd">for social good</span></label>
						<label id="personalNeed" class="btn btn-default cr-check-btn col-sm-2 col-xs-12 cr-mob-payments TW-discover-tab-decoration TW-padding-align"><span class="cr-reci-siz TW-cr-reci-siz">Personal&nbsp;</span><span class="cr-pay-rd TW-cr-pay-rd">need</span></label>
                </div>
                <!-- Search -->
                <g:render template="list/search"></g:render>
            </div>
            <br>
            <div class="row TW-Container-alignment">
            	<div class="col-lg-2 col-xs-12  col-sm-2 TW-discover-leftpane-menu">
            		<ul>
            			<li><a href="#">All Campaigns</a></li>
            			<li><a href="#">Non Profits</a></li>
            			<li><a href="#">Film</a></li>
            			<li><a href="#">Civic Needs</a></li>
            			<li><a href="#">Community</a></li>
            		</ul>
            	</div>
                <div class="col-md-10 col-lg-12 col-sm-10 col-xs-12 TW-discover-campaign-centering">
                    <g:if test="${flash.catmessage}">
                        <div class="alert alert-danger">
                            ${flash.catmessage}
                        </div>
                    </g:if>
                    <g:else>
                        <!-- Carousel -->
                        <g:render template="list/grid" model="['projects': projects]"></g:render>
                    </g:else>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<g:set var="projectService" bean="projectService"/>
<%
def country_code = projectService.getCountryCodeForCurrentEnv(request)
%>
<g:if test="${imageUrl.size() == 1 }">
    <div id="singleSlide">
        <img src="${imageUrl.get(0)}" id="us-slide" class="img-responsive home-img-large-size" alt="slide">
    </div>
</g:if>
<g:elseif test="${imageUrl.size() > 1}">
    <div id="multipleSlide">
        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <%--        <ol class="carousel-indicators">--%>
            <%--            <g:each in="${imageUrl}"  var="image" status="index">--%>
            <%--                <li data-target="#myCarousel" data-slide-to="index" class="<g:if test='${index==0}'>active</g:if>"></li>--%>
            <%--            </g:each>--%>
            <%--        </ol>--%>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <g:each in="${imageUrl}" var="image" status="index">
                    <div class="item <g:if test='${index==0}'>active</g:if>">
                        <img src="${image}" class="img-responsive home-img-large-size"
                            alt="dynamicSlide" id="index">
                    </div>
                </g:each>
            </div>

            <!-- Left and right controls -->
            <a class="left carousel-control" href="#myCarousel" role="button"
                data-slide="prev"> <span
                class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a> <a class="right carousel-control" href="#myCarousel" role="button"
                data-slide="next"> <span
                class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
    </g:elseif>
    <g:elseif test="${currentEnv=='prodIndia' || currentEnv=='stagingIndia' || currentEnv=='testIndia' }">
       <img class="img-responsive home-img-large-size" src="//s3.amazonaws.com/crowdera/assets/slider-home-page-india-slider.jpg" alt="India-slide">
       <div class="hm-how-it-work-img">
	        <a href="${resource(dir: '/campaign/create')}" class="btn btn-default btn-block hm-start-campaign-btn">Start Your Campaign</a>
	    </div>
    </g:elseif>
    <g:else>
    <div class="homepageNewcarousel" style="height: 360px;">
       <img class="img-responsive home-img-large-size" src="//s3.amazonaws.com/crowdera/project-images/8df0df66-9045-4fe7-a71c-c7c4c0a24212.png" alt="US-slide">
       <div class="homepageTextdiv">
       <h1 class="bannerBigtext">World's #1 Truly Free Online Fundraising Platform For <br>
       Nonprofits and Individuals</h1><br>
       <h3 class="bannerSmalltext">We are the only crowdfunding platform that does not charge any commission on your raise or take any tip from your donors.</h3>
       <br>
       <div class="homepagecarouselButton">
       <g:link mapping="createCampaign" params="[country_code: country_code]" class="btn necz btn-default btn-block hm-start-campaign-btn">
                  	CREATE A CAMPAIGN
       </g:link>
<%--	        <a href="${resource(dir: '/campaign/create')}" class="btn btn-default btn-block hm-start-campaign-btn">CREATE A CAMPAIGN</a>--%>
	    </div>
	    </div>
	</div>    
    </g:else>
    

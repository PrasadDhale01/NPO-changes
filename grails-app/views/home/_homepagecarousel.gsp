<%
	String userAgent = request.getHeader("User-Agent");
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
    <g:else>
    	<g:if test="${userAgent?.contains('iPad')}">
    		     <img class="img-responsive home-img-large-size" src="https://s3.amazonaws.com/crowdera/project-images/c345270a-0b44-4f1b-9c50-4068357e07bb.jpg" title="homepage banner for Tablet">
    	</g:if>
    	<g:elseif test="${userAgent?.contains('Mobile')|| userAgent?.contains('Android')}">
                  <img class="img-responsive home-img-large-size" src="https://s3.amazonaws.com/crowdera/project-images/c345270a-0b44-4f1b-9c50-4068357e07bb.jpg" title="homepage banner for Mobile.jpg">
      	</g:elseif>
      	<g:else>
      		<img class="img-responsive home-img-large-size" src="https://s3.amazonaws.com/crowdera/project-images/c345270a-0b44-4f1b-9c50-4068357e07bb.jpg" alt="US-slide">
    	</g:else>
    </g:else>
    <div class="homepageTextdiv">
		<h1 class="bannerBigtext">World's #1 Truly Free Online Fundraising Platform For <br>
			 Nonprofits and Individuals</h1>
		 <br>
		<div class="homepagecarouselButton">
			 <a href="${resource(dir: '/'+"${country_code}"+'/campaign/create')}" class="btn btn-default btn-block newCreatebtnn hm-start-campaignn-btn">
				 <span class="btnSpann">CREATE A CAMPAIGN</span>
			 </a>
		 </div>
	</div>
   
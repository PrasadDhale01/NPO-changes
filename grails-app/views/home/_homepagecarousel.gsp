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
    		     <img class="img-responsive home-img-large-size" src="//s3.amazonaws.com/crowdera/project-images/e505a7d9-686d-44e2-b503-4cfcbee2f967.jpg" title="homepage banner for Tablet">
    	</g:if>
    	<g:elseif test="${userAgent?.contains('Mobile')|| userAgent?.contains('Android')}">
                  <img class="img-responsive home-img-large-size" src="//s3.amazonaws.com/crowdera/project-images/85068622-3e90-4e44-9ad9-60fe73147a3a.jpg" title="homepage banner for Mobile.jpg">
      	</g:elseif>
      	<g:else>
    		     <img class="img-responsive home-img-large-size" src="//s3.amazonaws.com/crowdera/project-images/27a95f1e-d5de-423a-b60a-1ecddbe14ce2.jpg" alt="US-slide">
    	</g:else>
    </g:else>
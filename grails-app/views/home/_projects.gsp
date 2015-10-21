<div class="container">
    <div class="col-md-10 col-md-offset-1">
    
	    <div class="row">
	        <div class="col-md-12 hm-mobile-title">
	            <h1 class="text-center headingtext">Latest Campaigns</h1><br>
	        </div>
        </div>
        <div class="item active home-campaign-tile-container home-tile-mobile hidden-xs">
            <div class="row">
                <ul class="thumbnails list-unstyled home-campaign-tile">
                    <g:each in="${projects}" var="project">
                        <li class="col-md-6 col-lg-4 col-sm-6 col-xs-12">
                            <g:render template="/layouts/tile" model="['project': project]"></g:render>
                        </li>
                    </g:each>
                </ul>
            </div>
        </div>
        
        <div id="myCarousel" class="carousel slide visible-xs hm-mobile-positions"  data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active sh-carousel-li"></li>
                <li data-target="#myCarousel" data-slide-to="1" class="sh-carousel-li"></li>
                <li data-target="#myCarousel" data-slide-to="2" class="sh-carousel-li"></li>
            </ol>
            
			<%
			    def count = projects.size()
			    def cols = 1
			    def pages = (count / cols) + (count % cols > 0 ? 1 : 0)
			    def index = 0
			%>

            <div id="carousel-example" class="carousel slide visible-xs home-campaign-tile-container" >
                <!-- Wrapper for slides -->
                <div class="carousel-inner">
                    <g:each in="${(1..pages).toList()}" var="row">
                        <g:if test="${row == 1}">
		                    <div class="item active">
		                        <div class="row">
		                            <ul class="thumbnails list-unstyled">
		                                <g:each in="${1..cols}">
		                                    <% if (index < count) { %>
		                                    <li class="col-xs-2">
		                                        <g:render template="/layouts/tile" model="['project': projects.get(index++)]"></g:render>
		                                    </li>
		                                    <% } %>
		                                </g:each>
		                            </ul>
		                        </div>
		                    </div>
			                </g:if><g:else>
			                    <div class="item">
			                        <div class="row">
			                            <ul class="thumbnails list-unstyled">
			                                <g:each in="${1..cols}">
			                                    <% if (index < count) { %>
			                                    <li class="col-xs-2">
			                                        <g:render template="/layouts/tile" model="['project': projects.get(index++)]"></g:render>
			                                    </li>
			                                    <% } %>
			                                </g:each>
			                            </ul>
			                        </div>
			                    </div>
			                </g:else>
                    </g:each>
                </div>
           </div>
        </div>
        <div class="row text-center explorebtn">
            <a href="${resource(dir: '/campaigns')}"><img src="//s3.amazonaws.com/crowdera/assets/Explore-Campaigns -Button-img.jpg" class="Explore-Campaigns-Button-img" alt="Explore"></a>
        </div>
    </div>
</div>

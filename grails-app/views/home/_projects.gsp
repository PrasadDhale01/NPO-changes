<%--<div class="container">
    <div class="row">
        <div class="col-md-9 hidden-xs">
            <h3>Contribute</h3>
        </div>
        <div class="col-md-3">
            <!-- Controls -->
            <div class="controls pull-right hidden-xs">
                <a class="left glyphicon glyphicon-chevron-left btn btn-link btn-xs" href="#carousel-example" data-slide="prev"></a>
                <a class="right glyphicon glyphicon-chevron-right btn btn-link btn-xs" href="#carousel-example" data-slide="next"></a>
            </div>
        </div>
    </div>
    <%
        def count = projects.size()
        def cols = 4
        def pages = (count / cols) + (count % cols > 0 ? 1 : 0)
        def index = 0
    %>

    <div id="carousel-example" class="carousel slide hidden-xs" >
        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <g:each in="${(1..pages).toList()}" var="row">
                <g:if test="${row == 1}">
                    <div class="item active">
                        <div class="row">
                            <ul class="thumbnails list-unstyled">
                                <g:each in="${1..cols}">
                                    <% if (index < count) { %>
                                    <li class="col-xs-6 col-md-3">
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
                                    <li class="col-xs-6 col-md-3">
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
</div>--%>

<div class="container">
    <%
        def count = projects.size()
        def cols = 3
        def pages = (count / cols) + (count % cols > 0 ? 1 : 0)
        def index = 0
    %>
      
    <div id="carousel-example" class="col-md-10 col-md-offset-1 carousel slide" data-ride="carousel">
	    <div class="row">
	        <div class="col-md-12">
	            <h1 class="text-center headingtext">Latest Campaigns</h1><br>
	        </div>
<%--	        <div class="col-md-9">--%>
<%--	            &nbsp;--%>
<%--	        </div>--%>
<%--            <div class="col-md-3">--%>
<%--                <!-- Controls -->--%>
<%--                <div class="controls pull-right">--%>
<%--	                <a class="left glyphicon glyphicon-chevron-left btn btn-link btn-xs" href="#carousel-example" data-slide="prev"></a>--%>
<%--	                <a class="right glyphicon glyphicon-chevron-right btn btn-link btn-xs" href="#carousel-example" data-slide="next"></a>--%>
<%--                </div>--%>
<%--            </div>--%>
        </div>
        
        <!-- Wrapper for slides -->
<%--        <div class="carousel-inner">--%>
            <g:each in="${(1..pages).toList()}" var="row">
                <g:if test="${row == 1}">
                    <div class="item active home-campaign-tile-container">
                        <div class="row">
                            <ul class="thumbnails list-unstyled home-campaign-tile">
                                <g:each in="${1..cols}">
                                    <% if (index < count) { %>
                                    <li class="col-md-6 col-lg-4 col-xs-12 col-sm-6">
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
                                    <li class="col-md-4 col-xs-12 col-sm-6">
                                        <g:render template="/layouts/tile" model="['project': projects.get(index++)]"></g:render>
                                    </li>
                                    <% } %>
                                </g:each>
                            </ul>
                        </div>
                    </div>
                </g:else>
            </g:each>
            <div class="row text-center explorebtn">
                <a href="${resource(dir: '/campaigns')}"></a><img src="//s3.amazonaws.com/crowdera/assets/Explore-Campaigns -Button-img.jpg" class="Explore-Campaigns-Button-img"></a>
            </div>
        </div>
    </div>
	
<%--</div>--%>
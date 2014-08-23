<div class="container">
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

    <div id="carousel-example" class="carousel slide hidden-xs" data-ride="carousel">
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
</div>

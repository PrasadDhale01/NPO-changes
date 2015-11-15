<div class="row">
    <g:if test="${projects.size() > 0}">
        <ul class="thumbnails list-unstyled">
            <%
                def index = 1 
            %>
            <g:each in="${projects}" var="project">
                <g:if test="${dashboard}">
                    <g:if test="${activeTab == 'campaigns'}">
                        <g:if test="${ index++ % 2 == 0}">
                            <li class="campaigns-padding-right col-md-5 col-lg-5 col-sm-6 col-xs-12">
                                <g:render template="/user/user/dashboardtile" model="['project': project]"></g:render>
                            </li>
                        </g:if>
                        <g:else>
                            <li class="campaigns-padding-left col-md-offset-1 col-lg-offset-1 col-md-5 col-lg-5 col-sm-6 col-xs-12">
                                <g:render template="/user/user/dashboardtile" model="['project': project]"></g:render>
                            </li>
                        </g:else>
                    </g:if>
                    <g:else>
                        <li class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <g:render template="/user/user/dashboardtile" model="['project': project]"></g:render>
                        </li>
                    </g:else>
                </g:if>
                <g:else>
                    <li class="col-md-6 col-lg-4 col-sm-6 col-xs-12">
                        <g:render template="/user/user/tile" model="['project': project]"></g:render>
                    </li>
                </g:else>
            </g:each>
        </ul>
    </g:if>
    <g:else>
        <div class="col-sm-12">
            <div class="alert alert-info">
                No Campaigns.
            </div>
        </div>
    </g:else>
</div>

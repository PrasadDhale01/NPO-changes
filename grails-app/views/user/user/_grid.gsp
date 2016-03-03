<div class="row">
    <g:if test="${projects.size() > 0}">
        <ul class="thumbnails list-unstyled">
            <%
                def index = 1 
            %>
            <g:each in="${projects}" var="project">
                <li class="col-md-6 col-lg-4 col-sm-6 col-xs-12">
                    <g:render template="/user/user/tile" model="['project': project]"></g:render>
                </li>
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

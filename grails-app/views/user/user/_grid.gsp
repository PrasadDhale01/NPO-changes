<%--<%--%>
<%--    def count = projects.size()--%>
<%--    def cols = 3--%>
<%--    def rows = (count / cols) + (count % cols > 0 ? 1 : 0)--%>
<%--    def index = 0--%>
<%--%>--%>
<%----%>
<%--<g:each in="${(1..rows).toList()}" var="row">--%>
<%--    <div class="row">--%>
<%--        <ul class="thumbnails list-unstyled">--%>
<%--            <g:each in="${1..cols}">--%>
<%--                <% if (index < count) { %>--%>
<%--                <li class="col-md-6 col-lg-4 col-sm-6 col-xs-12">--%>
<%--                    <g:render template="/user/user/tile" model="['project': projects.get(index++)]"></g:render>--%>
<%--                </li>--%>
<%--                <% } %>--%>
<%--            </g:each>--%>
<%--        </ul>--%>
<%--    </div>--%>
<%--</g:each>--%>
<div class="row">
    <ul class="thumbnails list-unstyled">
        <g:each in="${projects}" var="project">
            <li class="col-md-6 col-lg-4 col-sm-6 col-xs-12">
                <g:render template="/user/user/tile" model="['project': project]"></g:render>
            </li>
        </g:each>
    </ul>
</div>

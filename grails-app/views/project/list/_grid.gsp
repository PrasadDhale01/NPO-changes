<%
    def count = projects.size()
    def cols = 4
    def rows = (count / cols) + (count % cols > 0 ? 1 : 0)
    def index = 0
%>

<g:each in="${(1..rows).toList()}" var="row">
    <div class="row">
        <ul class="thumbnails list-unstyled">
            <g:each in="${1..cols}">
                <% if (index < count) { %>
                    <g:render template="/layouts/tile" model="['project': projects.get(index++)]"></g:render>
                <% } %>
            </g:each>
        </ul>
    </div>
</g:each>

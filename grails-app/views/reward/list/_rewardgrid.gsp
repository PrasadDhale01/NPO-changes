<%
    def count = reward.size()
    def cols = 3
    def rows = (count / cols) + (count % cols > 0 ? 1 : 0)
    def index = 0
%>

<g:each in="${(1..rows).toList()}" var="row">
    <div class="row">
        <ul class="thumbnails list-unstyled">
            <g:each in="${1..cols}">
                <% if (index < count) { %>
                <li class=" col-sm-4">
                    <g:render template="list/rewardtile" model="['reward': reward.get(index++)]"></g:render>
                </li>
                <% } %>
            </g:each>
        </ul>
    </div>
</g:each>

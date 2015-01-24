<%
    def count = rewards.size()
    def cols = 4
    def rows = (count / cols) + (count % cols > 0 ? 1 : 0)
    def index = 0
%>

<g:each in="${(1..rows).toList()}" var="row">
    <div class="row">
        <ul class="thumbnails list-unstyled">
            <g:each in="${1..cols}">
                <% if (index < count) { %>
	                <li class="col-md-3 col-sm-6 col-xs-12">
	                    <g:render template="manageproject/rewardstile" model="['reward': rewards.get(index++)]"></g:render>
	                </li>
                <% } %>
            </g:each>
        </ul>
    </div>
</g:each>

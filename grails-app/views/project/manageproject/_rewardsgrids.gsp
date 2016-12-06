<%
    def count = rewards.size()
    def cols = 4
    def rows = (count / cols) + (count % cols > 0 ? 1 : 0)
    def index = 0
%>

<g:each in="${(1..rows).toList()}" var="row">
   
        <ul class="thumbnails list-unstyled">
            <g:each in="${1..cols}">
                <% if (index < count) { %>
	                <li class="col-md-4 col-sm-4 col-xs-12 perk-grid-paddings">
	                    <g:render template="manageproject/rewardstile" model="['reward': rewards.get(index++)]"></g:render>
	                </li>
                <% } %>
            </g:each>
        </ul>
    
</g:each>
 
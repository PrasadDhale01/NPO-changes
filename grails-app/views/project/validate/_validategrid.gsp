<%
    def count = projects.size()
    def cols = 4
    def rows = (count / cols) + (count % cols > 0 ? 1 : 0)
    def index = 0
%>
<g:if test="${flash.message}">
    <div class="alert alert-success">
        ${flash.message}
    </div>
</g:if>

<g:each in="${(1..rows).toList()}" var="row">
    <div class="item">
        <div class="row">
            <ul class="thumbnails list-unstyled">
                <g:each in="${1..cols}">
                    <% if (index < count) { %>
	                <li class="col-xs-6 col-md-3">
			    <g:render template="validate/validatetile" model="['project': projects.get(index++)]"></g:render>
                       </li>
		    <% } %>
                </g:each>     
            </ul>       
        </div>
    </div>
</g:each>

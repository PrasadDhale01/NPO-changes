<%
    def count = projects.size()
    def cols = 4
    def rows = (count / cols) + (count % cols > 0 ? 1 : 0)
    def index = 0
%>
<g:each in="${(1..rows).toList()}" var="row" >
	<div class="row">
		<g:each in="${1..cols}">
            <% if (index < count) { %>
                <div class="col-sm-3">
                    <g:render template="list/projecttile" bean="${projects.get(index++)}"></g:render>
                </div>
            <% } %>
		</g:each>
	</div>
	<hr/>
</g:each>

<div class="row">
    <div class="col-md-8">
    </div>
    <div class="col-md-4">
       <g:render template="list/pagination"></g:render>
    </div>
</div>

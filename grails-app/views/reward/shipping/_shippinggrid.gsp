<%
    def count = contribution.size()
    def index = 0
%>

<% while(index< count) { %>
    <g:render template="shipping/shippingtile" model="['contribution': contribution.get(index++)]"></g:render>
<% } %>

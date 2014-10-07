<%
   def count = users.size()
   def index = 0
%>

<% while(index < count) { %>
   <g:render template="register/adminView" model="['users': users.get(index++)]"></g:render>
<% } %>
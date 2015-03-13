<%
   def count = users.size()
   def index = 0
%>

<% while(index < count) { %>
   <g:render template="admin/userListView" model="['users': users.get(index++),index:index]"></g:render>
<% } %>

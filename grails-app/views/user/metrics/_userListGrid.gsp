<%
   def count = users.size()
   def index = 0
   def indexcount = offset ? Integer.parseInt(offset) : 0
%>

<% while(index < count) { %>
   <g:render template="/user/metrics/userListView" model="['user': users.get(index++),index: ++indexcount]"></g:render>
<% } %>

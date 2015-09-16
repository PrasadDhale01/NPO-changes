<%
   def count = users.size()
   def index = 0
%>

<% while(index < count) { %>
   <g:render template="/user/metrics/userListView" model="['user': users.get(index++),index:index]"></g:render>
<% } %>

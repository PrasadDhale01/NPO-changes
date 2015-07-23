<%
   def count = transaction.size()
   def index = 0
%>

<% while(index < count) { %>
   <g:render template="/user/admin/transactionList" model="['transaction': transaction.get(index++), index:index]"></g:render>
<% } %>

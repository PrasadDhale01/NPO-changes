<%
   def count = contribution.size()
   def index = 0
%>

<% while(index < count) { %>
   <g:render template="/user/admin/transactionList" model="['contribution': contribution.get(index++), index:index]"></g:render>
<% } %>

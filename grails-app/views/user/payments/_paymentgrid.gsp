<%
   def count = bankInfos.size()
   def countVar =  bankInfos.size()
   def index = 0
   
%>

<% while(index < count) { %>
   <g:render template="/user/payments/paymentlist" model="['bankInfo': bankInfos.get(index++), 'index': countVar-- ]"></g:render>
<% } %>

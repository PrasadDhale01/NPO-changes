<%
   def count = services.size()
   def countVar =  services.size()
   def index = 0
%>

<% while(index < count) { %>
   <g:render template="/user/userquestions/userquestionslist" model="['service': services.get(index++), 'index': countVar-- ]"></g:render>
<% } %>

<%
   def count = services.size()
   def index = 0
%>

<% while(index < count) { %>
   <g:render template="/user/userquestions/userquestionslist" model="['service': services.get(index++)]"></g:render>
<% } %>

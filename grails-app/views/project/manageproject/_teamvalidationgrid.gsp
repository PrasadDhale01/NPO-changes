<%
   def count = unValidatedTeam.size()
   def index = 0
%>

<% while(index < count) { %>
   <g:render template="manageproject/teamvalidation" model="['team': unValidatedTeam.get(index++), index: index]"></g:render>
<% } %>

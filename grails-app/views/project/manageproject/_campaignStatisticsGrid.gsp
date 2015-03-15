<%
   def count = team.size()
   def index = 0
%>

<% while(index < count) { %>
   <g:render template="manageproject/campaignStatistics" model="['team': team.get(index++), project:project, index: index]"></g:render>
<% } %>

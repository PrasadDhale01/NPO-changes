<%
   def count = teams.size()
   def index = 0
%>

<% while(index < count) { %>
   <g:render template="manageproject/campaignStatistics" model="['team': teams.get(index++), index: index]"></g:render>
<% } %>

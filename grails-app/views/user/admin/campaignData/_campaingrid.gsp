<%
   def count = projectlist.size()
   def projectcount =  projectlist.size()
   def index = 0
   
%>

<% while(index < count) { %>
   <g:render template="/user/admin/campaignData/campaignlist" model="['projectDTO': projectlist.get(index++), 'index': projectcount-- ]"></g:render>
<% } %>
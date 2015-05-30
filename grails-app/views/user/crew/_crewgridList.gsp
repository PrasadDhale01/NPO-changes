<%
    def count = crews.size()
	
	def index = 0
%>

<% while(index < count) { %>
    <g:render template="/user/crew/crewList" model="['crews': crews.get(index++), index: index]"></g:render> 
<% } %>

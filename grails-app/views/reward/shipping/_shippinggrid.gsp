<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="rewardjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
	    <%
            def count = contribution.size()
            def cols = 3
            def rows = (count / cols) + (count % cols > 0 ? 1 : 0)
            def index = 0
        %>
        <g:each in="${(1..rows).toList()}" var="row">
        <div class="row">
            <ul class="thumbnails list-unstyled">
                <g:each in="${1..cols}">
                    <% if (index < count) { %>
                    <li class=" col-sm-4">
                        <g:render template="shipping/shippingtile" model="['contribution': contribution.get(index++)]"></g:render>
                    </li>
                    <% } %>
                </g:each>
            </ul>
        </div>
        </g:each>
    </div>
</div>	
</body>
</html>

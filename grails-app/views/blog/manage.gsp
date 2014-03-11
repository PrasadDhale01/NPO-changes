<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
    <div class="container">
        <h1>Manage blogs</h1>
        <table class="table">
            <thead>
            <tr>
                <th>#</th>
                <th>Title</th>
                <th>Author</th>
                <th>Date</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
                <g:each in="${blogs}" var="blog">
                    <tr>
                        <td>${blog.id}</td>
                        <td><g:link action="show" id="${blog.id}">${blog.title}</g:link></td>
                        <td>${blog.author}</td>
                        <td>${blog.date}</td>
                        <td>
                            <g:form action="togglestatus" role="form" id="${blog.id}">
                                <g:if test="${blog.enabled}">
                                    <span class="glyphicon glyphicon-ok"/>
                                </g:if>
                                <g:else>
                                    <span class="glyphicon glyphicon-ban-circle"/>
                                </g:else>
                                <button type="submit" class="btn btn-danger btn-xs">Toggle</button>
                            </g:form>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </div>
</body>
</html>

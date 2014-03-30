<%@ page import="java.text.SimpleDateFormat" %>
<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
	<div class="container">
		<g:if test="${blog}">
			<div>
				<div class="row">
					<div class="col-sm-8">
						<h2>
							<a href="${blog.id}">${blog.title}</a>
						</h2>
					</div>
					<div class="col-sm-4">
						<h2>
                            <%
                                SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
                                def date = dateFormat.format(blog.date)
                            %>
                            <span class="lead pull-right">By ${blog.author} <span class="small">on ${date}</span></span>
						</h2>
					</div>
				</div>
				<div class="blogpost">
					<div class="well">
						<h4 class="text-justify lead">
							${blog.content}
						</h4>
					</div>
				</div>
			</div>
		</g:if>
		<g:else>
            <h1>Blog not found</h1>
			<p><div class="alert alert-danger">Oh snap! Looks like that blog's not available.</div></p>
		</g:else>
	</div>
</div>
</body>
</html>

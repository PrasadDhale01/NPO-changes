<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
	<div class="container">
		<g:if test="${blog}">
			<div>
				<div class="row">
					<div class="col-sm-8">
						<h2>
							<a href="sampleblog"> ${blog.title}
							</a>
						</h2>
					</div>
					<div class="col-sm-4">
						<h2>
							<span class="lead pull-right">By ${blog.author} <span
								class="small">on ${blog.date}</span></span>
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
			<div class="alert alert-danger">Oh snap! Looks like that blog doesn't exist.</div>
		</g:else>
	</div>
</body>
</html>

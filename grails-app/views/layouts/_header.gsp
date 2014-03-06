<!-- Fixed navbar -->
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${resource(dir: '/')}">FEDU</a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li><a href="#">Create Project</a></li>
                <li><a href="${resource(dir: '/contribute')}">Contribute</a></li>
				<li><a href="${resource(dir: '/howitworks')}">How it works</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="${resource(dir: '/login')}">Login</a></li>
				<li><a href="${resource(dir: '/register')}">Register</a></li>
			</ul>
		</div>
	</div>
</div>

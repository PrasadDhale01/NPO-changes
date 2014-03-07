
<div class="row">
	<div class="col-md-8">
		<div class="input-group">
			<div class="input-group-btn">
				<button type="button" class="btn btn-primary dropdown-toggle"
					data-toggle="dropdown">
					All <span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a href="#">Just started</a></li>
					<li><a href="#">Mid way</a></li>
					<li><a href="#">Almost complete</a></li>
					<li><a href="#">Complete</a></li>
				</ul>
			</div>
			<!-- /btn-group -->
			<input type="text" class="form-control">
			 <span class="input-group-btn">
				<button class="btn btn-default type="button">
				    <a href="" class="glyphicon glyphicon-search"></a>
				</button>
			</span>
		</div>
	</div>
	<div class="col-md-4">
		<g:render template="list/pagination"></g:render>
	</div>
</div>

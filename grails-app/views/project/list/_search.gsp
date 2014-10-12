<div class="row">
    <div class="col-md-8">
	    <div class="input-group">
		<!--<div class="input-group-btn">
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
			</div> -->
			<!-- /btn-group -->
			<g:form action="search" controller="project" id="searchableForm" name="searchableForm">
			    <div class="row">
			        <div class="col-md-6">
			            <input type="text" class="form-control" id="query"  name="query" value="${params.query}"> 
			        </div>
			        <div class="col-md-6">
			            <span class="input-group-btn">
				        <button class="btn btn-default">
				            <i class="glyphicon glyphicon-search"></i>
				        </button>
			            </span>
			        </div>
			    </div>
			</g:form>
		</div>
	</div>
<!--<div class="col-md-4">
		<g:render template="list/pagination"></g:render>
	</div> -->
</div><br>

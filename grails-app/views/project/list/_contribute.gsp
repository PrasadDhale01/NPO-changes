<% rows = 3 %>
<g:each in="${(1..rows).toList()}" var="row" >
	<div class="row">
		<g:each in="${1..4}">
		    <div class="col-sm-3">
		        <div class="col-item">
		            <div class="photo">
		                <img src="http://placehold.it/350x260/eee" class="img-responsive" alt="a" />
		            </div>
		            <div class="info">
		                <div class="row">
		                    <div class="price col-md-6">
		                        <h5>Beneficiary</h5>
		                        <h5>$199</h5>
		                    </div>
		                    <div class="rating hidden-sm col-md-6">
		                        <i class="glyphicon glyphicon-star"></i>
		                        <i class="glyphicon glyphicon-star"></i>
		                        <i class="glyphicon glyphicon-star"></i>
		                        <i class="glyphicon glyphicon-star"></i>
		                        <i class="glyphicon glyphicon-star"></i>
		                    </div>
		                </div>
		                <div class="separator clear-left">
		                    <p class="btn-add"><i class="glyphicon glyphicon-tint"></i><a href="" class="hidden-sm">Fund</a></p>
		                    <p class="btn-details"><i class="glyphicon glyphicon-user"></i><a href="" class="hidden-sm">Details</a></p>
		                </div>
		                <div class="clearfix">
		                </div>
		            </div>
		        </div>
		    </div>
		</g:each>
	</div>
	<hr/>
</g:each>

<div class="row">
    <div class="col-md-8">
    </div>
    <div class="col-md-4">
       <g:render template="list/pagination"></g:render>
    </div>
</div>

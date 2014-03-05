        <div class="row">
            <div class="col-md-9 hidden-xs">
                <h3>Contribute</h3>
            </div>
            <div class="col-md-3">
                <!-- Controls -->
                <div class="controls pull-right hidden-xs">
                    <a class="left glyphicon glyphicon-chevron-left btn btn-link btn-xs" href="#carousel-example" data-slide="prev"></a>
                    <a class="right glyphicon glyphicon-chevron-right btn btn-link btn-xs" href="#carousel-example" data-slide="next"></a>
                </div>
            </div>
        </div>
        <div id="carousel-example" class="carousel slide hidden-xs" data-ride="carousel">
            <!-- Wrapper for slides -->
            <div class="carousel-inner">
                <div class="item active">
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
                </div>
                <div class="item">
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
                </div>
            </div>
        </div>

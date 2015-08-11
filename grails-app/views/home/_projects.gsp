<div class="container">
    <div id="carousel-example" class="col-md-10 col-md-offset-1 carousel slide" data-ride="carousel">
	    <div class="row">
	        <div class="col-md-12">
	            <h1 class="text-center headingtext">Latest Campaigns</h1><br>
	        </div>
        </div>
        
        <div class="row">
            <ul class="thumbnails list-unstyled">
                <g:each in="${projects}" var="project">
                    <li class="col-md-6 col-lg-4 col-sm-6 col-xs-12">
                        <g:render template="/layouts/tile" model="['project': project]"></g:render>
                    </li>
                </g:each>
            </ul>
        </div>

        <div class="row text-center explorebtn">
            <a href="${resource(dir: '/campaigns')}"><img src="//s3.amazonaws.com/crowdera/assets/Explore-Campaigns -Button-img.jpg" class="Explore-Campaigns-Button-img"></a>
        </div>
    </div>
</div>

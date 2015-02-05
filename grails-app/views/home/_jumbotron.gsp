<g:set var="redirectToCreatePage" value="${redirectFromUrl}/projects/create"/>
<div class='mobile-carousel'>
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <div id="indicators" style="display:none;">
	    <ol class="carousel-indicators">
	        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	    </ol>
    </div>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
    	
    	<div class="item active">
            <img src="/images/Slider1.jpg" usemap="#mymap-mob">
            <map name="mymap-mob" >
  					<area  shape="rect" coords="58,115,115,140" alt="Slide-3" href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectToCreatePage}">
 			</map>
            
            <div class="carousel-caption" ></div>
        </div>
        <div class="item">
            <img src="/images/GirlComputerSlider1.jpg" usemap="#mymap-mob2" >
            <map name="mymap-mob2" >
  					<area  shape="rect" coords="90,163,138,138" alt="Slide-1" href="${base_url }/projects/create">
 			</map>
            <div class="carousel-caption"></div>
        </div>
        <div class="item">
            <img src="/images/KidsRunningSlider1.jpg" usemap="#mymap-mob1" >
            <map name="mymap-mob1" >
  					<area  shape="rect" coords="68,115,115,140" alt="slide-2" href="${base_url }/projects/create">
 			</map>
            <div class="carousel-caption"></div>
        </div>
        <div class="item">
            <img src="/images/Playgrounds.jpg" >
            <div class="carousel-caption">
            </div>
        </div>
        <div class="item">
            <img src="/images/Classroom.jpg" >
            <div class="carousel-caption">
            </div>
        </div>
        <div class="item">
            <img src="/images/sports.jpg" >
            <div class="carousel-caption">
            </div>
        </div>
        <div class="item">
            <img src="/images/Adventure.jpg" >
            <div class="carousel-caption">
            </div>
        </div>
		
    </div>

    <!-- Controls -->
    <div id="navigators" style="display: none">
	    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
	        <span class="glyphicon glyphicon-chevron-left"></span>
	    </a>
	    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
	        <span class="glyphicon glyphicon-chevron-right"></span>
	    </a>
    </div>
</div>
</div>
<div class='desktop-carousel'>
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <div id="indicators" style="display:none;">
	    <ol class="carousel-indicators">
	        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	    </ol>
    </div>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
        <div class="item active">
            <img src="/images/Slider1.jpg" usemap="#mymap">
            <map name="mymap">
  				<area  shape="rect" coords="240,213,478,258" alt="Slide-3" href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
 			</map>
            <div class="carousel-caption imageCarouseltextbox imageCoureselFormGroup">
                <g:form class="form-signin" controller="login" action="create" role="form">
                    <div class="imageCarousellabel"> 
                        <input type="name" name="name" class="imageCoureselForm" placeholder="First & Last Name" autofocus>
                        <input type="email" name="username" class="imageCoureselForm" placeholder="Email address">
            			<input type="password" id="password" name="password" class="imageCoureselForm" placeholder="Password *">
               			<input type="password" name="confirmPassword" class="imageCoureselForm" placeholder="Confirm Password *">
               			<button class="btn btn-image" type="submit"><b>Register</b></button>
               		</div>
                </g:form>
        	</div>
        </div>
        <div class="item">
            <img src="/images/GirlComputerSlider1.jpg" usemap="#mymap1">
             <map name="mymap1" >
  				<area  shape="rect" coords="380,250,583,319" alt="Slide-1" href="${base_url }/projects/create">
 			</map>
            <div class="carousel-caption">
            </div>
        </div>
        <div class="item">
            <img src="/images/KidsRunningSlider1.jpg" usemap="#mymap2">
            <map name="mymap2" >
  				<area  shape="rect" coords="282,211,491,250" alt="slide-2" href="${base_url }/projects/create">
 			 </map>
            <div class="carousel-caption">
            </div>
        </div>
        <div class="item">
            <img src="/images/Playgrounds.jpg" >
            <div class="carousel-caption">
            </div>
        </div>
        <div class="item">
            <img src="/images/Classroom.jpg" >
            <div class="carousel-caption">
            </div>
        </div>
        <div class="item">
            <img src="/images/sports.jpg" >
            <div class="carousel-caption">
            </div>
        </div>
        <div class="item">
            <img src="/images/Adventure.jpg" >
            <div class="carousel-caption">
            </div>
        </div>

    </div>

    <!-- Controls -->
    <div id="navigators" style="display: none">
	    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
	        <span class="glyphicon glyphicon-chevron-left"></span>
	    </a>
	    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
	        <span class="glyphicon glyphicon-chevron-right"></span>
	    </a>
    </div>
</div>
</div>

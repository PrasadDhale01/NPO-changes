<g:set var="redirectToCreatePage" value="${redirectFromUrl}/projects/create"/>
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
            <img src="/images/Slider1.jpg">
            <div class="carousel-caption">
                <div class="fbButton">
                    <a href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}"><img src="/images/fbButton.jpg" class="btn btn-fb"></a>
                </div>
            </div>
            <div class="carousel-caption imageCarouseltextbox">
                <g:form class="form-signin" controller="login" action="create" role="form">
                    <div class="imageCarousellabel"> 
                        <input type="name" name="name" class="imageCoureselForm" placeholder="First & Last Name">
                        <input type="email" name="username" class="imageCoureselForm" placeholder="Email address">
            			<input type="password" id="password" name="password" class="imageCoureselForm" placeholder="Password *">
               			<input type="password" name="confirmPassword" class="imageCoureselForm" placeholder="Confirm Password *">
               			<button class="btn btn-image" type="submit"><b>Register</b></button>
               		</div>
                </g:form>
        	</div>
        </div>
        <div class="item">
            <img src="/images/girlComputerSlider.jpg" >
            <div class="carousel-caption">
                <div class="girlSlider"><a href="http://localhost:8080/projects/create"><img src="/images/createButton.jpg"></img></a></div>
            </div>
        </div>
        <div class="item">
            <img src="/images/kidsRunningSlider.jpg" >
            <div class="carousel-caption">
            <div class="kidSlider"><a href="http://localhost:8080/projects/create"><img src="/images/createButton.jpg"></img></a></div>
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

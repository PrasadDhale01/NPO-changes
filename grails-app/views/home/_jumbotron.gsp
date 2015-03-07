<g:set var="redirectToCreatePage" value="${redirectFromUrl}/projects/create"/>
<g:set var="userService" bean="userService"/>
<%  def base_url = grailsApplication.config.crowdera.BASE_URL %>
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
            <g:if test="${userService.isLoggedIn()}">
                <img src="/images/sliderWithoutReg.jpg">
            </g:if>
            <g:else>
            <img src="/images/Slider1.jpg">
            <div class="carousel-caption">
                <div class="fbButton">
                    <a href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}"><img src="/images/fbButton.jpg" class="btn btn-fb"></a>
                </div>
            </div>
            <div class="carousel-caption imageCarouseltextbox">
                <g:form class="form-signin" controller="login" action="create" role="form">
                    <div class="imageCarousellabel">
                        <span class="imageCoureselFormGroup">
                            <input type="text" name="name" id="name" class="imageCoureselForm" placeholder="First & Last Name">
                        </span>
                        <span class="imageCoureselFormGroup">
                            <input type="email" name="username" id="username" class="imageCoureselForm" placeholder="Email address">
            		</span>
            		<span class="imageCoureselFormGroup">	
            		   <input type="password" name="password" id="password" class="imageCoureselForm" placeholder="Password *">
               		</span>
               		<span class="imageCoureselFormGroup">
               		    <input type="password" name="confirmPassword" id="confirmPassword" class="imageCoureselForm" placeholder="Confirm Password *">
               	        </span>		
               		<button class="btn btn-image" type="submit" id="regButton"><b>Register</b></button><br>
               		<div class="col-sm-10 errormessage"></div>
               	    </div>
                </g:form>
            </div>
            </g:else>
        </div>
        <div class="item ">
            <img src="/images/girlComputerSlider.jpg" >
            <div class="carousel-caption">
                <div class="girlSlider"><a href="${base_url}/campaigns/create"><img src="/images/createButton.jpg"></a></div>
            </div>
        </div>
        <div class="item">
            <img src="/images/kidsRunningSlider.jpg" >
            <div class="carousel-caption">
                <div><a href="${base_url}/campaigns/create"><button class="btn btn-create" type="submit"><b>Create Campaign</b></button></a></div>
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

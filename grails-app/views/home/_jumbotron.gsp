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
                <img class="hidden-xs" src="https://s3.amazonaws.com/crowdera/assets/sliderWithoutReg.jpg" alt="Slider-1"/>
                <img class="visible-xs" src="https://s3.amazonaws.com/crowdera/assets/slide-mobile.jpg" alt="Mobile Slider-1"/>
<%--                <g:if test="${userService.isFacebookUser() }">--%>
<%--                    <div class="carousel-caption">--%>
<%--                        <div class="fbButton">--%>
<%--                            <a href="${base_url}/campaigns/create"><img src="/images/fbButton.jpg" class="btn btn-fb"></a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </g:if>--%>
<%--                <g:else>--%>
<%--                    <div class="carousel-caption">--%>
<%--                        <div class="fbButton">--%>
<%--                            <a href="${base_url}/campaigns/create"><img src="/images/fbButton.jpg" class="btn btn-fb"></a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </g:else>--%>
            </g:if>
            <g:else>
            <img class="hidden-xs or-css" src="https://s3.amazonaws.com/crowdera/assets/sliderWithoutReg.jpg" alt="Slider-1"/>
            <img class="visible-xs" src="https://s3.amazonaws.com/crowdera/assets/slide-mobile.jpg" alt="Mobile Slider-1"/>
            <div class="carousel-caption">
                <div class="fbButton">
                    <a href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}"><img src="/images/facebook_register.jpg" alt="facebook register" class="btn btn-fb"/></a>
                    <img src="https://s3.amazonaws.com/crowdera/assets/or.png" alt="or"/>
                </div>
            </div>
            <div class="carousel-caption imageCarouseltextbox" id="imageCarouselForm">
                <g:form class="form-signin" controller="login" action="create" role="form">
                    <div class="imageCarousellabel img-carousel-label">
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
            <img class="hidden-xs" src="https://s3.amazonaws.com/crowdera/assets/girlComputerSlider.jpg" alt="Girl Computer Slider"/>
            <img class="visible-xs" src="https://s3.amazonaws.com/crowdera/assets/slide-3.jpg" alt="Girl Computer Slider Mobile"/>
            <div class="carousel-caption">
                <div class="girlSlider"><a href="${base_url}/campaigns/create"><img src="https://s3.amazonaws.com/crowdera/assets/createButton.jpg" alt="create campaign"></a></div>
            </div>
        </div>
        <div class="item">
            <img class="hidden-xs" src="https://s3.amazonaws.com/crowdera/assets/kidsRunningSlider.jpg" alt="kids Running Slider"/>
            <img class="visible-xs" src="https://s3.amazonaws.com/crowdera/assets/slide-2.jpg" alt="kids Running Slider Mobile"/>
            <div class="carousel-caption">
                <div><a href="${base_url}/campaigns/create"><button class="btn btn-create" type="submit"><b>Create Campaign</b></button></a></div>
            </div>       
        </div>

    </div>

    <!-- Controls -->
    <div id="navigators" style="display: none">
	    <a class="left carousel-control left-css" href="#carousel-example-generic" role="button" data-slide="prev">
	        <span class="glyphicon glyphicon-chevron-left arrow-mobile arrow-top"></span>
	    </a>
	    <a class="right carousel-control right-css" href="#carousel-example-generic" role="button" data-slide="next">
	        <span class="glyphicon glyphicon-chevron-right arrow-mobile-css arrow-top"></span>
	    </a>
    </div>
</div>

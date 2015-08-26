<g:set var="redirectToCreatePage" value="${redirectFromUrl}/projects/create"/>
<g:set var="userService" bean="userService"/>
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
%>
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
	    <div id="indicators" style="display:none;">
		<ol class="carousel-indicators">
		    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
		    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
		</ol>
	    </div>
    </g:if>
    <g:else>
	    <div id="indicators" style="display:none;">
		<ol class="carousel-indicators">
		    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
		    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
		    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
		</ol>
	    </div>
    </g:else>

    <!-- Wrapper for slides -->
     <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
	     <div class="carousel-inner">
	        <div class="item active">
	            <img class="hidden-xs hidden-sm or-css" src="//s3.amazonaws.com/crowdera/assets/indian-Flag-in2.jpg" alt="Slider-1"/>
	            <img class="visible-sm hidden-xs or-css" src="//s3.amazonaws.com/crowdera/assets/indian-flag-768.jpg" alt="Slider-1"/>
	            <img class="visible-xs or-css" src="//s3.amazonaws.com/crowdera/assets/mobile-slide-1.jpg" alt="Slider-1"/>
	            <div class="carousel-buttons">
	               <div class="fbButton">
	                  <a href="${resource(dir: '/howitworks')}">
	                  	<img src="//s3.amazonaws.com/crowdera/assets/Learn-How-Button-carousel-img.jpg" alt="Learn How" class="btn btn-fb">
	                  </a>
	                  <img src="//s3.amazonaws.com/crowdera/assets/or-icon-carousel.png" alt="or">
	                  <a href="${resource(dir: '/project/create')}">
	                   	<img src="//s3.amazonaws.com/crowdera/assets/Start-Now-button-carousel-img.jpg" alt="Start Now" class="btn btn-fb">
	                  </a>
	               </div>
	           	</div>
	        </div>
	        
	        <div class="item">
                <img class="hidden-xs hidden-sm" src="//s3.amazonaws.com/crowdera/assets/prajwala-1.jpg" alt="Prajwala-Slide">
                <img class="visible-sm hidden-xs"  src="//s3.amazonaws.com/crowdera/assets/prajwala-768.jpg" alt="Prajwala-Slide">
                <img class="visible-xs"  src="//s3.amazonaws.com/crowdera/assets/prajwala-mobile-slide.jpg" alt="Prajwala-Slide">
             </div>
	    </div>
    </g:if>
    <g:else>
    <div class="carousel-inner">
        <div class="item active">
            <img class="hidden-xs or-css" src="//s3.amazonaws.com/crowdera/assets/US-Flag-Slide.jpg" alt="Slider-1"/>
            <img class="visible-xs or-css" src="//s3.amazonaws.com/crowdera/assets/US - Flag-mobile.jpg" alt="Slider-1"/>
            <div class="carousel-buttons">
               <div class="fbButton">
                  <a href="${resource(dir: '/howitworks')}">
                  	<img src="//s3.amazonaws.com/crowdera/assets/Learn-How-Button-carousel-img.jpg" alt="Learn How" class="btn btn-fb">
                  </a>
                  <img src="//s3.amazonaws.com/crowdera/assets/or-icon-carousel.png" alt="or">
                  <a href="${resource(dir: '/project/create')}">
                   	<img src="//s3.amazonaws.com/crowdera/assets/Start-Now-button-carousel-img.jpg" alt="Start Now" class="btn btn-fb">
                  </a>
               </div>
           	</div>
        </div>
        <div class="item ">
            <img  class="hidden-xs" src="//s3.amazonaws.com/crowdera/assets/fog-slider-image-new.jpg" alt="FOG-Slide">
             <img class="visible-xs" src="//s3.amazonaws.com/crowdera/assets/fog-slider-mobile-image.jpg" alt="FOG-Slide">
            <div class="carousel-buttons joinFOG">
               <div class="fbButton joinFOG">
                  <a href="${resource(dir: '/campaigns/Festival-of-Globe---FOG/The-Federation-of-Indo-Americans-of-Northern-California-594')}">
                  	<img src="//s3.amazonaws.com/crowdera/assets/JoinFOG-button.jpg" alt="Join FOG" class=" hidden-xs btn btn-fb">
                  	<img src="//s3.amazonaws.com/crowdera/assets/Join-FOG -Button-mobile.jpg" alt="Join FOG" class="visible-xs">
                  </a> 
               </div>
           	</div>
        </div>
        <div class="item">
            <img class="hidden-xs" src="//s3.amazonaws.com/crowdera/assets/prajwala-1.jpg" alt="Prajwala-Slide">
            <img class="visible-xs"  src="//s3.amazonaws.com/crowdera/assets/prajwala-mobile-slide.jpg" alt="Prajwala-Slide">
            <div class="carousel-buttons">
               <div class="fbButton">
                  <a href="${resource(dir: '/campaigns/Securing-Prajwala--An-Anti-Trafficking-Intervention/Friends-of-680')}">
                  	<img src="//s3.amazonaws.com/crowdera/assets/Secure-Prajwala-Button.jpg" alt="Secure Prajwala" class="btn btn-fb">
                  </a>
               </div>
           	</div>
        </div>
    </div>
    </g:else>
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

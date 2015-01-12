<g:set var="projectService" bean="projectService"/>

<g:if test="${images.size()>1}">
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <div >
 	<ol class="carousel-indicators" id="indicators" style = "display:none">
    	<g:each in="${images}" var="img" status="count">
        	<g:if test="${count == 1}">
        		<li data-target="#carousel-example-generic" data-slide-to="${ count }" class="active"></li>
        	</g:if>
        	<g:else>
        		<li data-target="#carousel-example-generic" data-slide-to="${ count }"></li>
        	</g:else>
        </g:each>
    </ol>
    </div>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
        <g:each in="${images}" var="img" status="count">
        	<g:if test="${count == 1}">
        		<div class="item active">
		        	<div style="overflow: hidden;" class="blacknwhite">
			            <a href="${ img }"><img alt="" class="imagestyle" src="${img}"></a>
				    </div>
        		</div>
        	</g:if>
        	<g:else>
	        	<div class="item">
		        	<div style="overflow: hidden;" class="blacknwhite">
			            <a herf="${ img }"><img alt="" class="imagestyle" src="${img}"></a>
				    </div>
	        	</div>
        	</g:else>
        </g:each>
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
</g:if>
<g:else>
	<img alt="${project.title}" class="imagestyle"  src="${images.get(0)}">
</g:else>
<g:set var="projectService" bean="projectService"/>
<%
	def images = projectService.getProjectImageLinks(project)
%>
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
		        	<div style="height: 200px; overflow: hidden;" class="blacknwhite">
			            <a href="${ img }"><img alt="" style="width: 100%;" src="${img}"></a>
				    </div>
		            <div class="carousel-caption">
		            </div>
        		</div>
        	</g:if>
        	<g:else>
	        	<div class="item">
		        	<div style="height: 200px; overflow: hidden;" class="blacknwhite">
			            <a herf="${ img }"><img alt="" style="width: 100%;" src="${img}"></a>
				    </div>
		            <div class="carousel-caption">
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
	<img alt="${project.title}" style="width: 100%;"  src="${images.get(0)}">
</g:else>
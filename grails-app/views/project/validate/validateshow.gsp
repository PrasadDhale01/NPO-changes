<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectshowjs"/>
</head>
<body>
<g:set var="projectService" bean="projectService"/>
<div class="feducontent">
    <div class="container">
	<g:if test="${projects}">
            <div class="row">
                <div class="col-md-8">
                    <h1>
                        <a href="${projects.id}">${projects.title}</a>
                    </h1>
                    <h4 class="lead">Beneficiary: ${projectService.getBeneficiaryName(projects)}</h4>
                     <p class="text-justify">STORY:&nbsp;&nbsp;&nbsp;${projects.story}</p>  
                     <p class="text-justify">CREATED DATE:&nbsp;&nbsp;${projects.created}</p>  
                     <p class="text-justify">FUND_RAISING_FOR:${projects.fundRaisingFor}</p>  
                     <p class="text-justify">FUND_RAISING_REASON:${projects.fundRaisingReason}</p>  
                     <p class="text-justify">CATEGORY:&nbsp;&nbsp;${projects.category}</p>
                </div>  
                <div class="col-md-4">
                    <g:link controller="project" action="update" id="${projects.id}" class="btn btn-primary btn-lg btn-block" role="button"><i class="glyphicon glyphicon-check"></i>&nbsp;Validate project</g:link>  
                    <g:render template="validate/validatetile"/>
                </div>
            </div>  
        </g:if>
	<g:else>
            <h1>Project not found</h1>
       	    <div class="alert alert-danger">Oh snap! Looks like that project doesn't exist.</div>
	</g:else>
    </div>
</div>
</body>
</html>      
                  
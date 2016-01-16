<g:if test="${project.impactNumber > 0 && project.impactAmount > 0}">
    <div class="panel panel-default">
        <div class="panel-body">
	        <p class="">Our campaign will benefit 
		        <g:if test="${project.payuStatus}">
		            <span class="fa fa-inr"></span>
		        </g:if>
		        <g:else>
		            <span class="fa fa-usd"></span>
		        </g:else>
		        ${project.impactNumber}
	            
	            <g:if test="${project.category.toString() == 'ANIMALS'}">
	                animals by providing
	            </g:if>
	            <g:elseif test="${project.category.toString() == 'ARTS'}">
	                individuals by providing
	            </g:elseif>
	            <g:elseif test="${project.category.toString() == 'CHILDREN'}">
	                children's life by providing
	            </g:elseif>
	            <g:elseif test="${project.category.toString() == 'COMMUNITY'}">
	                community by providing
	            </g:elseif>
	            <g:elseif test="${project.category.toString() == 'CIVIC_NEEDS'}">
	                neighbourhood/s by
	            </g:elseif>
	            <g:elseif test="${project.category.toString() == 'EDUCATION'}">
	                students by providing
	            </g:elseif>
	            <g:elseif test="${project.category.toString() == 'ELDERLY'}">
	                elderlies by providing
	            </g:elseif>
	            <g:elseif test="${project.category.toString() == 'ENVIRONMENT'}">
	                neighbourhood/s by providing
	            </g:elseif>
	            <g:elseif test="${project.category.toString() == 'FILM'}">
	                lives by using
	            </g:elseif>
	            <g:elseif test="${project.category.toString() == 'HEALTH'}">
	                lives by providing
	            </g:elseif>
	            <g:elseif test="${project.category.toString() == 'SOCIAL_INNOVATION'}">
	                individual by innovating
	            </g:elseif>
	            <g:elseif test="${project.category.toString() == 'RELIGION'}">
	                religion empowerment by
	            </g:elseif>
	            <g:elseif test="${project.category.toString() == 'NON_PROFITS'}">
	                lives by providing
	            </g:elseif>
	            <g:else>
	                lives by providing
	            </g:else>
	            
	            <g:if test="${project.payuStatus}">
	                <span class="fa fa-inr"></span>
	            </g:if>
	            <g:else>
	                <span class="fa fa-usd"></span>
	            </g:else>
	            ${project.impactNumber}
	        </p>
	    </div>
    </div>
</g:if>

<div class="panel panel-default show-assessment">
    <label class="show-impact-assessment">IMPACT</label>
    <div class="panel-body">
        <g:if test="${project.category.toString() == 'ANIMALS'}">
            <g:if test="${project.payuStatus}">
                <p>Our campaign will benefit  ${project.impactNumber}  animals by providing <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>Our campaign will benefit ${project.impactNumber} animals by providing <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:if>
        <g:elseif test="${project.category.toString() == 'ARTS'}">
            <g:if test="${project.payuStatus}">
                <p>Our campaign will benefit  ${project.impactNumber}  individuals by providing <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>Our campaign will benefit ${project.impactNumber} individuals by providing <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:elseif test="${project.category.toString() == 'CHILDREN'}">
            <g:if test="${project.payuStatus}">
                <p>Our campaign will impact ${project.impactNumber}  children's life by providing  <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>Our campaign will impact ${project.impactNumber}  children's life by providing  <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:elseif test="${project.category.toString() == 'COMMUNITY'}">
            <g:if test="${project.payuStatus}">
                <p>Our campaign will benefit  ${project.impactNumber} community by providing <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>Our campaign will benefit ${project.impactNumber} community by providing <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:elseif test="${project.category.toString() == 'CIVIC_NEEDS'}">
            <g:if test="${project.payuStatus}">
                <p>This campaign will affect ${project.impactNumber} neighborhood by <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>This campaign will affect ${project.impactNumber} neighborhood by  <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:elseif test="${project.category.toString() == 'EDUCATION'}">
            <g:if test="${project.payuStatus}">
                <p>This campaign will educate ${project.impactNumber} students by providing <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>This campaign will educate ${project.impactNumber} students by providing <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:elseif test="${project.category.toString() == 'ELDERLY'}">
            <g:if test="${project.payuStatus}">
                <p>Our campaign will benefit ${project.impactNumber} elderlies by providing <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>Our campaign will benefit ${project.impactNumber} elderlies by providing <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:elseif test="${project.category.toString() == 'ENVIRONMENT'}">
            <g:if test="${project.payuStatus}">
                <p>Our campaign will benefit ${project.impactNumber}  neighbourhood/s by providing <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>Our campaign will benefit ${project.impactNumber} neighbourhood/s by providing <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:elseif test="${project.category.toString() == 'FILM'}">
            <g:if test="${project.payuStatus}">
                <p>Our film will impact ${project.impactNumber} lives by using <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>Our film will impact ${project.impactNumber} lives by using <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:elseif test="${project.category.toString() == 'HEALTH'}">
            <g:if test="${project.payuStatus}">
                <p>Our campaign will save ${project.impactNumber} lives by providing <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>Our campaign will save ${project.impactNumber} lives by providing <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:elseif test="${project.category.toString() == 'SOCIAL_INNOVATION'}">
            <g:if test="${project.payuStatus}">
                <p>Our campaign will benefit ${project.impactNumber} individual by innovating <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>Our campaign will benefit ${project.impactNumber} individual by innovating <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:elseif test="${project.category.toString() == 'RELIGION'}">
            <g:if test="${project.payuStatus}">
                <p>This campaign will help ${project.impactNumber} religion empowerment by <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>This campaign will help ${project.impactNumber} religion empowerment by <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:elseif test="${project.category.toString() == 'NON_PROFITS'}">
            <g:if test="${project.payuStatus}">
                <p>Our non-profit will help ${project.impactNumber} lives by providing <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>Our non-profit will help ${project.impactNumber} lives by providing <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:elseif>
        <g:else>
            <g:if test="${project.payuStatus}">
                <p>Our campaign will benefit ${project.impactNumber} lives by providing <span class="fa fa-inr"></span>${project.impactAmount}</p>
            </g:if>
            <g:else>
                <p>Our campaign will benefit ${project.impactNumber} lives by providing <span class="fa fa-usd"></span>${project.impactAmount}</p>
            </g:else>
        </g:else>
    </div>
</div>

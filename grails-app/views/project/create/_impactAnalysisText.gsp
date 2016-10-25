
<span class="col-sm-7 col-impact-text col-xs-12 impact-right-padding">If successfully funded, how many lives will this campaign impact?</span>
<div class="col-sm-4 col-xs-12 col-sm-impact-num form-group">
    <g:if test="${project.impactNumber > 0}">
         <input type="text" name="impactNumber" class="form-control form-control-impact-num numbersOnly" maxlength="8" placeholder = "Number" value="${project.impactNumber}">
    </g:if>
    <g:else>
         <input type="text" name="impactNumber" class="form-control form-control-impact-num numbersOnly" maxlength="8" placeholder = "Number">
    </g:else>
</div>

<g:if test="${project.category.toString() == 'ANIMALS'}">
    <span class="col-sm-3 col-impact-text col-impact-text-one col-xs-12 impact-right-padding">Our campaign will benefit</span>
    <div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
        <g:if test="${project.impactNumber > 0}">
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
        </g:if>
        <g:else>
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
        </g:else>
    </div>
    <span class="impact-text col-impact-text col-impact-animals-text-two col-xs-12 col-sm-3 impact-right-padding" id="impact-text">animals by providing</span>
    <div class="col-sm-2 col-xs-12 col-sm-impact-animal-amount form-group">
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="fa fa-inr cr-impact-animals-currency"></span>
        </g:if>
        <g:else>
            <span class="fa fa-usd cr-impact-animals-currency"></span>
        </g:else>
        <g:if test="${project.impactAmount > 0}">
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
        </g:if>
        <g:else>
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
        </g:else>
    </div>
</g:if>
<g:elseif test="${project.category.toString() == 'ARTS'}">
    <span class="col-sm-3 col-impact-text col-impact-text-one col-xs-12 impact-right-padding">Our campaign will benefit</span>
    <div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
        <g:if test="${project.impactNumber > 0}">
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
        </g:if>
        <g:else>
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
        </g:else>
    </div>
    <span class="impact-text col-impact-text col-impact-arts-text-two col-xs-12 col-sm-3 impact-right-padding" id="impact-text">individuals by providing</span>
    <div class="col-sm-2 col-xs-12 col-sm-impact-amount form-group">
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="fa fa-inr cr-impact-currency"></span>
        </g:if>
        <g:else>
            <span class="fa fa-usd cr-impact-currency"></span>
        </g:else>
        <g:if test="${project.impactAmount > 0}">
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
        </g:if>
        <g:else>
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
        </g:else>
    </div>
</g:elseif>
<g:elseif test="${project.category.toString() == 'CHILDREN'}">
    <span class="col-sm-3 col-impact-text col-impact-text-one col-xs-12 impact-right-padding">Our campaign will impact</span>
    <div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
        <g:if test="${project.impactNumber > 0}">
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
        </g:if>
        <g:else>
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
        </g:else>
    </div>
    <span class="impact-text col-impact-text col-impact-text-one col-xs-12 col-sm-3 impact-right-padding" id="impact-text">children's life by providing</span>
    <div class="col-sm-2 col-xs-12 col-sm-impact-animal-amount form-group">
         <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
              <span class="fa fa-inr cr-impact-animals-currency"></span>
         </g:if>
         <g:else>
              <span class="fa fa-usd cr-impact-animals-currency"></span>
         </g:else>
         <g:if test="${project.impactAmount > 0}">
              <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
         </g:if>
         <g:else>
              <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
         </g:else>
    </div>
</g:elseif>
<g:elseif test="${project.category.toString() == 'COMMUNITY'}">
    <span class="col-sm-3 col-impact-text col-impact-text-one col-xs-12 impact-right-padding">Our campaign will benefit</span>
    <div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
        <g:if test="${project.impactNumber > 0}">
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
        </g:if>
        <g:else>
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
        </g:else>
    </div>
    <span class="impact-text col-impact-text col-impact-community-text-two col-xs-12 col-sm-2 impact-right-padding" id="impact-text">community by providing</span>
    <div class="col-sm-2 col-xs-12 col-sm-impact-animal-amount form-group">
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="fa fa-inr cr-impact-animals-currency"></span>
        </g:if>
        <g:else>
            <span class="fa fa-usd cr-impact-animals-currency"></span>
        </g:else>
        <g:if test="${project.impactAmount > 0}">
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
        </g:if>
        <g:else>
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
        </g:else>
    </div>
</g:elseif>
<g:elseif test="${project.category.toString() == 'CIVIC_NEEDS'}">
    <span class="col-sm-3 col-impact-text col-impact-text-one col-xs-12 impact-right-padding">This campaign will affect</span>
    <div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
        <g:if test="${project.impactNumber > 0}">
             <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
        </g:if>
        <g:else>
             <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
        </g:else>
    </div>
    <span class="impact-text col-impact-text col-impact-text-two col-xs-12 col-sm-2 impact-right-padding" id="impact-text">neighborhood by</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-amount form-group">
		<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
		    <span class="fa fa-inr cr-impact-currency"></span>
		</g:if>
		<g:else>
		    <span class="fa fa-usd cr-impact-currency"></span>
		</g:else>
		<g:if test="${project.impactAmount > 0}">
		    <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
		</g:if>
		<g:else>
		    <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
		</g:else>
	</div>
</g:elseif>
<g:elseif test="${project.category.toString() == 'EDUCATION'}">
	<span class="col-sm-4 col-impact-text col-impact-education-text-one col-xs-12 impact-right-padding">This campaign will educate</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-education-num form-group">
		<g:if test="${project.impactNumber > 0}">
		    <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
		</g:if>
		<g:else>
		    <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
		</g:else>
	</div>
	<span class="impact-text col-impact-text col-impact-education-text-two col-xs-12 col-sm-3 impact-right-padding" id="impact-text">students by providing</span>
	<div class="col-sm-2 col-xs-12 form-group">
		<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
		    <span class="fa fa-inr cr-impact-currency cr-impact-education-currency"></span>
		</g:if>
		<g:else>
		    <span class="fa fa-usd cr-impact-currency cr-impact-education-currency"></span>
		</g:else>
		<g:if test="${project.impactAmount > 0}">
		    <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
		</g:if>
		<g:else>
		    <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
		</g:else>
	</div>
</g:elseif>
<g:elseif test="${project.category.toString() == 'ELDERLY'}">
	<span class="col-sm-3 col-impact-text col-impact-text-one col-xs-12 impact-right-padding">Our campaign will benefit</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
		<g:if test="${project.impactNumber > 0}">
		    <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
		</g:if>
		<g:else>
		    <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
		</g:else>
	</div>
	<span class="impact-text col-impact-text col-impact-animals-text-two col-xs-12 col-sm-2 impact-right-padding" id="impact-text">elderlies by providing</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-amount form-group">
		<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
		    <span class="fa fa-inr cr-impact-currency"></span>
		</g:if>
		<g:else>
		    <span class="fa fa-usd cr-impact-currency"></span>
		</g:else>
		<g:if test="${project.impactAmount > 0}">
		    <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
		</g:if>
		<g:else>
		    <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
		</g:else>
	</div>
</g:elseif>
<g:elseif test="${project.category.toString() == 'ENVIRONMENT'}">
	<span class="col-sm-3 col-impact-text col-impact-text-one col-xs-12 impact-right-padding">Our campaign will benefit</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
	    <g:if test="${project.impactNumber > 0}">
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
		</g:if>
		<g:else>
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
		</g:else>
	</div>
	<span class="impact-text col-impact-text col-impact-env-text-two col-xs-12 col-sm-2 impact-right-padding" id="impact-text">neighborhood/s by providing</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-amount form-group">
		<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="fa fa-inr cr-impact-currency"></span>
		</g:if>
		<g:else>
            <span class="fa fa-usd cr-impact-currency"></span>
		</g:else>
		<g:if test="${project.impactAmount > 0}">
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
		</g:if>
		<g:else>
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
		</g:else>
	</div>
</g:elseif>
<g:elseif test="${project.category.toString() == 'FILM'}">
	<span class="col-sm-3 col-impact-text col-impact-animals-text-two col-xs-12 impact-right-padding">Our film will impact</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
		<g:if test="${project.impactNumber > 0}">
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
		</g:if>
		<g:else>
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
		</g:else>
	</div>
	<span class="impact-text col-impact-text col-impact-elderly-text col-xs-12 col-sm-2 impact-right-padding" id="impact-text">lives by using</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-amount form-group">
		<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="fa fa-inr cr-impact-currency"></span>
		</g:if>
		<g:else>
            <span class="fa fa-usd cr-impact-currency"></span>
		</g:else>
		<g:if test="${project.impactAmount > 0}">
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
		</g:if>
		<g:else>
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
		</g:else>
	</div>
</g:elseif>
<g:elseif test="${project.category.toString() == 'HEALTH'}">
	<span class="col-sm-3 col-impact-text col-impact-text-one col-xs-12 impact-right-padding">Our campaign will save</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
		<g:if test="${project.impactNumber > 0}">
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
		</g:if>
		<g:else>
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
		</g:else>
	</div>
	<span class="impact-text col-impact-text col-impact-text-two col-xs-12 col-sm-2 impact-right-padding" id="impact-text">lives by providing</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-amount form-group">
		<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="fa fa-inr cr-impact-currency"></span>
		</g:if>
		<g:else>
            <span class="fa fa-usd cr-impact-currency"></span>
		</g:else>
		<g:if test="${project.impactAmount > 0}">
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
		</g:if>
		<g:else>
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
		</g:else>
	</div>
</g:elseif>
<g:elseif test="${project.category.toString() == 'SOCIAL_INNOVATION'}">
	<span class="col-sm-3 col-impact-text col-impact-text-one col-xs-12 impact-right-padding">Our campaign will benefit</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
		<g:if test="${project.impactNumber > 0}">
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
		</g:if>
		<g:else>
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
		</g:else>
	</div>
	<span class="impact-text col-impact-text col-impact-arts-text-two col-xs-12 col-sm-2 impact-right-padding" id="impact-text">individual by innovating</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-animal-amount form-group">
		<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="fa fa-inr cr-impact-animals-currency"></span>
		</g:if>
		<g:else>
            <span class="fa fa-usd cr-impact-animals-currency"></span>
		</g:else>
		<g:if test="${project.impactAmount > 0}">
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
		</g:if>
		<g:else>
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
		</g:else>
	</div>
</g:elseif>
<g:elseif test="${project.category.toString() == 'RELIGION'}">
	<span class="col-sm-3 col-impact-text col-impact-community-text-two col-xs-12 impact-right-padding">This campaign will help</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
		<g:if test="${project.impactNumber > 0}">
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
		</g:if>
		<g:else>
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
		</g:else>
	</div>
	<span class="impact-text col-impact-text col-xs-12 col-sm-3 impact-right-padding col-impact-text-religion-two" id="impact-text">religion empowerement by</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-amount form-group col-sm-impact-religion-amount">
		<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="fa fa-inr cr-impact-currency cr-impact-religion-cr"></span>
		</g:if>
		<g:else>
            <span class="fa fa-usd cr-impact-currency cr-impact-religion-cr"></span>
		</g:else>
		<g:if test="${project.impactAmount > 0}">
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
		</g:if>
		<g:else>
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
		</g:else>
	</div>
</g:elseif>
<g:elseif test="${project.category.toString() == 'NON_PROFITS'}">
	<span class="col-sm-3 col-impact-text col-impact-text-one col-xs-12 impact-right-padding">Our non-profit will help</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
		<g:if test="${project.impactNumber > 0}">
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
		</g:if>
		<g:else>
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
		</g:else>
	</div>
	<span class="impact-text col-impact-text col-impact-text-two col-xs-12 col-sm-2 impact-right-padding" id="impact-text">lives by providing</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-amount form-group">
		<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="fa fa-inr cr-impact-currency"></span>
		</g:if>
		<g:else>
            <span class="fa fa-usd cr-impact-currency"></span>
		</g:else>
		<g:if test="${project.impactAmount > 0}">
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
		</g:if>
		<g:else>
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
		</g:else>
	</div>
</g:elseif>
<g:else>
	<span class="col-sm-3 col-impact-text col-impact-text-one col-xs-12 impact-right-padding">Our campaign will benefit</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-num form-group">
		<g:if test="${project.impactNumber > 0}">
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number" value="${project.impactNumber}">
		</g:if>
		<g:else>
            <input type="text" name="impactNumber" class="form-control form-control-impact-num" placeholder = "Number">
		</g:else>
	</div>
	<span class="impact-text col-impact-text col-impact-text-two col-xs-12 col-sm-2 impact-right-padding" id="impact-text">lives by providing</span>
	<div class="col-sm-2 col-xs-12 col-sm-impact-amount form-group">
		<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="fa fa-inr cr-impact-currency"></span>
		</g:if>
		<g:else>
            <span class="fa fa-usd cr-impact-currency"></span>
		</g:else>
		<g:if test="${project.impactAmount > 0}">
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" value="${project.impactAmount}" placeholder="Amount"> &nbsp;
		</g:if>
		<g:else>
            <input type="text" name="impactAmount" class="form-control form-amount-impact impactAmount" > &nbsp;
		</g:else>
	</div>
</g:else>
<g:if test="${loadjs}">
<g:hiddenField name="projectIdImpact" value="${project.id}" id="projectIdImpact"/>
<script>
$('.form-amount-impact').blur(function (){
    var impactAmount = $(this).val();
    if (!isNaN(impactAmount) && impactAmount > 0){
        autoSave('impactAmount', impactAmount);
    }
});

$('.form-control-impact-num').blur(function (){
    var impactNumber = $(this).val();
    if (!isNaN(impactNumber) && impactNumber > 0){
        autoSave('impactNumber', impactNumber);
    }
});

function autoSave(variable, varValue) {
	var projectId = $('#projectIdImpact').val();
    $.ajax({
        type:'post',
        url:$("#b_url").val()+'/project/autoSave',
        data:'projectId='+projectId+'&variable='+variable+'&varValue='+varValue,
        success: function(data) {
            if (data != 'null'){
                $('#taxRecieptId').val(data);
            }
        }
    }).error(function() {
        console.log('Error occured while autosaving field'+ variable + 'value :'+ varValue);
    });
}
</script>
</g:if>
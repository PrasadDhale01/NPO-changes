<div id="chart-container">
    ${spendAmountPerList }
	<g:if test="${spendAmountPerList}">
		<g:hiddenField name="miscellaneous" value="hasOtherValues" id="miscellaneous"/>
		<g:hiddenField name="spendAmountPerList" value="${spendAmountPerList}" id="spendAmountPerList"/>
	</g:if>
	<g:else>
		<g:hiddenField name="miscellaneous" value="hasNoOtherValue" id="miscellaneous"/>
		<g:hiddenField name="spendAmountPerList" value="${project.amount.round()}" id="spendAmountPerList"/>
	</g:else>
	<div id="graphWithoutLabel"></div>
</div>

<script src="/js/raphel-pie/raphael-min.js"></script>
<script src="/js/raphel-pie/g.raphael.js"></script>
<script src="/js/raphel-pie/g.pie.js"></script>
<script src="/js/project/pieChart.js"></script>
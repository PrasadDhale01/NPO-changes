<%
def base_url = grailsApplication.config.crowdera.BASE_URL
 %>
<div id="chart-container">
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

<script src="${base_url}js/raphel-pie/raphael-min.js"></script>
<script src="${base_url}js/raphel-pie/g.raphael.js"></script>
<script src="${base_url}js/raphel-pie/g.pie.js"></script>
<script src="${base_url}js/project/pieChart.js"></script>
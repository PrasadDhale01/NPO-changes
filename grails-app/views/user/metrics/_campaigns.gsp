<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
%>
<div class="row metricsTabTop">
    <g:hiddenField name="baseUrl" value="${base_url}" id="baseUrl"/>
    <g:if test="${sortedCampaigns.size()}">
        <% def onLoadCampaign = sortedCampaigns[0] %>
        <g:hiddenField name="onLoadCampaign" value="${base_url}/project/campaignHistory?projectId=${onLoadCampaign.id}" id="onLoadCampaign"/>
    </g:if>
    <div class="col-lg-4 col-md-4 col-sm-6">
        <div id="campaignSearchOnMetrics">
            <g:form action="campaignSearch" controller="project">
                <div class="col-md-10 form-group">
                    <input type="text" class="form-control metricsCampaignLink" name="searchValue" id="searchValue" placeholder="Search....."/>
                </div>
            </g:form>
        </div>
        <div class="clear"></div>
        <g:if test="${searchresultmessage}">
            <div class="col-md-12">
                <div class="col-md-10 alert alert-danger">${searchresultmessage}</div>
            </div>
        </g:if>
        <div id="metricsCampaignLink">
            <g:each in="${sortedCampaigns}" var="project">
                <div class="col-md-10 metricsCampaignLink">
                    <a href="${base_url}/project/campaignHistory?projectId=${project.id}">${project.title}</a>
                </div>
                <br/>
            </g:each>
        </div>
        <div class="clear"></div>
        <div class="campaignsPagination" id="campaignsPagination">
            <g:paginate controller="project" max="12" action="campaignsList" total="${totalCampaigns.size()}"/>
        </div>
    </div>
    <div class="col-lg-8 col-md-8 col-sm-6" id="campaignhistory">
    </div>
</div>

<script>
    $('#campaignSearchOnMetrics').find('form').submit(function(event) {
        event.preventDefault();
        var url = $('#baseUrl').val() + '/project/campaignSearch?searchValue='+$('#searchValue').val();
        var grid = $(this).parents('#campaignstab');
        loadCampaignHistory(url, grid);
    });
    $('.campaignsPagination a').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var grid = $(this).parents('#campaignstab');
        loadCampaignHistory(url, grid);
    });

    $("#metricsCampaignLink a").click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var grid = $('#campaignhistory');
        loadCampaignHistory(url, grid);
    });

    if($('#onLoadCampaign').val()) {
    	var grid = $('#campaignhistory');
        loadCampaignHistory($('#onLoadCampaign').val(), grid);
    }
    
    function loadCampaignHistory(url, grid) {
        $.ajax({
            type: 'GET',
            url: url,
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
            }
        });
    }
    
</script>

<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="projectService" bean="projectService"/>
<%
	def country_code = projectService.getCountryCodeForCurrentEnv(request)
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
	String baseUrl = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
	def base_url = baseUrl.substring(0, (baseUrl.length() - 1))
%>

<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="userjs"/>
</head>
<body>
    <div class="feducontent">
        <div class="container">
            <div class="row">
                <g:hiddenField name='baseUrl' value='${base_url}' id='baseUrl'/>
                
                <div class="col-sm-12">
                
                    <div class="pull-right dashboard-sortByOptions" id="dashboard-sortByOptions">
                        <g:select class="selectpicker text-center" name="sortByOptions" id="sortByOptions" from="${sortByOptions}" optionKey="value" optionValue="value" value="" onchange="getcampaignsort()"/>
                    </div>
                    <div class="pull-right dashboard-sortByOptions">
                        <g:if test="${environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia'}">
                            <g:select class="selectpicker text-center" name="countryOpts" id="countryOpts" from="${countryOpts}" optionKey="value" optionValue="value" value="India" onchange="getcampaignsortByCountry()"/>
                        </g:if>
                        <g:else>
                            <g:select class="selectpicker text-center" name="countryOpts" id="countryOpts" from="${countryOpts}" optionKey="value" optionValue="value" value="USA" onchange="getcampaignsortByCountry()"/>
                        </g:else>
                    </div>
                </div>
                <div class="col-sm-12 text-center">
                    <g:if test="${flash.prj_validate_message}">
                        <div class="alert alert-success">
                            ${flash.prj_validate_message}
                        </div>
                    </g:if>
                </div>
                <div class="clear"></div>
                <div class="col-md-12">
                    <div id="adminCampaignGrid">
<%--                        <g:render template="validate/validategrid" model="['projects': projects]"></g:render>--%>
                    </div>
                </div>
                
            </div>
        </div>   
    </div>
    
    <div class="loadinggif text-center" id="loading-gif">
        <img src="//s3.amazonaws.com/crowdera/documents/loading.gif" alt="'loadingImage'" id="loading-gif-img">
    </div>
    <script type="text/javascript">
    $(document).ready(function(){
        $('#sortByOptions, #countryOpts').change();
    });
    </script>
</body>
</html>

<%@page import="org.codehaus.groovy.grails.commons.GrailsApplication"%>
<g:set var="projectService" bean="projectService"/>
<html>
<head>
	<meta name="layout" content="main" />
	<r:require modules="fundjs" />
	<r:require modules="fundcss" />
	<title>Crowdera- Contribute</title>
<script>
    function submitCampaignShowForm(pkey, projectId, fr){
        $.ajax({
            type    :'post',
            url     : $("#b_url").val()+'/project/urlBuilder',
            data    : "projectId="+projectId+"&fr="+fr+"&pkey="+pkey,
            success : function(response){
                $(location).attr('href', response);
            }
       }).error(function(){
           console.log("Error in redirecting");
       });
    }
</script>
</head>
<body>
    <div class="feducontent">
        <div class="container fund-sm-container footer-container">
        
            <div class="row" id="fundindex">
                <div class="alert alert-info" id="perkForAnonymousUser">
                    <b>Sorry ! You cannot select twitter perk as you are contributing anonymously.</b>
                </div>
                
                <g:if test="${project.payuEmail}">
                    <g:render template="fund/payu"/>
				</g:if>
                <g:elseif test="${project.paypalEmail}">
                    <g:render template="fund/paypal"/>
				</g:elseif>
				<g:elseif test="${project.citrusEmail}">
					<g:render template="fund/citrus"/>
				</g:elseif>
				<g:else>
				    <g:render template="fund/firstgiving"/>
				</g:else>
				

                <g:if test="${project.paypalEmail || project.payuStatus}">
                    <div class="col-md-4 hidden-sm hidden-xs campaignTile ">
                        <g:render template="fund/fundTile"/>
                    </div>
                </g:if>
				<g:elseif test="${project.charitableId}">
					<div class="col-md-4">
						<g:render template="/layouts/tile" />
					</div>
				</g:elseif>
				
			</div>
		</div>
		
	</div>
</body>
</html>

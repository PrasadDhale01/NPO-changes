<%@page import="org.codehaus.groovy.grails.commons.GrailsApplication"%>
<g:set var="projectService" bean="projectService"/>
<html>
<head>
	<meta name="layout" content="main" />
	<link rel="canonical" href="${grailsApplication.config.crowdera.BASE_URL}/campaign"/>
	<r:require modules="fundjs" />
	<r:require modules="fundcss" />
	<title>Crowdera- Contribute</title>
</head>
<body>
    <div class="feducontent">
        <div class="container fund-sm-container footer-container">
        
            <div class="row" id="fundindex">
                <div class="alert alert-info" id="perkForAnonymousUser">
                    <b>Sorry ! You cannot select twitter perk as you are contributing anonymously.</b>
                </div>
                
                <g:if test="${project.paypalEmail && ('us'.equalsIgnoreCase(country_code)) || (project.paypalEmail && project.citrusEmail && ('us'.equalsIgnoreCase(country_code))) || (project.paypalEmail && project.payuEmail && ('us'.equalsIgnoreCase(country_code)))}">
                    <g:render template="fund/paypal"/>
    			</g:if>
                <g:elseif test="${project.payuEmail}">
                    <g:render template="fund/payu"/>
    			</g:elseif>
    			<g:elseif test="${project.charitableId}" >
        			<g:render template="fund/firstgiving"/>
    			</g:elseif>
				

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

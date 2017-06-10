
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <r:require modules="projectshowjs"/>
    <r:require module="crowderacss"/>
    <r:layoutResources />
</head>
<body>

 <g:if test="${percentage == 999}">
    <button type="button" class="btn btn-success show-campaign-sucessbtn embed-donate-btn-size3 mob-show-sucessend" disabled>SUCCESSFULLY FUNDED!</button>
</g:if>
<g:elseif test="${ended}">
    <div class="show-A-fund"> </div>
    <button type="button" class="btn btn-warning show-campaign-sucess-endedbtn embed-donate-btn-size3 mob-show-sucessend show-campaign-ended-funded" disabled>CAMPAIGN ENDED!</button>
</g:elseif>
<g:else>
 <g:form controller="fund" action="fund" params="['fr': fr, 'projectTitle': projectTitle, 'country_code': country_code]" class="fundFormDesktop">
    <g:if test="${project.paypalEmail || project.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
       
            <button name="submit" class="btn btn-show-fund show-fund-size embed-donate-btn-size3 mob-show-fund sh-fund-donate-contri" id="btnFundDesktop">DONATE NOW</button>
        
    </g:if>
    <g:elseif test="${(project.payuEmail || project.citrusEmail) && !('in'.equalsIgnoreCase(country_code))}">
<%--         <g:form controller="fund" action="fund" params="['fr': fr, 'projectTitle': projectTitle, 'country_code': country_code]" class="fundFormDesktop">--%>
      	     <button name="inactiveContributeButton" class="btn btn-show-fund show-fund-size embed-donate-btn-size3 mob-show-fund sh-fund-donate-contri">DONATE NOW</button>
<%--         </g:form>--%>
    </g:elseif>
    <g:else>
    
        <button name="contributeButton" class="btn btn-show-fund show-fund-size embed-donate-btn-size3 mob-show-fund sh-fund-donate-contri">DONATE NOW</button>
    </g:else>
    </g:form>
</g:else>
			
</body>
</html>

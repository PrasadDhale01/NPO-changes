
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
def country_code = projectService.getCountryCodeForCurrentEnv(request)
%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <r:require module="projectshowjs"/>
    <r:require module="crowderacss"/>
    <r:layoutResources />
</head>
<body>
<g:hiddenField name="btnparam" id="btnparam" value="${btnparam}"/>

<g:if test="${btnparam == 'small'}">
 <g:if test="${percentage == 999}">
    <button type="button" class="btn btn-success show-campaign-sucessbtn embed-donate-btn-size1 mob-show-sucessend embdsmallBtn" disabled>SUCCESSFULLY FUNDED!</button>
</g:if>
<g:elseif test="${ended}">
    <div class="show-A-fund"> </div>
    <button type="button" class="btn btn-warning show-campaign-sucess-endedbtn embed-donate-btn-size1 mob-show-sucessend show-campaign-ended-funded embdsmallBtn" disabled>CAMPAIGN ENDED!</button>
</g:elseif>
<g:else>
 <g:form controller="fund" action="fund" params="['fr': fr, 'projectTitle': projectTitle]" class="fundFormDesktop">
    <g:if test="${project?.paypalEmail || project?.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
         <button name="submit" class="btn btn-show-fund show-fund-size embed-donate-btn-size1 mob-show-fund sh-fund-donate-contri embdsmallBtn" id="btnFundDesktop">DONATE NOW</button>
        
    </g:if>
    <g:elseif test="${(project?.payuEmail || project.citrusEmail) && !('in'.equalsIgnoreCase(country_code))}">
	<g:form controller="fund" action="fund" params="['fr': fr, 'projectTitle': projectTitle]" class="fundFormDesktop">      	     <button name="inactiveContributeButton" class="btn btn-show-fund show-fund-size embed-donate-btn-size1 mob-show-fund sh-fund-donate-contri embdsmallBtn">DONATE NOW</button>
         </g:form>
    </g:elseif>
    <g:else>
        <button name="contributeButton" class="btn btn-show-fund show-fund-size embed-donate-btn-size1 mob-show-fund sh-fund-donate-contri embdsmallBtn">DONATE NOW</button>
    </g:else>
    </g:form>
</g:else>
</g:if>


<g:if test="${btnparam == 'medium'}">
 <g:if test="${percentage == 999}">
    <button type="button" class="btn btn-success show-campaign-sucessbtn mob-show-sucessend embdmidBtn" disabled>SUCCESSFULLY FUNDED!</button>
</g:if>
<g:elseif test="${ended}">
    <div class="show-A-fund"> </div>
    <button type="button" class="btn btn-warning show-campaign-sucess-endedbtn mob-show-sucessend show-campaign-ended-funded embdmidBtn" disabled>CAMPAIGN ENDED!</button>
</g:elseif>
<g:else>
<g:form controller="fund" action="fund" params="['fr': fr, 'projectTitle': projectTitle]" class="fundFormDesktop">
    <g:if test="${project.paypalEmail || project.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
         <button name="submit" class="btn btn-show-fund show-fund-size mob-show-fund sh-fund-donate-contri embdmidBtn" id="btnFundDesktop">DONATE NOW</button>
        
    </g:if>
    <g:elseif test="${(project.payuEmail || project.citrusEmail) && !('in'.equalsIgnoreCase(country_code))}">
         <g:form controller="fund" action="fund" params="['fr': fr, 'projectTitle': projectTitle]" class="fundFormDesktop">
      	     <button name="inactiveContributeButton" class="btn btn-show-fund show-fund-size mob-show-fund sh-fund-donate-contri embdmidBtn">DONATE NOW</button>
         </g:form>
    </g:elseif>
    <g:else>
        <button name="contributeButton" class="btn btn-show-fund show-fund-size embed-donate-btn-size1 mob-show-fund sh-fund-donate-contri embdmidBtn">DONATE NOW</button>
    </g:else>
    </g:form>
</g:else>
</g:if>

<g:if test="${btnparam == 'large'}">
 <g:if test="${percentage == 999}">
    <button type="button" class="btn btn-success show-campaign-sucessbtn mob-show-sucessend embdlgBtn" disabled>SUCCESSFULLY FUNDED!</button>
</g:if>
<g:elseif test="${ended}">
    <div class="show-A-fund"> </div>
    <button type="button" class="btn btn-warning show-campaign-sucess-endedbtn mob-show-sucessend show-campaign-ended-funded embdlgBtn" disabled>CAMPAIGN ENDED!</button>
</g:elseif>
<g:else>
 <g:form controller="fund" action="fund" params="['fr': fr, 'projectTitle': projectTitle]" class="fundFormDesktop">
    <g:if test="${project.paypalEmail || project.charitableId || (project?.wepayEmail && project?.wepayAccountId != 0 && (wepayAccountStatus == 'active' || wepayAccountStatus == 'pending')) || (project.payuEmail && 'in'.equalsIgnoreCase(country_code)) || (project.citrusEmail && 'in'.equalsIgnoreCase(country_code))}">
         <button name="submit" class="btn btn-show-fund show-fund-size mob-show-fund sh-fund-donate-contri embdlgBtn" id="btnFundDesktop">DONATE NOW</button>
        
    </g:if>
    <g:elseif test="${(project.payuEmail || project.citrusEmail) && !('in'.equalsIgnoreCase(country_code))}">
         <g:form controller="fund" action="fund" params="['fr': fr, 'projectTitle': projectTitle]" class="fundFormDesktop">
      	     <button name="inactiveContributeButton" class="btn btn-show-fund show-fund-size mob-show-fund sh-fund-donate-contri embdlgBtn">DONATE NOW</button>
         </g:form>
    </g:elseif>
    <g:else>
        <button name="contributeButton" class="btn btn-show-fund show-fund-size mob-show-fund sh-fund-donate-contri embdlgBtn">DONATE NOW</button>
    </g:else>
    </g:form>
</g:else>
</g:if>
<r:layoutResources />
</body>
</html>

<g:set var="projectService" bean="projectService"/>
<html>
<head>
    <title>Crowdera- Partner</title>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div id="partner-show-container">
        <div class="partner-gallery">
            <h1><b>Partner Gallery</b></h1>
            <h3>We partner with innovative organizations whose audiences are engaged, passionate and ready to act.</h3>
            <g:link controller="user" action="partnerFaq" class="btn btn-default btn-sm">LEARN MORE</g:link>
        </div>
    </div>
</div>
<div class="partners_list_container">
    <ul class="thumbnails list-unstyled">
        <g:each in="${partners}" var="partner">
            <%
                 def partnerObj = projectService.getFundRaisedByPartner(partner.user)
				 def country_code = projectService.getCountryCodeForCurrentEnv(request)
				 
            %>
            <li class="col-md-3 col-lg-3 col-sm-4 col-xs-12">
                <div class="partner-show-tile thumbnail">
                    <g:if test="${partner.user.userImageUrl}">
                        <img class="partner-profile-img" src="${partner.user.userImageUrl}" alt="partner-profile-img">
                    </g:if>
                    <g:else>
                        <img class="partner-profile-img" src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" alt="partner-profile-img">
                    </g:else>

                    <div class="partner-show-info">
                        <div class="partner-org-name"><b>${partner.user.firstName}</b></div>
                        <div class="partner-raised-amt"><b><g:if test="${country_code == 'in'}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${partnerObj.raised.round()}</b> Raised</div>
                        <div class="partner-campaigns"><b>${partnerObj.totalprojects.size()}</b><g:if test="${partnerObj.totalprojects.size() > 1}"> Campaigns</g:if><g:else> Campaign</g:else></div>
                    </div>
                </div>
            </li>
        </g:each>
    </ul>
</div>
</body>
</html>

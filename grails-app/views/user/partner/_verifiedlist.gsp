<%
    indexcount = 1;
%>
<div class="active tab-pane tab-pane-active" id="validated">
    <div class="col-md-12 invitepartner">
        <div class="panel-body partner-panel">
            <ul class="thumbnails list-unstyled">
                <g:each in="${partners}" var="partner">
                    <li class="col-md-3 col-lg-3 col-sm-4 col-xs-12">
                        <div class="partner-tile thumbnail">
                            <g:link action="partnerdashboard" controller="user" id="${partner.id}">
                                <g:if test="${!partner.enabled}">
                                    <div class="over user-tile">
                                        <img src="//s3.amazonaws.com/crowdera/assets/Pending-tag.png" alt="pending">
                                    </div>
                                </g:if>
                                <g:if test="${partner.user.userImageUrl}">
                                    <img class="partner-profile-img" src="${partner.user.userImageUrl}" alt="partnerImg">
                                </g:if>
                                <g:else>
                                    <img class="partner-profile-img" src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" alt="defaultImg">
                                </g:else>
                            </g:link>

                            <div class="partner-information-bio text-center">
                                <label><b>${partner.user.firstName}</b></label>
                            </div>
                        </div>
                    </li>
                </g:each>
            </ul>
        </div>
    </div>
</div>

<g:set var="projectService" bean="projectService"/>
<g:if test="${isCampaignAdmin}">
     <input type="hidden" name="videoUrl" id="youtubeVideoUrl" value="${project.videoUrl}"/>
</g:if>
<g:elseif test="${currentTeam}">
    <g:if test="${currentTeam.user == project.user}">
        <input type="hidden" name="videoUrl" id="youtubeVideoUrl" value="${project.videoUrl}"/>
    </g:if>
    <g:else>
        <input type="hidden" name="videoUrl" id="youtubeVideoUrl" value="${currentTeam.videoUrl}"/>
    </g:else>
</g:elseif>
<g:else>
     <input type="hidden" name="videoUrl" id="youtubeVideoUrl" value="${project.videoUrl}"/>
</g:else>

<g:if test="${images.size()>1}">
<div id="carousel-example-genericss" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators manage-carousel" id="showmobileindicators">
        <g:each in="${images}" var="img" status="count">
            <g:if test="${count == 0}">
                <li data-target="#carousel-example-genericss" data-slide-to="${ count }" class="active"></li>
            </g:if>
            <g:else>
                <li data-target="#carousel-example-genericss" data-slide-to="${ count }"></li>
            </g:else>
        </g:each>
    </ol>

    <%-- Wrapper for slides --%>
    <div class="carousel-inner">
        <g:each in="${images}" var="img" status="count">
            <g:if test="${count == 0}">
                <div class="item active">
                    <div class="blacknwhite manage-carousel-in">
                        <g:if test="${img.toString().contains('.jpg') }">
                                        <img class="imagestyle" src="${img}" alt="manage carousel">
                                </g:if>
                                <g:elseif test="${img.toString().contains('.png')}">
                                        <img class="imagestyle" src="${img}" alt="manage carousel">
                                </g:elseif>
                               <g:else>
                                        <iframe class="imagestyle" src="${img}" allowfullscreen=""></iframe>
                               </g:else>
                </div>
                </div>
            </g:if>
            <g:else>
                <div class="item">
                    <div class="blacknwhite manage-carousel-in">
                        <g:if test="${img.toString().contains('.jpg') }">
                                        <img class="imagestyle" src="${img}" alt="manage carousel">
                                </g:if>
                                    <g:elseif test="${img.toString().contains('.png')}">
                                        <img class="imagestyle" src="${img}" alt="manage carousel">
                               </g:elseif>
                               <g:else>
                                        <iframe class="imagestyle" src="${img}" allowfullscreen=""></iframe>
                              </g:else>
                    </div>
                </div>
            </g:else>
        </g:each>
    </div>
    <%-- Controls --%>
    <div id="showmobilenavigators" class="manage-carousel">
        <a class="left carousel-control fixCarousel" href="#carousel-example-genericss" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control fixCarousel" href="#carousel-example-genericss" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </div>
</div>
</g:if>
<g:else>
    <g:if test="${images.toString().contains('.jpg') }">
        <img alt="${project.title}" class="imagestyle"  src="${images.get(0)}">
    </g:if>
    <g:elseif test="${images.toString().contains('.png') }">
        <img alt="${project.title}" class="imagestyle"  src="${images.get(0)}">
    </g:elseif>
    <g:elseif test="${images.toString().contains('abstract') }">
        <img alt="${project.title}" class="imagestyle"  src="${images.get(0)}">
    </g:elseif>
    <g:else>
        <iframe class="imagestyle" src="${images.get(0)}" allowfullscreen=""></iframe>
    </g:else>   
</g:else>

<%--
Expects the parent containers to be like so:
<div class="row">
    <ul class="thumbnails list-unstyled">
        ... /layouts/tile ...
    </ul>
</div>
--%>

<li class="col-xs-6 col-md-3">
    <div class="thumbnail" style="padding: 0">
        <div style="height: 200px; overflow: hidden;">
            <g:if test="${it.image}">
                <img alt="${it.title}" style="width: 100%;" src="${createLink(controller: 'project', action: 'thumbnail', id: it.id)}">
            </g:if>
            <g:else>
                <img style="width: 100%" src="http://lorempixel.com/300/250/abstract">
            </g:else>

        </div>

        <div class="caption">
            <h4><g:link controller="project" action="show" id="${it.id}">${it.title}</g:link></h4>
            <p>${it.name}</p>
            <!-- <p><i class="icon icon-map-marker"></i>Place, Country</p> -->
        </div>

        <div class="modal-footer" style="text-align: left; margin-top: 0;">
            <div class="progress">
                <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
                    <span class="sr-only">100% Complete</span>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4"><b>100%</b><br/><small>FUNDED</small></div>
                <div class="col-md-4"><b>$${it.amount}</b><br/><small>PLEDGED</small></div>
                <div class="col-md-4"><b>ON</b><br><small>JAN 26</small></div>
            </div>
        </div>
    </div>
</li>

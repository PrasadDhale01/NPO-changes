
<ul class="thumbnails list-unstyled">
    <g:each in="${projects}" var="project">
        <li class="col-md-6 col-lg-4 col-sm-6 col-xs-12 TW-discover-pg-tile-width">
            <g:render template="/layouts/newTile" model="['project': project]"></g:render>
        </li>
    </g:each>
</ul>

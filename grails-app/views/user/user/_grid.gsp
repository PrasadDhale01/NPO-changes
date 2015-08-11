<div class="row">
    <ul class="thumbnails list-unstyled">
        <g:each in="${projects}" var="project">
            <li class="col-md-6 col-lg-4 col-sm-6 col-xs-12">
                <g:render template="/user/user/tile" model="['project': project]"></g:render>
            </li>
        </g:each>
    </ul>
</div>

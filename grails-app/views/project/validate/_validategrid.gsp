<h1 class="text-center"><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-validated.png" alt="Campaigns to be validated"/> Campaigns to be validated</h1><br>
<div class="row">
    <ul class="thumbnails list-unstyled">
        <g:each in="${projects}" var="project">
            <li class="col-md-6 col-lg-4 col-sm-6 col-xs-12 text-center validatetile">
                <g:render template="validate/validatetile" model="['project': project]"></g:render>
            </li>
        </g:each>
    </ul>
</div>

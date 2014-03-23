<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <h1>
                <g:link controller="project" action="show" id="${project.id}">${project.title}</g:link>
            </h1>
            <h4 class="lead">Beneficiary: ${project.name}</h4>
            <button type="button" class="btn btn-primary btn-lg">Fund</button>
        </div>
        <div class="col-md-4">
            <g:render template="rendertile"/>
            <g:render template="/layouts/singletile"/>
        </div>
    </div>
</div>
</body>
</html>

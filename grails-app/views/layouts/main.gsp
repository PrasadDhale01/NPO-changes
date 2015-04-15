<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" href="//s3.amazonaws.com/crowdera/assets/favicon.png" type="image/x-icon">
    <title><g:layoutTitle default="Crowdera" /></title>

    <!-- Twitter Bootstrap CSS -->
    <!--
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.css">
    -->

    <!-- Crowdera CSS -->
    <r:require module="crowderacss"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <g:layoutHead />
    <r:layoutResources />

</head>
<body>
    <div id="fb-root"></div>
    <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=${grailsApplication.config.crowdera.facebook.appId}";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>

    <g:render template="/layouts/header"/>
    <div class="feduoutercontent">
        <g:layoutBody />
    </div>
    <g:render template="/layouts/footer"/>

    <!-- Include all javascript assets -->
    <r:require modules="crowderajs"/>
    <r:require module="googleanalytics"/>

    <r:layoutResources />
</body>
</html>

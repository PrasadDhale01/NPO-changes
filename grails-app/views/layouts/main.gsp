<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <title><g:layoutTitle default="FEDU" /></title>

    <!-- Twitter Bootstrap CSS -->
    <!--
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.css">
    -->

    <!-- Bootswatch Slate theme (http://bootswatch.com/slate/) -->
    <link rel="stylesheet" href="http://bootswatch.com/slate/bootstrap.css">
    <link rel="stylesheet/less" type="text/css" href="http://bootswatch.com/slate/variables.less" />
    <link rel="stylesheet/less" type="text/css" href="http://bootswatch.com/slate/bootswatch.less" />


    <!-- FEDU CSS -->
    <link rel="stylesheet" href="css/fedu.css">

    <g:layoutHead />
    <r:layoutResources />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <g:render template="/layouts/header"/>
	<g:layoutBody />
    <g:render template="/layouts/footer"/>

    <!-- jQuery JS -->
    <script src="http://code.jquery.com/jquery-2.1.0.js"></script>

    <!-- Twitter Bootstrap JS -->
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.js"></script>

    <!-- LESS JS -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/less.js/1.7.0/less.min.js"></script>

    <!-- FEDU JS -->
    <g:javascript src="fedu.js" />
    <r:layoutResources />
</body>
</html>

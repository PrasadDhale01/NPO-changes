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

    <!-- FEDU CSS -->
    <r:require module="feducss"/>
    <r:require module="lessjs"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <g:layoutHead />
    <r:layoutResources />

    <!-- Bootswatch themes (http://bootswatch.com/) -->
    <% def theme="journal" %>
    <link rel="stylesheet" href="http://bootswatch.com/${theme}/bootstrap.css">
    <link rel="stylesheet/less" type="text/css" href="http://bootswatch.com/${theme}/variables.less" />
    <link rel="stylesheet/less" type="text/css" href="http://bootswatch.com/${theme}/bootswatch.less" />

</head>
<body>
    <g:render template="/layouts/header"/>
	<g:layoutBody />
    <g:render template="/layouts/footer"/>

    <!-- Include all javascript assets -->
    <r:require modules="appjs"/>

    <r:layoutResources />
</body>
</html>

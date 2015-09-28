<%
	response.addHeader("X-Frame-Options","SAMEORIGIN")
	response.addHeader("X-Content-Type-Options","nosniff")
	response.addHeader("X-Xss-Protection","1; mode=block")
 %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta >
    <link rel="shortcut icon" href="//s3.amazonaws.com/crowdera/assets/Crowdera-Favicon-blue.png" type="image/x-icon">
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
    <iframe src="//www.googletagmanager.com/ns.html?id=GTM-KKG44S"
    height="0" width="0" style="display:none;visibility:hidden"></iframe>
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push(
    {'gtm.start': new Date().getTime(),event:'gtm.js'}
    );var f=d.getElementsByTagName(s)[0],
    j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
    '//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-KKG44S');</script>

    <div id="fb-root"></div>
    <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=${grailsApplication.config.crowdera.facebook.appId}";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
    </script>

    <g:render template="/layouts/header"/>
    <div class="feduoutercontent">
        <g:layoutBody />
    </div>
    <g:render template="/layouts/footer"/>

    <!-- Include all javascript assets -->
    <r:require modules="crowderajs"/>
    <r:require module="googleanalytics"/>
    
    <script src="/js/main.js" type="application/x-javascript"></script>

    <r:layoutResources />
</body>
</html>

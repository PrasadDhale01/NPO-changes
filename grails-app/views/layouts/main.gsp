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
    <link rel="shortcut icon" href="//s3.amazonaws.com/crowdera/assets/Crowdera-Favicon-blue.png" type="image/x-icon">
    <title><g:layoutTitle default="Crowdera- The Free Global Crowdfunding & Fundraising Website"/></title>
    
    <!-- font-family:Ubuntu Condensed -->
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Ubuntu+Condensed" />

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
    
	<!-- start Mixpanel -->
	<script type="text/javascript">
	(function(e,b){if(!b.__SV){var a,f,i,g;window.mixpanel=b;b._i=[];b.init=function(a,e,d){function f(b,h){var a=h.split(".");2==a.length&&(b=b[a[0]],h=a[1]);b[h]=function(){b.push([h].concat(Array.prototype.slice.call(arguments,0)))}}var c=b;"undefined"!==typeof d?c=b[d]=[]:d="mixpanel";c.people=c.people||[];c.toString=function(b){var a="mixpanel";"mixpanel"!==d&&(a+="."+d);b||(a+=" (stub)");return a};c.people.toString=function(){return c.toString(1)+".people (stub)"};i="disable time_event track track_pageview track_links track_forms register register_once alias unregister identify name_tag set_config people.set people.set_once people.increment people.append people.union people.track_charge people.clear_charges people.delete_user".split(" ");
	for(g=0;g<i.length;g++)f(c,i[g]);b._i.push([a,e,d])};b.__SV=1.2;a=e.createElement("script");a.type="text/javascript";a.async=!0;a.src="undefined"!==typeof MIXPANEL_CUSTOM_LIB_URL?MIXPANEL_CUSTOM_LIB_URL:"file:"===e.location.protocol&&"//cdn.mxpnl.com/libs/mixpanel-2-latest.min.js".match(/^\/\//)?"https://cdn.mxpnl.com/libs/mixpanel-2-latest.min.js":"//cdn.mxpnl.com/libs/mixpanel-2-latest.min.js";f=e.getElementsByTagName("script")[0];f.parentNode.insertBefore(a,f)}})(document,window.mixpanel||[]);
	mixpanel.init("d75cc9b700aea96b693ba0c44fa47bb9");
	</script>
	<!-- end Mixpanel -->

    <!-- Facebook Pixel Code -->
    
    <script>
    !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
    n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
    n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
    t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
    document,'script','https://connect.facebook.net/en_US/fbevents.js');
    
    fbq('init', '651945004959238');
    fbq('track', "PageView");</script>
    <noscript><img height="1" width="1" style="display:none" alt="facebook"
    src="https://www.facebook.com/tr?id=651945004959238&ev=PageView&noscript=1">
    </noscript>
    
    <!-- End Facebook Pixel Code -->

</head>
<body>
    <div id="fb-root"></div>
    <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=${grailsApplication.config.crowdera.facebook.appId}";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
    </script>
    <script src="/js/main.js" type="application/x-javascript"></script>
    
    <div class="main-header-gsp" id="loadHeaderTempate"></div>

    <div class="feduoutercontent mobile-header-onmain">
        <g:layoutBody />
    </div>
    <div id="loadFooter"></div>
    <g:render template="/layouts/ga"/>
    
    <!-- Include all javascript assets -->
    <r:require modules="crowderajs"/>
<%--    <r:require module="googleanalytics"/>--%>
    <r:layoutResources/>
</body>
</html>

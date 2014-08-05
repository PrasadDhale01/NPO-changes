<html>
<head>
<meta name="layout" content="main" />
<r:require modules="homejs"/>
</head>
<body>
      <div id="fb-root"></div>
       <script>(function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.0";
                fjs.parentNode.insertBefore(js, fjs);
                }(document, 'script', 'facebook-jssdk'));
       </script>

    <!-- Big banner -->
	<g:render template="jumbotron"></g:render>
        
    <!-- Call to action buttons -->
    <%-- <g:render template="createfund"></g:render> --%>
    <div class="fb-like" data-href="https://www.facebook.com/FundEdu/" data-layout="standard" data-action="like" data-show-faces="false" data-share="false">
    </div>
    <!-- Carousel -->
    <g:render template="carousel"></g:render>

	<!-- Ask/Contribute/Enable grid -->
	<%-- <g:render template="ace"></g:render> --%>

	<g:render template="featurettes"></g:render>

</body>
</html>

$(document).ready(function(){
    var currentEnv=$('#currentEnvironment').val();
    if(currentEnv === 'production'){
    	
    	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    		  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    		  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    		  ga('create', 'UA-56708048-1', 'auto');
    		  ga('send', 'pageview');
    		  
    }else if (currentEnv === 'prodIndia'){
    	
    	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    		  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    		  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    		  ga('create', 'UA-56708048-2', 'auto');
    		  ga('send', 'pageview');
    		  
    } else if (currentEnv === 'test') {
    
    	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    	  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    	  ga('create', 'UA-56708048-3', 'auto');
    	  ga('send', 'pageview');

    }
});

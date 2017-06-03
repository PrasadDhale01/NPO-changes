<%--<div class="container marketing">--%>
<%--    <h1 class="text-center"> How to create your campaign</h1>--%>
<%----%>
<%--    <!-- Three columns of text below the carousel -->--%>
<%--    <div class="row">--%>
<%--        <div class="col-lg-4 col-sm-4 col-xs-12">--%>
<%--            <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-5.png" alt="Create a Fundraiser"/>--%>
<%--            <h3>Create a Fundraiser</h3>--%>
<%--            <p>Create your online fundraising campaign and begin accepting contributions within 24 hours! Set a fundraising goal, add compelling photos and video, and share with your community through Facebook, email and more!</p>--%>
<%--        </div>--%>
<%----%>
<%--        <div class="col-lg-4 col-sm-4 col-xs-12">--%>
<%--            <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-6.png" alt="Share your Campaign"/>--%>
<%--            <h3>Share your Campaign</h3>--%>
<%--            <p>The more people who know about your campaign the greater chance you’ll reach your funding goal! Email the link to your campaign page to colleagues, family and friends. Post a link on Facebook and Twitter. Spread the word and get ready to feel the love!</p>--%>
<%--        </div>--%>
<%----%>
<%--        <div class="col-lg-4 col-sm-4 col-xs-12">--%>
<%--            <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-7.png" alt="Update your Campaign"/>--%>
<%--            <h3>Update your Campaign</h3>--%>
<%--            <p>Once your campaign is underway, we have found updating your contributors helps rally support. Share milestones, photos and updates easily via Crowdera’s update tab in your dashboard.</p>--%>
<%--        </div>--%>
<%----%>
<%--    </div>--%>
<%--</div>--%>
 <%
 def country_code = request.getHeader("cf-ipcountry")
 
  %>
<div class="hm-how-it-work">
	 <img class="img-responsive home-img-large-size hidden-xs  visible-lg" src="//s3.amazonaws.com/crowdera/project-images/b1f45ce3-0bb5-4e04-952a-a0108b10b366.jpg" alt="How-it-work">
	 
     <div class="how-it-learn-title">
	    <h1 class="text-center visible-xs how-it-title1">It's Simple, Secure and Free to Fundraise on Crowdera</h1>
	 </div>
	 <div class="hm-howitworks-mobile-image">
	    <img class="img-responsive home-img-large-size visible-xs" src="//s3.amazonaws.com/crowdera/project-images/01eb46a8-e556-45bc-b429-33b60f3b0339.jpg" alt="How the crowdfunding process works from creating a campaign to achieving your goal.">
	 </div>
	 
	 <img class="img-responsive home-img-large-size hidden-xs hidden-lg visible-sm visible-md" src="//s3.amazonaws.com/crowdera/project-images/b1f45ce3-0bb5-4e04-952a-a0108b10b366.jpg" alt="How the crowdfunding process works from creating a campaign to achieving your goal.">
	 
	 <div class="learn-how-it-work-img">
	     <a href="${resource(dir: '/'+"${country_code}"+'/campaign/create')}" class="btn btn-default btn-block hm-start-campaign-btn learn-startcampaign-btn">Start Your Campaign</a>
	 </div>
</div>


<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
    def currentEnv = projectService.getCurrentEnvironment()
    def base_url = grailsApplication.config.crowdera.BASE_URL
    def ebookUrl=base_url + "/crowdfunding-ebook"
    def user= userService.getCurrentUser()
%>
<html>
<head>
	<meta name="layout" content="main"/>
	<r:require modules="ebookjs"/>
	<title>The best crowdfunding success ebook - Crowdera </title>
    	<!-------------- Open Graph Data  -------------->
	<meta property="og:site_name" content="GoCrowdera" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="Resource Guides " />
	<meta property="og:url" content="${base_url}crowdfunding-ebook" />
	<meta property="og:image" content="//s3.amazonaws.com/crowdera/project-images/9dd48f64-4cf0-4550-8519-ed06166eff09.jpg" />
	<meta name="description" content="Free ebooks to help you with best practices, fundraising trends and more. "/>
	<meta name="keywords" content="Successful crowdfunding, free crowdfunding tips, free fundraising tips " />
	
	<!-------------- Twitter Card Data  -------------->
	
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:site" content="@gocrowdera" />
	<meta property="twitter:title" content="Resource Guides " />
	<meta name="twitter:domain" content="${base_url}crowdfunding-ebook" />
	<meta property="twitter:description" content="Free ebooks to help you with best practices, fundraising trends and more. " />
	<meta property="twitter:image" content="//s3.amazonaws.com/crowdera/project-images/9dd48f64-4cf0-4550-8519-ed06166eff09.jpg" />
	<meta property="twitter:url" content="${base_url}crowdfunding-ebook" />
</head>
<body>
	<div class="TW-ebook-body">
		<div class="TW-ebook-header-image">
	 		<img alt="The crowdfunding ebook for success " src="//s3.amazonaws.com/crowdera/assets/ebook-header-full.jpg">
		</div>
		<div id="sticky-header"></div>
		<div class="TW-ebook-header">
		    <g:hiddenField name="fbShareUrl" id="fbShareUrl" value="${ebookUrl}"/>
  		    <a id="downloadEbook" class="btn btn-info" <g:if test='${user}'>href="//s3.amazonaws.com/crowdera/assets/crowdera%20ebook-your%20go%20to%20guide%20for%20crowdfunding%20success.pdf"</g:if><g:else>data-target="#ebookModal" data-toggle="modal"</g:else>>Download E-book</a>
  		    <div class="TW-socialicons">
		       <a id="fbshare" class="fb-like pull-left" target="_blank" href="http://www.facebook.com/sharer/sharer.php?s=100&amp;p[url]=${ebookUrl}">
		           <img alt="Facebook Share" src="//s3.amazonaws.com/crowdera/assets/contribution-fb-share.png">
		        </a>
		        <a class="twitter-share pull-left" href="https://twitter.com/intent/tweet?text=The%20crowdfunding%20ebook%20for%20success&url=${ebookUrl}" id="twitterShare" target="_blank">
			   <img alt="Twitter Share" src="//s3.amazonaws.com/crowdera/assets/contribution-twitter-share.png">
		        </a>
			<a onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;" id="share-linkedin" target="_blank" href="https://www.linkedin.com/cws/share?url=${ebookUrl}" class="share-linkedin pull-left">
			    <img alt="LinkedIn Share" src="//s3.amazonaws.com/crowdera/assets/contribution-linked-in-share.png">
			</a>
			<a onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;" href="https://plus.google.com/share?url=${ebookUrl}" id="googlePlusShare" class="google-plus-share pull-left">
			    <img alt="Google+ Share" src="//s3.amazonaws.com/crowdera/assets/contribution-google-plus-share.png">
			</a>
  		    </div>
 		</div>
 		
 		<div class="container">
  			<div class="ebook-container">
  				<div class="row">
  					<div class="TW-page-container">
	  					<div class="col-lg-12 TW-pre-launch TW-ebook-page-borders">
	  						<div class="pull-right ebook-page-title"><h3>Pre launch</h3></div>
	  						<div class="TW-ebook-content">
		  						<ul class="TW-ebook-ul ">
		  							<li>The first step to successful crowdfunding is &ndash;Ideation! Crowdfunding is no easy feat and
									now that you are planning a campaign to fund your cause, make sure to check out our
									FAQs page, How It Works page, and Ebook to learn everything you need to know to have
									a successful campaign!</li>
	            				</ul>
	            				<div class="TW-Prelaunch-img ">
	            					<img src="https://s3.amazonaws.com/crowdera/assets/ebook-pre-launch.jpg" alt="Pre launch" class="img-responsive pull-left">
	            				</div>
	  							<ul class="TW-ebook-ul">
			  						<li>Still have more questions? Reach out to our Crowdfunding Champion for advice and to
									sort all of your doubts. We will respond promptly with advice specific to your campaign!</li>
									<li>If this is your first campaign, research some similar campaigns to gain inspiration to
									write your story and type of perks to offer.</li>
									<li>Constantly refer to our Crowdfunding questionnaire if you are looking for help. Remember to
									be your own critic as well as your own mentor.</li>
	  							</ul>
	  						</div>
							<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
							    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
							    <div  class="TW-ebook-footer-links">
							    	<g:if test="${currentEnv == 'production' || currentEnv=='development'}">
							    		<a href="https://gocrowdera.com">www.gocrowdera.com</a>
							    	</g:if>
							    	<g:elseif test="${currentEnv == 'prodIndia' || currentEnv=='development'}">
							    		<a href="https://crowdera.in">www.crowdera.in</a>
							    	</g:elseif>
							   </div>
							</div>
	  					</div>
	  			    </div>
	  			</div>
	  			<div class="TW-page-container">
	  			    <div class="col-lg-12 TW-setting-it-up TW-ebook-page-borders">
	  			        <div class="pull-right ebook-page-title"><h3>Setting it up</h3></div>
  					<div class="TW-settingItUp-img">
            				   <img src="https://s3.amazonaws.com/crowdera/assets/ebook-setting-it-up.jpg" alt="Setting it up" class="img-responsive pull-left">
	            			</div>
  					<div class="TW-ebook-content">
	  				    <ul class="TW-ebook-ul">
  					        <li>We recommend running your campaign for no less than 30 days. It takes time to engage
						your audience and gain insights about your contributors. If needed, you can utilize our
						flexible deadline to extend your campaign, but don't let your campaign drag on for too long</li>
					        <li>As most crowd funders come from within your social media outlets, email lists, friends and
						family, make sure to set your goal with your network in mind. Break your campaign down
						into pieces based off of the size of your network. For example, if you have a smaller network,
						try structuring your campaign into more attainable pieces suitable for your audience.</li>
					        <li>Invite team members to join you in your mission. With teams, you can divide your goals and
						efforts while strengthening each part of the campaign. Create a healthy competition
						amongst the teams as an extra mean of motivation.</li>
	  				    </ul>
  					</div>
  					<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
						<g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
						    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
						</g:if>
						<g:else>
						    <a href="https://crowdera.in">www.crowdera.in</a>
						</g:else>
					    </div>
					</div>	
				  </div>
	  			</div>
	  			<div class="TW-page-container">
	  			    <div class="col-lg-12 TW-setting-it-up TW-ebook-page-borders">
	  				<div class="pull-right ebook-page-title"><h3>Setting it up</h3></div>
	  				<div class="TW-ebook-content">
		  			    <ul class="TW-ebook-ul">
						<li>Get creative with your perks. Think outside of the box and add a personal touch to your
						perks. While basic perks such as organization t-shirts are great incentives, rewards that are
						more unique can engage your crowd well.</li>
						<li>Creating a campaign is just the beginning; running the campaign is all the hard work! It
						can be time consuming to maintain a campaign, so make sure you are prepared to spend
						a couple of hours every day promoting and tweaking it to perfection. Don't be afraid to
						make any big changes to your content if you believe what you currently have posted does
						not reflect your campaign progress!</li>
						<li>Make sure your contributors get all the information they need to make their decision about
						supporting your mission. This includes: the specifics of your crowdfunding goal, what is it
						you are trying to accomplish, and where will the funds be used.</li>
		  			    </ul>
		  			    <div class="TW-settingItUp-img2">
            					<img src="https://s3.amazonaws.com/crowdera/assets/ebook-project-&-desc.jpg" alt="Setting it up" class="img-responsive pull-left">
	            			    </div>
	  				</div>
	  				<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
					    	<g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
							    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
							</g:if>
							<g:else>
							    <a href="https://crowdera.in">www.crowdera.in</a>
							</g:else>
					   </div>
					</div>
	  			    </div>
	  			</div>
	  			<div class="TW-page-container">
	  			    <div class="col-lg-12 TW-project-description TW-ebook-page-borders">
	  			        <div class="pull-right ebook-page-title"><h4>Project Description</h4></div>
	  				<div class="TW-ebook-content">
		  			    <div class="TW-projectDesc-img">
            					<img src="https://s3.amazonaws.com/crowdera/assets/ebook-projectdescription.jpg" alt="Project Description" class="img-responsive pull-left">
	            			    </div>
		  			    <ul class="TW-ebook-ul">
				  	        <li>Your title should be impactful and memorable, portraying the essence of your campaign.</li>
				  		<li>Tell your story in a clear and concise manner while showing your energy and enthusiasm!
						    Make sure your readers remain engaged throughout the entirety of your story. The average
						    campaign's total word count is 609; you don't want to make your text excessively long as
						    people will just begin to lose attention and interest.</li>
						<li>The vital information about your campaign should be put across first. People want to know why
						    this campaign is important to you and what it is that you are crowdfunding for. Don't make
						    them hunt for this information; serve it on a silver platter.</li>
						<li class="hidden-xs">If you can break down your project and provide a clear budget, contributors will be more
						    confident about your capability to manage your campaign.</li>
						<li class="hidden-xs">Display professionalism, motivation and creativity throughout your media outlets. Use images
						    or videos to introduce yourself and your mission - this is a great way to connect with your
						    contributors.</li>
						<li class="hidden-xs">Media content (such as pictures/videos/infographics) are becoming increasingly
						    popular as a substitute for large amounts of text. It has been proven that this medium
						    of content attracts more attention, which in turn increases the likelihood of gaining
						support.</li>
		  			    </ul>
		  			</div>
		  			<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
							<g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
							    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
							</g:if>
							<g:else>
							    <a href="https://crowdera.in">www.crowdera.in</a>
							</g:else>
					    </div>
					</div>
	  			    </div>
	  			</div>
	  			<div class="TW-page-container visible-xs hidden-sm hidden-md hidden-lg">
	  			    <div class="col-lg-12 TW-project-description TW-ebook-page-borders">
	  				<div class="pull-right ebook-page-title"><h4>Project Description</h4></div>
	  				<div class="TW-ebook-content">
		  			    <ul class="TW-ebook-ul">
						<li>If you can break down your project and provide a clear budget, contributors will be more
						confident about your capability to manage your campaign.</li>
						<li>Display professionalism, motivation and creativity throughout your media outlets. Use images
						or videos to introduce yourself and your mission - this is a great way to connect with your
						contributors.</li>
						<li>Media content (such as pictures/videos/infographics) are becoming increasingly
						popular as a substitute for large amounts of text. It has been proven that this medium
						of content attracts more attention, which in turn increases the likelihood of gaining
						support.</li>
		  			    </ul>
		  			</div>
		  			<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
							<g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
							    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
							</g:if>
							<g:else>
							    <a href="https://crowdera.in">www.crowdera.in</a>
							</g:else>
					    </div>
					</div>
	  			    </div>
	  			</div>
	  			<div class="TW-page-container">
	  			    <div class="col-lg-12 TW-perks TW-ebook-page-borders">
	  				<div class="pull-right ebook-page-title"><h3>Perks</h3></div>
	  				<div class="TW-ebook-content">
		  			    <div class="TW-perks-img">
            					<img src="https://s3.amazonaws.com/crowdera/assets/ebook-perks.jpg" alt="Perks" class="img-responsive pull-left">
	            			    </div>
		  			    <ul class="TW-ebook-ul">
				  		<li>Don't offer too many or too few perks. On average, 8 to 10 perks is enough. Make sure to
						offer different denominations, starting from as little as $10. Make your perks interesting so
						you can engage your contributors</li>
						<li>We can't emphasize enough on creativity of perks. Let them be unique and diverse, spend
						some time thinking about the perks you want to offer and make sure they align with your
						campaign's story and your organization. For example, if your campaign is about providing
						kids educational opportunities, one perk can be having a handwritten thank you card with a
						$10 donation.</li>
						<li class="hidden-xs">Perks are not restricted to just goods; you can also offer experiences or services to your
						contributors. Offer to spend some time with them, walk them through your organization and
						introduce them with people behind the scenes. Make your contributors feel special and part
						of your crowdfunding mission</li>
						<li class="hidden-xs">We do allow people to share their Twitter handle for a Twitter shout out. You can customize
						what information you require to fulfill the perk. Such perks are easier to fulfill and come at
						no cost to you! With a shout out or public mention, you can also attract the social network of
						your contributors.</li>
				  	    </ul>
				  	</div>
				  	<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
					    	<g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
							    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
							</g:if>
							<g:else>
							    <a href="https://crowdera.in">www.crowdera.in</a>
							</g:else>
					   </div>
					</div>
	  			    </div>
	  			</div>
	  			<div class="TW-page-container visible-xs hidden-sm hidden-md hidden-lg">
	  			    <div class="col-lg-12 TW-perks TW-ebook-page-borders">
	  			        <div class="pull-right ebook-page-title"><h3>Perks</h3></div>
	  				<div class="TW-ebook-content">
		  			    <ul class="TW-ebook-ul">
					        <li>Perks are not restricted to just goods; you can also offer experiences or services to your
					        contributors. Offer to spend some time with them, walk them through your organization and
					        introduce them with people behind the scenes. Make your contributors feel special and part
					        of your crowdfunding mission</li>
					        <li>We do allow people to share their Twitter handle for a Twitter shout out. You can customize
					        what information you require to fulfill the perk. Such perks are easier to fulfill and come at
					        no cost to you! With a shout out or public mention, you can also attract the social network of
					        your contributors.</li>
				  	    </ul>
				       </div>
				       <div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
					        <g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
							    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
							</g:if>
							<g:else>
							    <a href="https://crowdera.in">www.crowdera.in</a>
							</g:else>
					    </div>
				       </div>
	  			   </div>
	  		       </div>
				<div class="TW-page-container">
	  			    <div class="col-lg-12 TW-videos TW-ebook-page-borders">
	  			        <div class="pull-right ebook-page-title"><h3>Videos</h3></div>
	  				<div class="TW-ebook-content">
	  				    <div class="clearfix ebook-launch-container">
	  				        <img  class="pull-left gap-right img-responsive TW-ebooklaunch-img" alt="Launch Img" src="https://s3.amazonaws.com/crowdera/assets/ebook-video-img.jpg">
		  				<ul class="TW-postcampaign-inner-ul">
					  	    <li>People want to hear your ideas, one way to
							connect with them directly is to star in your
							video and have a pitch and ask.</li>
						    <li>Express yourself with a heartfelt message!
							Don't look animated and serious: make your
							audience laugh and try to ignite their
						        feelings.</li>
						</ul>
					    </div>
				  	    <ul class="TW-ebook-ul">
				  		<li>Keep your video 2 to 3 minutes long, if possible. Just long enough to get your message
						across. Using regional languages is helpful if you have a global audience but be sure to add
						subtitles for supporters who aren't familiar with that language!</li>
						<li>Your video can also be placed within the story. Utilize this functionality if you have more
						than one video to share.</li>
						<li class="hidden-xs">If you can make a video professionally, do it by all means. But don't get disheartened if
						you cannot. There are a lot of softwares you can use to edit videos taken with phones or
						laptops. (Tip – If you are using your phone to record, utilize natural light to shoot your
						video)</li>
						<li class="hidden-xs">Try to include a video along with your campaign launch. While you can definitely add more
						than one video later on as the campaign progresses, it is crucial to have a video supplement
						the text description from the beginning. That is when the video is most supportive as most
						people either chose to watch the video OR read the content.</li>
				  	    </ul>
				  	</div>
				  	<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
							<g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
							    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
							</g:if>
							<g:else>
							    <a href="https://crowdera.in">www.crowdera.in</a>
							</g:else>
					    </div>
					</div>
  				    </div>
  				</div>
  				<div class="TW-page-container visible-xs hidden-lg- hidden-md hidden-sm">
	  			    <div class="col-lg-12 TW-videos TW-ebook-page-borders">
	  			        <div class="pull-right ebook-page-title"><h3>Videos</h3></div>
	  				<div class="TW-ebook-content">
				  	    <ul class="TW-ebook-ul">
						<li>If you can make a video professionally, do it by all means. But don't get disheartened if
						you cannot. There are a lot of softwares you can use to edit videos taken with phones or
						laptops. (Tip – If you are using your phone to record, utilize natural light to shoot your
						video)</li>
						<li>Try to include a video along with your campaign launch. While you can definitely add more
						than one video later on as the campaign progresses, it is crucial to have a video supplement
						the text description from the beginning. That is when the video is most supportive as most
						people either chose to watch the video OR read the content.</li>
				  	    </ul>
				  	</div>
				  	<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
						<g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
						    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
						</g:if>
						<g:else>
						    <a href="https://crowdera.in">www.crowdera.in</a>
						</g:else>
					    </div>
					</div>
  				    </div>
  				</div>
  				<div class="TW-page-container">
	  			    <div class="col-lg-12 TW-launching-the-campaign TW-ebook-page-borders">
	  			        <div class="pull-right ebook-page-title"><h5>Launching the campaign</h5></div>
	  				<div class="TW-ebook-content">
		  			    <div class="clearfix ebook-launch-container">
		  				<img  class="pull-left gap-right img-responsive TW-ebooklaunch-img" alt="Launching the campaign" src="https://s3.amazonaws.com/crowdera/assets/ebook-launch-img.jpg">
						<ul class="TW-postcampaign-inner-ul">
					  	    <li>The first couple of days post launch are crucial. Once your campaign is
						        off to a great start, all you need to do is maintain the momentum. You
							can achieve this by continuing to post on your social media and
							updating the campaign progress to your supporters.</li>
						</ul>
					    </div>
				  	    <ul class="TW-ebook-ul">
						<li>We highly recommend informing all your supporters about your launch date and sharing the
						campaign with them, so that your campaign has a catalyst to start off well - even if the
						initial crowd is just family and friends!</li>
						<li>If you plan your campaign in advance, you get the opportunity to build your network.
						Whichever social media platform you are comfortable with, be it Facebook, LinkedIn, Twitter,
						Instagram or just building on your email lists and blogs, dedicate time to these efforts and
						grow your network before the launch.</li>
						<li>Treat your crowdfunding campaign as a product launch and create a buzz around it.
						Generate excitement around it with an online teaser, webinar or by holding a local event.
						Your aim is to spread the word and create anticipation for your campaign.</li>
						<li class="hidden-xs">Don't be afraid to preview and tease your campaign before it officially takes off. Building a
						mystery behind a launch attracts attention more often than not.</li>
				  	    </ul>
				  	</div>
				  	<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
					    	<g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
							    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
							</g:if>
							<g:else>
							    <a href="https://crowdera.in">www.crowdera.in</a>
							</g:else>
					   </div>
					</div>
	  			    </div>
	  			</div>
	  			<div class="TW-page-container">
	  			    <div class="col-lg-12 TW-social-media TW-ebook-page-borders">
	  			        <div class="pull-right ebook-page-title"><h3>Social media</h3></div>
	  				<div class="TW-ebook-content">
		  			    <div class="TW-social-media-img">
            			                <img src="https://s3.amazonaws.com/crowdera/assets/ebook-social-media.jpg" alt="Social Media" class="img-responsive pull-left">
	            			    </div>
		  			    <ul class="TW-ebook-ul">
				                <li>Keep a stack of images that you want to share on your social media outlets once your
						campaign is live. Make sure these images are different from the ones you have shared on
						your campaign.</li>
						<li>Not all your Social Media posts should ask people to contribute. Maintain diversity in your
						posts but make sure to include a link to your crowdfunding campaign at the end of the
						post.</li>
						<li>Post regularly! People who know you and have liked your individual or organization
						page are interested in what you are doing. They support your mission and want to hear
						from you.</li>	
						<li>We recommend planning your social media posts in advance. Spend some to put together
						some ideas and strategy around your social media sharing. Keep a calendar to schedule your
						posts and updates.</li>
		  			    </ul>
		  			</div>
		  			<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
					        <g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
							    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
							</g:if>
							<g:else>
							    <a href="https://crowdera.in">www.crowdera.in</a>
							</g:else>
					     </div>
					 </div>
	  			    </div>
	  			</div>
	  			<div class="TW-page-container">
	  			    <div class="col-lg-12 TW-pr-and-promotion TW-ebook-page-borders">
	  				<div class="pull-right ebook-page-title"><h4>PR and Promotion</h4></div>
	  				<div class="TW-ebook-content">
		  			    <div class="TW-prAndPromo-img">
            					<img src="https://s3.amazonaws.com/crowdera/assets/ebook-pr-and-promotion.jpg" alt="PR and Promotion" class="img-responsive pull-left">
	            			    </div>
		  			    <ul class="TW-ebook-ul">
				  		<li>Reach out to build a network of media and bloggers. Write a press release for the campaign
						or send a brief to bloggers who will be interested in sharing your story. Remember, it's for a
						commendable cause and most people will oblige. Get as much coverage as possible from
						various channels.</li>
						<li>Focus your PR to specific journalist and publications whose readers you believe will be
						interested in your campaign. There are many non-profit and social good publications you
						can target. Start early and build connections.</li>
						<li>Quality over quantity. That rule applies to journalists as well. Reach out to the journalists that
						have replied back and given you attention to build a consistent relationship with to boost
						your PR. It is more effective to consistently target 5 journalists rather than mass emailing the
						entirety of a publication.</li>
						<li>Don't forget to send an image with your PR. Images capture attention and increase the
						likelihood of your article to be picked up.</li>
				  	    </ul>
				  	</div>
				  	<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
						<g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
						    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
						</g:if>
						<g:else>
						    <a href="https://crowdera.in">www.crowdera.in</a>
						</g:else>
					     </div>
					</div>
	  			    </div>
	  			</div>
	  			<div class="TW-page-container">
	  			    <div class="col-lg-12 TW-creativity TW-ebook-page-borders">
	  				<div class="pull-right ebook-page-title"><h3>Creativity</h3></div>
	  				<div class="TW-ebook-content">
		  			    <div class="TW-creativity-img">
            				        <img src="https://s3.amazonaws.com/crowdera/assets/creativity.jpg" alt="Creativity" class="img-responsive pull-left">
	            			    </div>
		  			    <ul class="TW-ebook-ul">
			  		        <li>Let your creativity flow! Let each element of your campaign and everything associated
						    with it be imaginative and engaging.</li>
					        <li>It is a tough job to keep people engaged throughout your campaign but nonetheless an
						    important one. Try to stay motivated even if progress slow down and you have patchy
						    contributions coming in. Maintain communication with your contributors and target
						    audience at this time.</li>
						<li>Come up with innovative ideas to maintain engagement. You can post a thank you post on
						     social media each day tagging a contributor or tweeting to them. Keep adding videos to
						    your campaign as updates.</li>
						<li>Keep adding Team Members. You can phase out adding team members at different stages
						    of your campaign to make sure your campaign doesn't lose momentum at any point of
						    time.</li>
		  			    </ul>
		  			</div>
		  			<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
					        <g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
							    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
							</g:if>
							<g:else>
							    <a href="https://crowdera.in">www.crowdera.in</a>
							</g:else>
					    </div>
					</div>
	  			    </div>
	  			</div>
	  			<div class="TW-page-container">
				     <div class="col-lg-12 TW-post-campaigns TW-ebook-page-borders">
					<div class="pull-right ebook-page-title"><h4>Post Campaigns</h4></div>
					<div class="TW-ebook-content">
					    <div class="TW-postcmpgn-section1">
						<h3>Perks-Delivery</h3>
						<ul class="TW-postcampaign-ul">
						    <li>Be sure to prepare your perks before the campaign begins so that you can send them out on
							time. Its imperative that you honor the commitment you made to your contributors to build
							up their trust and loyalty. Don't forget x% of contributors are repeat contributors; they will
							are the ones who will support your next campaign.</li>
						    <li>Incase you cannot fulfill the perks on time, reach out to your contributors and acknowledge
							the delay. Communication is key. Anytime that you lose contact with your contributors,
							especially over a delay, then you will lose supporters and brand loyalty.</li>
						</ul>
					    </div>
					    <h3 class="TW-ebook-h3Decoration hidden-xs">Stay Connected with your supporters</h3>
					    <div class="clearfix hidden-xs">
					        <img  class="pull-left gap-right img-responsive TW-postcampaign-img"  alt="Post Campaign" src="https://s3.amazonaws.com/crowdera/assets/ebook-post-campaign.jpg">
							
					        <ul class="TW-postcampaign-inner-ul">
						    <li class="hidden-xs">You can get the emails of your contributors from your campaign dashboard,
							make sure you use the details to stay connected with them about your
							project and organization even after your campaign is over.</li>
						</ul>
					    </div>
					    <ul class="TW-postcampaign-ul hidden-xs">
					        <li>These are the people who believe in your cause and will be interested in supporting
						    you for life. Build the relationship.</li>
						<li>Keep your supporters updated at least weekly with your campaign's progress and what you
						    can do so far with the funds received.</li>
						<li>Use your updates to get your supporters to bring in people from their own networks to.</li>
					     </ul>
					 </div>
					 <div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					     <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					     <div  class="TW-ebook-footer-links">
					    	<g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
							    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
							</g:if>
							<g:else>
							    <a href="https://crowdera.in">www.crowdera.in</a>
							</g:else>
					     </div>
					  </div>
				    </div>
				</div>
				<div class="TW-page-container visible-xs">
				    <div class="col-lg-12 TW-post-campaigns TW-ebook-page-borders">
					<div class="pull-right ebook-page-title"><h4>Post Campaigns</h4></div>
					<div class="TW-ebook-content TW-postcmpgn-section1">
					    <h3 class="TW-ebook-h3Decoration">Stay Connected with your supporters</h3>
					    <div class="clearfix">
						<img  class="pull-left gap-right img-responsive TW-postcampaign-img" alt="Post Campaign" src="https://s3.amazonaws.com/crowdera/assets/ebook-post-campaign.jpg">
					    </div>
					    <ul class="TW-postcampaign-ul">
						<li>You can get the emails of your contributors from your campaign dashboard,
						make sure you use the details to stay connected with them about your
						project and organization even after your campaign is over.</li>
						<li>These are the people who believe in your cause and will be interested in supporting
						you for life. Build the relationship.</li>
						<li>Keep your supporters updated at least weekly with your campaign's progress and what you
						can do so far with the funds received.</li>
						<li>Use your updates to get your supporters to bring in people from their own networks to.</li>
					    </ul>
					</div>
					<div class="col-lg-offset-4 col-sm-offset-4 col-xs-offset-2 col-md-offset-4 TW-ebook-footer">
					    <img class="img-reponsive" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo-small.png" alt="Ebook footer logo">
					    <div  class="TW-ebook-footer-links">
						<g:if test="${currentEnv == 'production' || currentEnv == 'staging'|| currentEnv == 'test'|| currentEnv=='development'}">
						    <a href="https://gocrowdera.com">www.gocrowdera.com</a>
						</g:if>
						<g:else>
						    <a href="https://crowdera.in">www.crowdera.in</a>
						</g:else>
					    </div>
					</div>
				    </div>
				</div>	  		  				
  			    </div><!-- row -->
  		       </div>
  		  </div>
 		
  		<!-- *****************************************Modal start ********************************** -->
	    <div id="ebookModal" class="modal fade" role="dialog">
	        <g:form controller="home" action="getEbookEmail" class="ebookform" name="ebookForm">
	            <input type="hidden" name="userId" id="userId" <g:if test='${!user}'> value="3"</g:if><g:else>value="${user.id}"</g:else> > 
	            <div class="modal-dialog">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <button type="button" class="close" data-dismiss="modal">&times;</button>
	                        <h4 class="modal-title text-center"><b>Get your free ebook!</b></h4>
	                    </div>
	                    <div class="modal-body">
	                        <div class="row">
	                            <div class="col-sm-10 col-xs-8">
	                                <div class="form-group">
	                                    <input type="text" class="form-control loginInput"  placeholder="Enter your email " id="ebookEmailInput" name="loginEmail"/>
	                                </div>
	                            </div>
	                            <div class="col-sm-2 col-xs-2">
	                                <button type="button" class="btn btn-info btn-sm addEbookEmail" id="addEmail">Add</button>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </g:form>
	    </div>
  	    
		<!-- ******************************************Modal end************************************* -->
       </div><!-- Body -->
       <div id="ajaxRender"></div>
    </body>
</html>

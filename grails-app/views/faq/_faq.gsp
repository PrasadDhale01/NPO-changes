<g:set var="projectService" bean="projectService"/>
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
	def currentEnv = projectService.getCurrentEnvironment()
%>
<div class="container">
<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
    <div class="row footer-panel-group">
        <div class="col-lg-12">
            <h1 class="page-header">FAQs
                <small>Frequently Asked Questions</small>
            </h1>
        </div>
    </div>
    
    <div class="row footer-panel-group">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="panel-group" id="accordion">
                <h3 class="faq-subheading">General FAQs</h3>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">What is Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
			                    Crowdera is a newest crowdfunding platform that supports individuals and non-profit organizations 
			                    trying to make a social impact or do social innovation. Fundraisers can start their campaigns on 
			                    Crowdera and supporters can rally to fund those campaigns.</p>
		                    <p class="text-justify">Crowdera intents to complement organizations’ 
		                        existing fundraising and volunteering activities by offering a user-friendly 
		                        platform to create visually compelling, viral fundraising campaigns that raise awareness 
		                        and funding for an individual or organization’s needs and dreams.
		                    </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">What is Crowdfunding?</a>
                        </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
			                   Crowdfunding is a new way to fund projects from a large group of people, mainly via the Internet and social media. It helps individuals and organizations reach their financial goals by receiving and leveraging small contributions from many people.</p>
		                    <p class="text-justify">
			                    All you need is a simple need for funds to do something good, a funding goal and timeframe, some cool perks to promise people and show gratitude, and a crowd of family, friends, and fans / followers / customers to promote your campaign to.
		                    </p>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">Why Crowdfunding?</a>
                        </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Crowdfunding is for people or organizations who have no direct means to fund their initiatives that benefit the community or amplify their goals. Crowdera aims to bridge this gap and help organizations and individuals reach out to a wider audience to help and support them for their financial need. By crowdfunding online on Crowdera, organizations can connect and raise funds from people beyond geographies yet who relate to the cause. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFour">Who are the people that fund my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Your funders will consist of your existing supporters, volunteers, friends, family, fans and extended circle of friends on social network, or just call them all collectively ‘crowd’ who like your work  and believe in your cause or mission.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFive">Why will someone fund my campaign? Why will people contribute towards my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">People contribute towards campaigns they relate to or if they connect with a cause. They love what you are doing for the community and society at large. Contributing is their way of showing support for your campaign, organization and cause. So be ready to feel the love!</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSix">How does Crowdera work?</a>
                        </h4>
                    </div>
                    <div id="collapseSix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <ul>
			                    <li>Crowdera lets you build your fundraising campaign on its
				                    platform. You can set a fundraising goal, write an amazing story and
				                    add compelling photos and video.</li>
			                    <li>Once your campaign is validated, you can email the link to
				                    the Support Page of your campaign to friends, family, colleagues as
				                    well as post the link on your Social Media. The more people who know
				                    about your campaign, the more opportunities to help you reach your
				                    goal!</li>
			                    <li>You can share milestones, photos and updates easily through
				                    email and social media right from your campaign page.</li>
			                    <li>The funds are transferred to your approved Bank account within a week of end date. Your campaign ends once it reaches the campaign end date. Do more good and make your campaign a success with the funds you just raised!</li>
		                    </ul>
                        </div>
                    </div>
                </div>
                
                
            
                <h3 class="faq-subheading">Campaigns FAQs</h3>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSeven">What do I need to create a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseSeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <ul>
			                    <li>A compelling story</li>
			                    <li>Fundraising Goal</li>
			                    <li>The duration of campaign</li>
		                     	<li>Video (preferably with a pitch and ask)</li>
			                    <li>High Resolution photos - We can’t stress enough the
				                    importance of pictures. Pictures are a showcase to your work and
				                    cause. It helps people connect faster if they can see your work
				                    represented visually.</li>
		                    </ul>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseEight">Will Crowdera assist in creating the campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">Yes we do!</p>
		                     <ul>
			                     <li>We guide and provide feedback on the story, photos and video
				                     to make sure you create an appealing campaign.</li>
			                     <li>Crowdera also provides tips on crowdfunding and you can read
				                     more on our <a href="http://crowdera.tumblr.com">blog</a>.</li>
			                     <li>Provide recent information on what constitutes a successful
				                     crowdfunding campaign.</li>
			                     <li>If you need more assistance contact the Crowdera Crew.</li>
		                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseNine">How much does Crowdera charge?</a>
                        </h4>
                    </div>
                    <div id="collapseNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">We are a free platform to help you do more good. We do not charge a startup fee, no fee charged on funds raised and no hidden fees. However, please note that the payment gateway transaction fee and NEFT fee will be borne by the campaign owner. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTen">Why do I need to build a strong social network and share my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseTen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">We have noticed that the campaigns that can rally about 30% of the funding immediately upon launch have a higher success rate. Therefore, we recommend that the initial 30% funding comes from your existing network and supporters. It would be wise to share your campaign and have it funded by you inner network as soon as you create it and encourage them to share it on their social media as well.</p>
                        </div>
                    </div>
                </div>
 
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseEleven">Do I get to see my contributors and how much they contributed?</a>
                        </h4>
                    </div>
                    <div id="collapseEleven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes, you do. You have complete access to
			                    your campaign and check who contributed and how much by logging into
			                    your Crowdera account.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseforty">Can I offer perks?</a>
                        </h4>
                    </div>
                    <div id="collapseforty" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes you can! You can create your own perks as well.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwelve">Are perks mandatory?</a>
                        </h4>
                    </div>
                    <div id="collapseTwelve" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">No, perks are not mandatory.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseForteen">Can I edit my campaign after I submit it?</a>
                        </h4>
                    </div>
                    <div id="collapseForteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes you can edit certain sections of the campaign.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseForteens">Does Crowdera accept international payments?</a>
                        </h4>
                    </div>
                    <div id="collapseForteens" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Our payment gateway partner PayU Money, only accepts domestic payments.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFifteen">How will the funds be transferred?</a>
                        </h4>
                    </div>
                    <div id="collapseFifteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">The funds will be transferred biweekly. Once you campaign receives its first contribution, we will ask you for bank details. The payment will be made by Crowdera by NEFT transaction. NEFT transactions are secure transactions. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSixteen">What if I don’t meet my fundraising goal? Do I still get the funds?</a>
                        </h4>
                    </div>
                    <div id="collapseSixteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Crowdera believes that all effort put into
			                    the campaign deserves to be paid off. Therefore, all the funds raised
			                    go to you even if you do not meet your fund raising goal.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSeventeen">What if I raise more than my goal?</a>
                        </h4>
                    </div>
                    <div id="collapseSeventeen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">You keep it!</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseEighteen">Why don’t I see my campaign on Crowdera after submitting?</a>
                        </h4>
                    </div>
                    <div id="collapseEighteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">After submitting, the campaign go through an approval process. Once the campaign is approved it goes live.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseNineteens">What is the approval checklist or criteria for selection?</a>
                        </h4>
                    </div>
                    <div id="collapseNineteens" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Before approving a campaign, we go through all the details provided by you. We will contact you for any missing items or if we feel your campaign needs and can be enhanced. The checklist including but not limited to -</p>
                            <ul class="decimalList">
			                    <li>Cause - Is it a social good cause that aims to help the community</li>
			                    <li>Title - Whether your title is apt and conveys the essence of your campaign</li>
			                    <li>Description - Will the contributors understand your aim and the cause you raising funds for</li>
			                    <li>Story - Have you provided adequate information for the contributor to make his or her decision to contribute</li>
			                    <li>Social Reference - If you have provided details to your social media and whether you or your organization popular</li>
			                    <li>Website check - Whether the link to the website or Facebook page is working and related to your cause and/or belongs to you</li>
			                    <li>Founder/Management - How motivated and active is the founder and management of the campaign</li>
			                    <li>Feasibility - Is it feasible to achieve your goal in the stipulated time</li>
			                    <li>Images - Are the images high resolution and appropriate</li>
			                    <li>Video - A relevant video </li>
		                    </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseNineteen">What benefits does Crowdera offer?</a>
                        </h4>
                    </div>
                    <div id="collapseNineteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <ul class="decimalList">
			                    <li>Fundraising is FREE! Crowdera does not charge any fee, it’s free so do more good!</li>
			                    <li>TEAMS - You can form teams to rally your campaign.</li>
			                    <li>We help you multiply your impact by cloning your campaign
				                    for your teams. Your team works towards a common goal which
				                    helps you to get more attention from your team’s crowd</li>
			                    <li>We plan to engage corporate CSR $$ in the most unique fashion to help you reach your goals faster.</li>
			                    <li>We are adding some cool new features soon!</li>
		                    </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFortyOne">What is the minimum amount that I can raise through Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseFortyOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">There is no minimum funding goal to be on the platform.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyOne">What is the maximum amount that I can raise through Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
			                   The maximum funding goal is INR 99,999,999. If you would like to raise more, you may have to go through rigorous approval 
			                   process so we understand your need better and help you to be successful. In such
			                   case, please reach out to one of our crowdfunding experts from the
			                   team <a href="mailto:partnerships@crowdera.co">here</a> to evaluate your situation.
		                    </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyTwo">My campaign was rejected. How do I know the reason for rejection?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyTwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Please read the FAQ section thoroughly and also read our crowdfunding guidelines sections to understand the criterion of selection. If you feel you need more information, you can reach out to Crowdera Crew to find out why your campaign was rejected. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwenty">Who is responsible for delivering the perks?</a>
                        </h4>
                    </div>
                    <div id="collapseTwenty" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">The beneficiary / campaign creator is responsible for shipping the perks.</p>
                        </div>
                    </div>
                </div>
                
                
                <h3 class="faq-subheading">Contribution FAQs</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyThree">How much of the funds raised reach the creator?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">100% of the funds reach the campaign
			                    creator, however the payment gateway charges transaction fee to the
			                    campaign creator.</p>
                        </div>
                    </div>
                </div>
                
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyFour">Do I need to sign up to on Crowdera to contribute?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">No you do not need to sign up. You can
			                    contribute without signing up. However, we recommend you to signup
		                    	and track the progress of campaigns you have funded.</p>
                        </div>
                    </div>
                </div>
                
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyFive">What payment method do you provide?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">We have partnered with PayU Money as our payment gateway service. You can pay with any credit, debit card or net banking.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentySix">I do not wish to use online methods of payment. How do I offer offline contributions?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentySix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
			                    We do not entertain offline payments at this time. However, if you
			                    want to give a large grant to a project, you can reach out to one of
		                    	our partnership managers <a href="mailto:partnerships@crowdera.co">here</a>.
		                    </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentySixx">How do I know the authenticity of organization, individual creating the campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentySixx" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
			                   All campaigns go through an approval process. Even though Crowdera carefully goes through all the information prior to approving a campaign, we request contributors to conduct due diligence before contributing.
		                    </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentySeven">Is your site secure for online credit / debit card transactions?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentySeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
			                    Yes it is. Donations and Contributions are collected and processed by
			                    our third-party vendors pursuant to the terms and conditions of its
		                    	privacy policy, and we do not obtain access to any billing
			                    information with these transactions. For more information refer to -
			                    <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
		                    </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyEight">I got an error while making an online contribution. How will
			I know whether the transaction was successful?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">You can log into your PayU Money account to check the status of the transaction. PayU Money requires you to “Release Payment” once you have made a contribution. If you do not respond to the release payment request within 3 days, the payment is released anyway. 
                                                   Please read more on https://www.payumoney.com/faq_details.html?topic=buyer_inquiries
                            </p>
                        </div>
                    </div>
                </div>
                
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyNine">Why should I contribute through Crowdera instead of
			contributing directly?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <ul>
			                    <li>Crowdera is curated platform, we review every application
				                    for it’s content and story and approve at our discretion, if we feel
				                    mission of the project is aligned to make a social impact.</li>
			                    <li>Crowdera gives you diversity in terms of organizations and
				                    causes to fund.</li>
			                    <li>We encourage campaign creators to update you about the
				                    campaign as well as the organization.</li>
			                    <li>Funding through Crowdera, you know which campaign you are
				                    being part of and where your funds will be utilized.</li>
			                    <li>Many organization do not have the option of contributing online.</li>
		                    </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFortyTwo">What is the minimum amount for a fund?</a>
                        </h4>
                    </div>
                    <div id="collapseFortyTwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">You can contribute a minimum of Rs. 100.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirty">How can I cancel my contribution?</a>
                        </h4>
                    </div>
                    <div id="collapseThirty" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Please contact Crowdera Crew with 3 days of the transaction in case you need to cancel your contribution.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyOne">How do I know my funds have reached the beneficiary?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Crowdera ensures funds are transferred to the beneficiary bi weekly.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyTwo">How do I know that my contribution was utilized for the purpose?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyTwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">We encourage campaign creators to provide
			                    updates to their contributors. If you have any questions related to
			                    the campaigns please reach out to the campaign creator.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyThrees">I am not from India; how can I contribute to a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyThrees" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Unfortunately campaigns by Indian organizations and individuals that are shown in INR only accept Indian cards. Don’t get disheartened, you can contribute to Global campaigns, shown in USD, through PayPal or First Giving payment gateway chosen by our beneficiaries. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyFour">How safe is it to login using Facebook?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Please refer to the Personal Information section on our 
                                <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a> page.
		                    </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyFive">Is it possible to make anonymous contribution? Can I do so after being logged in?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes it is. You can make an anonymous contribution even after being logged in.</p>
                        </div>
                    </div>
                </div>
                
		
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtySix">Is it possible to make anonymous contribution? Can I do so after being logged in?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtySix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes it is. You can make an anonymous contribution even after being logged in.</p>
                        </div>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtySevens">Can I receive perks after donating anonymously?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtySevens" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes you can. You will need to provide.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtySeven">I have not received my perks, what do I do now?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtySeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Please contact the campaign creator.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyEight">Does my contribution amount show on Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Every contribution is displayed on
			                    Crowdera under the contribution tab. Your name, date and amount
			                    donated is displayed.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyNine">Do I get tax deductions on my contributions?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Not all contributions will be tax
			                    deductible. Contributions made to NGOs with a registered 80G (India)
			                    and 501 c 3 (USA) are tax deductible. We recommend you check the
			                    details of the organization and contact them with queries about tax
			                    deductions.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor1">How will I receive the perk I selected while funding a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>The campaign owner is responsible for disbursing the perks. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor2">I am not from the US, can I contribute to a campaign I wish?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor2" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, you can contribute to any campaign. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor3">I am not from India, can I contribute to a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Crowdera does not accept foreign contributions in India at the moment. But you can contribute on our global site crowdera.co</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor4">Can I contribute money to more than one campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor4" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, you can. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor5">Can I contribute anonymously for a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor5" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes you can. Just check the anonymous box that appears when you make a contribution. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor6">If I contribute anonymously and select perks will it be shipped to me?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor6" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, Campaign Owner can check the shipping details that you have provided while choosing a perk. Apart from Twitter Perks you can select all the perks if you contribute anonymously.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor7">What are the visibility options for contributions on Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor7" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Logged In User</p>
			                     <ul>
			                         <li>Name and Amount Visibility</li>
			                         <li>Name anonymous and Amount visible</li>
			                     </ul>
			                     <p>Non Logged in User</p>
			                     <ul>
			                         <li>Name and Amount Visibility</li>
			                         <li>Name anonymous and Amount visible</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor8">How can I share my contribution socially?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor8" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>After contributing to a campaign, you can use social icons to share your contribution socially.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor9">Where are individual Team Contribution  [Online + Offline] displayed ?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor9" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Under Teams Tab, Click on the Team’s Name. The contributions will be visible there. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor10">Do I need to create an account to contribute?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor10" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>No you don’t need an account to contribute.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor11">If I fund without logging in to crowdera, will my Name and Amount contributed be visible to all?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor11" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, we do ask for your name and email to send you a receipt and that name is displayed on the campaign. However, 
			                     if you don’t want your name to appear on the contribution page, choose to contribute as anonymous.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor12">I can not contribute online, but I wish to contribute for the cause.</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor12" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can contribute offline to Campaign Owners/Co-owners/Teams and they can record it as offline contribution. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor13">Where can I see my contribution details on the campaign I just supported?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor13" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can see your contribution details under the contribution tab on the campaign detail page. </p>
                        </div>
                    </div>
                </div>
                
                <h3 class="page-header">Campaign Creation and Management </h3>
                
                <div class="panel panel-default">
			          <div class="panel-heading">
			              <h4 class="panel-title">
			                  <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProOne">How do I register on Crowdera?</a>
			              </h4>
			          </div>
			          <div id="collapseProOne" class="panel-collapse collapse faq-panel-height">
			              <div class="panel-body">
			                  <p class="text-justify">Click  <a href="${resource(dir: 'login/register')}">here</a> to register.</p>
			              </div>
			          </div>
			    </div>
			    
			    <div class="panel panel-default">
			          <div class="panel-heading">
			              <h4 class="panel-title">
			                  <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTwo">How do I reset my password?</a>
			              </h4>
			          </div>
			          <div id="collapseProTwo" class="panel-collapse collapse faq-panel-height">
			              <div class="panel-body">
			                  <p class="text-justify">Click <a href="${resource(dir: 'login/edit_reset')}">here</a> to reset your password.</p>
			              </div>
			          </div>
			    </div>
			    
			    <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProThree">How can I update my profile?</a>
                        </h4>
                    </div>
                    <div id="collapseProThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">You can update your profile by following these steps:</p>
		                     <ul>
			                     <li>Log in to your Crowdera account.</li>
			                     <li>Click the dropdown on your username.</li>
			                     <li>Select Setting</li>
		                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProFour">Can I change my username after registration?</a>
                        </h4>
                    </div>
                    <div id="collapseProFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">You can change your username by following these steps:</p>
		                     <ul>
			                     <li>Log in to your Crowdera account.</li>
			                     <li>Click the dropdown on your username.</li>
			                     <li>Select Setting</li>
		                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProFive">How can I change my  password ?</a>
                        </h4>
                    </div>
                    <div id="collapseProFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">You can change your password by following these steps:</p>
		                     <ul>
			                     <li>Log in to your Crowdera account.</li>
			                     <li>Click the dropdown on your username.</li>
			                     <li>Select Setting</li>
		                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProSix">Where and how can I upload/edit my Avatar?</a>
                        </h4>
                    </div>
                    <div id="collapseProSix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">You can change your Avatar by following these steps:</p>
		                     <ul>
			                     <li>Log in to your Crowdera account.</li>
			                     <li>Click the dropdown on your username.</li>
			                     <li>Select Setting</li>
		                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProSevan">How can I subscribe to a Newsletter ?</a>
                        </h4>
                    </div>
                    <div id="collapseProSevan" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can subscribe for the Crowdera Newsletter on our site. Just scroll to the 
			                     bottom of the home page and provide us with your email! </p>
                        </div>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProEight">How can I contact Crowdera Team?</a>
                        </h4>
                    </div>
                    <div id="collapseProEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can contact us by using the  "<a href="${resource(dir: 'customer-service')}">Contact Us</a>" query.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProNine">Can I unsubscribe from Crowdera Emails?</a>
                        </h4>
                    </div>
                    <div id="collapseProNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>We’re sorry you want to unsubscribe but yes you can. 
			                     Click on unsubscribe link in the bottom of the email received from Crowdera.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Creating a campaign</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTen">Who can create a Campaign on Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseProTen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Individuals and/or Nonprofit Organizations that want to raise funds for Passion, Innovation, 
			                     Impact or Need can create a campaign on Crowdera.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenOne">What are the details I need to provide to receive contributions?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>To accept contributions, you will need an active and verified <b>PayPal</b>. For country specific PayPal restrictions refer to the following link: <a href="https://www.paypal.com/webapps/mpp/country-worldwide" data-target="_blank">https://www.paypal.com/webapps/mpp/country-worldwide</a></p>
			                     <p>Nonprofit Organizations in the <b>USA</b> can also select <b>First Giving</b> as their choice of Payment Gateway.</p>
			                     <h4><b>India</b></h4>
			                     <p>You need to provide your bank details and will receive their funds via NEFT transaction at the end of their campaign. 
			                     To fill in your bank details follow these steps:</p>
			                     <ul>
				                     <li>Sign in to your Crowdera Account</li>
				                     <li>Select “My Campaigns” from the dropdown under your username</li>
				                     <li>Click on the campaign </li>
				                     <li>Go to Payments and provide your information</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenThree">How do I create my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can start creating your campaign <g:link controller="project" action="create">here</g:link>. Please refer to our Ebook for more crowdfunding guidelines. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenFour">Do I have to create a campaign in one go?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>No. You can save the information as draft and complete it whenever you wish.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenFive">My campaign is saved as a draft, what should I do next?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can edit the campaign or submit it for validation.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenSix">Who is an Owner?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenSix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>The person who creates a campaign is the Campaign Owner.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenSevan">Who is Co-Owner?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenSevan" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>People who are nominated by a Campaign Owner to work for a campaign are Co-owners.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenEight">I am an Owner how can I nominate a Co-owner for my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can add co-owners under the Admin section when you create or edit your campaign.You can add upto 3 co-owners.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Image</h3>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenNine">How many images can I upload?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Multiple images can be added but we recommend including not more than 3 or 4 images. </p>
                        </div>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTen">What is size and format accepted?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>The image should be less than 3 MB and have an aspect ratio of 3:2 (width major). Formats acceptable are jpg and png</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Perks</h3>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenOne">Can I create a perk after my campaign is live?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes you can create a perk even after a campaign is live by going to  “Perks” under “My Campaigns”.</p>
                        </div>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTentwo">Can I edit or delete a perk after my campaign is live?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTentwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can edit or delete a perk only if has not been selected by a contributor.</p> 
			                     <P> Once a perk has been selected, it cannot be edited or deleted.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Duration </h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenThree">I have set the campaign duration for 60 days, from when will the countdown start?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>The campaign countdown starts once the campaign is validated by Crowdera Administrator.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenFour">What is the maximum duration of a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>The maximum duration is 90 days. However, you can reach out to the Crowdera Team to extend your deadline.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenFive">Can I extend my deadline?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Deadline can be extended if the cause is genuine and verified by our Team.</p>
                        </div>
                    </div>
                </div>
                
                 <h3 class="faq-subheading">Co-owners/Co-creators  </h3>
                 
                  <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenSix">How many co-creators can I nominate for my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenSix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can nominate maximum of 3 co-owners for a campaign.</p>
                        </div>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenSaven">I have received an invitation for being a co-creator of a campaign, what should I do next?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenSaven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>To access the campaign:</p>
			                     <ul>
			                         <li><a href="${resource(dir: 'login/register')}">Register</a> / <a href="${resource(dir: 'login/auth')}"> Login </a> on Crowdera</li>
			                         <li>Click on the dropdown under Username</li>
			                         <li>Click on My Campaigns</li>
			                         <li>You should be able to see the campaign there</li>
			                     
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenEight">What are the rights of a co-owner?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>A co-owner can</p>
			                     <ul>
			                         <li>Validate team requests</li>
			                         <li>Enable/disable teams </li>
			                         <li>Edit campaign </li>
			                         <li>Edit team details</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Validation</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenNine">I have already submitted my campaign, then why does it show “Pending” ?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Pending banner indicates your campaign is still being verified by the administrator.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Campaign Updates </h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate1">Who can create an update for a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Campaign Owner/ Co-owner can create updates for a campaign.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate2">How many images can I upload with the update?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate2" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can upload multiple images but recommend not adding more that 3. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate3">Who will receive my campaign updates?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Your contributors, teams and those who have chosen to follow your campaign will receive an email about your latest updates.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate4">How do I edit my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate4" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Access your campaign from My Campaigns. On the right side of the page you will see the display picture of your campaign, the edit option is under that section. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate5">Can I hide the comments on my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate5" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Campaign Owner/Co-owner can enable/disable the campaign comments.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate6">Can I delete a live campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate6" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can not delete a live campaign. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContri1">Can I export my contribution report?</a>
                        </h4>
                    </div>
                    <div id="collapseProContri1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes. You can download the CSV report from the “Contribution” tab on the Manage Campaign page.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContri3">Can I edit the name & amount of the online contribution?</a>
                        </h4>
                    </div>
                    <div id="collapseProContri3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>No, as the online contributions are made via a Payment Gateway, they cannot be edited. </p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Teams </h3>
                 
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams1">Who is a Team?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>A Team owner is a person who helps you rally your campaign.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams2">How can I Invite my friend to be  a Team for my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams2" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <ul>
			                         <li>Log into your Crowdera Account </li>
			                         <li>Go to My Campaigns </li>
			                         <li>Select the campaign</li>
			                         <li>Click on the Activity</li>
			                         <li>Select Invite Members</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams3">How can someone join as a Team for a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>It’s simple, they go to the campaign detail page via Discover, click on “Teams” and hit Join Us! </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams4">Who can Validate/ Discard  a Team request?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams4" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Owner/ Co-owner have the authority to validate or discard a team request. Follow these steps: </p>
			                     <ul>
			                         <li>Log into your Crowdera Account </li>
			                         <li>Go to My Campaigns </li>
			                         <li>Select the campaign</li>
			                         <li>Click on the Activity</li>
			                         <li>Select Validate/Discard Team</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams5">Can I disable/enable an  existing Team of my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams5" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes you can disable an existing team by following these steps. </p>
			                     <ul>
			                         <li>Log into your Crowdera Account </li>
			                         <li>Go to My Campaigns </li>
			                         <li>Select the campaign</li>
			                         <li>Click on the Activity</li>
			                         <li>Select Validate/Discard Team</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams6">Who can enable/disable a Team?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams6" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Only Owner/Co-owners can enable/disable a team.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams7">I am Owner/Co-owner can I edit a Team’s fundraiser?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams7" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, you can edit a Team’s fundraiser page. To edit a Team’s fundraiser go to Teams page from Manage Campaign, 
			                     select the Team member whose page you want to edit. Now you will be on their fundraiser, go to Teams and click on Activity dropdown. 
			                     You will see edit fundraiser.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams8">Can I comment specifically on a Team’s fundraiser?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams8" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, you can comment on a Team’s individual fundraiser.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams9">How can I share my campaign on social media?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams9" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Access your campaign through the Discover page. Under the images displayed you will find all the necessary social media tools.
			                      Crowdera also provides a short link to your campaign that can be used to share your campaign on social media.</p>
                        </div>
                    </div>
                </div> 
                
                <h3 class="faq-subheading">Contributor</h3>
                 
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor1">How will I receive the perk I selected while funding a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>The campaign owner is responsible for disbursing the perks. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor2">I am not from the US, can I contribute to a campaign I wish?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor2" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, you can contribute to any campaign. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor3">I am not from India, can I contribute to a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Crowdera does not accept foreign contributions in India at the moment. But you can contribute on our global site crowdera.co</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor4">Can I contribute money to more than one campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor4" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, you can. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor5">Can I contribute anonymously for a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor5" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes you can. Just check the anonymous box that appears when you make a contribution. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor6">If I contribute anonymously and select perks will it be shipped to me?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor6" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, Campaign Owner can check the shipping details that you have provided while choosing a perk. Apart from Twitter Perks you can select all the perks if you contribute anonymously.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor7">What are the visibility options for contributions on Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor7" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Logged In User</p>
			                     <ul>
			                         <li>Name and Amount Visibility</li>
			                         <li>Name anonymous and Amount visible</li>
			                     </ul>
			                     <p>Non Logged in User</p>
			                     <ul>
			                         <li>Name and Amount Visibility</li>
			                         <li>Name anonymous and Amount visible</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor8">How can I share my contribution socially?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor8" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>After contributing to a campaign, you can use social icons to share your contribution socially.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor9">Where are individual Team Contribution  [Online + Offline] displayed ?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor9" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Under Teams Tab, Click on the Team’s Name. The contributions will be visible there. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor10">Do I need to create an account to contribute?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor10" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>No you don’t need an account to contribute.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor11">If I fund without logging in to crowdera, will my Name and Amount contributed be visible to all?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor11" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, we do ask for your name and email to send you a receipt and that name is displayed on the campaign. However, 
			                     if you don’t want your name to appear on the contribution page, choose to contribute as anonymous.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor12">I can not contribute online, but I wish to contribute for the cause.</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor12" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can contribute offline to Campaign Owners/Co-owners/Teams and they can record it as offline contribution. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor13">Where can I see my contribution details on the campaign I just supported?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor13" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can see your contribution details under the contribution tab on the campaign detail page. </p>
                        </div>
                    </div>
                </div> 
                
                
            </div>
        </div>
    </div>       
</g:if>
<g:else>
    <div class="row footer-panel-group">
        <div class="col-lg-12">
            <h1 class="page-header">FAQs
                <small>Frequently Asked Questions</small>
            </h1>
        </div>
    </div>
    
    <div class="row footer-panel-group">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="panel-group" id="accordion">
                <h3 class="faq-subheading">General FAQs</h3>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">What is Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
			                    Crowdera is a newest crowdfunding platform that supports individuals
			                    and non-profit organizations trying to make a social impact or do
			                    social innovation. Fundraisers can start their campaigns on Crowdera
			                    and supporters can rally to fund those campaigns.</p>
		                    <p class="text-justify"> Crowdera intents to complement organizations’ existing fundraising and
			                    volunteering activities by offering a user-friendly platform to
			                    create visually compelling, viral fundraising campaigns that raise
			                    awareness and funding for an individual or organization’s needs and
			                    dreams.
		                    </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">What is Crowdfunding?</a>
                        </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
			                    Crowdfunding is a new way to fund projects from a large group of
			                    people, mainly via the Internet and social media. It helps
			                    individuals and organizations reach their financial goals by
			                    receiving and leveraging small contributions from many people.</p>
		                    <p class="text-justify">
			                    All you need is a simple need for funds to do something good, a
			                    funding goal and timeframe, some cool rewards to promise people and
			                    show gratitude, and a crowd of family, friends, and fans / followers
			                    / customers to promote your campaign to.
		                    </p>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">Why Crowdfunding?</a>
                        </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Crowdfunding is for people or
			                organizations who have no direct means to fund their initiatives that
			                benefit the community or amplify their goals. Crowdera aims to bridge
			                this gap and help organizations and individuals reach out to a wider
			                audience to help and support them for their financial need. By
			                crowdfunding online on Crowdera, organizations can connect and raise
			                funds from people beyond geographies yet who relate to the cause.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFour">Who are the people that fund my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Your funders will consist of your existing
			                supporters, volunteers, friends, family, fans and extended circle of
			                friends on social network, or just call them all collectively ‘crowd’
			                who like your work and believe in your cause or mission.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFive">Why will someone fund my campaign? Why will people contribute towards my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">People contribute towards campaigns they
			                 relate to or if they connect with a cause. They love what you are
			                 doing for the community and society at large. Contributing is their
			                 way of showing support for your campaign, organization and cause. So
			                 be ready to feel the love!</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSix">How does Crowdera work?</a>
                        </h4>
                    </div>
                    <div id="collapseSix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <ul>
			                    <li>Crowdera lets you build your fundraising campaign on its
				                    platform. You can set a fundraising goal, write an amazing story and
				                    add compelling photos and video.</li>
			                    <li>Once your campaign is validated, you can email the link to
				                    the Support Page of your campaign to friends, family, colleagues as
				                    well as post the link on your Social Media. The more people who know
				                    about your campaign, the more opportunities to help you reach your
				                    goal!</li>
			                    <li>You can share milestones, photos and updates easily through
				                    email and social media right from your campaign page.</li>
			                    <li>Your campaign ends once it reaches the campaign end date
				                    and the funds raised are transfered to you. Do more good and make
				                    your campaign a success with the funds you just raised!</li>
		                    </ul>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Campaigns FAQs</h3>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSeven">What do I need to create a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseSeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <ul>
			                    <li>A compelling story</li>
			                    <li>Fundraising Goal</li>
			                    <li>The duration of campaign</li>
		                     	<li>Video (preferably with a pitch and ask)</li>
			                    <li>High Resolution photos - We can’t stress enough the
				                    importance of pictures. Pictures are a showcase to your work and
				                    cause. It helps people connect faster if they can see your work
				                    represented visually.</li>
		                    </ul>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseEight">Will Crowdera assist in creating the campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">Yes we do!</p>
		                     <ul>
			                     <li>We guide and provide feedback on the story, photos and video
				                     to make sure you create an appealing campaign.</li>
			                     <li>Crowdera also provides tips on crowdfunding and you can read
				                     more on our <a href="http://crowdera.tumblr.com">blog</a>.</li>
			                     <li>Provide recent information on what constitutes a successful
				                     crowdfunding campaign.</li>
			                     <li>If you need more assistance contact the Crowdera Crew.</li>
		                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseNine">How much does Crowdera charge?</a>
                        </h4>
                    </div>
                    <div id="collapseNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">We are a free platform to help you do more
			                    good. We do not charge a startup fee, no fee charged on funds raised
			                    and no hidden fees. However, please note that the payment gateway
			                    (FirstGiving or PayPal) will charge a transaction fee.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTen">Why do I need to build a strong social network and share my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseTen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">We have noticed that the campaigns that
			                    can rally about 30% of the funding immediately upon launch have a
		                    	higher success rate. Therefore, we recommend that the initial 30%
			                    funding comes from your existing network and supporters. It would be
			                    wise to share your campaign and have it funded by you inner network
			                    as soon as you create it and encourage them to share it on their
			                    social media as well.</p>
                        </div>
                    </div>
                </div>
 
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseEleven">Do I get to see my contributors and how much they contributed?</a>
                        </h4>
                    </div>
                    <div id="collapseEleven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes, you do. You have complete access to
			                    your campaign and check who contributed and how much by logging into
			                    your Crowdera account.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseforty">Can I offer rewards?</a>
                        </h4>
                    </div>
                    <div id="collapseforty" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes you can! You can create your own rewards as well.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwelve">Are rewards mandatory?</a>
                        </h4>
                    </div>
                    <div id="collapseTwelve" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">No, rewards are not mandatory.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseForteen">Can I edit my campaign after I submit it?</a>
                        </h4>
                    </div>
                    <div id="collapseForteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes you can edit certain sections of the campaign.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFifteen">How will the funds be transferred?</a>
                        </h4>
                    </div>
                    <div id="collapseFifteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Crowdera ensures complete transparency,
			                    therefore the funds will be transferred directly into your account
			                    associated with the payment gateway you choose while creating a
			                    campaign. At no point of time will we hold the funds.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSixteen">What if I don’t meet my fundraising goal? Do I still get the funds?</a>
                        </h4>
                    </div>
                    <div id="collapseSixteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Crowdera believes that all effort put into
			                    the campaign deserves to be paid off. Therefore, all the funds raised
			                    go to you even if you do not meet your fund raising goal.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSeventeen">What if I raise more than my goal?</a>
                        </h4>
                    </div>
                    <div id="collapseSeventeen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">You keep it!</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseEighteen">Why don’t I see my campaign on Crowdera after submitting?</a>
                        </h4>
                    </div>
                    <div id="collapseEighteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">After submitting, the campaign go through an approval process. Once the campaign is approved it goes live.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseNineteen">What benefits does Crowdera offer?</a>
                        </h4>
                    </div>
                    <div id="collapseNineteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <ul class="decimalList">
			                    <li>Fundraising is FREE! Crowdera does not charge any fee, it’s free so do more good!</li>
			                    <li>TEAMS - You can form teams to rally your campaign.</li>
			                    <li>We help you multiply your impact by cloning your campaign
				                    for your teams. Your team works towards a common goal which
				                    helps you to get more attention from your team’s crowd</li>
			                    <li>We plan to engage corporate CSR $$ in the most unique fashion to help you reach your goals faster.</li>
			                    <li>We are adding some cool new features soon!</li>
		                    </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFortyOne">What is the minimum amount that I can raise through Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseFortyOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">There is no minimum funding goal to be on the platform.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyOne">What is the maximum amount that I can raise through Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
			                    The maximum funding goal is $100,000. If you would like to raise
			                    more, you may have to go through rigorous approval process so we
			                    understand your need better and help you to be successful. In such
			                    case, please reach out to one of our crowdfunding experts from the
			                    team <a href="mailto:partnerships@crowdera.co">here</a> to evaluate your situation.
		                    </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyTwo">My campaign was rejected. How do I know the reason for rejection?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyTwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Please read the FAQ section thoroughly and also read our crowdfunding
		                        guidelines sections to understand the criterion of selection. If you feel you need more information, 
		                        you can reach out to our <a href="mailto:hello@crowdera.co">customer support</a>  to find out why your campaign was rejected.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwenty">Who is responsible for delivering the rewards?</a>
                        </h4>
                    </div>
                    <div id="collapseTwenty" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">The beneficiary / campaign creator is responsible for shipping the rewards.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Contribution FAQs</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyThree">How much of the funds raised reach the creator?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">100% of the funds reach the campaign
			                    creator, however the payment gateway charges transaction fee to the
			                    campaign creator.</p>
                        </div>
                    </div>
                </div>
                
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyFour">Do I need to sign up to contribute?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">No you do not need to sign up. You can
			                    contribute without signing up. However, we recommend you to signup
		                    	and track the progress of campaigns you have funded.</p>
                        </div>
                    </div>
                </div>
                
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyFive">What payment method do you provide?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">We have partnered with PayPal and
			                    FirstGiving as our payment gateway services, Campaign creators can
			                    choose either of them for their campaigns. You can pay with any
			                    credit or debit cards.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentySix">I do not wish to use online methods of payment. How do I offer offline contributions?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentySix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
			                    We do not entertain offline payments at this time. However, if you
			                    want to give a large grant to a project, you can reach out to one of
		                    	our partnership managers <a href="mailto:partnerships@crowdera.co">here</a>.
		                    </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentySeven">Is your site secure for online credit / debit card transactions?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentySeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
			                    Yes it is. Donations and Contributions are collected and processed by
			                    our third-party vendors pursuant to the terms and conditions of its
		                    	privacy policy, and we do not obtain access to any billing
			                    information with these transactions. For more information refer to -
			                    <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
		                    </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyEight">I got an error while making an online contribution. How will
			I know whether the transaction was successful?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">If you have received an error while
			                    contributing, check your email for a payment confirmation from Paypal
			                    or FirstGiving. If you have not received a confirmation for your
			                    contribution your card has not been charged.</p>
                        </div>
                    </div>
                </div>
                
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyNine">Why should I contribute through Crowdera instead of
			contributing directly?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <ul>
			                    <li>Crowdera is curated platform, we review every application
				                    for it’s content and story and approve at our discretion, if we feel
				                    mission of the project is aligned to make a social impact.</li>
			                    <li>Crowdera gives you diversity in terms of organizations and
				                    causes to fund.</li>
			                    <li>We encourage campaign creators to update you about the
				                    campaign as well as the organization.</li>
			                    <li>Funding through Crowdera, you know which campaign you are
				                    being part of and where your funds will be utilized.</li>
			                    <li>Many organization do not have the option of contributing online.</li>
		                    </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFortyTwo">What is the minimum amount for a fund?</a>
                        </h4>
                    </div>
                    <div id="collapseFortyTwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">You can contribute a minimum of $1.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirty">How can I cancel my contribution?</a>
                        </h4>
                    </div>
                    <div id="collapseThirty" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Crowdera doesn’t hold the payments and
			                    money is directly transferred to the beneficiary’s account. You may
			                    cancel the transaction by directly reaching out the beneficiaries.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyOne">How do I know my funds have reached the beneficiary?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Crowdera ensures that all the funds are
			                    directed from the Payment Gateway directly to the
			                    organization/beneficiary. You can be assured that your funds have
		                    	reached the organization as the funds do not go through multiple
			                hands.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyTwo">How do I know that my contribution was utilized for the purpose?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyTwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">We encourage campaign creators to provide
			                    updates to their contributors. If you have any questions related to
			                    the campaigns please reach out to the campaign creator.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyThree">I am an International contributor. Can I still contribute to the cause?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">PayPal and FirstGiving allows transaction
			                    in US Dollars from all non-restricted countries where PayPal and
			                    FirstGiving operates.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyFour">How safe is it to login using Facebook?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Please refer to the Personal Information section on our 
                                <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a> page.
		                    </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyFive">Is it possible to make anonymous contribution? Can I do so after being logged in?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes it is. You can make an anonymous contribution even after being logged in.</p>
                        </div>
                    </div>
                </div>
                
		
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtySix">Can I receive rewards after donating anonymously?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtySix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes you can.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtySeven">I have not received my rewards, what do I do now?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtySeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Please contact the campaign creator.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyEight">Does my contribution amount show on Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Every contribution is displayed on
			                    Crowdera under the contribution tab. Your name, date and amount
			                    donated is displayed.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtyNine">Do I get tax deductions on my contributions?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtyNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Not all contributions will be tax
			                    deductible. Contributions made to NGOs with a registered 80G (India)
			                    and 501 c 3 (USA) are tax deductible. We recommend you check the
			                    details of the organization and contact them with queries about tax
			                    deductions.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor1">How will I receive the perk I selected while funding a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>The campaign owner is responsible for disbursing the perks. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor2">I am not from the US, can I contribute to a campaign I wish?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor2" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, you can contribute to any campaign. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor3">I am not from India, can I contribute to a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Crowdera does not accept foreign contributions in India at the moment. But you can contribute on our global site crowdera.co</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor4">Can I contribute money to more than one campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor4" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, you can. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor5">Can I contribute anonymously for a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor5" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes you can. Just check the anonymous box that appears when you make a contribution. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor6">If I contribute anonymously and select perks will it be shipped to me?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor6" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, Campaign Owner can check the shipping details that you have provided while choosing a perk. Apart from Twitter Perks you can select all the perks if you contribute anonymously.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor7">What are the visibility options for contributions on Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor7" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Logged In User</p>
			                     <ul>
			                         <li>Name and Amount Visibility</li>
			                         <li>Name anonymous and Amount visible</li>
			                     </ul>
			                     <p>Non Logged in User</p>
			                     <ul>
			                         <li>Name and Amount Visibility</li>
			                         <li>Name anonymous and Amount visible</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor8">How can I share my contribution socially?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor8" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>After contributing to a campaign, you can use social icons to share your contribution socially.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor9">Where are individual Team Contribution  [Online + Offline] displayed ?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor9" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Under Teams Tab, Click on the Team’s Name. The contributions will be visible there. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor10">Do I need to create an account to contribute?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor10" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>No you don’t need an account to contribute.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor11">If I fund without logging in to crowdera, will my Name and Amount contributed be visible to all?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor11" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, we do ask for your name and email to send you a receipt and that name is displayed on the campaign. However, 
			                     if you don’t want your name to appear on the contribution page, choose to contribute as anonymous.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor12">I can not contribute online, but I wish to contribute for the cause.</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor12" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can contribute offline to Campaign Owners/Co-owners/Teams and they can record it as offline contribution. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor13">Where can I see my contribution details on the campaign I just supported?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor13" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can see your contribution details under the contribution tab on the campaign detail page. </p>
                        </div>
                    </div>
                </div>
                
                
                <h3 class="page-header">Campaign Creation and Management </h3>
                
                <div class="panel panel-default">
			          <div class="panel-heading">
			              <h4 class="panel-title">
			                  <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProOne">How do I register on Crowdera?</a>
			              </h4>
			          </div>
			          <div id="collapseProOne" class="panel-collapse collapse faq-panel-height">
			              <div class="panel-body">
			                  <p class="text-justify">Click  <a href="${resource(dir: 'login/register')}">here</a> to register.</p>
			              </div>
			          </div>
			    </div>
			    
			    <div class="panel panel-default">
			          <div class="panel-heading">
			              <h4 class="panel-title">
			                  <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTwo">How do I reset my password?</a>
			              </h4>
			          </div>
			          <div id="collapseProTwo" class="panel-collapse collapse faq-panel-height">
			              <div class="panel-body">
			                  <p class="text-justify">Click <a href="${resource(dir: 'login/edit_reset')}">here</a> to reset your password.</p>
			              </div>
			          </div>
			    </div>
			    
			    <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProThree">How can I update my profile?</a>
                        </h4>
                    </div>
                    <div id="collapseProThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">You can update your profile by following these steps:</p>
		                     <ul>
			                     <li>Log in to your Crowdera account.</li>
			                     <li>Click the dropdown on your username.</li>
			                     <li>Select Setting</li>
		                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProFour">Can I change my username after registration?</a>
                        </h4>
                    </div>
                    <div id="collapseProFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">You can change your username by following these steps:</p>
		                     <ul>
			                     <li>Log in to your Crowdera account.</li>
			                     <li>Click the dropdown on your username.</li>
			                     <li>Select Setting</li>
		                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProFive">How can I change my  password ?</a>
                        </h4>
                    </div>
                    <div id="collapseProFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">You can change your password by following these steps:</p>
		                     <ul>
			                     <li>Log in to your Crowdera account.</li>
			                     <li>Click the dropdown on your username.</li>
			                     <li>Select Setting</li>
		                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProSix">Where and how can I upload/edit my Avatar?</a>
                        </h4>
                    </div>
                    <div id="collapseProSix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">You can change your Avatar by following these steps:</p>
		                     <ul>
			                     <li>Log in to your Crowdera account.</li>
			                     <li>Click the dropdown on your username.</li>
			                     <li>Select Setting</li>
		                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProSevan">How can I subscribe to a Newsletter ?</a>
                        </h4>
                    </div>
                    <div id="collapseProSevan" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can subscribe for the Crowdera Newsletter on our site. Just scroll to the 
			                     bottom of the home page and provide us with your email! </p>
                        </div>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProEight">How can I contact Crowdera Team?</a>
                        </h4>
                    </div>
                    <div id="collapseProEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can contact us by using the  "<a href="${resource(dir: 'customer-service')}">Contact Us</a>" query.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProNine">Can I unsubscribe from Crowdera Emails?</a>
                        </h4>
                    </div>
                    <div id="collapseProNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>We’re sorry you want to unsubscribe but yes you can. 
			                     Click on unsubscribe link in the bottom of the email received from Crowdera.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Creating a campaign</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTen">Who can create a Campaign on Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapseProTen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Individuals and/or Nonprofit Organizations that want to raise funds for Passion, Innovation, 
			                     Impact or Need can create a campaign on Crowdera.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenOne">What are the details I need to provide to receive contributions?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>To accept contributions, you will need an active and verified <b>PayPal</b>. For country specific PayPal restrictions refer to the following link: <a href="https://www.paypal.com/webapps/mpp/country-worldwide" data-target="_blank">https://www.paypal.com/webapps/mpp/country-worldwide</a></p>
			                     <p>Nonprofit Organizations in the <b>USA</b> can also select <b>First Giving</b> as their choice of Payment Gateway.</p>
			                     <h4><b>India</b></h4>
			                     <p>You need to provide your bank details and will receive their funds via NEFT transaction at the end of their campaign. 
			                     To fill in your bank details follow these steps:</p>
			                     <ul>
				                     <li>Sign in to your Crowdera Account</li>
				                     <li>Select “My Campaigns” from the dropdown under your username</li>
				                     <li>Click on the campaign </li>
				                     <li>Go to Payments and provide your information</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenThree">How do I create my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can start creating your campaign <g:link controller="project" action="create">here</g:link>. Please refer to our Ebook for more crowdfunding guidelines. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenFour">Do I have to create a campaign in one go?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>No. You can save the information as draft and complete it whenever you wish.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenFive">My campaign is saved as a draft, what should I do next?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can edit the campaign or submit it for validation.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenSix">Who is an Owner?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenSix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>The person who creates a campaign is the Campaign Owner.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenSevan">Who is Co-Owner?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenSevan" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>People who are nominated by a Campaign Owner to work for a campaign are Co-owners.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenEight">I am an Owner how can I nominate a Co-owner for my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can add co-owners under the Admin section when you create or edit your campaign.You can add upto 3 co-owners.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Image</h3>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenNine">How many images can I upload?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Multiple images can be added but we recommend including not more than 3 or 4 images. </p>
                        </div>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTen">What is size and format accepted?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>The image should be less than 3 MB and have an aspect ratio of 3:2 (width major). Formats acceptable are jpg and png</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Perks</h3>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenOne">Can I create a perk after my campaign is live?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes you can create a perk even after a campaign is live by going to  “Perks” under “My Campaigns”.</p>
                        </div>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTentwo">Can I edit or delete a perk after my campaign is live?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTentwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can edit or delete a perk only if has not been selected by a contributor. 
			                      Once a perk has been selected, it cannot be edited or deleted.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Duration </h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenThree">I have set the campaign duration for 60 days, from when will the countdown start?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>The campaign countdown starts once the campaign is validated by Crowdera Administrator.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenFour">What is the maximum duration of a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>The maximum duration is 90 days. However, you can reach out to the Crowdera Team to extend your deadline.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenFive">Can I extend my deadline?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Deadline can be extended if the cause is genuine and verified by our Team.</p>
                        </div>
                    </div>
                </div>
                
                 <h3 class="faq-subheading">Co-owners/Co-creators  </h3>
                 
                  <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenSix">How many co-creators can I nominate for my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenSix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can nominate maximum of 3 co-owners for a campaign.</p>
                        </div>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenSaven">I have received an invitation for being a co-creator of a campaign, what should I do next?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenSaven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>To access the campaign:</p>
			                     <ul>
			                         <li><a href="${resource(dir: 'login/register')}">Register</a> / <a href="${resource(dir: 'login/auth')}"> Login </a> on Crowdera</li>
			                         <li>Click on the dropdown under Username</li>
			                         <li>Click on My Campaigns</li>
			                         <li>You should be able to see the campaign there</li>
			                     
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenEight">What are the rights of a co-owner?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>A co-owner can</p>
			                     <ul>
			                         <li>Validate team requests</li>
			                         <li>Enable/disable teams </li>
			                         <li>Edit campaign </li>
			                         <li>Edit team details</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Validation</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenNine">I have already submitted my campaign, then why does it show “Pending” ?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Pending banner indicates your campaign is still being verified by the administrator.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Campaign Updates </h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate1">Who can create an update for a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Campaign Owner/ Co-owner can create updates for a campaign.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate2">How many images can I upload with the update?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate2" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can upload multiple images but recommend not adding more that 3. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate3">Who will receive my campaign updates?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Your contributors, teams and those who have chosen to follow your campaign will receive an email about your latest updates.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate4">How do I edit my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate4" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Access your campaign from My Campaigns. On the right side of the page you will see the display picture of your campaign, the edit option is under that section. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate5">Can I hide the comments on my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate5" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Campaign Owner/Co-owner can enable/disable the campaign comments.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProUpdate6">Can I delete a live campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProUpdate6" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>You can not delete a live campaign. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContri1">Can I export my contribution report?</a>
                        </h4>
                    </div>
                    <div id="collapseProContri1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes. You can download the CSV report from the “Contribution” tab on the Manage Campaign page.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContri2">Can I edit the name & amount of the offline contribution?</a>
                        </h4>
                    </div>
                    <div id="collapseProContri2" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, name and amount is editable. </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContri3">Can I edit the name & amount of the online contribution?</a>
                        </h4>
                    </div>
                    <div id="collapseProContri3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>No, as the online contributions are made via a Payment Gateway, they cannot be edited. </p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Teams </h3>
                 
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams1">Who is a Team?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>A Team owner is a person who helps you rally your campaign.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams2">How can I Invite my friend to be  a Team for my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams2" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <ul>
			                         <li>Log into your Crowdera Account </li>
			                         <li>Go to My Campaigns </li>
			                         <li>Select the campaign</li>
			                         <li>Click on the Activity</li>
			                         <li>Select Invite Members</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams3">How can someone join as a Team for a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>It’s simple, they go to the campaign detail page via Discover, click on “Teams” and hit Join Us! </p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams4">Who can Validate/ Discard  a Team request?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams4" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Owner/ Co-owner have the authority to validate or discard a team request. Follow these steps: </p>
			                     <ul>
			                         <li>Log into your Crowdera Account </li>
			                         <li>Go to My Campaigns </li>
			                         <li>Select the campaign</li>
			                         <li>Click on the Activity</li>
			                         <li>Select Validate/Discard Team</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams5">Can I disable/enable an  existing Team of my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams5" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes you can disable an existing team by following these steps. </p>
			                     <ul>
			                         <li>Log into your Crowdera Account </li>
			                         <li>Go to My Campaigns </li>
			                         <li>Select the campaign</li>
			                         <li>Click on the Activity</li>
			                         <li>Select Validate/Discard Team</li>
			                     </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams6">Who can enable/disable a Team?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams6" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Only Owner/Co-owners can enable/disable a team.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams7">I am Owner/Co-owner can I edit a Team’s fundraiser?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams7" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, you can edit a Team’s fundraiser page. To edit a Team’s fundraiser go to Teams page from Manage Campaign, 
			                     select the Team member whose page you want to edit. Now you will be on their fundraiser, go to Teams and click on Activity dropdown. 
			                     You will see edit fundraiser.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams8">Can I comment specifically on a Team’s fundraiser?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams8" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Yes, you can comment on a Team’s individual fundraiser.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTeams9">How can I share my campaign on social media?</a>
                        </h4>
                    </div>
                    <div id="collapseProTeams9" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
			                     <p>Access your campaign through the Discover page. Under the images displayed you will find all the necessary social media tools.
			                      Crowdera also provides a short link to your campaign that can be used to share your campaign on social media.</p>
                        </div>
                    </div>
                </div> 
                
            </div>
        </div>
    </div>
    </g:else>
    </div>
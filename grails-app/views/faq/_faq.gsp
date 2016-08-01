<g:set var="projectService" bean="projectService"/>
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
	def currentEnv = projectService.getCurrentEnvironment()
%>
<div class="container footer-container">
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
			                    Crowdera is a crowdfunding platform that supports individuals and non profit organizations in their efforts to create a social impact. 
			                    Organizations start their fundraising campaigns on Crowdera and supporters rally to fund those campaigns. </p>
		                    <p class="text-justify">Crowdera intents to complement organization’s
		                        existing fundraising and volunteering activities by offering a user-friendly 
		                        platform to create visually compelling and viral fundraising campaigns that raise awareness 
		                        and funding for an individual or organization’s goals and missions.
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
			                   Crowdfunding is a popular way to fund projects from a large group of people, mainly via the Internet and social media. It helps individuals and organizations reach their financial goals by receiving and leveraging small contributions from many people.</p>
		                    <p class="text-justify">
			                    All you need is a mission to do something good, a funding goal and timeframe, some cool perks to promise to your supporters and show gratitude, and a crowd of family, friends, and fans / followers / customers to promote your campaign to.
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
                            <p class="text-justify">Crowdfunding is for people or organizations who have few direct means to fund their initiatives that benefit the community or amplify their goals. Crowdera aims to bridge this gap and help organizations reach out to an even wider audience so as to gain support for their mission. By crowdfunding online with Crowdera, organizations can connect to people around the world who share a passion for their cause.</p>
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
                             <p class="text-justify">People contribute towards campaigns they relate to or if they connect with a cause. They are passionate about what you are doing for the community and society at large. Contributing is their way of showing support for your campaign and organization. So be ready to feel the love!</p>
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
			                    <li>Crowdera lets you build your fundraising campaign on its platform. 
			                        You can set a fundraising goal, write your story and add compelling photos and video.</li>
			                    <li>Once your campaign is validated, you can email the link of your campaign to friends, 
                                    family, colleagues as well as post the link on your social media outlets. 
                                    The more people who know about your campaign, the more opportunities to help you reach your goal!
                                </li>
			                    <li>You can share milestones, photos and updates easily through
				                    email and social media right from your campaign page.</li>
			                    <li>Your campaign ends once it reaches the campaign end date. Do more good and make your campaign a success with the funds you just raised!</li>
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
                            <ul>
                                <li>Fundraising is FREE! Crowdera does not charge any fee, it’s free so do more good!</li>
                                <li>TEAMS - You can form teams to rally your campaign.</li>
                                <li>We help you multiply your impact by cloning your campaign for your teams. 
                                    All your team works towards a common goal which helps you to get more attention 
                                    from your team’s crowd.</li>
                                <li>We plan to engage corporate CSR <span class="fa fa-inr"></span><span class="fa fa-inr"></span> in the most unique fashion to help you reach your goals faster.</li>
                                <li>We are adding some cool new features soon!</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
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
                                 <li>Select Setting.</li>
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
                                 <li>Select Setting.</li>
                             </ul>
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProFive">How can I change my password ?</a>
                        </h4>
                    </div>
                    <div id="collapseProFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">You can change your password by following these steps:</p>
                             <ul>
                                 <li>Log in to your Crowdera account.</li>
                                 <li>Click the dropdown on your username.</li>
                                 <li>Select Setting.</li>
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
                                 <li>Select Setting.</li>
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

                <h3 class="page-header">Campaign Creation and Management Questions</h3>

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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSeven">What do I need to create a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseSeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <ul>
                                <li>A story describing your mission.</li>
                                <li>Fundraising Goal.</li>
                                <li>Campaign timeline, including an end date.</li>
                                <li>Video (preferably with a pitch and ask).</li>
                                <li>High Resolution photos/videos.</li>
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenFour">Do I have to create a campaign in one go?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p>No, You can save the information as draft and complete it whenever you wish.</p>
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
                            <p class="text-justify">We are a free platform to help you do more good. 
                            We do not charge a startup fee, no fee charged on funds raised and no hidden fees. 
                            However, please note that the payment gateway transaction fee and NEFT fee will be borne by the campaign owner.
                            The NEFT transaction charges levied by our bank are</p>
                            <table border="1">
                                <tr>
                                    <td>Amount</td>
                                    <td>Transaction Charges</td>
                                </tr>
                                <tr>
                                    <td>Upto Rs 10,000</td>
                                    <td>Rs. 2.50 + Service Tax</td>
                                </tr>
                                <tr>
                                    <td>Above Rs 10,000 and upto Rs 1 lakh</td>
                                    <td>Rs 5 + Service Tax</td>
                                </tr>
                                <tr>
                                    <td>Above Rs 1 lakh and upto Rs 2 lakh</td>
                                    <td>Rs 15 + Service Tax</td>
                                </tr>
                                <tr>
                                    <td>Above Rs 2 lakh and upto Rs 5 lakh</td>
                                    <td>Rs 25 + Service Tax</td>
                                </tr>
                                <tr>
                                    <td>Above Rs 5 lakh and upto Rs 10 lakh</td>
                                    <td>Rs 25 + Service Tax</td>
                                </tr>
                            </table>
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
                            <p class="text-justify">The minimum that you can raise is INR 500.</p>
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
                                The maximum funding goal is INR 99,999,999. If you would like to raise
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseForteen">Can I edit my campaign after I submit it?</a>
                        </h4>
                    </div>
                    <div id="collapseForteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes, you can edit certain sections of the campaign.</p>
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
                            <p class="text-justify">The funds will be transferred once your campaign ends. 
                            You can provide your banks details on the payment section of your campaign. 
                            The payment will be made by Crowdera by NEFT transaction. 
                            NEFT transactions are secure transactions. </p>
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
                                 <p>You can upload 5 images.</p>
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
                
                <h3 class="faq-subheading">Goal</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSixteen">What if I don’t meet my fundraising goal? Do I still get the funds?</a>
                        </h4>
                    </div>
                    <div id="collapseSixteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Crowdera believes that all effort put into
                                the campaign deserves to be paid off. Therefore, you receive all of the funds you have raised even 
                                if you do not meet your fundraising goal.</p>
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
                            <p class="text-justify">You keep every fund you raise!</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Duration</h3>
                
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#coownerquestion1">Who is a Owner?</a>
                        </h4>
                    </div>
                    <div id="coownerquestion1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>The person who creates a campaign is the Campaign Owner.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#coownerquestion2">Who is a co-owner?</a>
                        </h4>
                    </div>
                    <div id="coownerquestion2" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>People who are nominated by a Campaign Owner to work for a campaign are Co-owners.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#coownerquestion3">I am an Owner how can I nominate a Co-owner for my campaign?</a>
                        </h4>
                    </div>
                    <div id="coownerquestion3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>You can add co-owners under the Admin section when you create or edit your campaign.You can add upto 3 co-owners.</p>
                        </div>
                    </div>
                </div>
                 
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
                                 <p >To access the campaign:</p>
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
                
                <h3 class="faq-subheading">Perks</h3>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#perkcollapsequestion1">Can I offer rewards/perks?</a>
                        </h4>
                    </div>
                    <div id="perkcollapsequestion1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes, you can! You can create your own perks as well.</p>
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenOne">Can I create a perk after my campaign is live?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Yes, you can create a perk even after a campaign is live by going to  “Perks” under “My Campaigns”.</p>
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
                
                <h3 class="faq-subheading">Validation</h3>
                
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenNine">I have already submitted my campaign, then why does it show “Pending” ?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Pending banner indicates your campaign is still being verified by the administrator.</p>
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
                            <p class="text-justify">After submitting, the campaign go through an approval process. Once the campaign is approved , it goes live on the Crowdera platform.</p>
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
                            <ul>
                                <li>Cause - Is it a social good cause that aims to help the community.</li>
                                <li>Title - Whether your title is apt and conveys the essence of your campaign.</li>
                                <li>Description - Will the contributors understand your aim and the cause you raising funds for.</li>
                                <li>Story - Have you provided adequate information for the contributor to make his or her decision to contribute.</li>
                                <li>Social Reference - If you have provided details to your social media and whether you or your organization popular.</li>
                                <li>Website check - Whether the link to the website or Facebook page is working and related to your cause and/or belongs to you.</li>
                                <li>Founder/Management - How motivated and active is the founder and management of the campaign.</li>
                                <li>Feasibility - Is it feasible to achieve your goal in the stipulated time.</li>
                                <li>Images - Are the images high resolution and appropriate.</li>
                                <li>Video - A relevant video.</li>
                            </ul>
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
                            <p class="text-justify">Please read the FAQ section and our crowdfunding guidelines sections thoroughly to understand the criterion of selection. If you feel you need more information, you can reach out to the Crowdera Crew to find out why your campaign was rejected.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Contributions</h3>
                
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContri1">Can I export my contribution report?</a>
                        </h4>
                    </div>
                    <div id="collapseProContri1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Yes, You can download the CSV report from the “Contribution” tab on the Manage Campaign page.</p>
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
                                     <li>Log into your Crowdera Account.</li>
                                     <li>Go to My Campaigns.</li>
                                     <li>Select the campaign.</li>
                                     <li>Click on the Activity.</li>
                                     <li>Select Invite Members.</li>
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
                                     <li>Log into your Crowdera Account.</li>
                                     <li>Go to My Campaigns.</li>
                                     <li>Select the campaign.</li>
                                     <li>Click on the Activity.</li>
                                     <li>Select Validate/Discard Team.</li>
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
                                     <li>Log into your Crowdera Account.</li>
                                     <li>Go to My Campaigns.</li>
                                     <li>Select the campaign.</li>
                                     <li>Click on the Activity.</li>
                                     <li>Select Validate/Discard Team.</li>
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
                
                <h3 class="faq-subheading">Social Media</h3>
                
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
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTen">Why do I need to build a strong social network and share my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseTen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">We have noticed that the campaigns that can rally about 30% of the funding immediately upon launch have a higher success rate. Therefore, we recommend that the initial 30% funding comes from your existing network and supporters. Share your campaign with your inner network as soon as you create it and encourage them to share it on their social media networks as well.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Campaign Updates</h3>
                
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
                                 <p>You can upload multiple images but recommend not adding more than 3. </p>
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
                
                <h3 class="faq-subheading">After campaign is live </h3>
                
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
                
                <h3 class="faq-subheading">Contributor Questions</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyFour">Do I need to sign up to contribute?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">No, you do not need to sign up to contribute. However, 
                            we recommend you sign up so you can track the progress of campaigns you have funded.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorQ1">Why should I contribute through Crowdera instead of contributing directly?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorQ1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <ul>
                                     <li>Crowdera is curated platform, we review every application for its content and story, and approve campaigns at our discretion if we feel mission of the project is aligned to make a social impact.</li>
                                     <li>Crowdera gives you diversity in terms of organizations and causes to fund.</li>
                                     <li>We encourage campaign creators to update you about the campaign as well as the organization.</li>
                                     <li>Funding through Crowdera, you know which campaign you are being part of and where your funds will be utilized.</li>
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor3">I am not from India, can I contribute to a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Unfortunately campaigns by Indian organizations and individuals that are shown in 
                                 INR only accept Indian cards. Don’t get disheartened, you can contribute to Global campaigns, 
                                 shown in USD, through PayPal or First Giving payment gateway chosen by our beneficiaries</p>
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyThree">How much of the funds raised reach the creator?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">100% of the funds reach the campaign creator, 
                            however the payment gateway and bank charge a transaction fee that is borne by campaign creator.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributor1">How do I know the authenticity of organization, individual creating the campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseContributor1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">All campaigns go through an approval process. 
                            Even though Crowdera carefully goes through all the information prior to approving a campaign, 
                            we request contributors to conduct due diligence before contributing.</p>
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
                            <p class="text-justify">Crowdera ensures funds are transferred to the beneficiary at the end of the campaign.</p>
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor13">Where can I see my contribution details on the campaign I just supported?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor13" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>You can see your contribution details under the contribution tab on the campaign detail page. </p>
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
                            <p class="text-justify">Not all contributions will be tax deductible. 
                            Contributions made to NGOs with a registered 80G (India) are tax deductible. 
                            However, we recommend you check the details of the organization and contact 
                            them with queries about tax deductions. </p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Transactions</h3>
                
                                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentySeven">Is your site secure for online credit / debit card transactions?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentySeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
                                Yes it is. Donations and contributions are collected and processed by
                                our third-party vendors pursuant to the terms and conditions of its
                                privacy policy, and we do not have access to any billing
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
                            <p class="text-justify">You can log into your PayU Money account to check the status of the transaction. 
                            PayU Money requires you to “Release Payment” once you have made a contribution. 
                            If you do not respond to the release payment request within 3 days, the payment is released anyway. 
                            Please read more on <a href="https://www.payumoney.com/faq_details.html?topic=buyer_inquiries">https://www.payumoney.com/faq_details.html?topic=buyer_inquiries</a></p>
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
                            <p class="text-justify">Please contact Crowdera Crew within 3 days of the transaction in case you need to cancel your contribution.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Anonymous Contributions</h3>
                
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseanonymousContribution">Can I contribute anonymously for a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseanonymousContribution" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes you can. Just check the anonymous box that appears when you make a contribution.</p>
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
                                 <p><b>Logged In User</b></p>
                                 <ul>
                                     <li>Name and Amount Visibility</li>
                                     <li>Name anonymous and Amount visible</li>
                                 </ul>
                                 <p><b>Non Logged in User</b></p>
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
                
                <h3 class="faq-subheading">Social Sharing</h3>
                
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
                
                <h3 class="faq-subheading">Perks</h3>
                
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtySevens">Can I receive perks after donating anonymously?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtySevens" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes you can. You will need to provide the shipping information required for the delivery of perk.</p>
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
                
                <h3 class="faq-subheading">Team Contributions</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor9">Where are individual Team Contribution displayed ?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor9" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Under Teams Tab, Click on the Team’s Name. The contributions will be visible there. </p>
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
                                Crowdera is a crowdfunding platform that supports individuals and non profit organizations in their efforts to create a social impact. 
                                Organizations start their fundraising campaigns on Crowdera and supporters rally to fund those campaigns. </p>
                            <p class="text-justify">Crowdera intents to complement organization’s
                                existing fundraising and volunteering activities by offering a user-friendly 
                                platform to create visually compelling and viral fundraising campaigns that raise awareness 
                                and funding for an organization’s goals and missions.
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
                               Crowdfunding is a popular way to fund projects from a large group of people, mainly via the Internet and social media. It helps individuals and organizations reach their financial goals by receiving and leveraging small contributions from many people.</p>
                            <p class="text-justify">
                                All you need is a mission to do something good, a funding goal and timeframe, some cool perks to promise to your supporters and show gratitude, and a crowd of family, friends, and fans / followers / customers to promote your campaign to.
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
                            <p class="text-justify">Crowdfunding is for people or organizations who have few direct means to fund their initiatives that benefit the community or amplify their goals. Crowdera aims to bridge this gap and help organizations reach out to an even wider audience so as to gain support for their mission. By crowdfunding online with Crowdera, organizations can connect to people around the world who share a passion for their cause.</p>
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
                             <p class="text-justify">People contribute towards campaigns they relate to or if they connect with a cause. They are passionate about what you are doing for the community and society at large. Contributing is their way of showing support for your campaign and organization. So be ready to feel the love!</p>
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
                                <li>Crowdera lets you build your fundraising campaign on its platform. 
                                    You can set a fundraising goal, write your story, and add compelling photos and video.</li>
                                <li>Once your campaign is validated, you can email the link of your campaign to friends, 
                                    family, colleagues as well as post the link on your social media outlets. 
                                    The more people who know about your campaign, the more opportunities to help you reach your goal!
                                </li>
                                <li>You can share milestones, photos and updates easily through
                                    email and social media right from your campaign page.</li>
                                <li>Your campaign ends once it reaches the campaign end date. Do more good and make your campaign a success with the funds you just raised!</li>
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
                            <ul>
                                <li>Fundraising is FREE! Crowdera does not charge any fee, it’s free so do more good!</li>
                                <li>TEAMS - You can form teams to rally your campaign.</li>
                                <li>We help you multiply your impact by cloning your campaign for your teams. 
                                    All your team works towards a common goal which helps you to get more attention 
                                    from your team’s crowd.</li>
                                <li>We plan to engage corporate CSR $$ in the most unique fashion to help you reach your goals faster.</li>
                                <li>We are adding some cool new features soon!</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
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
                                 <li>Select Setting.</li>
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
                                 <li>Select Setting.</li>
                             </ul>
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProFive">How can I change my password ?</a>
                        </h4>
                    </div>
                    <div id="collapseProFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">You can change your password by following these steps:</p>
                             <ul>
                                 <li>Log in to your Crowdera account.</li>
                                 <li>Click the dropdown on your username.</li>
                                 <li>Select Setting.</li>
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
                                 <li>Select Setting.</li>
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

                <h3 class="page-header">Campaign Creation and Management Questions</h3>

                <h3 class="faq-subheading">Creating a campaign</h3>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTen">How do I create my Crowdera profile?</a>
                        </h4>
                    </div>
                    <div id="collapseProTen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                <ul>
                                    <li>Go to the <a href="${resource(dir: '/')}">Crowdera homepage</a></li>
                                    <li>Click on Sign up on the Upper right hand corner</li>
                                    <br>
                                        <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/7e8166e4-2dd8-4012-9652-4e2f49748382.png" alt="product-faq-header">
                                    <br>
                                    <li>You can also connect using Facebook or Google+. Just click the relevant button, 
                                        enter your email and password and sign into your Facebook or Google + account. 
                                        You will automatically be signed in to Crowdera. 
                                    </li>
                                    <br>
                                        <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/d04b83d3-ea2b-479d-9edd-3a708b605b44.png" alt="product-faq-signup">
                                    <br>
                                    <li>If you don’t want to use social media to sign in, simply use your email, 
                                        desired password and provide us with your First and Last Name. 
                                    </li>
                                    <br>
                                        <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/492b7891-d4ff-4918-a6d5-c4dab91ec440.png" alt="product-faq-signup-b">
                                    <br>
                                    <p>To edit or add more information to your profile sign into your Crowdera account</p>
                                    <li>Click on your name to view the dropdown</li>
                                    <br>
                                        <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/888d58fb-dd76-45d0-8955-2c83bef6eafe.png" alt="product-faq-logindropdown-b">
                                    <br>
                                    <li>Click on dashboard</li>
                                    <li>You can edit your user information and also update your profile picture</li>
                                    <br>
                                        <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/3a052923-5778-4d4e-9451-7c43ff18f04e.png" alt="product-faq-profile">
                                    <br>
                                </ul>
                               
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenThree">How do I add and edit the campaign title?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>To add a title to your campaign </p>
                                 <ul>
	                                <li>Login into your account</li>
	                                <li>Click on Create on the upper right hand corner</li>
	                                <li>Add your title to the “My plan is..” section</li>
	                                <br>
	                                   <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f6fec1a7-8738-44d7-b699-aff07be07103.png" alt="product-faq-planis">
	                                <br>
	                                <li>Complete the remaining information for your campaign</li>
                                    <li>Your draft will be autosaved and can be access via your Dashboard.</li>
                                 </ul>
                                 <p>If you want to edit the title of an existing campaign follow these steps</p>
                                 <ul>
                                    <li>Login to your Crowdera account</li>
                                    <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                    <li>Select Dashboard</li> 
                                    <li>Select Manage Campaign</li>
                                    <li>Click on the edit icon</li>
                                    <br>
                                       <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f8abf039-02e2-463c-ae9e-7b18a8f04f5d.png" alt="product-faq-planis">
                                    <br>
                                    <li>Edit your campaign title under the “My plan is..” section</li>
                                    <li>Scroll down and save your edits</li>
                                 </ul>
                                 
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSeven">How do I add and edit the campaign description?</a>
                        </h4>
                    </div>
                    <div id="collapseSeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p>To add a campaign description </p>
                            <ul>
                                <li>Login into your account</li>
                                <li>Click on Create on the upper right hand corner</li>
                                <li>Add the description in the box that says campaign description </li>
                                <br>
                                    <img src= "//s3.amazonaws.com/crowdera/assets/ca898caa-d0de-4c2f-aa65-b986265635d7.png"> 
                                <br>
                                <li>Complete the remaining information for your campaign</li>
                                <li>Your draft will be autosaved and can be access via your Dashboard</li> 
                            </ul>
                            <p>If you want to edit the description of an existing campaign follow these steps</p>
                            
                            <ul>
                                <li>Login to your Crowdera account</li>
                                <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                <li>Select Dashboard </li>
                                <li>Select Manage Campaign</li>
                                <li>Click on the edit icon</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f8abf039-02e2-463c-ae9e-7b18a8f04f5d.png" alt="product-faq-planis">
                                <br>
                                <li>Edit your campaign description</li>
                                <li>Scroll down and save your edits</li>
                             </ul>                            
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseEight">How do I add and edit my fundraising goal?</a>
                        </h4>
                    </div>
                    <div id="collapseEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                             <p class="text-justify">To add your fundraising goal</p>
                             <ul>
                                 <li>Login into your account</li>
                                 <li>Click on Create on the upper right hand corner</li>
                                 <li>Add the goal in the box that says “I need..”</li>
                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/0f7111eb-6c30-48dd-af82-6fdbdccaf040.png" alt="fundrasing">
                                 <br>
                                 <li>Complete the remaining information for your campaign</li>
                                 <li>Your draft will be autosaved and can be access via your Dashboard</li> 
                             </ul>
                             <p>If you want to edit the description of an existing campaign follow these steps</p>
                            
                            <ul>
                                <li>Login to your Crowdera account</li>
                                <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                <li>Select Dashboard </li>
                                <li>Select Manage Campaign</li>
                                <li>Click on the edit icon</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f8abf039-02e2-463c-ae9e-7b18a8f04f5d.png" alt="product-faq-planis">
                                <br>
                                <li>Edit your fundraising goal</li>
                                <li>Scroll down and save your edits</li>
                             </ul>        
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenFour">What is display name? How do I add and edit my display name for a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p>Display name is can be your personal name or an organization’s name. It represents the people running the campaign. It is visible on the campaign page and can be viewed by your contributors.</p>
                            <br>
                                <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/5cf086cb-ec8a-4947-8c3b-9aa44ae6f36e.png" alt="orgnizations-name">
                            <br>
                            <p>To add the display name when creating a new campaign </p>
                            <ul>
                               <li>Login into your account</li>
                               <li>Click on Create on the upper right hand corner</li>
                               <li>Add the display name under the “My name is ..” section</li> 
                            </ul>
                            <br>
                                <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/33863d20-1eab-478f-b93e-15056e4dc27d.png" alt="orgnizations-name-create">
                            <br>
                            <ul>
                                <li>Complete the remaining information for your campaign</li>
                                <li>Your draft will be autosaved and can be access via your Dashboard</li> 
                            </ul>
                            
                            <p>If you want to edit the display name of an existing campaign follow these steps</p>
                            <ul>
                                <li>Login to your Crowdera account</li>
                                <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                <li>Select Dashboard </li>
                                <li>Select Manage Campaign</li>
                                <li>Click on the edit icon</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f8abf039-02e2-463c-ae9e-7b18a8f04f5d.png" alt="product-faq-planis">
                                <br>
                                <li>Edit the “My name is..” section</li>
                                <p>OR</p>
                                <li>Scroll down to the Admin section</li>
                                <li>Select “Update Display Information”</li>
                                <li>Edit the Display Name</li> 
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/130c9ce5-6227-4690-ade0-8cc147cd89b6.png" alt="create-admin">
                                <br>
                                <li>Scroll down and save your edits</li> 
                             </ul>        
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseNine">How do I add the deadline to my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To add a deadline to your campaign</p>
                            <ul>
                                <li>Login into your account</li>
                                <li>Click on Create on the upper right hand corner</li>
                                <li>Complete the first step and click on Create Now</li>
                                <li>Click on the dropdown calendar </li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/17415419-29ec-4ea9-8bba-74bb25d540b8.png" alt="calender-deadline">
                                <br>
                                <li> Complete the remaining information for your campaign</li>
                                <li>Your draft will be autosaved and can be access via your Dashboard</li> 
                            </ul>
                            <p>If you want to edit or extend the deadline of an existing campaign follow these steps</p>
                             <ul>
                                <li>Login to your Crowdera account</li>
                                <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                <li>Select Dashboard </li>
                                <li>Select Manage Campaign</li>
                                <li>Click on the edit icon</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f8abf039-02e2-463c-ae9e-7b18a8f04f5d.png" alt="product-faq-planis">
                                <br>
                                <li>Select a new deadline</li>
                                <li>Scroll down and save your edits</li>
                             </ul>      
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFortyOne">How do I select my prefered payment gateway?</a>
                        </h4>
                    </div>
                    <div id="collapseFortyOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <ul>
                                <li>Login into your account</li>
                                <li>Click on Create on the upper right hand corner</li>
                                <li>Complete the first step of campaign creation</li> 
                                <li>On the second stage you will find a dropdown named “Payment”</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/8ba9f60d-feea-45f6-a89e-c9e5d1c5bad0.png" alt="payment-dropdown">
                                <br>
                                <li>Select the Payment Gateway you want to use</li>
                                <li>Complete the remaining information for your campaign</li>
                                <li>At the end of the campaign creation you will be asked to fill in the details for your payment gateway</li>
                                <li>If you select PayPal, you need to provide your email address</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f837314e-79dd-44bb-b69b-dd6e55783f76.png" alt="payment-paypal">
                                <br>
                                <li>If you select First Giving, you can search your organization by clicking on “Find your organization”</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/6593b02b-02f4-4dd3-b108-c3b4c1abdf6a.png" alt="payment-charitableId">
                                <br>
                                <li>Type the name of your organization in the pop up that appears</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/30cf56c2-3d4e-4bcf-934b-9ee221c4cafc.png" alt="payment-charitableId-organization">
                                <br>
                            </ul>
                            <p>Note: Payment gateway cannot be changed once the campaign is live. Contact us if you want to change your payment gateway.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyOne">How do I add a video to my campaign? Can I add more than one video? (Explain format as well as the option of adding in the story)</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
                               You can add only one video at the beginning of your campaign. However you can add multiple videos in the story section of the campaign.
                            </p>
                            <p>To add a video to the beginning of your campaign</p>
                            <ul>
                                <li>Login into your account</li>
                                <li>Click on Create on the upper right hand corner</li>
                                <li>Complete the first step and click on Create Now</li>
                                <li>You add the Video Url and click Add</li>
                                <br>
                                   <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/0ea7ac96-478d-4de7-89c5-e6622fc6534f.png" alt="video-Url">
                                <br>
                                <li>Please note, we only accept Youtube and Vimeo Urls only</li>
                            </ul>
                            <p>To add a video to the story section of your campaign</p>
                            <ul>
                                <li>Scroll down to the story section </li>
                                <li>Click on the icon that looks like “Play”</li>
                                <br>
                                   <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/83de158b-e4f2-4cb4-9e42-1f17f6f17574.png" alt="story-video-url">
                                <br>
                                <li>A pop up will appear. You can add an embed code or a Youtube/Vimeo link</li> 
                                <br>
                                   <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/d92b5242-78c2-4bfc-b285-8571b4d5b191.png" alt="story-video-url">
                                <br>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenOne">How can I add images to the campaign? (mention format, size, ratio)</a>
                        </h4>
                    </div>
                    <div id="collapseProTenOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p>You can add multiple images at the beginning of the campaign as well as in the story. We would recommend adding 3 to 4 images at the beginning and some within the relevant sections of the story.</p>
                            <p>To add an image to the beginning of your campaign</p>
                            <ul>
                                <li>Login into your account</li>
                                <li>Click on Create on the upper right hand corner</li>
                                <li>Complete the first step and click on Create Now</li>
                                <li>You add images by clicking on Add Image</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/b5068b12-16fb-418a-bda3-79309f96f67f.png" alt="add-image">
                                <br>
                                <li>To delete an image click on the red cross on the top of the image</li>
                            </ul>
                            <p>Please note the image size should be less than 3MB and should have an aspect ratio of 3 (width) : 2 (height). Formats accepted are .jpg and .png.</p>
                            <p>To add an image to the story section of your campaign</p>
                            <ul>
                                <li>Scroll down to the story section </li>
                                <li>Click on the icon that looks like an “Image”</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/83de158b-e4f2-4cb4-9e42-1f17f6f17574.png" alt="story-video">
                                <br>
                                <li>A pop up will appear where you can choose the images from your computer</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/4d8ae34c-ea2c-40b1-8962-b19340c5d7f8.png" alt="Insert image">
                                <br>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseForteen">How do I add the story to my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseForteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To add the story to your campaign</p>
                            <ul>
                               <li>Login into your account</li>
                               <li>Click on Create on the upper right hand corner</li>
                               <li>Complete the first step and click on Create Now</li>
                               <li>Once you complete all the information at the beginning of the form, you can scroll down to the Story section</li>
                               <br>
                                   <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/a2d7c2db-16cf-48c4-a766-ddc0c3ee3218.png" alt="Story">
                               <br> 
                               <li>Select the placeholder text in the story box and hit delete</li>
                               <li>You can type or copy paste the content in the section</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseForteens">How do I add other administrators to my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseForteens" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To add administrators while creating a campaign</p>
                            <ul>
	                            <li>Login into your account</li>
	                            <li>Click on Create on the upper right hand corner</li>
	                            <li>Complete the first step and click on Create Now</li>
	                            <li>Once you complete all the information at the beginning of the form, you can scroll down to the Admin section</li>
	                            <br>
	                                <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/50b28c32-b015-4344-a733-fc675daaca30.png" alt="admin">
	                            <br> 
	                            <li>You can add upto three administrators to your campaign</li>
                            </ul>
                            <p>To add administrators to an existing campaign</p>
                             <ul>
                                <li>Login to your Crowdera account</li>
                                <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                <li>Select Dashboard </li>
                                <li>Select Manage Campaign</li>
                                <li>Click on the edit icon</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f8abf039-02e2-463c-ae9e-7b18a8f04f5d.png" alt="product-faq-planis">
                                <br>
                                <li>Scroll down to the Admin section and add administrators to your campaign</li>
                                <li>Once done scroll down and save your edits</li>
                             </ul>      
                             
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFifteen">Where can I update the display information?</a>
                        </h4>
                    </div>
                    <div id="collapseFifteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">If you want to edit the display name of an existing campaign follow these steps</p>
                             <ul>
                                <li>Login to your Crowdera account</li>
                                <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                <li>Select Dashboard </li>
                                <li>Select Manage Campaign</li>
                                <li>Click on the edit icon</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f8abf039-02e2-463c-ae9e-7b18a8f04f5d.png" alt="product-faq-planis">
                                <br>
                                <li>Edit the “My name is..” section </li>
                                <p>OR</p>
                                <li>Scroll down to the Admin section</li>
                                <li>Select “Update Display Information”</li>
                                <li>Edit the Display Name</li> 
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/130c9ce5-6227-4690-ade0-8cc147cd89b6.png" alt="product-faq-planis">
                                <br>
                                <li>Scroll down and save your edits</li>
                             </ul>      
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsesixteen">Where will the display information be visible?</a>
                        </h4>
                    </div>
                    <div id="collapsesixteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Display information is visible on the campaign page and can be viewed by your contributors.</p>
                            <p>To access it</p> 
                             <ul>
                                <li>Go to the Crowdera homepage</li>
                                <li>Select Discover</li>
                                <li>Select your campaign</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/5cf086cb-ec8a-4947-8c3b-9aa44ae6f36e.png" alt="product-faq-planis">
                                <br>
                             </ul>      
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseseventeen">How can I customize my campaign url?</a>
                        </h4>
                    </div>
                    <div id="collapseseventeen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To add a custom url while creating a campaign</p>
                             <ul>
                               <li>Login into your account</li>
                               <li>Click on Create on the upper right hand corner</li>
                               <li>Complete the first step and click on Create Now</li>
                               <li>Once you complete all the information at the beginning of the form, you can scroll down to the Admin section</li>
                               <li>Select Update Personal Information</li> 
                               <li>Add the url you want under “Custom Vanity Url”</li>

                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/30b43f85-985b-48a8-b30e-b2da5a6af961.png" alt="custom-vanity-url">
                                <br>
                             </ul> 
                             <p>To add a custom url to an existing campaign</p>
                                <ul>
                                    <li>Login to your Crowdera account</li>
                                    <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                    <li>Select Dashboard </li>
                                    <li>Select Manage Campaign</li>
                                    <li>Click on the edit icon</li>
                                    <br>
                                       <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f8abf039-02e2-463c-ae9e-7b18a8f04f5d.png" alt="product-faq-planis">
                                    <br>
                                    <li>Scroll down to the Admin section and add the url to your campaign</li>
                                    <li>Once done scroll down and save your edits</li>
                                </ul>      
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
                                 <p>You can upload 5 images.</p>
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
                
                <h3 class="faq-subheading">Goal</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseSixteen">What if I don’t meet my fundraising goal? Do I still get the funds?</a>
                        </h4>
                    </div>
                    <div id="collapseSixteen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Crowdera believes that all effort put into
                                the campaign deserves to be paid off. Therefore, you receive all of the funds you have raised even 
                                if you do not meet your fundraising goal.</p>
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
                            <p class="text-justify">You keep every fund you raise!</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Duration</h3>
                
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#coownerquestion1">Who is a Owner?</a>
                        </h4>
                    </div>
                    <div id="coownerquestion1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>The person who creates a campaign is the Campaign Owner.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#coownerquestion2">Who is a co-owner?</a>
                        </h4>
                    </div>
                    <div id="coownerquestion2" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>People who are nominated by a Campaign Owner to work for a campaign are Co-owners.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#coownerquestion3">I am an Owner how can I nominate a Co-owner for my campaign?</a>
                        </h4>
                    </div>
                    <div id="coownerquestion3" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>You can add co-owners under the Admin section when you create or edit your campaign.You can add upto 3 co-owners.</p>
                        </div>
                    </div>
                </div>
                 
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
                                     <li>Validate team requests.</li>
                                     <li>Enable/disable teams.</li>
                                     <li>Edit campaign.</li>
                                     <li>Edit team details.</li>
                                 </ul>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Perks</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#perkcollapsequestion1">How do I create a perk?</a>
                        </h4>
                    </div>
                    <div id="perkcollapsequestion1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To create a perk</p>
                            <ul>
                                <li>Login into your account</li>
                                <li>Click on Create on the upper right hand corner</li>
                                <li>Complete the first step and click on Create Now</li>
                                <li>Once you complete all the information at the beginning of the form, you can scroll down to the Perk Section</li> 
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f5d5b68f-6794-4ff7-a92f-af6a71520850.png" alt="Perks">
                                <br>
                                <li>To add a mode of delivery just click on each mode of delivery that you want to choose.</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/6dfa560d-8d7b-4fe3-992b-400986ff3f82.png" alt="Mode of Delivery">
                                <br>
                                <li>To add any custom details such as size of t-shirt etc. use the custom field.</li>
                                <br>
                                    <img class="img-responsive" src="http://s3.amazonaws.com/crowdera/assets/47f3acae-2c00-4f1e-abf9-0c2b696503f9.png" alt="Custom-field">
                                <br>
                                <li>Use the following icons to Save, Add another perk or Delete the perk</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/ef8f6b9f-2265-4dfd-bf89-ebcb03fcd100.png" alt="save-delete">
                                <br>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwelve">How do I edit a perk?</a>
                        </h4>
                    </div>
                    <div id="collapseTwelve" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <ul>
                                <li>Login to your Crowdera account</li>
                                <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                <li>Select Dashboard</li> 
                                <li>Select Manage Campaign</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/3e5dde0f-bbc2-47b7-9397-bc52cd6a4a55.png" alt="manage-perks-tabs-tile">
                                <br>
                                <li>Move the cursor to the perk you want to edit and click on the edit icon</li>
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/4cf6dc76-1b19-4e15-a28c-034fa67bd41d.png" alt="manage-edit-perktile">
                                <br>
                                <li>Update the details of the perk</li> 
                                <br>
                                    <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f77676ec-3b42-4611-99f3-ce81bf171832.png" alt="manage-edit-perk-modal">
                                <br>
                            </ul>
                        </div>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenOne">How do I add a new perk after my campaign is complete?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>To add a new perk once your campaign is complete or live</p>
                                 <ul>
                                     <li>Login to your Crowdera account</li>
                                     <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                     <li>Select Dashboard </li>
                                     <li>Select Manage Campaign</li>
                                     <li>Select Perks</li>
                                     <li>Click on Create Perk</li>
                                     <br>
                                        <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/8b13ae76-f359-45bf-a95a-943491d80a61.png" alt="manage-create-perks">
                                     <br>
                                     <li>On the pop up that appears fill in the details of the perk</li>
                                     <br>
                                        <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/d6a5a55c-bf4a-4edd-b20c-e20f965e12df.png" alt="manage-create-perks-modal">
                                     <br>
                                 </ul>
                        </div>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTentwo">How do I add the shipping information needed for delivering the perks?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTentwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>While creating a perk,</p>
                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/6dfa560d-8d7b-4fe3-992b-400986ff3f82.png" alt="manage-create-mode-of-delivery">
                                 <br>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Managing a campaign</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsemnageOne">How do I access my campaign dashboard now that it is live?</a>
                        </h4>
                    </div>
                    <div id="collapsemnageOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            
                            <p>Follow these steps to access your campaign dashboard</p>
                            <ul>
                                 <li>Login to your Crowdera account</li>
                                 <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                 <li>Select Dashboard</li> 
                                 <li>Select Manage Campaign</li>
                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/c7b3d835-7934-4c5d-bf80-1280ee7cb26c.png" alt="manage-campaign-dashboard">
                                 <br>
                                 <li>Your campaign dashboard will look like the following picture. All options to run your campaign are available on that page</li>
                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/2d819502-d322-4e18-9a38-ec773079f5bc.png" alt="manage-campaign-tabs">
                                 <br>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsemnageTwo">How can I extend the deadline of my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapsemnageTwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p>Follow these steps to extend the deadline of your campaign</p> 
                            <ul>
                                <li>Login to your Crowdera account.</li>
                                <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                <li>Select Dashboard </li>
                                <li>Select Manage Campaign for the campaign you want to extend the deadline for </li>
                                <li>Click on the edit button on the right hand side of the page</li>
                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/e4ba0ca0-f33f-4e72-bf03-6fa7c50e5c4c.png" alt="org-tile-edit">
                                 <br>
                                 <li>Extend the deadline using the drop down calendar</li>
                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/dba8ac6c-3ab6-4266-baee-3f259fa06d46.png" alt="deadline dropdown">
                                 <br>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsemnageThree">How do I add updates to my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapsemnageThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p>Follow these steps to add updated to your campaign</p> 
                            <ul>
                                <li>Login to your Crowdera account</li>
                                <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                <li>Select Dashboard </li>
                                <li>Select Manage Campaign</li>
                                <li>Click on the Updates tab</li>

                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/578b13f6-f685-4abd-81c2-34c207ddd6b8.png" alt="update-tabs">
                                 <br>
                                 <li>Click on the Create Update button on the right hand side of the page </li>
                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/775fd520-8c1f-4a99-aff2-df077212e781.png" alt="create-update">
                                 <br>
                                 <li>Fill in the details and submit your update</li>
                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/8dad43fb-21fe-4ad9-b847-90c637db9c1b.png" alt="create-updatepage">
                                 <br>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsemnageFour">How can I add team members to my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapsemnageFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p>Teams can only be added once your campaign is live. Follow these steps to invite team members to join your campaign </p> 
                            <ul>
                                <li>Login to your Crowdera account</li>
                                <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                <li>Select Dashboard </li>
                                <li>Select Manage Campaign</li>
                                <li>Click on the Teams tab</li>

                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/846a37a4-00c0-4c16-9bdd-3e4375e9db8d.png" alt="Teams-tabs">
                                 <br>
                                 <li>Click on the Activity dropdown</li>
                                 <li>Click on Invite Members </li>
                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/01f30013-0957-485b-a981-45b046fd0f4a.png" alt="Activitydropdown">
                                 <br>
                                 <li>Fill in the email address of those you want to invite and add a personalized message if you want</li>
                                 <br>
                                     <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/9e2b4819-c44e-47cc-bfe7-90756d3c21b7.png" alt="InviteTeams">
                                 <br>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsefive">How do I validate the team request?</a>
                        </h4>
                    </div>
                    <div id="collapsefive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Follow these steps to valid the team request</p>
                                 <ul>
                                     <li>Login to your Crowdera account</li>
                                     <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                     <li>Select Dashboard </li>
                                     <li>Select Manage Campaign</li>
                                     <li>Click on the Teams tab</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/846a37a4-00c0-4c16-9bdd-3e4375e9db8d.png" alt="Teams-tabs">
                                     <br>
                                     <li>Click on the Activity dropdown</li>
                                     <li>Click on Validate Team</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/9432705d-1110-4045-954a-18dffbfe54a5.png" alt="Teams-Activity">
                                     <br>
                                     <li>Click on Validate </li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/c430aba7-b799-4ba4-a2f1-1e2a8e782348.png" alt="Teams-Validation">
                                     <br>
                                 </ul>
                        </div>
                    </div>
                </div>
                
              <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsemanageSix">How can I enable or disable a team?</a>
                        </h4>
                    </div>
                    <div id="collapsemanageSix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Follow these steps to enable or disable a team</p>
                                 <ul>
                                     <li>Login to your Crowdera account</li>
                                     <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                     <li>Select Dashboard </li>
                                     <li>Select Manage Campaign</li>
                                     <li>Click on the Teams tab</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/846a37a4-00c0-4c16-9bdd-3e4375e9db8d.png" alt="Teams-tabs">
                                     <br>
                                     <li>Click on the Activity dropdown</li>
                                     <li>Click on Campaign Statistics</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/9854761f-4a38-4ddf-ab9c-33d6c8405057.png" alt="Teams-Activity">
                                     <br>
                                     <li>Disable or enable under the Team Status</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/026c1c5a-ef51-4157-830e-9706c500df9c.png" alt=" Campaign Statistics">
                                     <br>
                                 </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsemanageSeven">Where do I access the contribution report? Where do I find my contributors details?</a>
                        </h4>
                    </div>
                    <div id="collapsemanageSeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Follow these steps to enable or disable a team</p>
                                 <ul>
                                     <li>Login to your Crowdera account</li>
                                     <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                     <li>Select Dashboard </li>
                                     <li>Select Manage Campaign</li>
                                     <li>Click on the Contributions tab</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/0ca47412-84ce-4621-bcda-d1ded1894efd.png" alt="Contribution-tabs">
                                     <br>
                                     <li>Click on Report</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/b01249b9-a500-44fd-a8b1-2662770411eb.png" alt="Click Report">
                                     <br>
                                     <li>You will be able to see the details of your contributors, as well as generate a CSV file</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/37d8852c-ddf0-411b-8109-aac9e9a32f3c.png" alt="Contribution Report">
                                     <br>
                                 </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsemanageeight">How do I add offline contributions?</a>
                        </h4>
                    </div>
                    <div id="collapsemanageeight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Follow these steps for offline contributions</p>
                                 <ul>
                                     <li>Login to your Crowdera account</li>
                                     <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                     <li>Select Dashboard </li>
                                     <li>Select Manage Campaign</li>
                                     <li>Click on the Contributions tab</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/0ca47412-84ce-4621-bcda-d1ded1894efd.png" alt="Contribution-tabs">
                                     <br>
                                     <li>Click on Manage Offline Contribution</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/4d26975d-f1e5-40d8-813b-3caccf97d5e4.png" alt="Manage offline">
                                     <br>
                                     <li>Fill in the details of the offline contribution. You will have to entry each contribution individually</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/98c26b59-cdcb-4d22-a49f-f461c5138674.png" alt="contributionoffline">
                                     <br>
                                 </ul>
                        </div>
                    </div>
                </div>
                
               <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsemanageNine">How do I share my campaign on social media?</a>
                        </h4>
                    </div>
                    <div id="collapsemanageNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Follow these steps to share your campaign on social media</p>
                                 <ul>
                                     <li>Login to your Crowdera account</li>
                                     <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                     <li>Select Dashboard </li>
                                     <li>Select Manage Campaign</li>
                                     <li>Use the social icons marked to share your campaign on social media and other channels</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/3c267ea5-2499-4aea-bf4c-a2759afdf9f2.png" alt="managepage-socialshare">
                                     <br>
                                 </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsemanageTen">How do I embed my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapsemanageTen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Follow these steps to embed your campaign</p>
                                 <ul>
                                     <li>Login to your Crowdera account</li>
                                     <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                     <li>Select Dashboard </li>
                                     <li>Select Manage Campaign</li>
                                     <li>Use the embed icon marked in the picture below</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/258fc236-93eb-4d3d-b927-5d87010acab1.png" alt="embedmanage-video">
                                     <br>
                                     <li>Copy the code and paste it</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/6e182900-9df6-49cf-a7a5-0faaab445abf.png" alt="Embed modal">
                                     <br>
                                 </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsemanageEleven">Where can I access the short link to the campaign</a>
                        </h4>
                    </div>
                    <div id="collapsemanageEleven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Follow these steps to get the short link to your campaign</p>
                                 <ul>
                                     <li>Login to your Crowdera account</li>
                                     <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                     <li>Select Dashboard </li>
                                     <li>Select Manage Campaign</li>
                                     <li>Click on the link icon marked below and copy the link displayed to share</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/e6bad6db-c712-45d7-b699-be65e0cdca3c.png" alt="Short Link">
                                     <br>
                                 </ul>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsemanageTwelve">How do I share the campaign via email directly from Crowdera?</a>
                        </h4>
                    </div>
                    <div id="collapsemanageTwelve" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Follow these steps to share the campaign via email directly from Crowdera</p>
                                 <ul>
                                     <li>Login to your Crowdera account</li>
                                     <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                                     <li>Select Dashboard </li>
                                     <li>Select Manage Campaign</li>
                                     <li>Click on the mail icon marked below</li>
                                     <br>
                                         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/94d9c5a3-fb42-4d33-9238-d27cd0c17645.png" alt="Email-Link">
                                     <br>
                                 </ul>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Validation</h3>
                
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProTenTenNine">I have already submitted my campaign, then why does it show “Pending” ?</a>
                        </h4>
                    </div>
                    <div id="collapseProTenTenNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Pending banner indicates your campaign is still being verified by the administrator.</p>
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
                            <p class="text-justify">After submitting, the campaign go through an approval process. Once the campaign is approved , it goes live on the Crowdera platform.</p>
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
                            <ul>
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyTwo">My campaign was rejected. How do I know the reason for rejection?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyTwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Please read the FAQ section and our crowdfunding guidelines sections thoroughly to understand the criterion of selection. If you feel you need more information, you can reach out to the Crowdera Crew to find out why your campaign was rejected.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Contributor</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorOne">How do I follow a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorOne" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To follow a campaign</p>
                        </div>
                        <ul>
                             <li>Log into your Crowdera account </li>
                             <li>Go to the campaign you want to follow </li>
                             <li>Click on the Follow icon marked in the picture below</li> 
                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/2820827a-e295-4ab3-98c6-82469a54f3a6.png" alt="Follow-campaign">
                             <br>
                             <li>Once followed, you will be able to receive updates for the campaign via email</li> 
                        </ul>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorTwo">How can I access my contribution dashboard?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorTwo" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To access your contributions</p>
                        </div>
                        <ul>
                             <li>Log into your Crowdera account </li>
                             <li>Click on “Your Name” that appears on the upper right corner of the page</li>
                             <li>Select Dashboard</li> 
                             <li>You can see the campaigns you have contributed to under the Campaigns Supported section</li>

                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/8196b57e-bb8e-4933-bb48-23181683b732.png" alt="Campagin Support">
                             <br>
                        </ul>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorThree">How can I invite my friends to view the campaign via email?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorThree" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To invite your friends to view a campaign you are supporting</p>
                        </div>
                        <ul>
                             <li>Click on the email icon on the campaign detail page</li>
                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/ce1ed42d-bec3-4b17-ab04-6317666c737a.png" alt="social-email">
                             <br>
                             <li>Fill out the details on the pop up that appears</li>
                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/7b67aea3-0252-404b-a633-627db651d446.png" alt="Recipient Email">
                             <br>
                        </ul>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorFour">How do I make a contribution?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To make a contribution go the campaign you would like to support</p>
                        </div>
                        <ul>
                             <li>Click on the Fund Now button</li>
                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/d8694e73-d259-4895-bfdd-eb519d86d4ab.png" alt="Fund now">
                             <br>
                             <li>Fill in the details and click on Fund This Campaign</li>
                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/ed446534-cc0c-49c1-9042-4c2f097b9118.png" alt="Amount for fund">
                             <br>
                             <li>You will be redirected to a PayPal Checkout page</li>
                             <li>Fill in the details and click pay</li>
                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/f2489a56-95a5-4212-84f5-751d47f70b5d.png" alt="Pypal transactions page">
                             <br>
                             <li>Once done you will automatically redirected to Crowdera</li>
                        </ul>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorFive">How can I view the website of the campaigner?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorFive" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To view the website of the campaigner</p>
                        </div>
                        <ul>
                             <li>Go to the campaign detail page </li>
                             <li>Click on the globe icon on the right side of the page </li>

                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/03f4d3ee-9d2f-43ab-92ae-ace5a1e07747.png" alt="org-Globe">
                             <br>
                        </ul>
                    </div>
                </div>
                
                 <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorSix">How do I leave comments for the campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorSix" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To leave a comment and encourage the fundraisers</p>
                        </div>
                        <ul>
                             <li>Log into your Crowdera Account</li>
                             <li>Go to the campaign you want to leave a comment for </li>
                             <li>Click on comments on the campaign page </li>

                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/4204c234-89d1-429c-8b55-c320b190b445.png" alt="comments-tab">
                             <br>
                             <li>Type your comment in the box and click on Post Comment</li>
                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/7d432e04-c31d-41c8-91b8-0b44117e6509.png" alt="Post comment">
                             <br>
                        </ul>
                    </div>
                </div>
                
               <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorSeven">How do I edit or delete my comment?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorSeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To edit or delete a comment from a campaign</p>
                        </div>
                        <ul>
                             <li>Log into your Crowdera Account</li>
                             <li>Go to the campaign that you commented on</li>
                             <li>Click on comments</li>
                             <li>You will see your comment. Click on the icons to either edit or delete your comment</li>
                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/71872495-12f8-44f3-87c9-5d624f12302c.png" alt="comments-edit-delete">
                             <br>
                             
                        </ul>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorEight">How do I contribute anonymously?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorEight" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To make an anonymous contribution,</p>
                        </div>
                        <ul>
                             <li>Go the campaign you would like to support</li>
                             <li>Click on the Fund Now button</li>

                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/d8694e73-d259-4895-bfdd-eb519d86d4ab.png" alt="Fund now">
                             <br>
                             <li>Make sure to select “Please keep my contribution anonymous”</li>
                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/a5558316-d8fa-4c19-8cff-71cb25acc40e.png" alt="Fund-amount-anonymous">
                             <br>
                        </ul>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorNine">How do I select perks?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorNine" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">To select a perk</p>
                        </div>
                        <ul>
                             <li>Go to the campaign you want to support</li>
                             <li>Click on the Fund Now button</li>

                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/d8694e73-d259-4895-bfdd-eb519d86d4ab.png" alt="Fund now">
                             <br>
                             <li>Select the perk you want on the following page</li>
                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/17d40955-194a-4466-b6dc-5d71f30f20bc.png" alt="Fund-perks-selections">
                             <br>
                        </ul>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorTen">How do I enter my shipping details?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorTen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Once you have selected the perk you want, you will see the shipping information section on the screen.</p>
                            <p>Fill in the details to get your perk.</p> 
                        </div>
                             <br>
                                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/eea69923-9923-4cc7-a577-41dec8b55e78.png" alt="fund-shipping-info">
                             <br>
                    </div>
                </div>

                <h3 class="faq-subheading">Contributions</h3>
                
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContri1">Can I export my contribution report?</a>
                        </h4>
                    </div>
                    <div id="collapseProContri1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>Yes, You can download the CSV report from the “Contribution” tab on the Manage Campaign page.</p>
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
                                     <li>Log into your Crowdera Account.</li>
                                     <li>Go to My Campaigns.</li>
                                     <li>Select the campaign.</li>
                                     <li>Click on the Activity.</li>
                                     <li>Select Invite Members.</li>
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
                                     <li>Log into your Crowdera Account.</li>
                                     <li>Go to My Campaigns.</li>
                                     <li>Select the campaign.</li>
                                     <li>Click on the Activity.</li>
                                     <li>Select Validate/Discard Team.</li>
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
                                     <li>Log into your Crowdera Account.</li>
                                     <li>Go to My Campaigns.</li>
                                     <li>Select the campaign.</li>
                                     <li>Click on the Activity.</li>
                                     <li>Select Validate/Discard Team.</li>
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
                
                <h3 class="faq-subheading">Social Media</h3>
                
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
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTen">Why do I need to build a strong social network and share my campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseTen" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">We have noticed that the campaigns that can rally about 30% of the funding immediately upon launch have a higher success rate. Therefore, we recommend that the initial 30% funding comes from your existing network and supporters. Share your campaign with your inner network as soon as you create it and encourage them to share it on their social media networks as well.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Campaign Updates</h3>
                
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
                                 <p>You can upload multiple images but recommend not adding more than 3. </p>
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
                
                <h3 class="faq-subheading">After campaign is live </h3>
                
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
                
                <h3 class="faq-subheading">Contributor Questions</h3>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentyFour">Do I need to sign up to contribute?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentyFour" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">No, you do not need to sign up to contribute. However, 
                            we recommend you sign up so you can track the progress of campaigns you have funded.</p>
                        </div>
                    </div>
                </div>
                
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributorQ1">Why should I contribute through Crowdera instead of contributing directly?</a>
                        </h4>
                    </div>
                    <div id="collapseContributorQ1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <ul>
                                     <li>Crowdera is curated platform, we review every application for its content and story, and approve campaigns at our discretion if we feel mission of the project is aligned to make a social impact.</li>
                                     <li>Crowdera gives you diversity in terms of organizations and causes to fund.</li>
                                     <li>We encourage campaign creators to update you about the campaign as well as the organization.</li>
                                     <li>Funding through Crowdera, you know which campaign you are being part of and where your funds will be utilized.</li>
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor12">I can not contribute online, but I wish to contribute for the cause.</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor12" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>You can contribute offline to Campaign Owners/Co-owners/Teams and they can record it as offline contribution. If you want to give a large grant to a project, you can reach out to one of our partnership managers <a href="mailto:chet@crowdera.co">here</a></p>
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
                                choose either one for their campaigns. You can pay with any
                                credit or debit cards.</p>
                        </div>
                    </div>
                </div>
                
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseContributor1">How do I know the authenticity of organization, individual creating the campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseContributor1" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">All campaigns go through an approval process. 
                            Even though Crowdera carefully goes through all the information prior to approving a campaign, 
                            we request contributors to conduct due diligence before contributing.</p>
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
                            <p class="text-justify">Crowdera ensures that all the funds are directed from the payment gateway directly to the organization/beneficiary. 
                            You can be assured that your funds have reached the organization as the funds do not go through multiple hands.</p>
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseProContributor13">Where can I see my contribution details on the campaign I just supported?</a>
                        </h4>
                    </div>
                    <div id="collapseProContributor13" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                                 <p>You can see your contribution details under the contribution tab on the campaign detail page. </p>
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
                            <p class="text-justify">Not all contributions will be tax deductible. 
                            Contributions made to registered 501 c 3 nonprofits are tax deductible. 
                            We recommend you check the details of the organization and contact them with queries about tax deductions.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Transactions</h3>
                
                                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwentySeven">Is your site secure for online credit / debit card transactions?</a>
                        </h4>
                    </div>
                    <div id="collapseTwentySeven" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">
                                Yes it is. Donations and contributions are collected and processed by
                                our third-party vendors pursuant to the terms and conditions of its
                                privacy policy, and we do not have access to any billing
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
                            <p class="text-justify">If you have received an error while contributing, check your email for a payment confirmation from Paypal or FirstGiving. 
                            If you have not received a confirmation for your contribution your card has not been charged.
                            </p>
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
                            <p class="text-justify">Crowdera doesn’t hold the payments and money is directly transferred to the beneficiary’s account. You may cancel the transaction by directly reaching out to the beneficiaries.</p>
                        </div>
                    </div>
                </div>
                
                <h3 class="faq-subheading">Anonymous Contributions</h3>
                
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseanonymousContribution">Can I contribute anonymously for a campaign?</a>
                        </h4>
                    </div>
                    <div id="collapseanonymousContribution" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes you can. Just check the anonymous box that appears when you make a contribution.</p>
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
                                 <p><b>Logged In User</b></p>
                                 <ul>
                                     <li>Name and Amount Visibility.</li>
                                     <li>Name anonymous and Amount visible.</li>
                                 </ul>
                                 <p><b>Non Logged in User</b></p>
                                 <ul>
                                     <li>Name and Amount Visibility.</li>
                                     <li>Name anonymous and Amount visible.</li>
                                 </ul>
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
                
                <h3 class="faq-subheading">Social Sharing</h3>
                
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
                
                <h3 class="faq-subheading">Perks</h3>
                
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
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThirtySevens">Can I receive perks after donating anonymously?</a>
                        </h4>
                    </div>
                    <div id="collapseThirtySevens" class="panel-collapse collapse faq-panel-height">
                        <div class="panel-body">
                            <p class="text-justify">Yes you can. You will need to provide the shipping information required for the delivery of perk.</p>
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
                
                <h3 class="faq-subheading">Team Contributions</h3>
                
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
                
            </div>
        </div>
    </div>
</g:else>
</div>           
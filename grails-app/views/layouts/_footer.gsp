<!-- Changes for new home page -->
<input type="hidden" id="b_url" value="${base_url}" />
<div id="footermarker"></div>
<footer>
    <div class="footer_links">
    <g:if test="${country_code == 'in'}">
        <div class="container footer-container">
    <div class="visible-lg footer-lg">
    <div class="row footer-lg-first-section">
        <div class="col-md-4 footer-logosize">
            <a href="${resource(dir: '/')}">
				<g:if test="${country_code == 'in'}">
                    <img src="//s3.amazonaws.com/crowdera/assets/Crowdera-logo.png" alt="Crowdera">
                </g:if>
                <g:else>
                    <img src="//s3.amazonaws.com/crowdera/assets/crowdera-footer-logo-cdra.png" class="cdra-ft-clogo" alt="Crowdera">
                </g:else>
            </a>
            <div class="col-md-6 footer-mid-section-menu">
            <ul>
                <li><a href="${resource(dir: '/')}">Home</a></li>
                <li><a href="${resource(dir: '/aboutus')}">About Us</a></li>
                <li><a href="${resource(dir: '/careers')}" >Careers</a></li>
                <li><a href="${resource(dir: '/campaigns')}" >Explore Campaigns</a></li>
                <li><a href="${resource(dir: '/customer-service')}">Contact Us</a></li>
                <li><a href="http://gocrowdera.com" target="_blank">Blog</a></li>
                
            </ul>
            </div>
            <div class="col-md-6 footer-mid-section-menu">
            <ul>
                <li><g:link controller="project" action="create">Start Your Campaign</g:link></li>
                <li><a href="${resource(dir: '/howitworks')}">How it works</a></li>
                <li><a href="${resource(dir: '/crowdfunding-ebook')}">Crowdfunding Ebook</a></li>
                <g:if test="${isTestEnv}">
                    <li><g:link controller="user" action="partners">Partner Pages</g:link></li>
                </g:if>
                <li><a href="${resource(dir: '/faq')}">FAQ</a></li>
<%--                <li><a href="${resource(dir: '/Learning-Center')}">Learn More</a></li>--%>
            </ul>
        
            </div>
        </div>
        
        <div class="col-md-4 cdra-ft-top">
				<g:if test="${country_code == 'in'}">            
				    <p class="cdra-ft-cutomercnt">Customer support:</p>
                    <p class="cdr-ft-contactnum">+91 721 970 2234</p>
                    <p class="cdra-ft-contactmail">support@crowdera.co</p>
                </g:if>
                <g:else>
                    <p class="cdra-ft-cutomercnt">Customer support:</p>
                    <p class="cdr-ft-contactnum">+1 (650) 690 2234</p>
                    <p class="cdra-ft-contactmail">support@crowdera.co</p>
                </g:else>
            </div>
            
            <div class="col-md-4 socialiconlinks footer-mid-section">
            <br>
            <div class="socialicon pull-right">
            <a href="http://gocrowdera.com"  target="_blank"><img class="blogsocialicon" src="//s3.amazonaws.com/crowdera/assets/wordpress-gray.png" alt="blog"></a>
            <a href="https://plus.google.com/102697810290030135564"  target="_blank"><img class="googleplussocial" src="//s3.amazonaws.com/crowdera/assets/googleplus-gray.png.png" alt="googlepluse"></a>
            <a href="https://www.facebook.com/crowderainc?ref=hl"  target="_blank"><img class="facebooklink" src="//s3.amazonaws.com/crowdera/assets/facebook-footer.png" alt="facebook"></a>   
            <a href="https://twitter.com/gocrowdera"  target="_blank"><img class="twittersocialicon" src="//s3.amazonaws.com/crowdera/assets/twitter-footer.png" alt="twitter"></a>
            <a href="https://www.linkedin.com/company/crowdera"  target="_blank"><img class="linkedin-footer" src="//s3.amazonaws.com/crowdera/assets/linkedin-footer.png" alt="linkedin"></a>
            <a href="https://instagram.com/gocrowdera"  target="_blank"><img class="instagram-footer" src="//s3.amazonaws.com/crowdera/assets/instagram-footer.png" alt="instagram"></a>
            
            <br><br>
            </div>
            <br><br>
            <div class="footer-newsletter">
            <form action="${mailChimpUrl}" method="post" id="mvc-embedded-subscribe-form-lg" name="mc-embedded-subscribe-form" class="validate" target="_blank">
                <div class="newsletter-alignment col-lg-12">
                <div class="newsletter-input col-lg-10">
                    <input type="text" class="all-place form-control subscriberEmail" name="EMAIL" tabindex="-1" value="" placeholder="Your email">
                </div>
                <div class="newsletter-button footer-signup-margin col-lg-2">
                    <input type="submit" value="" name="subscribe" class="button-signup signup-lg">
                    <br><br>
                        </div>
                </div>
            </form>
            </div>
            <div class="thomas-owens-testimonial-div">
                <p class="thomas-owens-testimonial">"The idea of enabling non-profits to raise funds free enabled Two Cents of Hope to avoid commissions and help more students in need. 
                    I'd recommend Crowdera to every serious fundraiser." <br><br>
                <g:if test="${country_code == 'in'}">
                	<span class="thomas-margin-align">- Swaroop Ramchandra</span><br>
                </g:if>
                <span class="thomas-margin-align">Two Cents of Hope</span><br>
            </div>
        </div>
        <hr class="footer-hr">
        </div>
         
        <div class="row">
        <div class="col-md-8 footer-last-section-payment-icon">
            <g:if test="${currentEnv == 'test' || currentEnv == 'staging' || currentEnv == 'production' || currentEnv=='development'}">
                <div class="col-md-6 payment-method-footer">
                    <span>Payment Methods</span>
                    <img src="//s3.amazonaws.com/crowdera/assets/payment-icon-Card.png" alt="payment-icon">
                </div>
                <div class="col-md-6 secure-payment-footer">
                    <table>
                        <tr>
                            <td>
                                <img src="//s3.amazonaws.com/crowdera/assets/secure-payment-icon-footer.png" alt="secure-payment">
                            </td>
                            <td>
                                <div class="footer-text-align">100% Secure Payment</div>
                            </td>
                        </tr>
                    </table>
                </div>
            </g:if>
        </div>
        <g:if test="${country_code == 'in'}">
            <div class="col-md-12 text-center footer-last-section-links">
                <span class="text-primary ft-text-terms-privacy">
                    <a href="${resource(dir: '/termsofuse')}" class="footerlink">Terms Of  Use</a>&nbsp;&nbsp;
                <a href="${resource(dir: '/privacypolicy')}" class="footerlink">Privacy Policy &nbsp;&nbsp;</a>
                <a class="footerlink">&copy;&nbsp; 2016 Crowdera, Inc.</a>
                </span>
            </div>
        </g:if>
        <g:else>
            <div class="col-md-4 footer-last-section-links">
                <span class="text-primary">
                    <a href="${resource(dir: '/termsofuse')}" class="footerlink">Terms Of  Use</a>&nbsp;&nbsp;
                <a href="${resource(dir: '/privacypolicy')}" class="footerlink">Privacy Policy &nbsp;&nbsp;</a>
                <a class="footerlink">&copy;&nbsp; 2016 Crowdera, Inc.</a>
                </span>
            </div>
        </g:else>
        </div>
        <g:if test="${country_code == 'in'}">
            <div class="row">
                <div class="col-lg-12 footer-disclaimer-lg">
                    <span class="footer-disclaimer">Disclaimer: Contributing through Crowdera Ventures India Pvt Ltd (Crowdera) is not always a tax exempt charitable donation.
                    Crowdera does not guarantee that beneficiary projects will be fully or partially funded. Crowdera is an internet platform to connect individuals, non-profits and contributors to collaborate published purposes. Crowdera does not take any responsibility for any promises made by campaign creators on our platform.
                    Please read the Terms of Use and Privacy Policy prior performing any transactions on our platform. *Crowdera does not charge a fee, however payment gateway and bank transfer fee are applicable.</span>
                </div>
            </div>
        </g:if>
    </div>
    </div>
    </g:if>
     <g:else>
        <div class="row newFooteroptions">
           <div class="col-md-2 newLeftfooter">
              <a href="/">
                 <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/8fbfaf2c-44e5-4a93-9a6c-df23bc199467.png" title="Footer-Crowdera---Logo.png">
              </a>
              <br>
              <b class="footerleftsubTitle">Crowdera is <br>World's #1 Truly Free Online Fundraising <br>Platform For Nonprofits,NGOs<br> and Individuals</b>
              <br>
                 <p class="cdra-ft-cutomercnt footersubTitlenew">Customer support:</p>
                 <p class="cdr-ft-contactnum contactNewbold">+1 (650) 690 2234</p>
                 <p class="cdra-ft-contactmail contactNewnormal">support@crowdera.co</p>
           </div>
           <div class="col-md-2 footerNopadding">
              <b><a class="footerTitle">Crowdera</a></b>
              <br>
              <ul style="list-style-type:none;display:initial">
              <li>
                 <a class="footersubTitle">About Us</a>
              </li>
              <li>
                 <a class="footersubTitle">Our Blog</a>
              </li>
              <li>
                 <a class="footersubTitle">Media & Press</a>
              </li>
              <li>
                 <a class="footersubTitle">Contact Us</a>
              </li>
              <li>
                 <a class="footersubTitle">Pricing & Fee</a>
              </li>
              <li>
                 <a class="footersubTitle">Success Stories</a>
              </li>
              <li>
                 <a class="footersubTitle">Learning Center</a>
              </li>
              <li>
                 <a class="footersubTitle">Compassionate Souls</a>
              </li>
              <li>
                 <a class="footersubTitle">Careers & Internships</a>
              </li>
              <li>
                 <a class="footersubTitle">Support & Helpdesk</a>
              </li>
              <li>
                 <a class="footersubTitle">Marketing Partners</a>
              </li>
              </ul>
           </div>
           <div class="col-md-2 footerNopadding">
           <b><a class="footerTitle">Crowdfunding</a></b>
              <br>
              <ul style="list-style-type:none;display:initial">
              <li>
                 <a class="footersubTitle">Start A Campaign</a>
              </li>
              <li>
                 <a class="footersubTitle">Discover Campaigns</a>
              </li>
              <li>
                 <a class="footersubTitle">Crowdfunding Features</a>
              </li>
              <li>
                 <a class="footersubTitle">How It Works</a>
              </li>
              <li>
                 <a class="footersubTitle">Fundraising Ideas</a>
              </li>
              <li>
                 <a class="footersubTitle">Perk Ideas</a>
              </li>
              <li>
                 <a class="footersubTitle">Customer Speak</a>
              </li>
              <li>
                 <a class="footersubTitle">Crowdfunding FAQ</a>
              </li>
              </ul>
           </div>
           <div class="col-md-2 footerNopadding">
           <b><a class="footerTitle">Nonprofits</a></b>
              <br>
              <ul style="list-style-type:none;display:initial">
              <li>
                 <a class="footersubTitle">Register Nonprofit</a>
              </li>
              <li>
                 <a class="footersubTitle">Start Nonprofit Fundraiser</a>
              </li>
              <li>
                 <a class="footersubTitle">How It Works</a>
              </li>
              <li>
                 <a class="footersubTitle">Vetting Process</a>
              </li>
              <li>
                 <a class="footersubTitle">Volunteer</a>
              </li>
              <li>
                 <a class="footersubTitle">Nonprofit FAQs</a>
              </li>
              <li>
                 <a class="footersubTitle">Charity Challenges</a>
              </li>
              <li>
                 <a class="footersubTitle">Google Grant</a>
              </li>
              <li>
                 <a class="footersubTitle">Nonprofit Fundraising Ideas</a>
              </li>
              <li>
                 <a class="footersubTitle">Celebrity Supporters</a>
              </li>
              <li>
                 <a class="footersubTitle">United Nation's SDGs</a>
              </li>
              <li>
                 <a class="footersubTitle">CSR Partners</a>
              </li>
              </ul>
           </div>
           <div class="col-md-2 footerNopadding">
           <b><a class="footerTitle">Products</a></b>
              <br>
              <ul style="list-style-type:none;display:initial">
              <li>
                 <a class="footersubTitle">Donation Processing</a>
              </li>
              <li>
                 <a class="footersubTitle">Donor Management</a>
              </li>
              <li>
                 <a class="footersubTitle">Event Management</a>
              </li>
              <li>
                 <a class="footersubTitle">Donor Communication</a>
              </li>
              <li>
                 <a class="footersubTitle">Team Fundraising</a>
              </li>
              <li>
                 <a class="footersubTitle">Third Party Integrations</a>
              </li>
              <li>
                 <a class="footersubTitle">Features & Pricing</a>
              </li>
              </ul>
           </div>
           <div class="col-md-2 footerNopadding">
           <b><a class="footerTitle">Corporation</a></b>
              <br>
              <ul style="list-style-type:none;display:initial">
              <li>
                 <a class="footersubTitle">Start Giving Page</a>
              </li>
              <li>
                 <a class="footersubTitle">Nominate Nonprofit</a>
              </li>
              <li>
                 <a class="footersubTitle">Nonprofit Vetting</a>
              </li>
              <li>
                 <a class="footersubTitle">Register Your Cause</a>
              </li>
              <li>
                 <a class="footersubTitle">Employee Matching</a>
              </li>
              <li>
                 <a class="footersubTitle">CSR Services</a>
              </li>
              <li>
                 <a class="footersubTitle">Partnership Terms</a>
              </li>
              </ul>
           </div>
           <br><br>
             <div class="footer-newsletter">
             <form action="${mailChimpUrl}" method="post" id="mvc-embedded-subscribe-form-lg" name="mc-embedded-subscribe-form" class="validate" target="_blank">
                 <div class="newsletter-alignment newslettercenterAlligned col-md-8 newsletterPadding">
                 <div class="newsletter-input col-md-3">
                     <input type="text" class="all-place form-control newInnermail subscriberEmail" name="EMAIL" tabindex="-1" value="" placeholder="Your email">
                 </div>
                 <div class="newsletter-button footer-signup-margin col-lg-2">
                     <input type="submit" value="" name="subscribe" class="button-signup signup-lg">
                     <br><br>
                         </div>
                 </div>
             </form>
             </div>
             <div class="row paymentcardRow rowcardBottom">
                <div class="col-lg-2 paymentTop paymentText" style="width: 140px;padding-right: 0px;">
                   <b>Payment Methods:</b>
                </div>
                <div class="col-lg-1 paymentCard paymentTop">
                   <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/e1a2d86d-8948-425a-9789-2895678f0407.png" title="Visa---Card.png">
                </div>
                <div class="col-lg-1 paymentCard paymentTop">
                   <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/2f7a99cb-6c44-47b3-8624-e2913430fd46.png" title="American-Express---Crad.png">
                </div>
                <div class="col-lg-1 paymentCard paymentTop">
                   <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/a3d99e58-0d10-40a6-afaf-1a46e5cda2d5.png" title="Paypal-Card.png">
                </div>
                <div class="col-lg-1 paymentCard paymentTop">
                   <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/71e46519-73e2-49f3-8a69-84b1c0fb6e4f.png" title="Master-Card.png">
                </div>
                <div class="col-lg-1 paymentCard paymentTop pull-right securityNewcard">
                   <img class="img-responsive securetImg" src="//s3.amazonaws.com/crowdera/project-images/350a25e2-d430-4ab9-b3dc-27d493195ecd.png" title="100%-Secure-Payment.png">
                </div>
             </div>
             <hr class="footer-hr rowMargin">
             <br><br><br>
             <div class="row followRow">
                <b class="followUs">FOLLOW US</b>
             </div>
             <br>
             <div class="row socialicon newSocialicon">
                <a href="http://gocrowdera.com"  target="_blank"><img class="blogsocialicon" src="//s3.amazonaws.com/crowdera/assets/wordpress-gray.png" alt="blog"></a>
                <a href="https://plus.google.com/102697810290030135564"  target="_blank"><img class="googleplussocial" src="//s3.amazonaws.com/crowdera/assets/googleplus-gray.png.png" alt="googlepluse"></a>
                <a href="https://www.facebook.com/crowderainc?ref=hl"  target="_blank"><img class="facebooklink" src="//s3.amazonaws.com/crowdera/assets/facebook-footer.png" alt="facebook"></a>   
                <a href="https://twitter.com/gocrowdera"  target="_blank"><img class="twittersocialicon" src="//s3.amazonaws.com/crowdera/assets/twitter-footer.png" alt="twitter"></a>
                <a href="https://www.linkedin.com/company/crowdera"  target="_blank"><img class="linkedin-footer" src="//s3.amazonaws.com/crowdera/assets/linkedin-footer.png" alt="linkedin"></a>
                <a href="https://instagram.com/gocrowdera"  target="_blank"><img class="instagram-footer" src="//s3.amazonaws.com/crowdera/assets/instagram-footer.png" alt="instagram"></a>
             </div>
             <br><br>
             <div class="row termsCondition">
                <a href="#">
                   <b>Terms of Use</b>
                </a>
                <a href="#">
                   <b>Privacy Policy</b>
                </a>
                <a href="#">
                   <b>Sitemap</b>
                </a>
                <a href="#">
                   <b>@ 2016 Crowdera,Inc.</b>
                </a>
             </div>
<%--             <div class="socialicon pull-right">--%>
<%--             <a href="http://gocrowdera.com"  target="_blank"><img class="blogsocialicon" src="//s3.amazonaws.com/crowdera/assets/wordpress-gray.png" alt="blog"></a>--%>
<%--             <a href="https://plus.google.com/102697810290030135564"  target="_blank"><img class="googleplussocial" src="//s3.amazonaws.com/crowdera/assets/googleplus-gray.png.png" alt="googlepluse"></a>--%>
<%--             <a href="https://www.facebook.com/crowderainc?ref=hl"  target="_blank"><img class="facebooklink" src="//s3.amazonaws.com/crowdera/assets/facebook-footer.png" alt="facebook"></a>   --%>
<%--             <a href="https://twitter.com/gocrowdera"  target="_blank"><img class="twittersocialicon" src="//s3.amazonaws.com/crowdera/assets/twitter-footer.png" alt="twitter"></a>--%>
<%--             <a href="https://www.linkedin.com/company/crowdera"  target="_blank"><img class="linkedin-footer" src="//s3.amazonaws.com/crowdera/assets/linkedin-footer.png" alt="linkedin"></a>--%>
<%--             <a href="https://instagram.com/gocrowdera"  target="_blank"><img class="instagram-footer" src="//s3.amazonaws.com/crowdera/assets/instagram-footer.png" alt="instagram"></a>--%>
<%--             <br><br>--%>
<%--             </div>--%>
        </div>
     </g:else>
  </div>
</footer>
<script>
	$("#mvc-embedded-subscribe-form-lg").validate({ 
	    rules: { 
	     EMAIL: { 
	               required: true, 
	               email: true 
	             } 
	    }, 
	    messages: { 
	     email: "" 
	    } 
	 });
</script>
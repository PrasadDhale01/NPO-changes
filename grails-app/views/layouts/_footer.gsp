<g:set var="projectService" bean="projectService"/>
<% 
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    def currentEnv = projectService.getCurrentEnvironment()
    def mailChimpUrl
    if (currentEnv == 'development' || currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
        mailChimpUrl = "//crowdera.us3.list-manage.com/subscribe/post?u=41c633b30eeabc78e88bd090d&id=11344f1cfe"
    } else {
        mailChimpUrl = "//crowdera.us3.list-manage.com/subscribe/post?u=41c633b30eeabc78e88bd090d&amp;id=e37aea1b78"
    }
%>
<input type="hidden" id="b_url" value="<%=base_url%>" />
<!-- Footer -->
<div id="footermarker"></div>
<footer>
    <div class="footer_links">
        <%--<div class="footer-mobile-border visible-xs"></div>--%>
        <div class="container footer-container">
     <div class="visible-xs show-mobilejs">
  <section class="row">  
       <div class="col-xs-12">
   <div class="crowdera-title"><a href="${resource(dir: '/')}"><img src="//s3.amazonaws.com/crowdera/assets/Crowdera-logo.png" alt="Crowdera"></a></div>
        <div class="crowdera-menu">
    <div class="col-xs-6 footer-mid-section-menu-mobile footer-menu-align">
        <div class="quicklinks-menu-div">
     <ul class="quicklinks-menu">
         <li><a href="${resource(dir: '/')}">Home</a></li>
          <li><a href="${resource(dir: '/aboutus')}">About Us</a></li>
         <li><a href="${resource(dir: '/campaigns')}" >Explore Campaigns</a></li>
         <li><a href="${resource(dir: '/customer-service')}">Contact Us</a></li>
         <li><a href="http://gocrowdera.com" target="_blank">Blog</a></li>
     </ul>
        </div>
    </div>
    <div class="col-xs-6 footer-mid-section-menu-mobile footer-menu-align">
        <div class="campaigning-menu-div">
     <ul class="campaigning-menu">
         <li><g:link controller="project" action="create">Start Your Campaign</g:link></li>
         <li><a href="${resource(dir: '/howitworks')}">How it works</a></li>
      <li><a href="${resource(dir: '/crowdfunding-ebook')}">Crowdfunding Ebook</a></li>
         <li><a href="${resource(dir: '/faq')}">FAQ</a></li>
     </ul>
        </div>
      </div>
   </div>
      </div>
  </section>
  <!-- ***********************************Section two************************ -->
  <section class="row">
      <div class="col-xs-12 footer-first-section-mobile footer-text-align">
   <p>Hands up for a Better World. See how you can make a difference with Crowdera.</p>
    <div class="footer-first-section-mobile footer-img-align">
       <img src="//s3.amazonaws.com/crowdera/assets/hand-image-mobile.png" alt="Crowdera">
       <g:link controller="project" action="create"><img src="//s3.amazonaws.com/crowdera/assets/start-a-campaign-mobile.png" alt="Crowdera"></g:link>
   </div>
      </div>
  </section>       
  <!-- ********************************Section three************************* -->
  <section class="row">
      <div class="col-xs-12 footer-mid-section footer-p-text-align">
   <br>
   <div class="socialicon">
       <a href="http://gocrowdera.com"  target="_blank"><img class="blogsocialicon" src="//s3.amazonaws.com/crowdera/assets/blog-footer.png" alt="blog"></a>
       <a href="https://www.facebook.com/crowderainc?ref=hl"  target="_blank"><img class="facebooklink" src="//s3.amazonaws.com/crowdera/assets/facebook-footer.png" alt="facebook"></a>
       <a href="https://twitter.com/gocrowdera"  target="_blank"><img class="twittersocialicon" src="//s3.amazonaws.com/crowdera/assets/twitter-footer.png" alt="twitter"></a>
       <a href="https://www.linkedin.com/company/fedu"  target="_blank"><img class="linkedin-footer" src="//s3.amazonaws.com/crowdera/assets/linkedin-footer.png" alt="linkedin"></a>
       <a href="https://instagram.com/gocrowdera"  target="_blank"><img class="instagram-footer" src="//s3.amazonaws.com/crowdera/assets/instagram-footer.png" alt="instagram"></a>
   </div>
   <br>

            <div class="thomas-testimonial">
                <p>"The idea of enabling non-profits to raise funds free enabled Two Cents of Hope to avoid commissions and help more students in need. 
                    I'd recommend Crowdera to every serious fundraiser." <br><br>
                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"><span class="thomas-margin-align">- Swaroop Ramchandra</span></g:if>
                <span class="thomas-margin-align">Two Cents of Hope</span><br>
            </div>
            <div class="footer-newsletter">
               <form action="${mailChimpUrl}" method="post" id="mc-embedded-subscribe-form-sm" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
                    <div class="col-xs-offset-1 newsletter-align">
                   <br>
                   <div class="col-xs-6 footer-input-align">
                    <input type="text" class="text-email all-place form-control" name="EMAIL" tabindex="-1" value="" placeholder="Your email">
                   </div>
                   <div class="col-xs-6 ">
                    <input type="submit" value="" name="subscribe" id="mc-embedded-subscribe"  class="button-signup signup-sm all-place ">
                   </div>
                </div>
                </form>
            </div>
            <br>
            </div>
        </section>
        
        <!-- *********************Section four*****************-->
        <hr class="footer-hr">
 
        <section class="row">
            <div class="col-xs-12">
                <div class="text-primary">
                    <a href="${resource(dir: '/termsofuse')}" class="footerlink">Terms  Of  Use</a>&nbsp;&nbsp;
                    <a href="${resource(dir: '/privacypolicy')}" class="footerlink">Privacy Policy &nbsp;&nbsp;</a>
                    <a class="footerlink">&copy;&nbsp; Crowdera,inc, 2015</a>
                </div>
            </div>
        </section>
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <section class="row">
                <div class="col-lg-12 footer-disclaimer-lg">
                    <span class="footer-disclaimer">Disclaimer: Contributing through Crowdera Ventures India Pvt Ltd (Crowdera) is not always a tax exempt charitable donation.
                    Crowdera does not guarantee that beneficiary projects will be fully or partially funded. Crowdera is an internet platform to connect individuals, non-profits and contributors to collaborate published purposes. Crowdera does not take any responsibility for any promises made by campaign creators on our platform.
                    Please read the Terms of Use and Privacy Policy prior performing any transactions on our platform. *Crowdera does not charge a fee, however payment gateway and bank transfer fee are applicable.</span>
                </div>
            </section>
        </g:if>
        <br><br>            
    </div>
        
    <!-- Footer Design for medium size device -->
    <div class="visible-sm visible-md">
        <section class="row">
        <div class="col-sm-4 footer-logo-padding-left">
            <a href="${resource(dir: '/')}"><img src="//s3.amazonaws.com/crowdera/assets/Crowdera-logo.png" alt="Crowdera"></a>
            <div class="col-sm-6 footer-mid-section-menu tab-menu-padding">
            <ul>
                <li><a href="${resource(dir: '/')}">Home</a></li>   
                <li><a href="${resource(dir: '/aboutus')}">About Us</a></li>
                <li><a href="${resource(dir: '/campaigns')}" >Explore Campaigns</a></li>
                <li><a href="${resource(dir: '/customer-service')}">Contact Us</a></li>
                <li><a href="http://gocrowdera.com" target="_blank">Blog</a></li>
            </ul>
           </div>
           <div class="col-sm-6 footer-mid-section-menu tab-menu-padding">
            <ul>
                <li><g:link controller="project" action="create">Start Your Campaign</g:link></li>
                <li><a href="${resource(dir: '/howitworks')}">How it works</a></li>
                <li><a href="${resource(dir: '/crowdfunding-ebook')}">Crowdfunding Ebook</a></li>
                <li><a href="${resource(dir: '/faq')}">FAQ</a></li>
            </ul>
            </div>
        </div>
        <div class="col-sm-4 footer-hands-image-top">
            <div class="footer-mid-section-img">
            <br>
            <img src="//s3.amazonaws.com/crowdera/assets/Hands-image-footer.png" alt="Crowdera" class="footer-hands-img">
            <a href="#" class="display-footer-text"><img class="footer-start-cmpg-img" src="//s3.amazonaws.com/crowdera/assets/Hands-up-for-a-better - button.jpg" alt="Crowdera"></a>
            </div>
        </div>
        <div class="col-sm-4 socialiconlinks footer-mid-section">
            <br>
           <div class="socialicon pull-right">
            <a href="http://gocrowdera.com"  target="_blank"><img class="blogsocialicon" src="//s3.amazonaws.com/crowdera/assets/blog-footer.png" alt="blog"></a>
            <a href="https://www.facebook.com/crowderainc?ref=hl"  target="_blank"><img class="facebooklink" src="//s3.amazonaws.com/crowdera/assets/facebook-footer.png" alt="facebook"></a>
            <a href="https://twitter.com/gocrowdera"  target="_blank"><img class="twittersocialicon" src="//s3.amazonaws.com/crowdera/assets/twitter-footer.png" alt="twitter"></a>
            <a href="https://www.linkedin.com/company/fedu"  target="_blank"><img class="linkedin-footer" src="//s3.amazonaws.com/crowdera/assets/linkedin-footer.png" alt="linkedin"></a>
            <a href="https://instagram.com/gocrowdera"  target="_blank"><img class="instagram-footer" src="//s3.amazonaws.com/crowdera/assets/instagram-footer.png" alt="instagram"></a>
            <br><br>
            </div>
            <br><br>
            <div class="footer-newsletter">
            <form action="${mailChimpUrl}" method="post" id="mc-embedded-subscribe-form-md" name="mc-embedded-subscribe-form" class="validate" target="_blank">
                <div class="newsletter-alignment col-sm-12 col-md-12">
                    <div class="newsletter-input col-sm-10 col-md-10">
                    <input type="text" class="all-place form-control" name="EMAIL" tabindex="-1" value="" placeholder="Your email" id="subscriberEmail">
                </div>
                <div class="newsletter-button footer-signup-margin col-sm-2 col-md-2">
                    <input type="submit" value="" name="subscribe" id="mc-embedded-subscribe"  class="button-signup signup-lg">
                    <br><br>
                </div>
                </div>
            </form>
            </div>
            <div class="thomas-owens-testimonial-div">
                <p class="thomas-owens-testimonial">"The idea of enabling non-profits to raise funds free enabled Two Cents of Hope to avoid commissions and help more students in need. 
                I'd recommend Crowdera to every serious fundraiser." <br><br>
                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"><span class="thomas-margin-align">- Swaroop Ramchandra</span><br></g:if>
                <span class="thomas-margin-align">Two Cents of Hope</span><br>
            </div>
        </div>
        <hr class="footer-hr">
        </section>
            <section class="row">
                <div class="col-sm-8 footer-last-section-payment-icon">
                    <g:if test="${currentEnv == 'test' || currentEnv == 'staging' || currentEnv == 'production' || currentEnv=='development'}">
                        <div class="col-sm-6 payment-method-footer">
                            <span>Payment Methods</span>
                            <img src="//s3.amazonaws.com/crowdera/assets/payment-icon-Card.png" class="payment-card-icons" alt="payment-icon">
                        </div>
                        <div class="col-sm-6 secure-payment-footer">
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
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <div class="col-sm-12 text-center footer-last-section-links">
                <span class="text-primary ft-text-termsofUse">
                <a href="${resource(dir: '/termsofuse')}" class="footerlink">Terms  Of Use</a>&nbsp;&nbsp;
                <a href="${resource(dir: '/privacypolicy')}" class="footerlink">Privacy Policy &nbsp;&nbsp;</a>
                <a class="footerlink">&copy;&nbsp; Crowdera,inc, 2015</a>
                </span>
            </div>
        </g:if>
        <g:else>
            <div class="col-md-4 footer-last-section-links">
                <span class="text-primary">
                    <a href="${resource(dir: '/termsofuse')}" class="footerlink">Terms Of  Use</a>&nbsp;&nbsp;
                <a href="${resource(dir: '/privacypolicy')}" class="footerlink">Privacy Policy &nbsp;&nbsp;</a>
                <a class="footerlink">&copy;&nbsp; Crowdera,inc, 2015</a>
                </span>
            </div>
        </g:else>
        </section>
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <section class="row">
                <div class="col-lg-12 footer-disclaimer-lg">
                    <span class="footer-disclaimer">Disclaimer: Contributing through Crowdera Ventures India Pvt Ltd (Crowdera) is not always a tax exempt charitable donation.
                    Crowdera does not guarantee that beneficiary projects will be fully or partially funded. Crowdera is an internet platform to connect individuals, non-profits and contributors to collaborate published purposes. Crowdera does not take any responsibility for any promises made by campaign creators on our platform.
                    Please read the Terms of Use and Privacy Policy prior performing any transactions on our platform. *Crowdera does not charge a fee, however payment gateway and bank transfer fee are applicable.</span>
                </div>
            </section>
        </g:if>
    </div>
        
    <!-- Footer Design for large size device -->    
    <div class="visible-lg footer-lg">
            
        <section class="row footer-lg-first-section">
        <div class="col-md-4">
            <a href="${resource(dir: '/')}"><img src="//s3.amazonaws.com/crowdera/assets/Crowdera-logo.png" alt="Crowdera"></a>
            <div class="col-md-6 footer-mid-section-menu">
            <ul>
                <li><a href="${resource(dir: '/')}">Home</a></li>
                <li><a href="${resource(dir: '/aboutus')}">About Us</a></li>
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
                <li><a href="${resource(dir: '/faq')}">FAQ</a></li>
            </ul>
        
            </div>
        </div>
        <div class="col-md-4 footer-hands-image-top ">
            <div class="footer-mid-section-img">
            <br>
            <img src="//s3.amazonaws.com/crowdera/assets/Hands-image-footer.png" alt="Crowdera" class="footer-hands-img">
                <a href="#" class="display-footer-text"><img class="footer-start-cmpg-img" src="//s3.amazonaws.com/crowdera/assets/Hands-up-for-a-better - button.jpg" alt="Crowdera"></a>
            </div>
        </div>
        <div class="col-md-4 socialiconlinks footer-mid-section">
            <br>
            <div class="socialicon pull-right">
            <a href="http://gocrowdera.com"  target="_blank"><img class="blogsocialicon" src="//s3.amazonaws.com/crowdera/assets/blog-footer.png" alt="blog"></a>
            <a href="https://www.facebook.com/crowderainc?ref=hl"  target="_blank"><img class="facebooklink" src="//s3.amazonaws.com/crowdera/assets/facebook-footer.png" alt="facebook"></a>   
            <a href="https://twitter.com/gocrowdera"  target="_blank"><img class="twittersocialicon" src="//s3.amazonaws.com/crowdera/assets/twitter-footer.png" alt="twitter"></a>
            <a href="https://www.linkedin.com/company/fedu"  target="_blank"><img class="linkedin-footer" src="//s3.amazonaws.com/crowdera/assets/linkedin-footer.png" alt="linkedin"></a>
            <a href="https://instagram.com/gocrowdera"  target="_blank"><img class="instagram-footer" src="//s3.amazonaws.com/crowdera/assets/instagram-footer.png" alt="instagram"></a>
            <br><br>
            </div>
            <br><br>
            <div class="footer-newsletter">
            <form action="${mailChimpUrl}" method="post" id="mvc-embedded-subscribe-form-lg" name="mc-embedded-subscribe-form" class="validate" target="_blank">
                <div class="newsletter-alignment col-lg-12">
                <div class="newsletter-input col-lg-10">
                    <input type="text" class="all-place form-control" name="EMAIL" tabindex="-1" value="" placeholder="Your email" id="subscriberEmail">
                </div>
                <div class="newsletter-button footer-signup-margin col-lg-2">
                    <input type="submit" value="" name="subscribe" id="mc-embedded-subscribe"  class="button-signup signup-lg">
                    <br><br>
                        </div>
                </div>
            </form>
            </div>
            <div class="thomas-owens-testimonial-div">
                <p class="thomas-owens-testimonial">"The idea of enabling non-profits to raise funds free enabled Two Cents of Hope to avoid commissions and help more students in need. 
                    I'd recommend Crowdera to every serious fundraiser." <br><br>
                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"><span class="thomas-margin-align">- Swaroop Ramchandra</span><br></g:if>
                <span class="thomas-margin-align">Two Cents of Hope</span><br>
            </div>
        </div>
        <hr class="footer-hr">
        </section>
         
        <section class="row">
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
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <div class="col-md-12 text-center footer-last-section-links">
                <span class="text-primary ft-text-terms-privacy">
                    <a href="${resource(dir: '/termsofuse')}" class="footerlink">Terms Of  Use</a>&nbsp;&nbsp;
                <a href="${resource(dir: '/privacypolicy')}" class="footerlink">Privacy Policy &nbsp;&nbsp;</a>
                <a class="footerlink">&copy;&nbsp; Crowdera,inc, 2015</a>
                </span>
            </div>
        </g:if>
        <g:else>
            <div class="col-md-4 footer-last-section-links">
                <span class="text-primary">
                    <a href="${resource(dir: '/termsofuse')}" class="footerlink">Terms Of  Use</a>&nbsp;&nbsp;
                <a href="${resource(dir: '/privacypolicy')}" class="footerlink">Privacy Policy &nbsp;&nbsp;</a>
                <a class="footerlink">&copy;&nbsp; Crowdera,inc, 2015</a>
                </span>
            </div>
        </g:else>
        </section>
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <section class="row">
                <div class="col-lg-12 footer-disclaimer-lg">
                    <span class="footer-disclaimer">Disclaimer: Contributing through Crowdera Ventures India Pvt Ltd (Crowdera) is not always a tax exempt charitable donation.
                    Crowdera does not guarantee that beneficiary projects will be fully or partially funded. Crowdera is an internet platform to connect individuals, non-profits and contributors to collaborate published purposes. Crowdera does not take any responsibility for any promises made by campaign creators on our platform.
                    Please read the Terms of Use and Privacy Policy prior performing any transactions on our platform. *Crowdera does not charge a fee, however payment gateway and bank transfer fee are applicable.</span>
                </div>
            </section>
        </g:if>
    </div>
    </div>
  </div>
</footer>

<input type="hidden" id="b_url" value="${base_url}" />
<div id="footermarker"></div>
<footer>
    <div class="footer_links">
        <div class="container footer-container">
    <div class="visible-lg footer-lg">
    <div class="row footer-lg-first-section">
        <div class="col-md-4 footer-logosize">
            <a href="${resource(dir: '/')}">
                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'test' || currentEnv == 'development'}">
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
                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
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
                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"><span class="thomas-margin-align">- Swaroop Ramchandra</span><br></g:if>
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
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
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
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
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

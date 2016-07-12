<input type="hidden" id="b_url" value="${base_url}" />
<div id="footermarker"></div>
<footer>
    <div class="footer_links">
        <%--<div class="footer-mobile-border visible-xs"></div>--%>
        <div class="container footer-container">
            <div class="visible-xs show-mobilejs">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="crowdera-title"><a href="${resource(dir: '/')}">
                            <g:if test="${currentEnv == 'testIndia' || currentEnv == 'test' || currentEnv == 'development'}">
                                <img src="//s3.amazonaws.com/crowdera/assets/Crowdera-logo.png" alt="Crowdera">
                            </g:if>
                            <g:else>
                                <img src="//s3.amazonaws.com/crowdera/assets/crowdera-footer-logo-cdra.png" class="cdra-ft-clogo" alt="Crowdera">
                            </g:else>
                        </a></div>
                        <div class="crowdera-menu">
                            <div class="col-xs-6 footer-mid-section-menu-mobile footer-menu-align">
                                <div class="quicklinks-menu-div">
                                    <ul class="quicklinks-menu">
                                        <li><a href="${resource(dir: '/')}">Home</a></li>
                                        <li><a href="${resource(dir: '/aboutus')}">About Us</a></li>
                                        <li><a href="${resource(dir: '/careers')}" >Careers</a></li>
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
                                        <g:if test="${isTestEnv}">
                                            <li><g:link controller="user" action="partners">Partner Pages</g:link></li>
                                        </g:if>
                                        <li><a href="${resource(dir: '/faq')}">FAQ</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ***********************************Section two************************ -->
                <div class="footer-newsletter">
                    <form action="${mailChimpUrl}" method="post" id="mc-embedded-subscribe-form-sm" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
                        <div class="col-xs-offset-1 newsletter-align">
                            <br>
                            <div class="col-xs-8 footer-input-align foot-margin-mobile">
                                <input type="text" class="text-email all-place form-control" name="EMAIL" placeholder="Your email">
                            </div>
                            <div class="col-xs-4 ">
                                <input type="submit" name="subscribe" value="" class="button-signup signup-sm all-place foot-mobile-margin">
                            </div>
                        </div>
                    </form>
                </div>
                
                <!-- ********************************Section three************************* -->
                <div class="row">
                    <div class="col-xs-12 footer-mid-section footer-p-text-align">
                        <br>
                        <div class="socialicon">
                            <a href="http://gocrowdera.com"  target="_blank"><img class="blogsocialicon" src="//s3.amazonaws.com/crowdera/assets/wordpress-gray.png" alt="blog"></a>
                            <a href="https://plus.google.com/102697810290030135564"  target="_blank"><img class="googleplussocial" src="//s3.amazonaws.com/crowdera/assets/googleplus-gray.png.png" alt="googlepluse"></a>
                            <a href="https://www.facebook.com/crowderainc?ref=hl"  target="_blank"><img class="facebooklink" src="//s3.amazonaws.com/crowdera/assets/facebook-footer.png" alt="facebook"></a>
                            <a href="https://twitter.com/gocrowdera"  target="_blank"><img class="twittersocialicon" src="//s3.amazonaws.com/crowdera/assets/twitter-footer.png" alt="twitter"></a>
                            <a href="https://www.linkedin.com/company/fedu"  target="_blank"><img class="linkedin-footer" src="//s3.amazonaws.com/crowdera/assets/linkedin-footer.png" alt="linkedin"></a>
                            <a href="https://instagram.com/gocrowdera"  target="_blank"><img class="instagram-footer" src="//s3.amazonaws.com/crowdera/assets/instagram-footer.png" alt="instagram"></a>
                        </div>
                        <br>

<%--                        <div class="thomas-testimonial">--%>
<%--                            <p>"The idea of enabling non-profits to raise funds free enabled Two Cents of Hope to avoid commissions and help more students in need. --%>
<%--                                I'd recommend Crowdera to every serious fundraiser." <br><br>--%>
<%--                            <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"><span class="thomas-margin-align">- Swaroop Ramchandra</span></g:if>--%>
<%--                            <span class="thomas-margin-align">Two Cents of Hope</span><br>--%>
<%--                        </div>--%>
                        
                        
                        <div class="row">
                        
                            <div class="col-xs-12 footer-first-section-mobile footer-text-align footer-mobile-startcampaign">
                                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                    <span class="cdra-ft-cutomercnt col-xs-12">Customer support:</span>
                                    <span class="cdr-ft-contactnum-in col-xs-12">+91 721 970 2234</span>
                                    <span class="cdra-ft-contactmail col-xs-12">support@crowdera.co</span>
                                </g:if>
                                <g:else>
                                    <span class="cdra-ft-cutomercnt col-xs-12">Customer support:</span>
                                    <span class="cdr-ft-contactnum col-xs-12">+1 (650) 690 2234</span>
                                    <span class="cdra-ft-contactmail col-xs-12">support@crowdera.co</span>
                                </g:else>
                            </div>
                    </div>
                        
                </div>
             </div>
        
        <!-- *********************Section four*****************-->
        <hr class="footer-hr">
 
        <div class="row">
            <div class="col-xs-12">
                <div class="text-primary">
                    <a href="${resource(dir: '/termsofuse')}" class="footerlink">Terms  Of  Use</a>&nbsp;&nbsp;
                    <a href="${resource(dir: '/privacypolicy')}" class="footerlink">Privacy Policy &nbsp;&nbsp;</a>
                    <a class="footerlink">&copy;&nbsp; 2016 Crowdera, Inc.</a>
                </div>
            </div>
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
        <br><br>            
    </div>
   </div>
  </div>
</footer>
<script>
	$("#mc-embedded-subscribe-form-sm").validate({ 
	    rules: { 
	     EMAIL: {// compound rule 
	               required: true, 
	               email: true 
	             } 
	    }, 
	    messages: { 
	     email: "" 
	    } 
	 }); 
</script>

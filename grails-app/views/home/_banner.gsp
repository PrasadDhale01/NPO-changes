<%--<div class="container">
    <div class="panel panel-primary" style="margin-top: 20px;">
        <div class="panel-body text-center">
            <h1><strong>ENABLING YOU TO FUND YOUR CAUSE FOR FREE</strong></h1>
            <p>Crowdera enables you to do good & doing good makes us happy</p>
        </div>
    </div>
</div> --%>
<div class="greenbg">
	<div class="container testimonial-inner-container">
		<div class="row testimonial-container">
			<div class="header-testimonial">
				<div  class="left-inverted-comma">
					<img src="//s3.amazonaws.com/crowdera/assets/inverted-comma-Left.png" alt="''">
				</div>
				<div class="text-center TW-testimonial-width">
				    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
				        <h1 class="bannerheadbtmMargin"><b>I have seen Crowdera grow from idea to reality. It truly amazes me to see the energy, passion and determination to keep the platform fee free!</b></h1>
				    </g:if>
				    <g:else>
					<h1 class="bannerheadbtmMargin"><b>I ran my campaign through Crowdera in its initial phases and I greatly appreciated the support I received from the Crowdera team ...</b></h1>
				    </g:else>
				</div>
				<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
				    <div class="hm-right-inverted-India">
					<img src="//s3.amazonaws.com/crowdera/assets/inverted-comma-Right.png">
				    </div>
				</g:if>
				<g:else>
				    <div class="right-inverted-comma">
					<img src="//s3.amazonaws.com/crowdera/assets/inverted-comma-Right.png" alt="''">
				    </div>
				</g:else>
			</div>
			<span class="testimonial-name pull-right">
			    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
			        <img src="//s3.amazonaws.com/crowdera/assets/sandeep-Nath-Testimonial-Image.png" alt="testimonial"><b class="hm-testimonial-font">- Sandeep Nath, Bollywood Lyricist & Writer</b>
			    </g:if>
			    <g:else>
			        <img src="//s3.amazonaws.com/crowdera/assets/testimonial-lifevest-icon.png" alt="testimonial"><b>- Orly Wahba, Founder of Life Vest Inside</b>
			    </g:else>
		    </span>
		</div>
	</div>
</div>

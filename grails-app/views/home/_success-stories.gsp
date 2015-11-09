<div class="container how-it-work-container">
    <div class="row text-center success-story-title">
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="text-center">They Raised Successfully on Crowdera for What Matters to them</span>
        </g:if>
        <g:else>
            <span class="text-center">They Raised Successfully on Crowdera <br> for What Matters to them</span>
        </g:else>
    </div> 
</div>
<g:if test="${currentEnv == 'stagingIndia' || currentEnv == 'prodIndia' || currentEnv == 'staging' || currentEnv == 'production'}">
    <div class="container how-it-work-container">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 text-center story-bottom-margin">
                    <span><a href="${resource(dir: '/campaigns/The-Relay-2015/Two-Cents-of-Hope-440')}"><img src="//s3.amazonaws.com/crowdera/assets/The-Relay-2015-story-img.jpg" alt="Life Vest"></a></span><br>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 text-center story-bottom-margin">
                    <span class="navbar-brand-footer"><a href="${resource(dir: '/campaigns/Girls-Write-Haiti/Laura-104')}"><img src="//s3.amazonaws.com/crowdera/assets/Girls-write-haiti-story-img.jpg" alt="Two Cents Of hope"></a></span>
                </div>
                <div class="clear-both hidden-md hidden-lg"></div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 text-center story-bottom-margin">
                    <span><a href="${resource(dir: '/campaigns/Vote-For-Austin-With-The-Election-Navigator/Brandi-Clark-174')}"><img src="//s3.amazonaws.com/crowdera/assets/Vote-for-austin-story-img.jpg" alt="Prajwala"></a></span>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 text-center story-bottom-margin">
                    <span><a href="${resource(dir: '/campaigns/Dance-For-Kindness-Flashmob-Anthem/Orly-155')}"><img src="//s3.amazonaws.com/crowdera/assets/Dace-for-kindness-story-img.jpg" alt="Eco Netwrork"></a></span>
                </div>
                <div class="clear-both"></div>
            </div>
        </div>
    </div>
</g:if>

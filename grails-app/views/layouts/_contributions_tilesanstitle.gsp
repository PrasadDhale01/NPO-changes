<div class="col-lg-12 col-sm-12 col-md-12 panel-body panel-bgColor ">
     <div class="col-lg-12 show-raised-amt text-center">
         <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
              <span class="fa fa-inr"></span><span class="lead show-contribution-amt-tile"><g:if test="${project.payuStatus}">${contributedSoFar}</g:if><g:else>${contributedSoFar * conversionMultiplier}</g:else></span>
         </g:if>
         <g:else>
              $<span class="show-raised-amt show-contribution-amt-tile">${contributedSoFar}</span>
         </g:else>
     </div>
     <span class="col-lg-12 col-sm-12 col-md-12 show-funds-padding text-center">Funds Raised</span>
     
     <div class="show-left-cmtbox">
	     <div class="show-fundamt-tooltip">
	         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/assets/7e52ee4d-35a6-4219-a32b-4695b000fd71.png" alt="tooltip">
	     </div>
	     <div class="show-text-cmt-tooltip">
	         <label class="show-cmt-label">Latest Update</label>
	         <p class="show-cmt-text">We are all so excited to have raised so much money</p>
	     </div>
     </div>
</div>

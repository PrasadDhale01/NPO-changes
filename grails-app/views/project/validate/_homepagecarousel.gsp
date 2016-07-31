<div class="feedback-container homepagTempHeight" id="homeCarouselContainer">
    <div class="col-sm-12 ">
        <g:form action="manageHomePageCarousel" controller="home" method="POST" class="homeCarouselForm">
           <div class="row">
                <div class="col-sm-12">
                    <div class="col-sm-2">Select your option</div>
                    <div class="col-sm-8">
                        <g:radioGroup name="carouselOption" labels="['Upload','Delete','Update']" values="['upload','delete','update']" value="upload">
						              <span>${it.radio}${it.label} </span>&nbsp;
						</g:radioGroup>
                        
                    </div>
                </div>
           </div>
           <div id="carouselTemplate"></div>
       </g:form>
    </div>
</div>
<script type="text/javascript">
	$('#carouselTemplate').load('/carouseltemplate #uploadTemplate');
	$('input:radio').change(function(){
	    var status = $(this).val();
	     switch(status){
	       case 'upload':
	            $('#carouselTemplate').load('/carouseltemplate #uploadTemplate');
	       break;
	       case 'delete':
	    	   $('#carouselTemplate').load('/carouseltemplate #deleteTemplate');
	    	   $('#loading-gif').show();
	    	   loadDropDownData('deleteImage');
	           
	       break;
	       case 'update':
	    	   $('#carouselTemplate').load('/carouseltemplate #updateTemplate');
	    	   $('#loading-gif').show();
	    	   loadDropDownData('updateImage');
	       break; 
	       
	     }
	});

	$('.homeCarouselForm').validate({
		rules: {
			
			uploadImage:{
			    required: true
			},
			carouselImage: {
			    required : true
		    }
	    }
    });

</script>

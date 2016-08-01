<div id="uploadTemplate">
    <br><br>
    <div class="row">
          <div class="col-sm-8">
            <div class="upload">
                  <div class="col-sm-8 ">
                      <div class="input-group">
                          <span class="input-group-btn"> 
                              <span class="btn btn-info btn-file"> Browse<input type="file" name="uploadFile" id="uploadCarouselFile" 
                              accept="image/png, image/jpeg" class="uploadCarouselFile" onchange="setSelectedFileName();"> </span>
                          </span> 
                          <input type="text" class="form-control" id="uploadFile" name="uploadImage" placeholder="filename"  readonly>
                      </div>
                  </div>
                  <div class="col-sm-2">
                      <button type="submit" id="carouselUploadBtn" class="btn btn-default btn-info btn-sm pull-right carouselUploadBtn"
                       onclick="uploadCarouselImage();">Upload</button>
                  </div>
             </div>
        </div>
    </div>
</div>

<div id="deleteTemplate">
<br><br>
	    <div class="row">
	          <div class="col-sm-8">
	            <div class="upload">
	                  <div class="col-sm-8 ">
	                      <g:select class="selectpicker form-control input-md "
	                                name="carouselImage" from="" id="deleteImage" 
	                                noSelection="['': 'Please select an image name']"/>
	                  </div>
	                  <div class="col-sm-2">
	                      <button type="submit" id="carouselDeleteBtn" class="btn btn-default btn-info btn-sm  carouselDeleteBtn"
	                       onclick="deleteCarouselImage();">Delete</button>
	                  </div>
	             </div>
	        </div>
	    </div>
</div>

<div id="updateTemplate">
     <br><br>
     <div class="row">
          <div class="col-sm-4">
	           <g:select class="selectpicker form-control input-md "
	                     name="carouselImage" from="" id="updateImage"  
	                     noSelection="['': 'Please select an image name']"/>
        </div>
          <div class="col-sm-4 upload">
               <div class="input-group">
                   <span class="input-group-btn"> 
                       <span class="btn btn-info btn-file"> Browse<input type="file" name="uploadFile" id="uploadCarouselFile" 
                       accept="image/png, image/jpeg" class="uploadCarouselFile" onchange="setSelectedFileName();"> </span>
                   </span> 
                   <input type="text" class="form-control" name="uploadImage" placeholder="filename"  readonly>
               </div>
          </div>
           <div class="col-sm-4">
                 <button type="submit" id="carouselUpdateBtn" class="btn btn-default btn-info btn-sm carouselUpdateBtn" 
                 onclick="updateCarouselImage();">Update</button>
           </div>
    </div>
</div>

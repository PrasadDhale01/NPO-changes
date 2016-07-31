    <div class="feedback-container homepagTempHeight" id="deadlinecalculation">
        <div class="col-sm-12 ">
            <g:form action="manageCampaignDeadline" controller="project" method="POST" class="deadlineForm">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="chooseHomePageCampaign">
                            <g:select class="selectpicker form-control input-lg "
                                name="campaignSelection" from="${projects}" id="campaignSelection"  value="${campaignOne}"
                                onchange="setCampaignCurrentDays()" noSelection="['': 'Please Select Campaign']"/>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="form-group">
                             <div class="chooseHomePageCampaign"> 
                                 <input type="hidden" id="deadline" name="deadline"  class="input-lg" placeholder="Days" readonly min="0"/>
                             </div>
                             <div class="chooseHomePageCampaign"> 
                                 <input type="number" id="daysLeft" name="daysLeft" value="<g:if test='${extendDays}'>${extendDays}</g:if>" class="input-lg" placeholder="Days Left" max="90" min="0" readonly/>
                             </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                             <div class="chooseHomePageCampaign">
                                <label for="extendDays">Extend Days</label>
                                <g:select from="${deadlinDays}" id="extendDays" name="extendDays" class="input-lg"  optionKey="key" optionValue="value" />
                             </div>
                        </div>
                    </div>
                </div>
                <div class="submitbtn">
                    <button class="btn btn-default btn-info center-block submitFormData" type="button">Submit</button>
                </div>
            </g:form>
        </div>
    </div>
        
        
    <script type="text/javascript">
        $(function() {

            /* Apply selectpicker to selects. */
            $('.selectpicker').selectpicker({
                style: 'btn btn-md btn-default'
            });

            $('.submitFormData').click(function(){
                var data = $(".deadlineForm").serializeArray();

                if ($('#deadlinecalculation').find('form').valid()) {
	                $('#loading-gif').show();
	
	                $.ajax({
	                    type: 'post',
	                    url: $('#baseUrl').val()+'/project/manageCampaignDeadline',
	                    data: data,
	                    success: function(data){
	                        $('#loading-gif').hide();
	                    }
	                }).error(function(){
	                    $('#loading-gif').hide();
	                })
                }
           });
        });

        $('#deadlinecalculation').find('form').validate({
            rules: {
                deadline: {
                    required: true
                },
                daysLeft: {
                    required: true,
                    number: true,
                    min: 0
                }
            }
        });
</script>

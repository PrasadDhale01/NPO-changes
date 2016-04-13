    <div class="feedback-container">
        <div class="col-sm-12 ">
            <g:form action="manageCampaignDeadline" controller="project" method="POST" class="deadline-form">
                <div class="row">
                    <div class="col-sm-8">
                        <div class="chooseHomePageCampaign">
                            <g:select class="selectpicker form-control input-lg "
                                name="campaignSelection" from="${projects.title}" id="campaignSelection"  optionValue="value" value="${campaignOne}"
                                onchange="setCampaignCurrentDays()"/>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                             <div class="chooseHomePageCampaign"> 
                                 <input type="text" id="deadline" name="deadline"  class="input-lg" placeholder="days"/>
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
                var data = new FormData();
                data.append('campaignSelection', $('#campaignSelection').val());
                data.append('deadline', $('#deadline').val());
         
                $('#loading-gif').show();

                $.ajax({
                    type: 'post',
                    url: $('#baseUrl').val()+'/project/manageCampaignDeadline',
                    data: data,
                    processData:false,
                    contentType:false,
                    success: function(data){
                        $('#loading-gif').hide();
                    }
                }).error(function(){
                    $('#loading-gif').hide();
                })
           });
        });
</script>

    <div class="feedback-container homepagTempHeight" id="deletedCampaignContainer">
        <div class="col-sm-12 ">
            <g:form action="manageDeletedCamapaigns" controller="project" method="POST" class="deletedCampaign-form">
                <div class="row">
                    <div class="col-sm-8">
                        <div class="chooseHomePageCampaign">
                            <g:select class="selectpicker form-control input-lg "
                                name="deletedCampaign" from="${projects}" id="deletedCampaign"  value="${campaignOne}"
                                noSelection="['': 'Please select a campaign to restore ']"/>
                        </div>
                        <div id="campaignStatus"></div>
                    </div>
                   <div class="col-sm-4">
                       <button class="btn btn-default btn-info center-block submitFormData" type="button">Submit</button>
                   </div>
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
                    var formData = $('.deletedCampaign-form').serializeArray();
                    $('#loading-gif').show();
    
                    $.ajax({
                        type: 'post',
                        url: $('#baseUrl').val()+'/project/manageDeletedCamapaigns',
                        data: formData,
                        success: function(data){
                            $('#loading-gif').hide();
                            
                            if(data=="true"){
                                $('#campaignStatus').html("Campaign  restored.").css("color","green");
                            }else if(data=='false'){
                                $('#campaignStatus').html("Campaign not restore.").css("color","green");
                            }else{
                                $('#campaignStatus').html("Please select a campaign to restore").css("color","red");
                            }
                        }
                    }).error(function(){
                        $('#loading-gif').hide();
                    })
           });
        });
</script>

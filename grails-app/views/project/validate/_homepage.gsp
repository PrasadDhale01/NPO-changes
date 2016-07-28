    <div class="bg-color-white homepagTempHeight">
        <div class="col-sm-12">
            <div class="question-list">
                <g:form action="manageHomePageCampaigns" controller="project" method="POST" class="homepage-form">
                    <g:hiddenField name="currentEnv" value="${currentEnv}"/>
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="chooseHomePageCampaign">
                                <g:select class="selectpicker form-control input-lg "
                                    name="campaignOne" from="${projects}" id="campaignOne" value="${campaignOne}"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="chooseHomePageCampaign">
                                    <g:select class="selectpicker form-control input-lg"
                                        name="campaignTwo" from="${projects}" id="campaignTwo"  value="${campaignTwo}" /> 
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="chooseHomePageCampaign">
                                <g:select class="selectpicker form-control input-lg"
                                    name="campaignThree" from="${projects}" id="campaignThree"  value="${campaignThree}"/> 
                            </div>
                        </div>
                    </div>
                    <div class="submitbtn">
                        <button class="btn btn-default btn-info center-block submitFormData" type="button">Submit</button>
                    </div>
                </g:form>
            </div>
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
                data.append('campaignOne', $('#campaignOne').val());
                data.append('campaignTwo', $('#campaignTwo').val());
                data.append('campaignThree', $('#campaignThree').val());
                data.append('currentEnv', $('#currentEnv').val());
         
                $('#loading-gif').show();

                $.ajax({
                    type: 'post',
                    url: $('#baseUrl').val()+'/project/manageHomePageCampaigns',
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

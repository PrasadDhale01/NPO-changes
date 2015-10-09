<g:if test="${shippingInfo}">
    <g:if test="${shippingInfo.address != null || shippingInfo.email  != null || (shippingInfo.twitter  != null && anonymous == 'false') || (shippingInfo.custom  != null && shippingInfo.custom  != '')}">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Shipping Information Required to Fulfill a Perk</h3>
            </div>
            <div class="panel-body">
                <g:if test="${shippingInfo.address != null}">
                    <div class="col-md-12 col-sm-6 col-xs-12" id="physicalAddress">
                        <div class="form-group">
                            <div class="input-group col-md-12">
                                <input class="form-control addr1" type="text" placeholder="AddressLine1" name="addressLine1">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group col-md-12">
                                <input class="form-control addr2" type="text" placeholder="AddressLine2" name="addressLine2">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group col-md-12">
                                <input class="form-control cityField" type="text" placeholder="City" name="city" id="city">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <div class="input-group col-md-12">
                                <input class="form-control zipField" type="text" placeholder="Zip" name="zip">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group col-md-12">
                                <g:select class="selectpicker states stateField" name="state"
                                    from="${state}" optionKey="key" optionValue="value" />
                            </div>
                        </div>
                        <div class="form-group ostate">
                            <div class="input-group col-md-12">
                                <input class="form-control otherField" type="text" placeholder="Other State" name="otherstate">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group col-md-12">
                                <g:select class="selectpicker countryField" name="country"
                                    from="${country}" value="US" optionKey="key" optionValue="value" />
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <g:if test="${shippingInfo.email  != null || (shippingInfo.twitter  != null && anonymous == 'false') || shippingInfo.custom  != null}">
                        <hr>
                    </g:if>
                </g:if>
                <g:if test="${shippingInfo.email != null}">
                    <div class="col-md-12 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <div class="input-group col-md-12">
                                <input class="form-control emailField" type="text" placeholder="Email" name="shippingEmail">
                            </div>
                        </div>
                    </div>
                </g:if>
                <g:if test="${shippingInfo.twitter != null && anonymous == 'false'}">
                    <div class="col-md-12 col-sm-6 col-xs-12" id="twitterPerk">
                        <div class="form-group">
                            <div class="input-group col-md-12">
                                <input class="form-control twitterField" type="text"
                                    placeholder="Twitter Handle" name="twitterHandle">
                            </div>
                        </div>
                    </div>
                </g:if>
                <g:if test="${shippingInfo.custom != null && shippingInfo.custom != ''}">
                    <div class="col-md-12 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <div class="input-group col-md-12">
                                <input class="form-control customField " type="text" rel="popover" data-content="${shippingInfo.custom}"
                                    id="customShippingInfo" name="shippingCustom">
                            </div>
                        </div>
                    </div>
                </g:if>
            </div>
        </div>
    </g:if>
</g:if>

<script src="/vendor/bootstrap-select/bootstrap-select.js"></script>
<script type="text/javascript">
    /* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });

    $('.customField').each(function(){
        $(this).popover({
            trigger: 'manual',
            placement: 'bottom'
        })
        .focus(showPopover)
        .blur(hidePopover)
        .hover(showPopover, hidePopover);
    });

    /* Show pop-over tooltip on hover for some fields. */
    var showPopover = function () {
        $(this).popover('show');
    },
    hidePopover = function () {
        $(this).popover('hide');
    };
</script>

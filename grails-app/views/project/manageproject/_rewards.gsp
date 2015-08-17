<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="rewardService" bean="rewardService"/>
    
<div class="row">
    <div class="col-xs-12">
        
        <!-- Button trigger modal -->
        <g:if test="${!ended}">
	        <a href="#" class="btn btn-primary btn-sm btn-circle pull-right" data-toggle="modal" data-target="#createRewardModal" model="['project': project]">
	            <i class="fa fa-plus-circle"></i> Create Perk
	        </a>
        </g:if>
        <g:else>
            <g:if test="${project.validated}">
                <div class="alert alert-info">Campaign Ended.</div>
            </g:if>
        </g:else>
        
        <!-- Modal -->
        <div class="modal fade" id="createRewardModal" tabindex="-1" role="dialog" aria-labelledby="createRewardModal" aria-hidden="true">
            <g:form action="customrewardsave" id="${project.id}"role="form" class="perkForm">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">Create a new Perk</h4>
                        </div>
                        <div class="modal-body">
                            <g:hiddenField name="amount" value="${project.amount}" id="cAmount"/>
                            <g:if test="${project.payuStatus}">
                                <g:hiddenField name="isINR" value="${project.payuStatus}" id="isINR"/>
                            </g:if>
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control" name="title" placeholder="Title"/>
                            </div>
                            <div class="form-group">
                                <label for="title">Number available</label>
                                <input type="text" class="form-control" name="numberAvailable" placeholder="Number available"/>
                            </div>
                            <div class="form-group descriptionDiv createDescDiv">
                                <label for="description">Description</label>
                                <textarea class="form-control" id="descarea" name="description" maxlength="250" rows="4" placeholder="Description"></textarea>
                                <label class="pull-right " id="desclength"></label>
                            </div>
                            <div class="clear"></div>
                            <div class="form-group">
                                <label for="price">Price (<g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>)</label>
                                <input type="number" class="form-control perkPrice" name="price" id="perkPrice" placeholder="Price"/>
                                <span id="errormsg"></span>
                            </div>
                            <div class="form-group">
                                <label class="control-label">Which of the following is necessary to fulfill this perk:</label>
                                <div class="shippingreward shipping-inline col-lg-12 col-xs-12 col-md-12 col-sm-12">
                                    <label class="btn btn-primary btn-sm checkbox-inline control-label col-lg-3 col-xs-6 col-md-3 col-sm-4 shipping-margin"><input type="checkbox" class="shippingInfo" name="address" value="true" id="mailaddcheckbox">Mailing address</label>
                                    <label class="btn btn-primary btn-sm checkbox-inline control-label col-lg-3 col-xs-6 col-md-3 col-sm-4 shipping-margin"><input type="checkbox" class="shippingInfo" name="email" value="true" id="emailcheckbox">Email address</label>
                                    <label class="btn btn-primary btn-sm checkbox-inline control-label col-lg-3 col-xs-6 col-md-3 col-sm-4 shipping-margin"><input type="checkbox" class="shippingInfo" name="twitter" value="true" id="twittercheckbox">Twitter handle</label>
                                    <input type="text" class="shippingInfo col-lg-3 col-xs-6 col-md-3 col-sm-4" name="custom" placeholder="Custom" id="custombox"/>
                                </div>
                                <div class="shippingError"></div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary btn-block createPerk" id="btnCreatePerk">Create Perk</button>
                        </div>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <g:render template="manageproject/rewardsgrids" model="['rewards': rewards]"></g:render>
    </div>
</div>

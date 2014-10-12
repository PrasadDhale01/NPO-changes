<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="rewardjs"/>
</head>
<body>
<div class="feducontent">
	<div class="container">
        <div class="row">
            <div class="col-xs-6">
                <h1><i class="fa fa-gift fa-lg"></i> Rewards</h1>
            </div>
            <div class="col-xs-6">
                <!-- Button trigger modal -->
                <a href="#" class="btn btn-primary btn-circle pull-right" data-toggle="modal" data-target="#createRewardModal">
                    <i class="glyphicon glyphicon-plus"></i>
                </a>
                
                <!-- Modal -->
                <div class="modal fade" id="createRewardModal" tabindex="-1" role="dialog" aria-labelledby="createRewardModal" aria-hidden="true">
                    <g:form id="form" action="save" role="form">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                    <h4 class="modal-title">Create a new Reward</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="title">Title</label>
                                        <input type="text" class="form-control" name="title" placeholder="Title"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <textarea class="form-control" name="description" rows="4" placeholder="Description"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="price">Price ($)</label>
                                        <input type="number" class="form-control" name="price" placeholder="Price"/>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary btn-block">Create Reward</button>
                                </div>
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>

        <g:if test="${flash.message}">
            <div class="alert alert-info">
                ${flash.message}
            </div>
        </g:if>

        <div class="row">
            <div class="col-md-12">
                <g:render template="list/rewardgrid" model="['rewards': rewards]"></g:render>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-md-12">
                <h1><i class="fa fa-gift fa-lg"></i> Obsolete Rewards</h1>
                <g:render template="list/rewardgrid" model="['rewards': obsoleteRewards]"></g:render>
            </div>
        </div>
        <hr>
    </div>
</div>
</body>
</html>

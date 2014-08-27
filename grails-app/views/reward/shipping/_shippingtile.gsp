<g:set var="user" value="${contribution.user}"/>
<g:set var="reward" value="${contribution.reward}"/>
<g:set var="shippingDone" value="${contribution.shippingDone}"/>
<g:if test="${shippingDone == false}">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title"><i class="glyphicon glyphicon-user"></i>&nbsp;&nbsp;${user.firstName}&nbsp;${user.lastName}</h3>
        </div>
        <div class="panel-body">
            <p>${reward.description}</p>
            <!-- Button trigger modal -->
            <button href="#" class="edit close" data-toggle="modal" data-target="#createRewardModal">
                <i class="fa fa-info-circle" ></i>
            </button>
        </div>
        <div class="panel-footer">
            <form action="update" method="post">
                <g:hiddenField name="contributionId" value="${contribution.id}"/>
                <g:hiddenField name="shippingdone" value="${shippingDone}"/>
                <g:link controller="reward" action="update">
                    <button class="btn btn-block btn-primary">Shipping done&nbsp;<i class=" fa fa-exclamation-circle"></i></button>
                </g:link>
            </form>
        </div>
    </div>
</g:if>
<g:else>
    <div class="panel panel-primary" >
        <div class="panel-heading">
            <h3 class="panel-title"><i class="glyphicon glyphicon-user"></i>&nbsp;&nbsp;${user.firstName}&nbsp;${user.lastName}</h3>
        </div>
        <div class="panel-body">
            <p>${reward.description}</p>
            <!-- Button trigger modal -->
            <button href="#" class="edit close" data-toggle="modal" data-target="#createRewardModal">
                <i class="fa fa-info-circle" ></i>
            </button>
        </div>
        <div class="panel-footer">
             <button class="btn btn-block btn-success">Shipping done&nbsp;<i class=" fa fa-exclamation-circle"></i></button>
        </div>
    </div>
</g:else>
<!-- Modal -->
<div class="modal fade" id="createRewardModal" tabindex="-1" role="dialog" aria-labelledby="createRewardModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button"  class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title"><i class="glyphicon glyphicon-user"></i>&nbsp;User Detail</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="Name">Name:</label>
                    <input class="form-control" value="${user.firstName}&nbsp;${user.lastName}" disabled/>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input class="form-control" value="${user.email}" disabled/>
                </div>
                <div class="form-group">
                    <label for="">Address</label>
                    <input class="form-control" value="" disabled/>
                </div>
            </div>
        </div>
    </div>
</div>

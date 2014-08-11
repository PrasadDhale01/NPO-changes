<g:set var="rewardDelete" value="${reward.delete}"></g:set> 
<g:if test="${rewardDelete == true}">
<div class="panel panel-primary" >
    <div class="panel-heading">
        <h3 class="panel-title">${reward.title}</h3>
    </div>
    <div class="panel-body">
        <p>${reward.description}</p> 
        <form action="delete/${reward.id}" method="post" >
            <input type="hidden" name="_method" value="DELETE" id="_method" />
            <button class="rewarddelete close" name="_action_delete" value="Delete" onclick="return confirm(&#39;Are you sure want to Delete this reward?&#39;);">
                <i class="fa fa-trash-o" >
                </i>
            </button>
   	</form>  
    </div>
    <div class="panel-footer">
        $${reward.price}
    </div>
</div>
</g:if>
<g:else>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${reward.title}</h3>
    </div>
    <div class="panel-body">
        <p>${reward.description}</p>     
    </div>
    <div class="panel-footer">
        $${reward.price}
    </div>
</div>
</g:else>
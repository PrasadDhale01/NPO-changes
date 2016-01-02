<g:hiddenField name="folderId"></g:hiddenField>
<input type="file" class="upload" name="file" id="newDocFile">
<div class="col-sm-12 col-xs-12 docs-tab-border">
    <ul class="nav nav-pills nav-tab-doc">
        <li><span class="active doc-tab-right-border doc-tab-padding">
            <a href="#sendReceipt" data-toggle="tab" class="active tab-data-toggle doc-tab-files">
                Send Tax Receipt
            </a>
            </span>
        </li>
        <li><span class="doc-tab-padding">
            <a href="#exportReceipt" data-toggle="tab" class="tab-data-toggle">
                Export Tax Receipt
            </a>
            </span>
        </li>
    </ul>
</div>

<div class="clear"></div>
<div class="tab-content">
	<div class="<g:if test="${isUserProjectHavingContribution}">active</g:if> tab-pane tab-pane-active" id="sendReceipt">
		<g:if test="${isUserProjectHavingContribution}">
			<g:if test="${contributorListForProject}">
			    <g:render template="/user/user/sendTaxReceipt"/>
			</g:if>
			<g:else>
			    <g:render template="/user/user/userCampaignTile"/>
			</g:else>
		</g:if>
		<g:else>
			<div class="col-sm-12">
				<br>
				<div class="alert alert-info">
                    <g:if test="${totalProjects.isEmpty()}">
                        You do not have any <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"></g:if>NGO<g:else>NON-PROFIT</g:else>project yet.
                    </g:if>
                    <g:else>Your Project do not have any contributors yet.</g:else>
				</div>
			</div>
		</g:else>
	</div>
	<div class="<g:if test="${!isUserProjectHavingContribution && userHasContributedToNonProfitOrNgo}">active</g:if> tab-pane tab-pane-active" id="exportReceipt">
		<g:if test="${userHasContributedToNonProfitOrNgo}">
			<g:render template="/user/user/exportTaxReceipt"/>
		</g:if>
		<g:else>
			<div class="col-sm-12">
				<br>
				<div class="alert alert-info">
				    You do have any tax receipt to export.
				</div>
			</div>
		</g:else>
	</div>
</div>

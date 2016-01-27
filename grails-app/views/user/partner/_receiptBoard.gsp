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

<div class="clear"></div><br>
<div class="tab-content">
	<div class="active tab-pane tab-pane-active" id="sendReceipt">
		<g:if test="${isUserProjectHavingContribution}">
			<g:if test="${contributorListForProject}">
                <div class="send-tax-receipt-to-contributors">
                    <g:render template="/user/user/sendTaxReceipt" model="[sort:'All']"/>
			    </div>
			</g:if>
			<g:else>
				<div class="campaignTilePaginate">
				    <g:render template="/user/user/userCampaignTile"/>
				</div>
			</g:else>
		</g:if>
		<g:else>
			<div class="col-sm-12">
				<br>
				<div class="alert alert-info">
                    <g:if test="${totalProjects.isEmpty()}">
                        You do not have any <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">NGO</g:if><g:else>NON-PROFIT</g:else>project yet.
                    </g:if>
                    <g:else>Your Project do not have any contributors yet.</g:else>
				</div>
			</div>
		</g:else>
	</div>
	<div class="tab-pane tab-pane-active exportTaxReceiptThumbnail" id="exportReceipt">
		<g:if test="${userHasContributedToNonProfitOrNgo}">
			<br><g:render template="/user/user/exportTaxReceipt"/>
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

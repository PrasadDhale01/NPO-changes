<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("d/MM/YYYY");
    def date = dateFormat.format(contribution.date)
%>

<g:if test="${project.payuStatus}">
    <div class="row">
        <div class="col-sm-9 taxreceiptbgcolor">
            <img class="img-responsive img-thumbnail" src="${project.organizationIconUrl}" alt="orglogo"/>
            <label class="taxdetailslabel"><b>${project.organizationName}</b></label>
        </div>
        <div class="col-sm-3">
            <g:link controller="user" action="exportTaxReceiptPdf"
             params="['id': contribution.id]" class="btn btn-primary btn-sm pull-right">Download Receipt</g:link><br>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 taxreceiptheader">Tax Receipt</div>
        <div class="row taxleftrightmargin">
            <div class="col-sm-12 col-plr-0">
                <div class="col-sm-8">
	                <div class="col-sm-12">
	                    <label class="taxdetailslabel"><b>Organization Name:</b></label>
	                    <div class="">
	                        ${project.organizationName}
	                    </div><br>
	                </div>
                    <div class="col-sm-12">
	                    <label class="taxdetailslabel"><b>Organization Address:</b></label>
	                    <div class="taxorgaddress">
	                        ${taxReciept?.addressLine1},<br/>
	                        ${taxReciept?.addressLine2},<br/>
	                        ${taxReciept?.city}- ${taxReciept?.zip},<br/>
	                        ${taxReciept?.taxRecieptHolderState}, India
	                    </div><br>
                    </div>
                </div>
                <div class="col-sm-4">
                    <label class="taxdetailslabel"><b>Registration Date:</b></label>
                    <div class="">
                        ${dateFormat.format(taxReciept?.regDate)}
                    </div><br>
                    <label class="taxdetailslabel"><b>PAN no. of Organization:</b></label>
                    <div class="">
                        ${taxReciept?.panCardNumber}
                    </div><br>
                    <label class="taxdetailslabel"><b>Receipt Number / Transaction Number:</b></label>
                    <div class="">
                        ${transaction?.transactionId}
                    </div><br>
                </div>
            </div>
            
        </div>

        <br/>
        <div class="row taxleftrightmargin">
            <div class="col-sm-12 ">
                <div class="taxreceiptcontributorlabel">
                    <label class="col-xs-12"><span class="taxreceiptlabelfont">CONTRIBUTOR DETAILS</span></label>
                </div>
                <div class="panel panel-body taxreceiptbgcolor taxreceiptcontributiondetail">
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Contributed amount in words:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${amountInWords}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Contributed amount in number:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop"><span class="fa fa-inr"></span> ${contribution.amount.round()}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Date of contribution:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${date}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">PAN no. of Contributor:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${contribution?.panNumber}</div>
                    </div>
                </div>
            </div>
        </div>
    
        <div class="row taxleftrightmargin">
            <div class="col-sm-12 ">
                <div class="taxreceiptcontributorlabel">
                    <label class="col-xs-12"><span class="taxreceiptlabelfont">TAX DEDUCTION DETAILS</span></label>
                </div>
                <div class="panel panel-body taxreceiptbgcolor taxreceiptcontributiondetail">
                    <div class="col-xs-6 taxreceipttop">
                       <span class="pull-right taxreceiptdetailsfont">Name and Signature of
                        Authorized Representative of Organization:</span>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${taxReciept?.name}</div>
                        <div class="digitalsignature taxreceipttop">
                            <img src="${taxReciept?.signatureUrl}" alt="signature">
                        </div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Status of Organization:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${taxReciept?.deductibleStatus}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">% of Exemption:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${taxReciept?.exemptionPercentage}</div>
                    </div>
                </div>
            </div>
        </div>
    
    </div>
    
</g:if>
<g:else>
    <div class="row">
        <div class="col-sm-9 taxreceiptbgcolor">
            <img class="img-responsive img-thumbnail" src="${project.organizationIconUrl}" alt="orglogo"/>
            <label class="taxdetailslabel"><b>${project.organizationName}</b></label>
        </div>
        <div class="col-sm-3">
            <g:link controller="user" action="exportTaxReceiptPdf"
             params="['id': contribution.id]" class="btn btn-primary btn-sm pull-right">Download Receipt</g:link><br>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 taxreceiptheader">Tax Receipt</div>
        <div class="row taxleftrightmargin">
            <div class="col-sm-12 col-plr-0">
                <div class="col-sm-8">
                   <div class="c0l-sm-12">
	                    <label class="taxdetailslabel"><b>Organization Name:</b></label>
	                    <div class="">
	                        ${project.organizationName}
	                    </div><br>
                    </div>
                    <div class="col-sm-12">
	                    <label class="taxdetailslabel"><b>Organization Address:</b></label>
	                    <div class="taxorgaddress">
	                        ${taxReciept?.addressLine1},<br/>
	                        ${taxReciept?.addressLine2},<br/>
	                        ${taxReciept?.city}- ${taxReciept?.zip},<br/>
	                        ${taxReciept?.taxRecieptHolderState}, ${taxReciept?.country}
	                    </div><br>
                    </div>
                </div>
                <div class="col-sm-4">
                    <label class="taxdetailslabel"><b>Website</b></label>
                    <div class="">
                        ${project.webAddress}
                    </div><br>
                    <label class="taxdetailslabel"><b>Email</b></label>
                    <div class="">
                        ${project.user.email}
                    </div><br>
                    <label class="taxdetailslabel"><b>Phone</b></label>
                    <div class="">
                        ${taxReciept?.phone}
                    </div><br>
                </div>
            </div>
            
        </div>

        <br/>
        <div class="row taxleftrightmargin">
            <div class="col-sm-12 ">
                <div class="taxreceiptcontributorlabel">
                    <label class="col-xs-12"><span class="taxreceiptlabelfont">CONTRIBUTOR DETAILS</span></label>
                </div>
                <div class="panel panel-body taxreceiptbgcolor taxreceiptcontributiondetail">
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Contributed amount in words:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${amountInWords}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Contributed amount in number:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop"><span class="fa fa-usd"></span> ${contribution.amount.round()}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Contribution received from:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${contribution.contributorName}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Date of contribution:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${date}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Perk claimed by contributor:</label>
                        <div class="clear"></div>
                        <label class="pull-right">(goods or services in exchange of contribution)</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${contribution.reward.title}</div>
                    </div>
                </div>
            </div>
        </div>
    
        <div class="row taxleftrightmargin">
            <div class="col-sm-12 ">
                <div class="taxreceiptcontributorlabel">
                    <label class="col-xs-12"><span class="taxreceiptlabelfont">TAX DEDUCTION DETAILS</span></label>
                </div>
                <div class="panel panel-body taxreceiptbgcolor taxreceiptcontributiondetail">
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Federal ID Number:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="">${taxReciept?.ein}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Legal Status / % of Exemption:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="">${(taxReciept.deductibleStatus!=null || !'null'.equalsIgnoreCase(taxReciept?.deductibleStatus.toString())) ? taxReciept.deductibleStatus : "N/A"}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <span class="pull-right taxreceiptdetailsfont">Name and Signature of
                        Authorized Representative of Organization:</span>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${taxReciept?.name}</div>
                        <div class="digitalsignature taxreceipttop">
                            <img src="${taxReciept?.signatureUrl}" alt="signature">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
    </div>
</g:else>

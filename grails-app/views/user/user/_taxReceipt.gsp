<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("d/MM/YYYY");
    def date = dateFormat.format(contribution.date)
%>

<g:if test="${project.payuStatus}">
    <div class="row">
        <div class="col-sm-4 col-xs-6 taxreceiptbgcolor tax-receipt-logo">
            <img class="img-responsive img-thumbnail" src="${project.organizationIconUrl}" alt="orglogo"/>
        </div>
        <div class="col-sm-8 col-xs-6">
            <g:link controller="user" action="exportTaxReceiptPdf"
             params="['id': contribution.id]" class="btn btn-primary btn-sm pull-right">Download Receipt</g:link><br>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 taxreceiptheader">Tax Receipt</div>
        <div class="row taxleftrightmargin">
            <div class="col-sm-12 col-plr-0 organizationdetails">
                <div class="col-xs-6 taxreceipttop">
                    <label class="pull-right taxreceiptdetailsfont">Organization Name:</label>
                </div>
                <div class="col-xs-6 taxreceipttop">
                    <div class="taxreceipttop">${project.organizationName}</div>
                </div>
                <div class="clear"></div>
                <div class="col-xs-6 taxreceipttop">
                    <label class="pull-right taxreceiptdetailsfont">Organization Address:</label>
                </div>
                <div class="col-xs-6 taxreceipttop">
                    <div class="taxreceipttop">
                       ${taxReciept?.addressLine1} ,<br/>
                       <g:if test="${taxReciept?.addressLine2}">${taxReciept?.addressLine2},<br/></g:if>
                       ${taxReciept?.city}- ${taxReciept?.zip},<br/>
                       ${taxReciept?.taxRecieptHolderState}, India
                    </div>
                </div>
                <div class="clear"></div>
                
                <div class="col-xs-6 taxreceipttop">
                    <label class="pull-right taxreceiptdetailsfont">Registration Date:</label>
                </div>
                <div class="col-xs-6 taxreceipttop">
                    <div class="taxreceipttop">${dateFormat.format(taxReciept?.regDate)}</div>
                </div>
                <div class="clear"></div>
                
                <div class="col-xs-6 taxreceipttop">
                    <label class="pull-right taxreceiptdetailsfont">PAN no. of Organization:</label>
                </div>
                <div class="col-xs-6 taxreceipttop">
                    <div class="taxreceipttop">${taxReciept?.panCardNumber}</div>
                </div>
                <div class="clear"></div>
                
                <div class="col-xs-6 taxreceipttop">
                    <label class="pull-right taxreceiptdetailsfont">Receipt Number / Transaction Number:</label>
                </div>
                <div class="col-xs-6 taxreceipttop">
                    <div class="taxreceipttop">${transaction?.transactionId}</div>
                </div>
                <div class="clear"></div>
                
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
                        <div class="taxreceipttop"><span class="fa fa-inr"></span> ${amountInWords}</div>
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
                        <div class="taxreceipttop">
                        <g:if test="${taxReciept?.exemptionPercentage % 1 == 0}">
                            ${taxReciept?.exemptionPercentage?.round()}
                        </g:if>
                        <g:else>
                            ${taxReciept?.exemptionPercentage}
                        </g:else></div>
                    </div>
                </div>
            </div>
        </div>
    
    </div>
    
</g:if>
<g:else>
    <div class="row">
        <div class="col-sm-4 col-xs-6 taxreceiptbgcolor tax-receipt-logo">
            <img class="img-responsive img-thumbnail" src="${project.organizationIconUrl}" alt="orglogo"/>
        </div>
        <div class="col-sm-8 col-xs-6">
            <g:link controller="user" action="exportTaxReceiptPdf"
             params="['id': contribution.id]" class="btn btn-primary btn-sm pull-right">Download Receipt</g:link><br>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 taxreceiptheader">Tax Receipt</div>
        <div class="row taxleftrightmargin">
            <div class="col-sm-12 col-plr-0 organizationdetails">
                <div class="col-xs-6 taxreceipttop">
                    <label class="pull-right taxreceiptdetailsfont">Organization Name:</label>
                </div>
                <div class="col-xs-6 taxreceipttop">
                    <div class="taxreceipttop">${project.organizationName}</div>
                </div>
                <div class="clear"></div>
                <div class="col-xs-6 taxreceipttop">
                    <label class="pull-right taxreceiptdetailsfont">Organization Address:</label>
                </div>
                <div class="col-xs-6 taxreceipttop">
                    <div class="taxreceipttop">
                        ${taxReciept?.addressLine1},<br/>
                        <g:if test="${taxReciept?.addressLine2}">${taxReciept?.addressLine2},<br/></g:if>
                        ${taxReciept?.city}- ${taxReciept?.zip},<br/>
                        ${taxReciept?.taxRecieptHolderState}, ${taxReciept?.country}
                    </div>
                </div>
                <div class="clear"></div>
                
                <div class="col-xs-6 taxreceipttop">
                    <label class="pull-right taxreceiptdetailsfont">Website:</label>
                </div>
                <div class="col-xs-6 taxreceipttop">
                    <div class="taxreceipttop">${project.webAddress}</div>
                </div>
                <div class="clear"></div>
                <div class="col-xs-6 taxreceipttop">
                    <label class="pull-right taxreceiptdetailsfont">Email:</label>
                </div>
                <div class="col-xs-6 taxreceipttop">
                    <div class="taxreceipttop">${project.user.email}</div>
                </div>
                <div class="clear"></div>
                <div class="col-xs-6 taxreceipttop">
                    <label class="pull-right taxreceiptdetailsfont">Phone:</label>
                </div>
                <div class="col-xs-6 taxreceipttop">
                    <div class="taxreceipttop">${taxReciept?.phone}</div>
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
                        <div class="taxreceipttop"><span class="fa fa-usd"></span> ${amountInWords}</div>
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
                        <div class="taxreceipttop">${taxReciept?.ein}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Legal Status / % of Exemption:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="taxreceipttop">${(taxReciept.deductibleStatus!=null || !'null'.equalsIgnoreCase(taxReciept?.deductibleStatus.toString())) ? taxReciept.deductibleStatus : "N/A"}</div>
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

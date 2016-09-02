<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("d/MM/YYYY");
    def date = dateFormat.format(contribution.date)
%>

<g:if test="${project.payuStatus}">
    <div class="taxreceiptcontainer">
        <div class="taxreceiptheader">Tax Receipt</div>
        <div class="row taxleftrightmargin">
            <div class="col-xs-4">
                <label class="taxdetailslabel"><b>Organization Logo:</b></label>
                <div class="taxreceiptbgcolor text-center">
                    <img src="${project.organizationIconUrl}" alt="orglogo"/>
                </div>
            </div>
            <div class="col-xs-8 col-plr-0">
                <div class="col-xs-12">
                    <label class="taxdetailslabel"><b>Organization Name:</b></label>
                    <div class="form-control">
                        ${project.organizationName}
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="taxdetailslabel"><b>Registration Date:</b></label>
                    <div class="form-control">
                        ${dateFormat.format(taxReciept?.regDate)}
                    </div>
                    <label class="taxdetailslabel"><b>PAN no. of Organization:</b></label>
                    <div class="form-control">
                        ${taxReciept?.panCardNumber}
                    </div>
                    <label class="taxdetailslabel"><b>Receipt Number / Transaction Number:</b></label>
                    <div class="form-control">
                        ${transaction?.transactionId}
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="taxdetailslabel"><b>Organization Address:</b></label>
                    <div class="form-control taxorgaddress">
                        ${taxReciept?.addressLine1},<br/>
                        ${taxReciept?.addressLine2},<br/>
                        ${taxReciept?.city}- ${taxReciept?.zip},<br/>
                        ${taxReciept?.taxRecieptHolderState}, India
                    </div>
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
                        <div class="form-control">${amountInWords}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Contributed amount in number:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control"><span class="fa fa-inr"></span> ${contribution.amount.round()}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Date of contribution:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control">${date}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">PAN no. of Contributor:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control">${contribution?.panNumber}</div>
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
                        <label class="pull-right taxreceiptdetailsfont">Name and Signature of</label>
                        <label class="pull-right taxreceiptdetailsfont zerotopmargin">Authorized Representative of Organization:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control">${taxReciept?.name}</div>
                        <div class="form-control digitalsignature taxreceipttop text-center">
                            <img src="${taxReciept?.signatureUrl}" alt="signature">
                        </div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Status of Organization:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control"></div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">% of Exemption:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control"></div>
                    </div>
                </div>
            </div>
        </div>
    
    </div>
    
</g:if>
<g:else>
    <div class="taxreceiptcontainer">
        <div class="taxreceiptheader">Tax Receipt</div>
        <div class="row taxleftrightmargin">
            <div class="col-xs-4">
                <label class="taxdetailslabel"><b>Organization Logo:</b></label>
                <div class="taxreceiptbgcolor text-center">
                    <img src="${project.organizationIconUrl}" alt="orglogo"/>
                </div>
            </div>
            <div class="col-xs-8 col-plr-0">
                <div class="col-xs-12">
                    <label class="taxdetailslabel"><b>Organization Name:</b></label>
                    <div class="form-control">
                        ${project.organizationName}
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="taxdetailslabel"><b>Website</b></label>
                    <div class="form-control">
                        ${project.webAddress}
                    </div>
                    <label class="taxdetailslabel"><b>Email</b></label>
                    <div class="form-control">
                        ${project.user.email}
                    </div>
                    <label class="taxdetailslabel"><b>Phone</b></label>
                    <div class="form-control">
                        ${taxReciept?.phone}
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="taxdetailslabel"><b>Organization Address:</b></label>
                    <div class="form-control taxorgaddress">
                        ${taxReciept?.addressLine1},<br/>
                        ${taxReciept?.addressLine2},<br/>
                        ${taxReciept?.city}- ${taxReciept?.zip},<br/>
                        ${taxReciept?.taxRecieptHolderState}, ${taxReciept?.country}
                    </div>
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
                        <div class="form-control">${amountInWords}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Contributed amount in number:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control"><span class="fa fa-usd"></span> ${contribution.amount.round()}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Contribution received from:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control">${contribution.contributorName}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Date of contribution:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control">${date}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Perk claimed by contributor:</label>
                        <div class="clear"></div>
                        <label class="pull-right">(goods or services in exchange of contribution)</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control">${contribution.reward.title}</div>
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
                        <div class="form-control">${taxReciept?.ein}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Legal Status / % of Exemption:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control">${taxReciept?.deductibleStatus}</div>
                    </div>
                    <div class="clear"></div>
                    
                    <div class="col-xs-6 taxreceipttop">
                        <label class="pull-right taxreceiptdetailsfont">Name and Signature of</label>
                        <label class="pull-right taxreceiptdetailsfont zerotopmargin">Authorized Representative of Organization:</label>
                    </div>
                    <div class="col-xs-6 taxreceipttop">
                        <div class="form-control">${taxReciept?.name}</div>
                        <div class="form-control digitalsignature taxreceipttop text-center">
                            <img src="${taxReciept?.signatureUrl}" alt="signature">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
    </div>
</g:else>

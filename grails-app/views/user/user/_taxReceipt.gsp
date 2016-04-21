<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en">
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("d/MM/YYYY");
    def date = dateFormat.format(contribution.date)
%>

<g:if test="${!ismodal}">
    <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style>
            html {
              font-family: sans-serif;
              -webkit-text-size-adjust: 100%;
                  -ms-text-size-adjust: 100%;
            }
            body {
              margin: 0;
            }
            .row:before, .row:after, .panel-body:before, .panel-body:after {
                display: table;
                content: " ";
            }
            .row:after, .panel-body:after {
                clear: both;
            }
            .panel {
                margin-bottom: 20px;
                background-color: #fff;
                border: 1px solid transparent;
                border-radius: 4px;
                -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
                      box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
            }
            .panel-body {
                padding: 15px;
            }
            .col-xs-4 {
                width: 33.33333333%;
            }
            .col-xs-6 {
                width: 50%;
            }
            .col-plr-0 {
                padding-left: 0px !important;
                padding-right: 0px !important;
            }
            .col-xs-8 {
                width: 66.66666667%;
            }
            .col-xs-12 {
                width: 100%;
            }
            .col-xs-4, .col-xs-6, .col-xs-8, .col-xs-12 {
                float: left;
                position: relative;
                min-height: 1px;
                padding-right: 15px;
                padding-left: 15px;
            }
            .text-center {
                word-wrap: break-word;
                text-align: center;
            }
            .taxreceiptbgcolor img {
                width: 175px;
                height: 175px;
            }
            img {
                vertical-align: middle;
                border: 0;
            }
            .taxreceiptheader {
                background-color: #B3373C;
                color: #fff;
                padding: 10px 50px;
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 20px;
            }
            .feduoutercontent {
                margin-top: 48px;
            }
            .taxreceiptcontainer {
                width: 1000px;
                margin-left: auto;
                margin-right: auto;
                margin-top: 20px;
                margin-bottom: 20px;
            }
            .row {
                margin-right: -15px;
                margin-left: -15px;
            }
            label {
                display: inline-block;
                max-width: 100%;
                margin-bottom: 5px;
                font-weight: 700;
            }
            b, strong {
                font-weight: 700;
            }
            .taxreceiptbgcolor {
                background-color: #F4F4F4;
                padding-top: 30px;
                padding-bottom: 30px;
            }
            .clear {
                clear: both;
            }
            .form-control {
                display: block;
                width: 100%;
                min-height: 34px;
                padding: 6px 12px;
                font-size: 14px;
                line-height: 1.42857143;
                color: #555;
                background-color: #fff;
                background-image: none;
                border: 1px solid #e7e7e7;
                box-shadow: none;
                border-radius: 4px;
                -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
                -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
                transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            }
            .taxreceiptcontainer .form-control {
                min-height: 34px;
                height: auto;
            }
            * {
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
            }
            .taxreceiptcontributorlabel label {
                background-color: #889299;
                border-color: #889299;
                color: #FFF;
                height: 40px;
                padding: 10px;
            }
            .taxreceiptlabelfont {
                font-size: 16px;
                font-weight: 600;
            }
            .taxdetailslabel {
                margin-top: 12px;
                font-size: 14px;
            }
            .taxreceiptcontainer .taxorgaddress.form-control {
                min-height: 170px;
            }
            .pull-right {
                float: right !important;
            }
            .taxreceiptcontributiondetail .taxreceipttop {
                margin-top: 10px;
                margin-bottom: 10px;
            }
            .taxreceiptdetailsfont {
                margin-top: 8px;
                margin-bottom: 0px;
                font-size: 16px;
                font-weight: 500;
            }
            .taxreceiptcontainer .form-control.digitalsignature {
                height: 150px;
            }
        </style>
    </head>
    <body>
    
    <div class="feduoutercontent mobile-header-onmain">
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
                                ${dateFormat.format(taxReciept.regDate)}
                            </div>
                            <label class="taxdetailslabel"><b>PAN no. of Organization:</b></label>
                            <div class="form-control">
                                ${taxReciept.panCardNumber}
                            </div>
                            <label class="taxdetailslabel"><b>Receipt Number / Transaction Number:</b></label>
                            <div class="form-control">
                                ${transaction.transactionId}
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <label class="taxdetailslabel"><b>Organization Address:</b></label>
                            <div class="form-control taxorgaddress">
                                ${taxReciept.addressLine1},<br/>
                                ${taxReciept.addressLine2},<br/>
                                ${taxReciept.city}- ${taxReciept.zip},<br/>
                                ${taxReciept.taxRecieptHolderState}, India
                            </div>
                        </div>
                    </div>
                    
                </div>
        
                <br/>
                <div class="row taxleftrightmargin">
                    <div class="col-xs-12 ">
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
                                <div class="form-control"></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>
            
                <div class="row taxleftrightmargin">
                    <div class="col-xs-12">
                        <div class="taxreceiptcontributorlabel">
                            <label class="col-xs-12"><span class="taxreceiptlabelfont">TAX DEDUCTION DETAILS</span></label>
                        </div>
                        <div class="panel panel-body taxreceiptbgcolor taxreceiptcontributiondetail">
                            <div class="col-xs-6 taxreceipttop">
                                <label class="pull-right taxreceiptdetailsfont">Name and Signature of</label>
                                <label class="pull-right taxreceiptdetailsfont zerotopmargin">Authorized Representative of Organization:</label>
                            </div>
                            <div class="col-xs-6 taxreceipttop">
                                <div class="form-control">${taxReciept.name}</div>
                                <div class="form-control digitalsignature taxreceipttop"></div>
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
                            <div class="clear"></div>
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
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <label class="taxdetailslabel"><b>Organization Address:</b></label>
                            <div class="form-control taxorgaddress">
                                ${taxReciept.addressLine1},<br/>
                                ${taxReciept.addressLine2},<br/>
                                ${taxReciept.city}- ${taxReciept.zip},<br/>
                                ${taxReciept.taxRecieptHolderState}, ${taxReciept.country}
                            </div>
                        </div>
                    </div>
                    
                </div>
        
                <br/>
                <div class="row taxleftrightmargin">
                    <div class="col-xs-12 ">
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
                    <div class="col-xs-12 ">
                        <div class="taxreceiptcontributorlabel">
                            <label class="col-xs-12"><span class="taxreceiptlabelfont">TAX DEDUCTION DETAILS</span></label>
                        </div>
                        <div class="panel panel-body taxreceiptbgcolor taxreceiptcontributiondetail">
                            <div class="col-xs-6 taxreceipttop">
                                <label class="pull-right taxreceiptdetailsfont">Federal ID Number:</label>
                            </div>
                            <div class="col-xs-6 taxreceipttop">
                                <div class="form-control">${taxReciept.ein}</div>
                            </div>
                            <div class="clear"></div>
                            
                            <div class="col-xs-6 taxreceipttop">
                                <label class="pull-right taxreceiptdetailsfont">Legal Status / % of Exemption:</label>
                            </div>
                            <div class="col-xs-6 taxreceipttop">
                                <div class="form-control">${taxReciept.deductibleStatus}</div>
                            </div>
                            <div class="clear"></div>
                            
                            <div class="col-xs-6 taxreceipttop">
                                <label class="pull-right taxreceiptdetailsfont">Name and Signature of</label>
                                <label class="pull-right taxreceiptdetailsfont zerotopmargin">Authorized Representative of Organization:</label>
                            </div>
                            <div class="col-xs-6 taxreceipttop">
                                <div class="form-control">${taxReciept.name}</div>
                                <div class="form-control digitalsignature taxreceipttop"></div>
                            </div>
                        </div>
                    </div>
                </div>
            
            </div>
        </g:else>
    </div>
    
    </body>
</g:if>
<g:else>
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
                            ${dateFormat.format(taxReciept.regDate)}
                        </div>
                        <label class="taxdetailslabel"><b>PAN no. of Organization:</b></label>
                        <div class="form-control">
                            ${taxReciept.panCardNumber}
                        </div>
                        <label class="taxdetailslabel"><b>Receipt Number / Transaction Number:</b></label>
                        <div class="form-control">
                            ${transaction.transactionId}
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="taxdetailslabel"><b>Organization Address:</b></label>
                        <div class="form-control taxorgaddress">
                            ${taxReciept.addressLine1},<br/>
                            ${taxReciept.addressLine2},<br/>
                            ${taxReciept.city}- ${taxReciept.zip},<br/>
                            ${taxReciept.taxRecieptHolderState}, India
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
                            <div class="form-control"></div>
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
                            <div class="form-control">${taxReciept.name}</div>
                            <div class="form-control digitalsignature taxreceipttop"></div>
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
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="taxdetailslabel"><b>Organization Address:</b></label>
                        <div class="form-control taxorgaddress">
                            ${taxReciept.addressLine1},<br/>
                            ${taxReciept.addressLine2},<br/>
                            ${taxReciept.city}- ${taxReciept.zip},<br/>
                            ${taxReciept.taxRecieptHolderState}, ${taxReciept.country}
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
                            <div class="form-control">${taxReciept.ein}</div>
                        </div>
                        <div class="clear"></div>
                        
                        <div class="col-xs-6 taxreceipttop">
                            <label class="pull-right taxreceiptdetailsfont">Legal Status / % of Exemption:</label>
                        </div>
                        <div class="col-xs-6 taxreceipttop">
                            <div class="form-control">${taxReciept.deductibleStatus}</div>
                        </div>
                        <div class="clear"></div>
                        
                        <div class="col-xs-6 taxreceipttop">
                            <label class="pull-right taxreceiptdetailsfont">Name and Signature of</label>
                            <label class="pull-right taxreceiptdetailsfont zerotopmargin">Authorized Representative of Organization:</label>
                        </div>
                        <div class="col-xs-6 taxreceipttop">
                            <div class="form-control">${taxReciept.name}</div>
                            <div class="form-control digitalsignature taxreceipttop"></div>
                        </div>
                    </div>
                </div>
            </div>
        
        </div>
    </g:else>
</g:else>
</html>

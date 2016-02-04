<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en-US">
<head>
    <meta name="layout" content="main" />
</head>
<body>
    <div class="taxreceiptcontainer">
        <h1 class="title">This is tax receipt</h1>
        <div class="row">
            <div class="col-xs-4">
                <div class="taxreceiptbgcolor text-center">
                    <img src="${project.organizationIconUrl}" alt="orglogo">
                </div>
            </div>
            <div class="col-xs-8">
                <div class="col-xs-12 form-group">
                    <h5><b>${project.organizationName}</b></h5>
                </div>
                <div class="col-xs-6">
                    <h5><b>${project.webAddress}</b></h5>
                    <h5><b>${project.user.email}</b></h5>
                </div>
                <div class="col-xs-6">
                    
                </div>
            </div>
            
        </div>

        <br/>
        <div class="row">
            <div class="col-sm-12 ">
                <div class="taxreceiptcontributorlabel">
                    <label class="col-xs-12 text-center"><span class="taxreceiptlabelfont">CONTRIBUTOR DETAILS</span></label>
                </div>
                <div class="panel panel-body cr-partner-contact-info">
                    
                </div>
            </div>
        </div>
    
        <div class="row">
            <div class="col-sm-12 ">
                <div class="taxreceiptcontributorlabel">
                    <label class="col-xs-12 text-center"><span class="taxreceiptlabelfont">TAX DEDUCTION DETAILS</span></label>
                </div>
                <div class="panel panel-body cr-partner-contact-info">
                    
                </div>
            </div>
        </div>
    
    </div>
</body>
</html>

package crowdera

import groovy.json.JsonSlurper
import org.apache.http.HttpEntity
import org.apache.http.HttpResponse
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpPost
import org.apache.http.entity.StringEntity
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils

class ContributionService {
    
    private UserService userService;
    
    def grailsApplication
    
    Transaction getTransactionByTransactionId(String transactionId) {
        return Transaction.findByTransactionId(transactionId)
    }

    def getBankInfoByProject(Project project) {
        return BankInfo.findByProject(project)
    }
    
    def getTotalContribution() {
        def c = Contribution.createCriteria()
        def totalContribution = c.get {
            projections {
                sum "amount"
            }
        }
        return totalContribution
    }
    
    def getTotalUSDContributions(){
        def contribution = Contribution.createCriteria()
        def totalContribution = contribution.get{
            projections {
                eq("currency", "USD")
                projections {
                    sum "amount"
                }
            }
        }
        return totalContribution
    }
    
    def getTotalINRContributions(){
        def contribution = Contribution.createCriteria()
        def totalContribution = contribution.get{
            projections {
            eq("currency", "INR")
                projections {
                    sum "amount"
                }
            }
        }
        return totalContribution
    }
	
    def moveContribution(params, User user){
        Team moveFrom = Team.get(params.long("fundRaiserTeam"));
        Team moveTo = Team.get(params.long("fundRaiserTeam2"));
        Project project = Project.get(params.id);
        
        Contribution contribution = Contribution.get(params.long("contributiondetailId"));
        if (contribution && (moveFrom?.id != moveTo?.id)) {
            moveFrom?.removeFromContributions(contribution)
            moveTo?.addToContributions(contribution)
        }
    }
    
    def getContributionListByTeamId(def teamId) {
        Team team = Team.get(teamId);
        def contributiondetails = []
        def teamContributions = team?.contributions
        teamContributions.each {
            def infoList = [];
            infoList.add(it.id);
            infoList.add(it.contributorName+" :: Amount: "+it.amount?.round())
            
            contributiondetails.add(infoList);
        }
        
        return contributiondetails
    }
    
    def getContributionById(def contributionId){
        if (contributionId) {
            return Contribution.get(contributionId)
        }
    }

    def getTotalContributors (Project project){
        def user = []
        project.contributions.each { 
            user.add(it.userId)
        }
        return user
    }
	
	def getTotalContributionForUser(def contribution) {
	    if (!contribution) {
		   return 0
		}
		
		double total = 0
		contribution.each {
		   total += it.amount
		}
		return total.round()
	}

    def getShippingPendingItems() {
        return Contribution.findAllWhere(shippingDone: false)
    }

    def getShippingDoneItems() {
        return Contribution.findAllWhere(shippingDone: true)
    }

    def isFundingAchievedForProject(Project project) {
        if (!project) {
            return null
        }

        return getPercentageContributionForProject(project) == 999
    }

    def getTotalContributionForProject(Project project) {
        if (!project) {
            return null
        }

        double total = 0
        if(project.contributions){
            project.contributions.each { contribution ->
                total += contribution.amount
            }
            return total.round()
        }else{
            return 0
        }
    }

    def getBackersForProjectByReward(Project project, Reward reward) {
        if (!project || !reward) {
            return null
        }

        return Contribution.findAllByProjectAndReward(project, reward).size()
    }

    def getPercentageContributionForProject(Project project) {
        if (!project) {
            return null
        }

        double totalContribution = getTotalContributionForProject(project)
        def percentage
        if (totalContribution == 0) {
            percentage = 0
        } else if (totalContribution == project.amount) {
            percentage = 100
        } else {
            percentage = totalContribution / project.amount * 100
            if (percentage <= 1) {
                percentage = 1
            }else if(percentage>999){
                percentage=999
            } else {
                percentage = percentage.intValue()
            }
        }
        return percentage
    }
    
    def getPercentageContributionForProject(def totalContribution, Project project) {
        if (!project) {
            return null
        }

        def percentage
        if (totalContribution == 0) {
            percentage = 0
        } else if (totalContribution == project.amount) {
            percentage = 100
        } else {
            percentage = totalContribution / project.amount * 100
            if (percentage <= 1) {
                percentage = 1
            }else if(percentage>999){
                percentage=999
            } else {
                percentage = percentage.intValue()
            }
        }
        return percentage
    }
	
    def getPercentageContributionForTeam(def team){
        if (!team) {
            return null
        }
        double totalContribution = getTotalContributionForUser(team.contributions)
        def percentage
        if (totalContribution == 0) {
            percentage = 0
        } else if (totalContribution == team.amount) {
            percentage = 100
        } else {
            percentage = totalContribution / team.amount * 100
            if (percentage <= 1) {
                percentage = 1
            }else if(percentage>999){
	            percentage=999
            } else {
 	            percentage = percentage.intValue()
            }
        }
        return percentage
    }
    
    def getPercentageContributionForTeam(def totalContribution, def team){
        if (!team) {
            return null
        }
        def percentage
        if (totalContribution == 0) {
            percentage = 0
        } else if (totalContribution == team.amount) {
            percentage = 100
        } else {
            percentage = totalContribution / team.amount * 100
            if (percentage <= 1) {
                percentage = 1
            }else if(percentage>999){
                percentage=999
            } else {
                percentage = percentage.intValue()
            }
        }
        return percentage
    }

    def getFundingAchievedDate(Project project) {
        if (!project) {
            return null
        }

        Contribution contribution = project.contributions.last()
        return contribution.date
    }
    
    def getMonth() {
        def month = [
            '01' :  'January',
            '02' :  'February',
            '03' :  'March',
            '04' :  'April',
            '05' :  'May',
            '06' :  'June',
            '07' :  'July',
            '08' :  'August',
            '09' :  'September',
            '10' :  'October',
            '11' :  'November',
            '12' :  'December'
        ]
        return month
    }
    
    def getYear() {
        def year = [
            2014 : '2014',
            2015 : '2015',
            2016 : '2016',
            2017 : '2017',
            2018 : '2018',
            2019 : '2019',
            2020 : '2020',
            2021 : '2021',
            2022 : '2022',
            2023 : '2023',
            2024 : '2024',
            2025 : '2025',
            2026 : '2026',
            2027 : '2027',
            2028 : '2028',
            2029 : '2029',
            2030 : '2030'
        ]
        return year
    }
    
    def getFundRaiserName(def contribution, def project) {
        def user = User.findByUsername(contribution.fundRaiser)
        def fundRaiserName
        if (user) {
            fundRaiserName = user.firstName +" "+ user.lastName
        } else {
            fundRaiserName = project.user.firstName +" "+project.user.lastName
        }
        return fundRaiserName
    }
    
    def getShippingDetails(Contribution contributions) {
        def shippingDetails
        if(contributions.email==null && contributions.physicalAddress==null && contributions.
            twitterHandle==null  && contributions.custom==null){
            shippingDetails="No Perk Selected "
        }else{
            if(contributions.email!=null){
                shippingDetails="<b>Email:</b> " +contributions.email

                if(contributions.physicalAddress!=null){
                    shippingDetails+=", <br><b>Physical Address:</b> " + contributions.physicalAddress
                }
                if(contributions.twitterHandle!=null){
                    shippingDetails+=" , <br><b>Twitter Handle:</b> " + contributions.twitterHandle
                }
                if(contributions.custom!=null) {
                    shippingDetails+=" , <br><b>Custom: </b> " +contributions.custom
                }
            }
            if(contributions.physicalAddress!=null){
                shippingDetails="<b>Physical Address:</b> " + contributions.physicalAddress
                if(contributions.twitterHandle!=null){
                    shippingDetails+=" , <br><b>Twitter Handle:</b> " + contributions.twitterHandle
                }
                if(contributions.custom!=null) {
                    shippingDetails+=" , <br><b>Custom: </b> " + contributions.custom
                }
                if(contributions.email!=null){
                    shippingDetails+=" , <br><b>Email:</b> " +contributions.email
                }
            }
            if(contributions.twitterHandle!=null){
                shippingDetails ="<b>Twitter Handle:</b> " + contributions.twitterHandle
                if(contributions.physicalAddress!=null){
                    shippingDetails+=" , <br><b>Physical Address:</b> " + contributions.physicalAddress
                }
                if(contributions.custom!=null) {
                    shippingDetails+=" , <br><b>Custom: </b> " + contributions.custom
                }
                if(contributions.email!=null){
                    shippingDetails+=" ,<br><b>Email:</b> " +contributions.email
                }
            }
            if(contributions.custom!=null){
                shippingDetails="<b>Custom: </b>  " + contributions.custom
                if(contributions.physicalAddress!=null){
                    shippingDetails+=" , <br><b>Physical Address:</b> " + contributions.physicalAddress
                }
                if(contributions.twitterHandle!=null) {
                    shippingDetails+=" , <br><b>Twitter Handle:</b> " + contributions.twitterHandle
                }
                if(contributions.email!=null){
                    shippingDetails+=" , <br><b>Email:</b> " +contributions.email
                }
            }
        }
        return shippingDetails
    }
	
    def getNumberOfDaysForContribution(Contribution contribution) {
	def contributionDate = contribution.date;
	def currentDate = new Date();
	def numberOfDays = currentDate - contributionDate
	return numberOfDays
    }
    
    def getUSDContributions(def params){
        List totalContributions = Contribution.findAllWhere(currency: 'USD').reverse()
        List contributions = []
        if (!totalContributions.isEmpty()) {
            def offset = params.offset ? params.int('offset') : 0
            def max = 10
            def count = totalContributions.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            contributions = totalContributions.reverse().subList(offset, maxrange)
        }
        return [totalContributions: totalContributions, contributions: contributions]
    }

    def getINRContributions(def params){
        List totalContributions = Contribution.findAllWhere(currency: 'INR').reverse()
        List contributions = []
        if (!totalContributions.isEmpty()) {
            def offset = params.offset ? params.int('offset') : 0
            def max = 10
            def count = totalContributions.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            contributions = totalContributions.reverse().subList(offset, maxrange)
        }
        return [totalContributions: totalContributions, contributions: contributions]
    }
    
    def getINRContributions() {
        return Contribution.findAllWhere(currency: 'INR').reverse()
    }
    
    def getUSDContributions() {
        return Contribution.findAllWhere(currency: 'USD').reverse()
    }
	
    def transactionSort(){
        def sort = [
            Date : 'Date',
            Name : 'Name',
            Offline : 'Offline',
            Online : 'Online'
        ]
        return sort
    }

    def getContributionSortedResult(def params, def query, def currency){
        def result
        def contributions
        switch (query) {
            case 'Name':
                contributions = (currency == 'INR') ? Contribution.findAllWhere(currency: 'INR') : Contribution.findAllWhere(currency: 'USD');
                result = contributions?.sort{it.contributorName.toUpperCase()};
                break;

            case 'Offline':
                result = (currency == 'INR') ? Contribution.findAllWhere(currency: 'INR', isContributionOffline:true) : Contribution.findAllWhere(currency: 'USD', isContributionOffline:true);
                break;

            case 'Online':
                result = (currency == 'INR') ? Contribution.findAllWhere(currency: 'INR', isContributionOffline:false) : Contribution.findAllWhere(currency: 'USD', isContributionOffline:false);
                break;

            case 'Date':
                contributions = (currency == 'INR') ? Contribution.findAllWhere(currency: 'INR') : Contribution.findAllWhere(currency: 'USD');
                def sortedByDate = contributions?.sort{it.date};
                result = sortedByDate.reverse();
                break;

            default :
                contributions = (currency == 'INR') ? Contribution.findAllWhere(currency: 'INR') : Contribution.findAllWhere(currency: 'USD');
                def sortedByDate = contributions?.sort{it.date};
                result = sortedByDate.reverse();
        }
        List totalContributions = []
        if (!result.isEmpty()) {
            def offset = params.int('offset') ?: 0
            def max = Math.min(params.int('max') ?: 10, 100)
            def count = result.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            totalContributions = result.reverse().subList(offset, maxrange)
        }
        return [totalContributions: result, contributions: totalContributions]
        
    }

    def getHighestContributionDay(Project project) {
        int monday = 0, tuesday = 0, wednesday = 0, thursday = 0, friday = 0, saturday = 0, sunday = 0
        int zeroth = 0, first = 0, second = 0, third = 0, forth = 0, fifth = 0, sixth = 0, seventh = 0, eight = 0, nineth=0
        int tenth = 0, eleventh = 0, twelfth = 0, thirteenth = 0, forteenth = 0, fifteenth = 0, sixteenth = 0, seventeenth = 0
        int eighteenth = 0, nineteenth = 0 , twentieth = 0, twentyFirst = 0, twentySecond = 0, twentyThird = 0
        
        List contributions = project.contributions
        
        contributions.each{ contribution->
            Date contributionDate = contribution.date
            def day = contributionDate[Calendar.DAY_OF_WEEK]
            switch (day) {
                case 1:
                    sunday = sunday + 1
                    break;
                case 2:
                    monday = monday + 1
                    break;
                case 3:
                    tuesday = tuesday + 1
                    break;
                case 4:
                    wednesday = wednesday + 1
                    break;
                case 5:
                    thursday = thursday + 1
                    break;
                case 6:
                    friday = friday + 1
                    break;
                case 7:
                    saturday = saturday + 1
                    break;
                default :
                    monday = monday + 1
            }
            
            def hour = contributionDate[Calendar.HOUR_OF_DAY]
            switch (hour) {
                case 0:
                    zeroth = zeroth + 1
                    break;
                case 1:
                    first = first + 1
                    break;
                case 2:
                    second = second + 1
                    break;
                case 3:
                    third = third + 1
                    break;
                case 4:
                    forth = forth + 1
                    break;
                case 5:
                    fifth = fifth + 1
                    break;
                case 6:
                    sixth = sixth + 1
                    break;
                case 7:
                    seventh = seventh + 1
                    break;
                case 8:
                    eight = eight + 1
                    break;
                case 9:
                    nineth = nineth + 1
                    break;
                case 10:
                    tenth = tenth + 1
                    break;
                case 11:
                    eleventh = eleventh + 1
                    break;
                case 12:
                    twelfth = twelfth + 1
                    break;
                case 13:
                    thirteenth = thirteenth + 1
                    break;
                case 14:
                    forteenth = forteenth + 1
                    break;
                case 15:
                    fifteenth = fifteenth + 1
                    break;
                case 16:
                    sixteenth = sixteenth + 1
                    break;
                case 17:
                    seventeenth = seventeenth + 1
                    break;
                case 18:
                    eighteenth = eighteenth + 1
                    break;
                case 19:
                    nineteenth = nineteenth + 1
                    break;
                case 20:
                    twentieth = twentieth + 1
                    break;
                case 21:
                    twentyFirst = twentyFirst + 1
                    break;
                case 22:
                    twentySecond = twentySecond + 1
                    break;
                case 23:
                    twentyThird = twentyThird + 1
                    break;
                default :
                    zeroth = zeroth + 1
            }
        }
        
        Map hours = ['00 - 01': zeroth , '01 - 02' : first, '02 - 03': second, '03 - 04': third, '04 - 05': forth, '05 - 06': fifth, '06 - 07': sixth, '07 - 08': seventh, '08 - 09': eight,
                     '09 - 10': nineth, '10 - 11': tenth, '11 - 12': eleventh, '12 - 13':twelfth, '13 - 14': thirteenth , '14 - 15': forteenth, '15 - 16': fifteenth,
                     '16 - 17': sixteenth, '17 - 18': seventeenth ,'18 - 19': eighteenth, '19 - 20':nineteenth, '20 - 21': twentieth, '21 - 22': twentyFirst, '22 - 23': twentySecond, '23 - 24':twentyThird]
        def highestContributionHour = hours.max { it.value }.key
        
        Map days = ['monday' : monday, 'tuesday': tuesday, 'wednesday' : wednesday, 'thursday': thursday, 'friday' : friday,'saturday': saturday, 'sunday': sunday]
        def highestContributionDay = days.max { it.value }.key
        return ['highestContributionDay':highestContributionDay , 'highestContributionHour': highestContributionHour]
    }
    
    def getContributorsForProject(def id, def params, String environment){
        Project project = Project.get(id)
        
        List<Contribution> totalContributions =  Contribution.findAllWhere(project:project)
        List<Contribution> contributionList = new ArrayList<>();
        
        if (environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia') {
            totalContributions.each {
                if (it.panNumber != null) {
                    contributionList.add(it);
                }
            }
            totalContributions = contributionList;
        } 
        
        List contributions
        if (!totalContributions.empty){
            def offset = params.offset ? params.int('offset') : 0
            def max = 10
            def count = totalContributions.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            contributions = totalContributions.reverse().subList(offset, maxrange)
        }
        
        return [totalContributions:totalContributions, contributions:contributions]
    }
    
    def contributorsSortUs(){
        def sort = [
            'All':'All',
            'Anonymous':'Anonymous',
            'Non-Anonymous':'Non-Anonymous',
            'Online':'Online',
            'Offline':'Offline',
            'Receipt Sent':'Receipt Sent',
            'Receipt Not Sent':'Receipt Not Sent',
            'Perk Selected':'Perk Selected',
            'No Perk Selected':'No Perk Selected',
        ]
    }

    def contributorsSortInd(){
        def sort = [
            'All':'All',
            'Anonymous':'Anonymous',
            'Non-Anonymous':'Non-Anonymous',
            'Receipt Sent':'Receipt Sent',
            'Receipt Not Sent':'Receipt Not Sent',
            'Perk Selected':'Perk Selected',
            'No Perk Selected':'No Perk Selected',
        ]
    }
    
    def getTransactionByContribution(def contribution) {
        return Transaction.findByContribution(contribution)
    }
    
    def getSecuritySignature(String txnID, String secret_key, String access_Key, def amount ) {
        
        String data = "merchantAccessKey=" + access_Key + "&transactionId=" + txnID + "&amount=" + amount;
        
        javax.crypto.Mac mac = javax.crypto.Mac.getInstance("HmacSHA1");
        
        mac.init(new javax.crypto.spec.SecretKeySpec(secret_key.getBytes(), "HmacSHA1"));
        
        byte[] hexBytes = new org.apache.commons.codec.binary.Hex().encode(mac.doFinal(data.getBytes()));
        String securitySignature = new String(hexBytes, "UTF-8");
        return securitySignature
    }
    
    
    def setSellerId(Project project) {
        def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.SPLITPAY_URL
        def url = citrusBaseUrl +"/marketplace/seller/"
        
        BankInfo bankInfo = getBankInfoByProject(project)
        
        if (bankInfo != null) {
            def sellername = bankInfo.fullName
            def selleremail = bankInfo.email
            
            def seller = getSellerIdByEmail(selleremail)
            def sellerId
            if (seller) {
                return seller.sellerId
            } else {
                def address1 = bankInfo.address1
                def address2 = bankInfo.address2
                def city = bankInfo.city
                def state = bankInfo.state
                def country = bankInfo.country
                def zip = bankInfo.zip
                def businessurl = project.webAddress
                def sellermobile = bankInfo.mobile
                
                def ifsccode = bankInfo.ifscCode
                def payoutmode = bankInfo.payoutmode
                def accountnumber = bankInfo.accountNumber
                
                def auth_token = getAccessTokenForCitrus()
                HttpClient httpclient = new DefaultHttpClient()
                HttpPost httppost = new HttpPost(url)
                httppost.setHeader("auth_token","${auth_token}")
                
                StringEntity input = new StringEntity("{\"seller_name\":\"${sellername}\",\"seller_add1\":\"${address1}\",\"seller_add2\":\"${address2}\",\"seller_city\":\"${city}\",\"seller_state\":\"${state}\",\"seller_country\":\"${country}\",\"zip\":\"${zip}\",\"businessurl\":\"${businessurl}\",\"seller_mobile\":\"${sellermobile}\",\"seller_ifsc_code\":\"${ifsccode}\",\"selleremail\":\"${selleremail}\",\"payoutmode\":\"${payoutmode}\",\"seller_acc_num\":\"${accountnumber}\",\"active\":1}")
                input.setContentType("application/json")
                httppost.setEntity(input)
        
                HttpResponse httpres = httpclient.execute(httppost)
                
                int status = httpres.getStatusLine().getStatusCode()
                if (status == 200){
                    HttpEntity entity = httpres.getEntity()
                    if (entity != null){
                        def jsonString = EntityUtils.toString(entity)
                        def slurper = new JsonSlurper()
                        def json = slurper.parseText(jsonString)
                        sellerId = json.sellerid
                        
                        if (sellerId != null) {
                            new Seller(email: selleremail, sellerId: sellerId).save();
                        }
                    }
                    
                }
                
                return sellerId
            }
        } else {
            return null;
        }
    }
    
    def getAccessTokenForCitrus() {
        def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.SPLITPAY_URL
        def url = citrusBaseUrl +"/marketplace/auth/"
        
        HttpClient httpclient = new DefaultHttpClient()
        HttpPost httppost = new HttpPost(url)
        
        def access_key = grailsApplication.config.crowdera.CITRUS.ACCESS_KEY
        def secret_key = grailsApplication.config.crowdera.CITRUS.SECRETE_KEY

        StringEntity input = new StringEntity("{\"access_key\":\"${access_key}\",\"secret_key\":\"${secret_key}\"}")
        
        input.setContentType("application/json")
        httppost.setEntity(input)

        HttpResponse httpres = httpclient.execute(httppost)
        def authToken
        
        int status = httpres.getStatusLine().getStatusCode()
        if (status == 200){
            HttpEntity entity = httpres.getEntity()
            if (entity != null){
                String jsonString = EntityUtils.toString(entity)
                def slurper = new JsonSlurper()
                def json = slurper.parseText(jsonString)
                authToken = json.auth_token
            }
        }
        return authToken
    }
    
    def getSellerIdByEmail(String email) {
        return Seller.findByEmail(email)
    }
    

    def setPaypalIPNData(def params){
        PaypalIPNData ipnData = new PaypalIPNData( itemNumber: params.item_number, residenceCountry: params.residence_country,
                                           invoice: params.invoice, addressCountry: params.address_country, addressCity: params.address_city,
                                           paymentStatus: params.payment_status, payerId: params.payer_id, firstName : params.first_name,
                                           shipping: params.shipping, payerEmail: params.payer_email, txnId: params.txn_id, receiverEmail: params.receiver_email,
                                           txnType: params.txn_type, mcGross: params.mc_gross, mcCurrency: params.mc_currency, payerStatus: params.payer_status,
                                           paymentDate: params.payment_date, addressZip: params.address_zip, addressState: params.address_state, itemName: params.item_name,
                                           addressName: params.address_name, lastName: params.last_name, paymentType: params.payment_type,
                                           addressStreet: params.address_street, receiverId: params.receiver_id
                                         )
        ipnData.save()
    }

}

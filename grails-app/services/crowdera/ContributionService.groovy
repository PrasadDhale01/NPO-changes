package crowdera

class ContributionService {

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
        project.contributions.each { contribution ->
            total += contribution.amount
        }
        return total.round()
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
    
    def getContributorsForProject(def id, def params){
        Project project = Project.get(id)
        def totalContributions =  Contribution.findAllWhere(project:project)
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
    
}

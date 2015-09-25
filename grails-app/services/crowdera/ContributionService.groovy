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
    
    def getUSDTransactions(){
        return Transaction.findAllWhere(currency: 'USD')
    }
    
    def getINRTransactions(){
        return Transaction.findAllWhere(currency: 'INR')
    }
    
    def getHighestContributionDay(Project project) {
        int monday = 0, tuesday = 0, wednesday = 0, thursday = 0, friday = 0, saturday = 0, sunday = 0
        int zeroth = 0, first = 0, second = 0, third = 0, forth = 0, fifth = 0, sixth = 0, seventh = 0, eight = 0, nineth=0
        int tenth = 0, eleventh = 0, twelfth = 0, thirteenth = 0, forteenth = 0, fifteenth = 0, sixteenth = 0, seventeenth = 0
        int eighteenth = 0, nineteenth = 0 , twentieth = 0, twentyFirst = 0, twentySecond = 0, twentyThird = 0
        
        List contributions = project.contributions
        List hourList = []
        
        contributions.each{ contribution->
            Date contributionDate = contribution.date
            def day = contributionDate[Calendar.DAY_OF_WEEK]
            switch (day) {
                case 1:
                    monday = monday + contribution.amount
                    break;
                case 2:
                    tuesday = tuesday + contribution.amount
                    break;
                case 3:
                    wednesday = wednesday + contribution.amount
                    break;
                case 4:
                    thursday = thursday + contribution.amount
                    break;
                case 5:
                    friday = friday + contribution.amount
                    break;
                case 6:
                    saturday = saturday + contribution.amount
                    break;
                case 7:
                    sunday = sunday + contribution.amount
                    break;
                default :
                    println 'day'
            }
            
            
            def hour = contributionDate[Calendar.HOUR_OF_DAY]
            switch (hour) {
                case 0:
                    zeroth = zeroth + contribution.amount
                    break;
                case 1:
                    first = first + contribution.amount
                    break;
                case 2:
                    second = second + contribution.amount
                    break;
                case 3:
                    third = third + contribution.amount
                    break;
                case 4:
                    forth = forth + contribution.amount
                    break;
                case 5:
                    fifth = fifth + contribution.amount
                    break;
                case 6:
                    sixth = sixth + contribution.amount
                    break;
                case 7:
                    seventh = seventh + contribution.amount
                    break;
                case 8:
                    eight = eight + contribution.amount
                    break;
                case 9:
                    nineth = nineth + contribution.amount
                    break;
                case 10:
                    tenth = tenth + contribution.amount
                    break;
                case 11:
                    eleventh = eleventh + contribution.amount
                    break;
                case 12:
                    twelfth = twelfth + contribution.amount
                    break;
                case 13:
                    thirteenth = thirteenth + contribution.amount
                    break;
                case 14:
                    forteenth = forteenth + contribution.amount
                    break;
                case 15:
                    fifteenth = fifteenth + contribution.amount
                    break;
                case 16:
                    sixteenth = sixteenth + contribution.amount
                    break;
                case 17:
                    seventeenth = seventeenth + contribution.amount
                    break;
                case 18:
                    eighteenth = eighteenth + contribution.amount
                    break;
                case 19:
                    nineteenth = nineteenth + contribution.amount
                    break;
                case 20:
                    twentieth = twentieth + contribution.amount
                    break;
                case 21:
                    twentyFirst = twentyFirst + contribution.amount
                    break;
                case 22:
                    twentySecond = twentySecond + contribution.amount
                    break;
                case 23:
                    twentyThird = twentyThird + contribution.amount
                    break;
                default :
                    println 'day'
            }
        }
        
        Map hours = ['zeroth': zeroth , 'first' : first, 'second': second, 'third': third, 'forth': forth, 'fifth': fifth, 'sixth': sixth, 'seventh': seventh, 'eight': eight,
                     'nineth': nineth, 'tenth': tenth, 'eleventh': eleventh, 'twelfth':twelfth, 'thirteenth': thirteenth , 'forteenth': forteenth, 'fifteenth': fifteenth,
                     'sixteenth': sixteenth, 'eighteenth': eighteenth, 'nineteenth':nineteenth, 'twentieth': twentieth, 'twentyFirst': twentyFirst, 'twentySecond': twentySecond, 'twentyThird':twentyThird]
        def highestContributionHour = hours.max { it.value }.key
        
        Map days = ['monday' : monday, 'tuesday': tuesday, 'wednesday' : wednesday, 'thursday': thursday, 'friday' : friday,'saturday': saturday, 'sunday': sunday]
        def highestContributionDay = days.max { it.value }.key
        return ['highestContributionDay':highestContributionDay , 'highestContributionHour': highestContributionHour]
    }
    
}

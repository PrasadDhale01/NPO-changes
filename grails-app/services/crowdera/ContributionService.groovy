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
	 
	def getContributionById(def contributionId){
		return Contribution.get(contributionId)
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
}

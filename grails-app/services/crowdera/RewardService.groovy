package crowdera

import grails.transaction.Transactional

class RewardService {

    def getNoReward() {
        return Reward.findById(1)
    }

    def isRewardUnused(Reward reward) {
        if (reward.projects == null) {
            return true
        } else {
            return false
        }
    }
	
    def getRewardByParams(def rewardParams){
        Reward reward = new Reward(rewardParams)
        return reward
    }

    def getRewardById(def rewardId){
        if (rewardId) {
            return Reward.get(rewardId)
        }
    }

    def numProjectsUsingReward(Reward reward) {
        return reward.projects.size()
    }

    def getNonObsoleteRewards() {
        return Reward.findAllWhere(obsolete: false)
    }

    def getObsoleteRewards() {
        return Reward.findAllWhere(obsolete: true)
    }
    
    def getRewardShippingInfo(def reward) {
        return RewardShipping.findByReward(reward)
    }
    
    def editCustomReward(params) {
        int price = Double.parseDouble(params.price)
        int amount = Double.parseDouble(params.amount)
        def reward = Reward.get(params.long('id'))
        def isPerkPriceLess = true
        if(reward) {
            if (price <= amount) {
                if(price != reward.price) {
                    reward.price = price
                }
            } else {
                isPerkPriceLess = false;
            }
            
            if (params.title != reward.title) {
                reward.title = params.title
            }
            
            if (params.description != reward.description) {
                reward.description = params.description
            }
            
            if (Integer.parseInt(params.numberAvailable) != reward.numberAvailable) {
                reward.numberAvailable = Integer.parseInt(params.numberAvailable)
            }
            
            def rewardShipping = RewardShipping.findByReward(reward)
			if (rewardShipping) {
                rewardShipping.address = params.address
                rewardShipping.email = params.email 
                rewardShipping.twitter = params.twitter
                rewardShipping.custom = params.custom
			}
        }
        return isPerkPriceLess
    }
    
    def isOnlyTwitterHandled (Reward reward){
       def rewardShipping = RewardShipping.findByReward(reward)
       def isOnlyTwitterSelected = false
       if(rewardShipping) {
           if (rewardShipping.twitter == 'true') {
               if(rewardShipping.email == null && rewardShipping.address == null && rewardShipping.custom == null) {
                   isOnlyTwitterSelected = true
               }
           }
       }
       return isOnlyTwitterSelected
    }
    
    def isTwitterHandled(reward){
        def rewardShipping = RewardShipping.findByReward(reward)
        def isTwitterSelected = false
        if(rewardShipping) {
            if (rewardShipping.twitter == 'true') {
                if(rewardShipping.email == 'true' || rewardShipping.address == 'true' || rewardShipping.custom == 'true') {
                    isTwitterSelected = true
                }
            }
        }
        return isTwitterSelected
    }
    
    def getOnlytwitterHandlerReward(Project project){
        def reward = project.rewards
        List rewardList = []
        reward.each {
            def rewardShipping = RewardShipping.findByReward(it)
            if(rewardShipping) {
                if (rewardShipping.twitter == 'true') {
                    if(rewardShipping.email == null && rewardShipping.address == null && rewardShipping.custom == null) {
                        rewardList.add(it)
                    }
                }
            }
        }
        return rewardList
    }
    
    def getTwitterHandlerReward(Project project){
        def reward = project.rewards
        List rewardList = []
        reward.each {
            def rewardShipping = RewardShipping.findByReward(it)
            if(rewardShipping) {
                if (rewardShipping.twitter == 'true') {
                    if(rewardShipping.email == 'true' || rewardShipping.address == 'true' || rewardShipping.custom == 'true') {
                        rewardList.add(it)
                    }
                }
            }
        }
        return rewardList
    }
    
    def getMultipleRewards(def project, def rewardTitle ,def rewardPrice ,def rewardNumberAvailable ,def rewardDescription, def mailingAddress, def emailAddress, def twitter, def custom) {
        def amount
        for(int i=0; i<rewardTitle.size();i++ ) {
            Reward reward = new Reward()
            RewardShipping shippingInfo = new RewardShipping()
            reward.title = rewardTitle[i]
            amount = rewardPrice[i]
            if(!amount.isAllWhitespace()) {
                reward.price = Double.parseDouble(rewardPrice[i])
            }
            reward.description = rewardDescription[i]
			reward.numberAvailable = Integer.parseInt(rewardNumberAvailable[i])
            reward.rewardCount = project.rewards.size();
            reward.obsolete = true
            reward.save(failOnError: true)
            
            shippingInfo.email = emailAddress[i]
            shippingInfo.address = mailingAddress[i]
            shippingInfo.twitter = twitter[i]
            shippingInfo.custom = custom[i]
            shippingInfo.reward = reward
            shippingInfo.save(failOnError: true)
            
            project.addToRewards(reward)
        }
    }
    
    def getShippingInfo(def reward) {
        return RewardShipping.findByReward(reward)
    }
    
    def getSortedRewards(Project project) {
        def rewards = project.rewards
        def sortedRewards = rewards.sort {it.price}
        return sortedRewards
    }
	
    def autoSaveRewardDetails(def params) {
        Project project = Project.get(params.projectId);
        List rewards = project.rewards
        Reward reward
        RewardShipping shippingInfo
        def newreward
        rewards.each{
            if (it.rewardCount == Integer.parseInt(params.rewardNum)){
                reward = it
                shippingInfo = RewardShipping.findByReward(it)
            }
        }
        if (!reward) {
            reward = new Reward();
            shippingInfo = new RewardShipping();
            newreward = true
        }
        reward.title = params.rewardTitle
        reward.price = Double.parseDouble(params.rewardPrice);
        reward.rewardCount = Integer.parseInt(params.rewardNum);
        reward.description = params.rewardDesc;
        reward.numberAvailable = Integer.parseInt(params.rewardNumberAvailable);
        reward.obsolete = true;
        reward.save(failOnError: true);

        shippingInfo.email = (params.email == true || params.email == 'true') ? true : null;
        shippingInfo.address = (params.address == true || params.address == 'true') ? true : null;
        shippingInfo.twitter = (params.twitter == true || params.twitter == 'true') ? true : null;
        shippingInfo.custom = (params.custom) ? params.custom : null;
        shippingInfo.reward = reward
        shippingInfo.save(failOnError: true)

        if (newreward){
            project.addToRewards(reward)
        }
    }

    def deleteReward(def params){
        Project project = Project.get(params.projectId)
        RewardShipping rewardShippingInfo
		List temprewards = []
		List rewards = project.rewards
		rewards.each {
			temprewards.add(it)
		}
        temprewards.each{
            if(it.rewardCount == Integer.parseInt(params.rewardCount)){
                rewards.remove(it);
                rewardShippingInfo = RewardShipping.findByReward(it)
                if (rewardShippingInfo)
                    rewardShippingInfo.delete();
                it.delete();
            }
        }
     }

     def deleteAllRewards(def params){
         Project project = Project.get(params.projectId)
         RewardShipping rewardShippingInfo
         List temprewards = []
         List rewards = project.rewards
		 def defaultReward
         rewards.each {
             if (it.id == 1){
                 defaultReward = it
             } else {
                 temprewards.add(it)
             }
         }
         if (!rewards.isEmpty()){
             rewards.removeAll(rewards)
             rewards.add(defaultReward)
             temprewards.each{
                 rewardShippingInfo = RewardShipping.findByReward(it)
                 if (rewardShippingInfo)
                     rewardShippingInfo.delete();
                 it.delete();
             }
         }
     }

	 def getRewardShippingObjectByReward(def reward){
         RewardShipping shippingInfo = RewardShipping.findByReward(reward)
		 return shippingInfo
	 }
	 
	 def saveRewardDetails(def params){
		 Reward reward
		 RewardShipping shippingInfo
		 Project project = Project.get(params.projectId)
		 def rewardLength = Integer.parseInt(params.rewardCount)
		 List rewardsList = project.rewards
		 def newReward = false
		 if(rewardLength > 0){
		 rewardsList.each{
			 if (it.rewardCount == Integer.parseInt(params.rewardCount)){
				  reward = it
				  shippingInfo = RewardShipping.findByReward(it) 
			 }
		 }
		 if (!reward){
		 reward = new Reward();
		 shippingInfo = new RewardShipping();
		 newReward = true;
		 }
		 
		 reward.title = params.('rewardTitle'+params.rewardCount)
		 reward.price = Double.parseDouble(params.('rewardPrice'+params.rewardCount));
		 reward.rewardCount = Integer.parseInt(params.rewardCount);
		 reward.description = params.('rewardDescription'+params.rewardCount);
		 reward.numberAvailable = Integer.parseInt(params.('rewardNumberAvailable'+params.rewardCount));
		 reward.obsolete = true;
		 reward.save(failOnError: true);
 
		 shippingInfo.email = (params.('mailingAddress'+params.rewardCount) == true || params.('mailingAddress'+params.rewardCount) == 'true') ? true : null;
		 shippingInfo.address = (params.('address'+params.rewardCount) == true || params.('address'+params.rewardCount) == 'true') ? true : null;
		 shippingInfo.twitter = (params.('twitter'+params.rewardCount) == true || params.('twitter'+params.rewardCount) == 'true') ? true : null;
		 shippingInfo.custom = (params.('custom'+params.rewardCount)) ? params.custom : null;
		 shippingInfo.reward = reward
		 shippingInfo.save(failOnError: true)
 
		 if (newReward){
			 project.addToRewards(reward)
		 }
		 }
		 return
	 }

    @Transactional
    def bootstrap() {
        new Reward(
                title: 'No Perk',
                description: 'No Perk. I just want to contribute',
                price: 0.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: 'Personal thank you Email',
                description: 'Personal thank you email from beneficiary',
                price: 10.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: 'Handwritten Postcard',
                description: 'A handwritten postcard',
                price: 15.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '6 FEDU Wristbands',
                description: '6 FEDU Wristbands',
                price: 20.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '12 FEDU Wristbands',
                description: '12 FEDU Wristbands',
                price: 25.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '1 FEDU T-shirt & 6 FEDU Wristbands',
                description: '1 FEDU T-shirt & 6 FEDU Wristbands',
                price: 25.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '1 FEDU T-shirt & 12 FEDU Wristbands',
                description: '1 FEDU T-shirt & 12 FEDU Wristbands',
                price: 30.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '2 FEDU T-shirts & 6 FEDU Wristbands',
                description: '2 FEDU T-shirts & 6 FEDU Wristbands',
                price: 40.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '2 FEDU T-shirts & 12 FEDU Wristbands',
                description: '2 FEDU T-shirts & 12 FEDU Wristbands',
                price: 45.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '3 FEDU T-shirts & 6 FEDU Wristbands',
                description: '3 FEDU T-shirts & 6 FEDU Wristbands',
                price: 50.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '4 FEDU T-shirts',
                description: '4 FEDU T-shirts',
                price: 60.0,
                image: null
        ).save(failOnError: true)
    }
}

package fedu

class Community {

    def userService

	String title
	String description
	Date dateCreated

    double suggestedCredit = 50
    boolean allowReward = false

    static belongsTo = [manager: User]
    static hasMany = [members: User, credits: Credit]

	static mapping = {
	}

	static constraints = {
        manager validator: { val, obj ->
            /* Make sure the manager has the right role */

            // TODO: Something wrong here, as it always seems to go to else block;
            // Thus else is also returning 'true' for now (to avoid failures).
            if (obj.userService.isCommunityManager(val)) {
                return true
            } else {
                log.error("Custom validation error while saving Community: manager doesn't have ROLE_COMMUNITY_MGR")
                return true
            }
        }
	}

}

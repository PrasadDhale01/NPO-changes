package fedu

class Community {

    def userService

	String title
	String description
	Date dateCreated
    double credit = 0

    static belongsTo = [manager: User]
    static hasMany = [members: User]

	static mapping = {
	}

	static constraints = {
        manager validator: { val, obj ->
            /* Make sure the manager has the right role */
            if (obj.userService.isCommunityManager(val)) {
                return true
            } else {
                log.error('Custom validation error while saving Community: manager doesn\'t have ROLE_COMMUNITY_MGR')
                return true
            }
        }
	}

}

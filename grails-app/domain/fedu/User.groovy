package fedu

import org.apache.commons.validator.EmailValidator

class User {

    static hasMany = [projects: Project, contributions: Contribution, comments: ProjectComment, teams: Team]

	transient springSecurityService

	String username
	String password
    String firstName
    String lastName
    String email
    String userImageUrl

    String inviteCode
    String confirmCode
    String resetCode

    Date dateCreated
    Date lastUpdated

    boolean enabled = true
    boolean confirmed = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
        confirmCode nullable: true
        inviteCode nullable: true
        resetCode nullable: true
        firstName nullable: true
        lastName nullable: true
        email blank: false, email: true, nullable: true, unique: true
        userImageUrl nullable: true
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

    def beforeValidate() {
        if (!email) {
            EmailValidator emailValidator = EmailValidator.getInstance()
            if (emailValidator.isValid(username)) {
                email = username
            }
        }
    }

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
}

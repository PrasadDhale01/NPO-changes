package fedu

class User {

    static hasMany = [projects: Project]

	transient springSecurityService

    // We enforce username to be an email
	String username
	String password
    String firstName
    String lastName

    String confirmCode

	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true, email: true
		password blank: false
        confirmCode nullable: true
        firstName nullable: true
        lastName nullable: true
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

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
}

package crowdera

import grails.transaction.Transactional
import org.apache.commons.validator.EmailValidator
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import org.jets3t.service.security.AWSCredentials
import org.jets3t.service.model.*


class UserService {

    def imageFile
    def springSecurityService
    def roleService
    def mandrillService

    def getNumberOfUsers() {
        return User.count()
    }

    def findUserByEmail(String email) {
        return User.findByEmail(email)
    }
    
    def getUserRole(User users){
        def roletype
	def userrole = UserRole.findAllWhere(user: users)
	userrole.each {
	    roletype = it.role.authority
	}
        return roletype
    }

    def getCommunitiesUserIn() {
        return getCommunitiesUserIn(getCurrentUser())
    }

     def getRequesteUsers() {
        return User.findAllWhere(enabled:false,confirmed:false)
    }

    def getCommunitiesUserIn(User user) {
        def communities = Community.findAll {
            members {
                id == user.id
            }
        }
        return communities
    }
    
    def getCurrentFundRaiser(User user, Project project) {
        def currentFundraiser
        if (user) {
            currentFundraiser = user
        } else {
            currentFundraiser = project.user
        }
        return currentFundraiser
    }
    
    def getImageUrl(CommonsMultipartFile imageFile) {
        this.imageFile = imageFile
        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
            def awsSecretKey = "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"
            def bucketName = "crowdera"
            def folder = "user-images"

            def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
            def s3Service = new RestS3Service(awsCredentials);
            def s3Bucket = new S3Bucket(bucketName)

            def file = new File("${imageFile.getOriginalFilename()}")
            def key = "${folder}/${imageFile.getOriginalFilename()}"

            imageFile.transferTo(file)
            def object = new S3Object(file)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            file.delete()
            def imageUrl = "//s3.amazonaws.com/crowdera/${key}"

            return imageUrl
        }
    }
	
	def getVerifiedUserList(){
		return User.findAllWhere(enabled:true)
	}
	
	def getNonVerifiedUserList(){
		return User.findAllWhere(enabled:false)
	}

    def getEmail() {
        EmailValidator emailValidator = EmailValidator.getInstance()

        User user = getCurrentUser()
        if (user.email) {
            return user.email
        } else if (emailValidator.isValid(user.username)) {
            return user.username
        } else {
            return null
        }
    }

    def getFriendlyName() {
        return getFriendlyName(getCurrentUser())
    }

    def getFriendlyName(User user) {
        def friendlyName = user.firstName
        if (!friendlyName) {
            friendlyName = user.email
        }
        if (!friendlyName) {
            friendlyName = user.username
        }
        return friendlyName
    }

    def getFriendlyFullName(User user) {
        def friendlyFullName
        if (user.firstName && user.lastName) {
            friendlyFullName = user.firstName + ' ' + user.lastName
        } else {
            friendlyFullName = getFriendlyName(user)
        }
        return friendlyFullName
    }

    def getFriendlyFullName() {
        return getFriendlyFullName(getCurrentUser())
    }

    def isFacebookUser() {
        return isFacebookUser(getCurrentUser())
    }

    def isFacebookUser(User user) {
        if (FacebookUser.findByUser(user)) {
            return true;
        } else {
            return false;
        }
    }

    def isCommunityManager(User user) {
        if (UserRole.findByUserAndRole(user, roleService.communityManagerRole())) {
            return true
        } else {
            return false
        }
    }

    def isCommunityManager() {
        return isCommunityManager(getCurrentUser())
    }

    def isAdmin() {
        if (UserRole.findByUserAndRole(getCurrentUser(), roleService.adminRole())) {
            return true
        } else {
            return false
        }
    }
    
    def isAnonymous(User user) {
        if (UserRole.findByUserAndRole(user, roleService.anonymousRole())) {
            return true
        } else {
            return false
        }
    }


    def isAuthor() {
        if (UserRole.findByUserAndRole(getCurrentUser(), roleService.authorRole())) {
            return true
        } else {
            return false
        }
    }

    def getCurrentUser() {
        return springSecurityService.getCurrentUser()
    }

    def isLoggedIn() {
        return springSecurityService.isLoggedIn()
    }

    def getAllCommunityMgrs() {
        Set<User> communitymgrs = UserRole.findAllByRole(roleService.communityManagerRole()).collect {it.user} as Set
        return communitymgrs
    }
    
    def isTeamAlreadyExist(def project, def user) {
        def isFundRaiserExist = false
        def fundRaisers = project.teams
        if (user) {
            fundRaisers.each {
                if(user.id == it.user.id) {
                    isFundRaiserExist = true
                }
            }
            return isFundRaiserExist
        } else {
            return isFundRaiserExist
        }
    }
    
    def isValidatedTeamExist(def project, def user) {
        def isFundRaiserExist = false
        def fundRaisers = Team.findAllWhere(project: project, validated: true)
        if (user) {
            fundRaisers.each {
                if(user.id == it.user.id) {
                    isFundRaiserExist = true
                }
            }
            return isFundRaiserExist
        } else {
            return isFundRaiserExist
        }
    }
    
    def isTeamEnabled(def project, def user) {
        def isFundRaiserExist = false
        def fundRaisers = Team.findAllWhere(project: project, enable: true)
        if (user) {
            fundRaisers.each {
                if(user.id == it.user.id) {
                    isFundRaiserExist = true
                }
            }
            return isFundRaiserExist
        } else {
            return isFundRaiserExist
        }
    }

    def isCampaignBeneficiaryOrAdmin(def project, def user) {
        def projectAdmins = project.projectAdmins
        def isAdmin = false
        projectAdmins.each { projectAdmin ->
            if(user.email == projectAdmin.email) {
                isAdmin = true
            }
        }
        if (project.user == user) {
            isAdmin = true
        }
        return isAdmin
    }
    
    def isCampaignAdmin(Project project, def username){
        def projectAdmins = project.projectAdmins
        def isAdmin = false
        projectAdmins.each { projectAdmin ->
            if(username == projectAdmin.email) {
                isAdmin = true
            }
        }
        return isAdmin
    }

    def isCampaignAdminByUserID(Project project, User user){
        def projectAdmins = project.projectAdmins
        def username =user.email
        def isAdmin = false
        projectAdmins.each { projectAdmin ->
            if(username == projectAdmin.email) {
                isAdmin = true
            }
        }
        return isAdmin
    }
	
	def getTeamByUser(User user, Project project) {
		Team team = Team.findByUserAndProject(user, project)
		return team
	}
    
    def getCustomerServiceList() {
        def service = CustomerService.list();
        return service.reverse()
    }
    
    def sendResponseToCustomer(def params, CommonsMultipartFile attachedFile) {
        def service = CustomerService.get(params.id);
        def adminResponse = params.answer
        def attachmentUrl
        if (!attachedFile?.empty && attachedFile.size < 1024 * 1024 * 3) {
            def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
            def awsSecretKey = "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"
            def bucketName = "crowdera"
            def folder = "user-images"

            def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
            def s3Service = new RestS3Service(awsCredentials);
            def s3Bucket = new S3Bucket(bucketName)

            def file = new File("${attachedFile.getOriginalFilename()}")
            def key = "${folder}/${attachedFile.getOriginalFilename()}"

            attachedFile.transferTo(file)
            def object = new S3Object(file)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            file.delete()
            attachmentUrl = "//s3.amazonaws.com/crowdera/${key}"
        }
        
        service.status = true
        mandrillService.sendResponseToCustomer(adminResponse,service,attachmentUrl)
    }
    
    def contributionEmailToOwnerOrTeam(def fundRaiser, def project, def contribution) {
        def user = project.user
        
        if(user != fundRaiser) {
            mandrillService.contributionEmailToCampaignOwnerOrTeam(fundRaiser, project, contribution)
            mandrillService.contributionEmailToCampaignOwnerOrTeam(user, project, contribution)
        } else {
            mandrillService.contributionEmailToCampaignOwnerOrTeam(user, project, contribution)
        }
    }

    def getUserId(def userId){
        def avatarUser = User.get(userId)
        return avatarUser
    }
    
    def getUserById(def userId) {
        def user = User.get(userId)
        return user
    }

    def getUserByName(def userName){
        def user = User.findByUsername(userName)
        return user
    }
	
    def getUserByUsername(def username){
        return User.findByUsername(username)
    }

    def getUserByConfirmCode(String id){
        def confirmCode= User.findByConfirmCode(id)
        return confirmCode
    }
	
    def getBeneficiaryByParams(def projectParams){
        Beneficiary beneficiary = new Beneficiary(projectParams)
        return beneficiary
    }

    def getUserByInviteCode(String id){
        def inviteCode= User.findByInviteCode(id)
        return inviteCode
    }
    
    def getUserByResetCode(String id){
        def resetCode= User.findByResetCode(id)
        return resetCode
    }

    User getUserObject(def params){
        def user = new User(params)
        return user
    }

    def createUserRole(User users, RoleService roleService){
        UserRole.create(users, roleService.userRole())
    }
    
    def discardUserQuery(def params) {
        CustomerService service = CustomerService.get(params.id)
        if (service) {
            service.delete();
        }
    }
    
    def deleteNonVerifiedUser(User user) {
        if (user) {
            def userRoles = UserRole.findAllWhere(user: user);
            
            userRoles.each { userRole ->
                userRole.delete();
            }
            user.delete();
        }
    }

    def getUsersMails(){
        List nonVerifiedUsers = getNonVerifiedUserList()
        def status =false
        Date date = new Date()
        nonVerifiedUsers.each {
            def lastUpdatedbyusers = it.lastUpdated
            def diff = date - lastUpdatedbyusers
            if (diff > 3) {
                def user =User.findByLastUpdated(it.lastUpdated)
                mandrillService.reSendConfirmationMail(user)
                user.lastUpdated = date
                status =true
            }
        }
        if(status==true){
            return true
        }else{
            return false
        }
    }
	
    def getUserUpdatedDetails(def params, User user){
        def name = user.firstName
        if(params.firstName){
            user.firstName = params.firstName
        }
        if(params.lastName){
            user.lastName = params.lastName
        }
        /* Password change is optional */
        if (params.password) {
            user.password = params.password
        }

        if (name != params.firstName){
            getProjectVanityUsername(user)
        }
    }

    def getProjectVanityUsername(User user){
        def firstname = user.firstName.trim()
        def vanityname = firstname.replaceAll("[^a-zA-Z0-9]", "-")+user.id
        def vanity_username = VanityUsername.findAllWhere(vanityUsername:vanityname)
        if (!vanity_username) {
            new VanityUsername(
                user:user,
                username:user.username,
                vanityUsername:vanityname
            ).save(failOnError: true)
        }
    }

    def getVanityNameFromUsername(def username,def projectId){
        def status = false
        def user
        def project = Project.get(projectId)
        if (username)
            user = User.findByUsername(username)
        else
            user = User.findByUsername(project.user.username)
        def vanityName = user.firstName.trim()
		def vanityUsername = vanityName.replaceAll("[^a-zA-Z0-9]", "-")+user.id
        def vanity = VanityUsername.findAllWhere(user:user)
        vanity.each {
            if (vanityUsername == it.vanityUsername){
                status = true
            }
        }
        if (!status){
            getProjectVanityUsername(user)
        }
        return vanityUsername
    }

    def getUsernameFromVanityName(def username){
        def fundRaiser
        def vanityusername = VanityUsername.findByVanityUsername(username)
        if (vanityusername)
            fundRaiser = vanityusername.username
        return fundRaiser
    }
	
    def getUserFromVanityName(def username){
        def fundRaiser
        def user
        def vanityusername = VanityUsername.findByVanityUsername(username)
        if (vanityusername){
            fundRaiser = vanityusername.username
            user = User.findByUsername(fundRaiser)
        }
        return user
    }

    @Transactional
    def bootstrap() {
        def admin = User.findByUsername('admin@fedu.org')
        if (!admin) {
            admin = new User(username: 'admin@fedu.org', password: 'P@$$w0rd',firstName: 'adminFirstName', lastName:'adminLastName').save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(admin, roleService.adminRole())

        def user = User.findByUsername('user@example.com')
        if (!user) {
            user = new User(username: 'user@example.com', password: 'password',firstName: 'userFirstName', lastName:'userLastName', email: 'user@example.com').save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(user, roleService.userRole())
        
        def anonymous = User.findByUsername('anonymous@example.com')
        if (!anonymous) {
            anonymous = new User(username: 'anonymous@example.com', password: 'password',firstName: 'Anonymous Good Soul', lastName:'anonymousLastName', email: 'anonymous@example.com').save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(anonymous, roleService.anonymousRole())

        def author = User.findByUsername('author@fedu.org')
        if (!author) {
            author = new User(username: 'author@fedu.org', password: 'P@$$w0rd').save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(author, roleService.authorRole())
    }

    @Transactional
    def bootstrapDeepshikha() {
        def deepshikha = User.findByUsername('info@deepshikha.org')
        if (!deepshikha) {
            deepshikha = new User(username: 'info@deepshikha.org', password: 'password').save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(deepshikha, roleService.userRole())
        return deepshikha
    }
}

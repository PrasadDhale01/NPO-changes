package fedu

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

    def getNumberOfUsers() {
        return User.count()
    }

    def findUserByEmail(String email) {
        return User.findByEmail(email)
    }
    
    def getUserRole(User users){
        def userRole = UserRole.list()
        def roletype
        userRole.each {
            if(it.user.id == users.id){
                def userrole = UserRole.findByUser(users)
                roletype = userrole.role.authority
            }
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

    def getImageUrl(CommonsMultipartFile imageFile) {
        this.imageFile = imageFile
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
        def imageUrl = "https://s3.amazonaws.com/crowdera/${key}"

        return imageUrl
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
	
	def getTeamByUser(User user, Project project) {
		Team team = Team.findByUserAndProject(user, project)
		return team
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
            anonymous = new User(username: 'anonymous@example.com', password: 'password',firstName: 'anonymousFirstName', lastName:'anonymousLastName', email: 'anonymous@example.com').save(failOnError: true)
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

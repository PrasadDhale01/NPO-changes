package crowdera

import grails.transaction.Transactional
import org.apache.commons.validator.EmailValidator
import org.apache.http.HttpEntity
import org.apache.http.HttpResponse
import org.apache.http.NameValuePair
import org.apache.http.client.HttpClient
import org.apache.http.client.entity.UrlEncodedFormEntity
import org.apache.http.client.methods.HttpPost
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.message.BasicNameValuePair
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import org.jets3t.service.security.AWSCredentials
import org.jets3t.service.model.*
import java.security.NoSuchAlgorithmException;
import java.security.InvalidKeyException;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;


class UserService {

    def imageFile
    def springSecurityService
    def roleService
    def mandrillService
    def grailsApplication
	def contributionService

    def getNumberOfUsers() {
        return User.count()
    }

    def findUserByEmail(String email) {
        return User.findByEmail(email)
    }
    
    def getUserRole(User users) {
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
        def service = CustomerService.get(params.long('id'));
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
		
    def getNonRespondList() {
	return CrewReg.findAllWhere(status: false)
    }
	
    def getRespondedList() {
	return CrewReg.findAllWhere(status: true)
    }
		
    def sendResponseToCrews(def params, CommonsMultipartFile attachedFile) {
	def crewsResponse = CrewReg.get(params.long('id'));
	def adminResponse = params.adminReply
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
		crewsResponse.docByAdmin = attachmentUrl
	}
	
	crewsResponse.status = true
	mandrillService.sendResponseToCrews(adminResponse,crewsResponse,attachmentUrl)
    }
	
    def discardMessage(def params) {
	CrewReg crewsRequest = CrewReg.get(params.long('id'))
	if (crewsRequest) {
		crewsRequest.delete();
	}
    }
	
    def getCrewRegById(def crewId) {
	def crew = CrewReg.get(crewId)
	return crew
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
        if (userId) {
            def avatarUser = User.get(userId)
            return avatarUser
        }
    }
    
    def getUserById(def userId) {
        if(userId) {
            def user = User.get(userId)
            return user
        }
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
        CustomerService service = CustomerService.get(params.long('id'))
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
        def firstname
        def vanityname
        def vanity_username
        if (user.firstName) {
            firstname = user.firstName.trim()
            if (firstname) {
                vanityname = firstname.replaceAll("[^a-zA-Z0-9]", "-")+"-"+user.id
            }
            vanity_username = VanityUsername.findAllWhere(vanityUsername:vanityname)
            if (!vanity_username) {
                new VanityUsername(
                    user:user,
                    username:user.username,
                    vanityUsername:vanityname
                ).save(failOnError: true)
            }
        }
    }

    def getVanityNameFromUsername(def username,def projectId){
        def status = false
        def user
        def vanityName
        def vanityUsername
        def project = Project.get(projectId)
        if (username) {
            user = User.findByUsername(username)
        } else {
            if (project) {
                user = User.findByUsername(project.user.username)
            }
        }
        if (user) {
            vanityName = user.firstName.trim()
            if (vanityName) {
                vanityUsername = vanityName.replaceAll("[^a-zA-Z0-9]", "-")+"-"+user.id
            }
            def vanity = VanityUsername.findAllWhere(user:user)
            vanity.each {
                if (vanityUsername == it.vanityUsername){
                    status = true
                }
            }
        }
        if (!status){
            getProjectVanityUsername(user)
        }
        return vanityUsername
    }

    def getUsernameFromVanityName(def username){
        def userName
        def vanityusername = VanityUsername.findByVanityUsername(username)
        if (vanityusername)
            userName = vanityusername.username
        return userName
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
    
    /* Help Desk Integration*/
    
    def getFreshDeskUrl() throws NoSuchAlgorithmException, InvalidKeyException {
        def hash
        def url
        def name = grailsApplication.config.crowdera.freshDesk.LOGIN_NAME;
        def BASE_URL = grailsApplication.config.crowdera.freshDesk.BASE_URL;
        def email = grailsApplication.config.crowdera.freshDesk.LOGIN_EMAIL;
        
        TimeZone.setDefault(TimeZone.getTimeZone('UTC'))
        Date currentDate = new Date()
        long timeInSeconds = currentDate.getTime()/1000;
        try {
            hash = getHMACHash(name,email,timeInSeconds);
            url = BASE_URL + "?name="+name+"&email="+email+"&timestamp="+timeInSeconds+"&hash=" + hash;
 
        }catch (Exception e) {
            url = null
        }
        return url
    }
    
    def hashToHexString(byte[] byteData) {
        def hexString = new StringBuffer();
        for (int i = 0; i < byteData.length; i++) {
            def hex = Integer.toHexString(0xff & byteData[i]);
            // NB! E.g.: Integer.toHexString(0x0C) will return "C", not "0C"
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }

    def String getHMACHash(String name,String email,long timeInMillis) throws Exception {
        def sharedSecret = grailsApplication.config.crowdera.freshDesk.sharedSecret;
        byte[] keyBytes = sharedSecret.getBytes();
        def movingFact =name+email+timeInMillis;
        byte[] text = movingFact.getBytes();

        def hexString = "";
        Mac hmacMD5;
        try {
            hmacMD5 = Mac.getInstance("HmacMD5");
            SecretKeySpec macKey = new SecretKeySpec(keyBytes, "RAW");
            hmacMD5.init(macKey);
            byte[] hash =  hmacMD5.doFinal(text);
            hexString = hashToHexString(hash);
        } catch (Exception nsae) {
			nsae.printStackTrace()
		}
        
        return hexString;
    }
    
    /* End of Help Desk Integration*/
	
	def sendUserSubscription(def subscribeUrl,def userID, def listID, def email){
		HttpClient httpclient = new DefaultHttpClient()
		HttpPost httppost = new HttpPost(subscribeUrl)
		List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(2)
		nameValuePairs.add(new BasicNameValuePair("u",userID))
		nameValuePairs.add(new BasicNameValuePair("id", listID))
		nameValuePairs.add(new BasicNameValuePair("EMAIL", email))
		httppost.setEntity(new UrlEncodedFormEntity(nameValuePairs));
		HttpResponse httpres = httpclient.execute(httppost)
		int status = httpres.getStatusLine().getStatusCode()

		if (status == 200){
			HttpEntity entity = httpres.getEntity()
			if (entity != null){
				return true
			}
		}else{
			return false
		}
	}
    
    def getCurrentUserImage(String firstName) {
        def userImage
	def alphabet
        if (firstName) {
            def valueAtIndex
            if (firstName) 
                valueAtIndex = firstName.getAt(0).toLowerCase()
            switch (valueAtIndex) {
                case 'a':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-A.png";
                    alphabet = "alphabet-A";
                    break;
                case 'b':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-B.png";
                    alphabet = "alphabet-B";
                    break;
                case 'c':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-C.png";
                    alphabet = "alphabet-C";
                    break;
                case 'd':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-D.png";
		            alphabet = "alphabet-D";
                    break;
                case 'e':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-E.png";
                    alphabet = "alphabet-E";
                    break;
                case 'f':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-F.png";
                    alphabet = "alphabet-F";
                    break;
                case 'g':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-G.png";
                    alphabet = "alphabet-G";
                    break;
                case 'h':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-H.png";
                    alphabet = "alphabet-H";
                    break;
                case 'i':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-I.png";
                    alphabet = "alphabet-I";
                    break;
                case 'j':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-J.png";
                    alphabet = "alphabet-J";
                    break;
                case 'k':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-K.png";
                    alphabet = "alphabet-K";
                    break;
                case 'l':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-L.png";
                    alphabet = "alphabet-L";
                    break;
                case 'm':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-M.png";
                    alphabet = "alphabet-M";
                    break;
                case 'n':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-N.png";
                    alphabet = "alphabet-N";
                    break;
                case 'o':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-O.png";
                    alphabet = "alphabet-O";
                    break;
                case 'p':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-P.png";
                    alphabet = "alphabet-P";
                    break;
                case 'q':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-Q.png";
                    alphabet = "alphabet-Q";
                    break;
                case 'r':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-R.png";
                    alphabet = "alphabet-R";
                    break;
                case 's':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-S.png";
                    alphabet = "alphabet-S";
                    break;
                case 't':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-T.png";
                    alphabet = "alphabet-T";
                    break;
                case 'u':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-U.png";
                    alphabet = "alphabet-U";
                    break;
                case 'v':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-V.png";
                    alphabet = "alphabet-V";
                    break;
                case 'w':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-W.png";
                    alphabet = "alphabet-W";
                    break;
                case 'x':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-X.png";
                    alphabet = "alphabet-X";
                    break;
                case 'y':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-Y.png";
                    alphabet = "alphabet-Y";
                    break;
                case 'z':
                    userImage = "//s3.amazonaws.com/crowdera/assets/alphabet-Z.png";
                    alphabet = "alphabet-Z";
                    break;
                default :
                    userImage = "//s3.amazonaws.com/crowdera/assets/default-user-icon.png";
                    alphabet = "default-user-icon.png";
            }
        }
        return [userImage: userImage, alphabet: alphabet]
    }
    
    def getCampaignSupporter(Project project) {
        User user = getCurrentUser()
        def supporters = Supporter.findByUserAndProject(user, project)
        def message
        if (supporters) {
            message = "You are already following this campaign."
        } else {
            Supporter supporter = new Supporter(
                user: user
            )
            project.addToSupporters(supporter).save(failOnError: true)
            
            message = "You have followed "+project.title+". You will receive email updates for this campaign at "+user.email+"."
        }
        return message
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
            anonymous = new User(username: 'anonymous@example.com', password: 'password',firstName: 'Anonymous Good Soul', lastName:'Good Soul', email: 'anonymous@example.com').save(failOnError: true)
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

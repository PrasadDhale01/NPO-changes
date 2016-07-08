package crowdera

import grails.transaction.Transactional

import java.security.InvalidKeyException
import java.security.NoSuchAlgorithmException
import java.text.SimpleDateFormat

import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec

import org.apache.commons.validator.EmailValidator
import org.apache.http.HttpEntity
import org.apache.http.HttpResponse
import org.apache.http.NameValuePair
import org.apache.http.client.HttpClient
import org.apache.http.client.entity.UrlEncodedFormEntity
import org.apache.http.client.methods.HttpPost
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.message.BasicNameValuePair
import org.codehaus.groovy.grails.plugins.jasper.JasperReportDef
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import org.jets3t.service.model.*
import org.jets3t.service.security.AWSCredentials
import org.springframework.web.multipart.commons.CommonsMultipartFile
import java.text.DecimalFormat;

import org.codehaus.groovy.grails.plugins.jasper.JasperExportFormat

class UserService {

    def imageFile
    def springSecurityService
    def roleService
    def mandrillService
    def grailsApplication
	def contributionService
    def projectService
    def grailsLinkGenerator

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
            
            
            int index = imageFile.getOriginalFilename().lastIndexOf(".")
            String extName = imageFile.getOriginalFilename().substring(index);

            def fileName = UUID.randomUUID().toString() + extName
            
            def file = new File("${fileName}")
            def key = "${folder}/${fileName}"
            key = key.toLowerCase()

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
    
    def isGooglePlusUser() {
        return isGooglePlusUser(getCurrentUser())
    }

    def isGooglePlusUser(User user) {
        if (GooglePlusUser.findByUser(user)) {
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
    
    def getBankInfoList() {
        return BankInfo.list()
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
        def projectAdmins = project?.projectAdmins
        def isAdmin = false
        projectAdmins.each { projectAdmin ->
            if(user?.email == projectAdmin?.email) {
                isAdmin = true
            }
        }
        if (project?.user == user) {
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
            
            int index = attachedFile.getOriginalFilename().lastIndexOf(".")
            String extName = attachedFile.getOriginalFilename().substring(index);

            def fileName =  UUID.randomUUID().toString() + extName
            
            def file = new File("${fileName}")
            def key = "${folder}/${fileName}"
            key = key.toLowerCase()
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
		
    def sendResponseToCrews(def params, CommonsMultipartFile attachedFile, def base_url) {
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
            
            int index = attachedFile.getOriginalFilename().lastIndexOf(".")
            String extName = attachedFile.getOriginalFilename().substring(index);

            def fileName =  UUID.randomUUID().toString() + extName
            
            def file = new File("${fileName}")
            def key = "${folder}/${fileName}"
            key = key.toLowerCase()
            attachedFile.transferTo(file)
            def object = new S3Object(file)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            file.delete()
            attachmentUrl = "//s3.amazonaws.com/crowdera/${key}"
            crewsResponse.docByAdmin = attachmentUrl
       }
       crewsResponse.status = true
       mandrillService.sendResponseToCrews(adminResponse,crewsResponse,attachmentUrl, base_url)
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
    
    def getUserByEmail(String email) {
        return User.findByEmail(email)
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
        if (user?.firstName) {
            firstname = user?.firstName.trim()
            if (firstname) {
                vanityname = firstname.replaceAll("[^a-zA-Z0-9]", "-")+"-"+user?.id
            }
            vanity_username = VanityUsername.findAllWhere(vanityUsername:vanityname)
            if (!vanity_username) {
                new VanityUsername(
                    user:user,
                    username:user?.username,
                    vanityUsername:vanityname
                ).save(failOnError: true)
            }
        }
        
        return vanityname
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
                user = User.findByUsername(project?.user?.username)
            }
        }
        if (user) {
            vanityName = user?.firstName.trim()
            if (vanityName) {
                vanityUsername = vanityName.replaceAll("[^a-zA-Z0-9]", "-")+"-"+user?.id
            }
            def vanity = VanityUsername.findAllWhere(user:user)
            vanity.each {
                if (vanityUsername == it?.vanityUsername){
                    status = true
                }
            }
        }
        if (!status){
            if (user) {
                vanityUsername = getProjectVanityUsername(user)
            }
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
			log.error("Error : " + nsae)
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
    
    def setBankInfoDetails(def params, Project project) {
        BankInfo bankInfo = BankInfo.findByProject(project)
        if (bankInfo) {
            boolean isbankInfoChanged = false
            if (params.fullName != null && bankInfo.fullName != params.fullName) {
                bankInfo.fullName= params.fullName
                isbankInfoChanged = true
            }
            if (params.branch != null && bankInfo.branch != params.branch) {
                bankInfo.branch = params.branch
                isbankInfoChanged = true
            }
            if (params.ifscCode != null && bankInfo.ifscCode != params.ifscCode) {
                bankInfo.ifscCode = params.ifscCode
                isbankInfoChanged = true
            }
            if (params.accountType != null && bankInfo.accountType !=  params.accountType) {
                bankInfo.accountType=  params.accountType
                isbankInfoChanged = true
            }
            if (params.accountNumber != null && bankInfo.accountNumber != params.accountNumber) {
                bankInfo.accountNumber= params.accountNumber
                isbankInfoChanged = true
            }
            if (params.email != null && bankInfo.email != params.email) {
                bankInfo.email= params.email
                isbankInfoChanged = true
            }
            if (params.mobile != null && bankInfo.mobile != params.mobile) {
                bankInfo.mobile= params.mobile
                isbankInfoChanged = true
            }
            if (params.address1 != null && bankInfo.address1 != params.address1) {
                bankInfo.address1= params.address1
                isbankInfoChanged = true
            }
            if (bankInfo.address2 != params.address2) {
                bankInfo.address2= params.address2
                isbankInfoChanged = true
            }
            if (params.city != null && bankInfo.city != params.city) {
                bankInfo.city= params.city
                isbankInfoChanged = true
            }
            if (params.zip != null && bankInfo.zip != params.zip) {
                bankInfo.zip = params.zip
                isbankInfoChanged = true
            }
            if (params.state != null && bankInfo.state != params.state) {
                bankInfo.state= params.state
                isbankInfoChanged = true
            }
            if (params.country != null && bankInfo.country != params.country) {
                bankInfo.country= params.country
                isbankInfoChanged = true
            }
            if (params.payoutmode != null && bankInfo.payoutmode != params.payoutmode) {
                bankInfo.payoutmode= params.payoutmode
                isbankInfoChanged = true
            }
            if (isbankInfoChanged) {
                bankInfo.save()
            }
        } else {
            bankInfo = new BankInfo(params)
            bankInfo.project = project
            bankInfo.save(failOnError: true)
        }
    }
    
    def getNumberOfCampaignsForUser(User user) {
        List projects = Project.findAllWhere(user: user)
        return projects.size()
    }
    
    def getNumberOfCampaignsContributedTo(User user) {
        List contributions = Contribution.findAllWhere(user: user)
        return contributions.size()
    }
    
    def getAvgMinMaxContributionForUser(User user) {
        List contributions = Contribution.findAllWhere(user: user)
        int minAmount = 0
        int maxAmount = 0
        int totalAmount = 0
        int avgAmount = 0
        contributions.each {contribution->
            if (maxAmount == 0) {
                minAmount = contribution.amount
                maxAmount = contribution.amount
            } else {
                if (contribution.amount > minAmount) {
                    if (contribution.amount > maxAmount) {
                        maxAmount = contribution.amount
                    }
                } else {
                    minAmount = contribution.amount
                }
            }
            totalAmount = totalAmount + contribution.amount
        }
        if (contributions.size() > 0) {
            avgAmount = totalAmount/contributions.size()
        }
        return [minAmount: minAmount, maxAmount: maxAmount, avgAmount: avgAmount]
    }
    
    def getCategorySupportedTo(User user) {
        def category
        List contributions = Contribution.findAllWhere(user: user)
        contributions.each {contribution->
            Project project = contribution.project
            if (category) {
                if (!category.contains(project.category.toString())) {
                    category = category+', '+project.category.toString()
                }
            } else {
                category = project.category.toString()
            }
        }
        return category
    }
    
    def getUsersList(def params) {
        List totalUsers = []
        List users = []
        def max = Math.min(params.int('max') ?: 12, 100)
        def offset = params.int('offset') ?: 0
        totalUsers = getVerifiedUserList()
        def count = totalUsers.size()
        def maxrange
        if(offset+max <= count) {
            maxrange = offset + max
        } else {
            maxrange = offset + (count - offset)
        }
        
        users = totalUsers.subList(offset, maxrange)
        return [totalUsers: totalUsers, users: users]
    }
    
    def updateUserProfile(def params, User user) {
        boolean isChangesDone = false
        if (params.city && params.city != user.city) {
            user.city = params.city
            isChangesDone = true
        }
        if (params.state && params.state != user.state) {
            user.state = params.state
            isChangesDone = true
        }
        if (params.country && params.country != user.country) {
            user.country = params.country
            isChangesDone = true
        }

        if (isChangesDone) {
            user.save()
        }
    }

    def setUserInfo(def params, User user){
        def name = user.firstName
        if(params.firstName && user.firstName != params.firstName){
            user.firstName = params.firstName
        }
        if(params.lastName && user.lastName != params.lastName){
            user.lastName = params.lastName
        }
        /* Password change is optional */
        if (params.password) {
            user.password = params.password
        }

        if (params.firstName && name != params.firstName){
            getProjectVanityUsername(user)
        }

        if (params.biography && user.biography != params.biography){
            user.biography = params.biography
        }
        if(params.state == 'other'){
            if (user.state != params.otherstate) {
                user.state = params.otherstate
            }
        } else {
            if (user.state != params.state) {
                user.state = params.state
            }
        }
        if(params.country && user.country != params.country){
            user.country = params.country
        }
        if(params.city && user.city != params.city){
            user.city = params.city
        }
        user.save()
    }
    
    def getCurrencyById() {
        return Currency.get(1)
    }
	def getFeedbackByUser(User user){
	    def feedback = Feedback.findAllWhere(user:user)
	    def feedbackId
	    feedback.each{
		    if(feedback){
			    feedbackId =it
		    }
	    }
	    return feedbackId
	}
	
	def setFeedbackByUser(def feedback, def params, User user){
		feedback.answer_1= params.answer_1
		feedback.answer_2_y1 = params.answer_2_y1
		feedback.answer_2_y2 = params.answer_2_y2
		feedback.answer_2_n = params.answer_2_n
		feedback.answer_3 = params.answer_3
		feedback.answer_4_y = params.answer_4_y
		feedback.answer_4_n =  params.answer_4_n
		feedback.answer_5 = params.answer_5
		feedback.answer_6 = params.answer_6
		feedback.answer_7 = params.answer_7
		feedback.answer_8 = params.answer_8
		feedback.answer_9_y1 = params.answer_9_y1
		feedback.answer_9_y2 = params.answer_9_y2
		feedback.answer_9_y3 = params.answer_9_y3
		feedback.answer_9_y4 = params.answer_9_y4
		feedback. answer_9_y5 = params.answer_9_y5
		feedback.answer_9_y6 = params.anwer_9_y6
		feedback.answer_9_n= params.answer_9_n
		feedback.user = user
		feedback.rating = params. rating
	}
	def getSupportersByUser(User user){
          def supporters = Supporter.findAllWhere(user:user)
          int i=0
          supporters.each{
              if(it==null){
	              i=0
              }else{
	              i++
              }
         }
         return i
	}
	
	def getUserContribution(User user){
            def userContribution = Contribution.findAllByUser(user)
            int contribution =0  
            userContribution.each{
                contribution += it.amount
            }
            return contribution
	}
	
	def getUserCommnet(User user){
            List comments =[]
            def projectComments =ProjectComment.findAllWhere(user:user)
            def teamComments = TeamComment.findAllWhere(user:user)
            comments.add(projectComments)
            comments.add(teamComments)
            return comments
	}
	
	def getSupporterListActivity(def project, User user, def teams){
          SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d YYYY, hh:mm a")
          def supporterList =[:]
          def supporters = Supporter.findAllWhere(user:user)

          teams.each{
              if(user.username.equals(it.user.username) && !user.username.equals(it.project.user.username) ){
                   supporterList.put("team"+it.id, it.project.title +";"+ dateFormat.format(it.joiningDate))
              }
          }
          project.each {
              if(user.username.equals(it.user.username)){
                  supporterList.put("project"+it.id,it.title +";"+ dateFormat.format(it.created))
              }
              if(isCampaignAdmin(it, user.email)){
                  supporterList.put("co-owner"+it.id,it.title +";"+ dateFormat.format(it.created))
              }
          }

         if(supporters){
             supporters.each{
                 if(it.followedDate!=null)
                     supporterList.put("supporter"+it.id, it.project.title +";"+ dateFormat.format(it.followedDate))
             }
         }
         //sort
         return supporterList.sort { a, b -> b.value.toString().substring(b.value.toString().indexOf(';') + 1) <=> a.value.toString().substring(a.value.toString().indexOf(';') + 1) }
	}
	
	def getUserRecentActivity(def project, def contributions ,def comments, User user, def teams){
          SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d YYYY, hh:mm a")
          def recentActivity =[:]
          def supporters = Supporter.findAllWhere(user:user)

          teams.each{
              if(user.username.equals(it.user.username) && !user.username.equals(it.project.user.username) ){
                  recentActivity.put("team"+it.id, it.project.title +";"+ dateFormat.format(it.joiningDate))
              }
         }
         project.each {
             if(user.username.equals(it.user.username)){
                  recentActivity.put("project"+it.id,it.title +";"+ dateFormat.format(it.created))
             }
         }

         project.each{
             def projectUser =  it.user
             it.rewards.each{perks ->
                 perks.each{perk ->
                     if(!perk.title.equals('No Perk') && perk.perkCreatedDate!=null){
                          if(projectUser.username.equals(user.username)){
                               recentActivity.put("perk"+perk.id, perk.title +";" + dateFormat.format(perk.perkCreatedDate))
                          }
                     }
                 }
             }
         }

         project.projectUpdates.each {
              it.each{
                  if(it.updateDate!=null)
                      recentActivity.put("update"+it.id, it.title +";"+ dateFormat.format(it.updateDate))
              }
        }
        contributions.each{
            if(!it.isAnonymous && !it.isContributionOffline)
                recentActivity.put("contribution"+it.id, it.amount.round() +";"+ dateFormat.format(it.date))
        }
        def i =  comments.size()
        comments.each{
            it.each{
                recentActivity.put("comment"+ --i, it.comment +";"+ dateFormat.format(it.date))
           }
        }
        if(supporters){
            supporters.each{
                if(it.followedDate!=null)
                    recentActivity.put("supporter"+it.id, it.project.title +";"+ dateFormat.format(it.followedDate))
            }
        }
        //sort
        return recentActivity.sort { a, b -> b.value.toString().substring(b.value.toString().indexOf(';') + 1) <=> a.value.toString().substring(a.value.toString().indexOf(';') + 1) }
   }
    
    def setUserObject(def params) {
        def password = projectService.getAlphaNumbericRandomUrl()
        
        User user = new User(params)
        user.confirmCode = UUID.randomUUID().toString()
        user.enabled = true
        user.confirmed = true
        user.password = password
        user.username = params.email
        if (user.save(failOnError:true)) {
            createUserRole(user, roleService)
        }
        
        return [password : password, user : user]
    }
    
    def getPartnerByConfirmCode(def id) {
        return Partner.findByConfirmCode(id);
    }
    
    def createPartnerRole(User user, RoleService roleService){
        UserRole.create(user, roleService.partnerRole())
    }
    
    def getPartners() {
        return Partner.findAllWhere(discarded: false, rejected: false, validated: true)
    }
    
    def getNonVerifiedPartners() {
        return Partner.findAllWhere(discarded: false, rejected: false, validated: false, draft: false)
    }
    
    def getPendingPartners() {
        return Partner.findAllWhere(discarded: false, rejected: false, enabled: false)
    }
    
    def getDraftPartners() {
        return Partner.findAllWhere(discarded: false, rejected: false, draft: true, enabled: true)
    }
    
    def isPartner() {
        if (UserRole.findByUserAndRole(getCurrentUser(), roleService.partnerRole())) {
            return true
        } else {
            return false
        }
    }
    
    def isPartner(User user) {
        if (UserRole.findByUserAndRole(user, roleService.partnerRole())) {
            return true
        } else {
            return false
        }
    }
    
    def isPartnerValidated(User user) {
        Partner partner = Partner.findByUser(user);
        if(partner) {
            return partner.validated
        } else {
            return false
        }
    }
    
    def getPartnerByUser(User user) {
        return Partner.findByUser(user)
    }
    
    def getPartnerById(def id) {
        return Partner.get(id)
    }
    
    def inviteCampaignOwner(def params) {
        User user = getCurrentUser()
        Partner partner = getPartnerByUser(user)
        if (partner) {
            def emails = params.emails
            def emailList = emails.split(',')
            emailList = emailList.collect { it.trim() }
            
            emailList.each { email ->
                PartnerInvite invite = PartnerInvite.findByEmail(email)
                if (invite) {
                    mandrillService.sendInvitationToCampaignOwner(email, user, partner.confirmCode, params.message)
                } else {
                    invite = new PartnerInvite()
                    invite.email = email
                    invite.partner = partner
                    if (invite.save()) {
                        mandrillService.sendInvitationToCampaignOwner(email, user, partner.confirmCode, params.message)
                    }
                }
                
            }
        }
        
    }
    
    def getTotalNumberOfInvites(partner) {
        List invites = PartnerInvite.findAllWhere(partner: partner)
        return invites.size()
    }
    
    def getGoogleDriveFiles(User user, def fileId, def title, def url) {
        boolean isSelected = false;
        def driveFile = GoogleDrive.findByFileId(fileId, user)
        if (driveFile) {
            if (driveFile.title != title) {
                driveFile.title = title
                driveFile.save();
            }
            isSelected = true;
        } else {
            new GoogleDrive (
                alternateLink: url,
                fileId: fileId,
                title : title,
                user: user ).save(failOnError: true)
        }
        return isSelected
    }
    
    def getDriveFiles(User user, def params) {
        List totalFiles = GoogleDrive.findAllWhere(user : user)
        List files = []
        def max = Math.min(params.int('max') ?: 8, 100)
        def offset = params.int('offset') ?: 0
        def count = totalFiles.size()
        def maxrange
        if(offset+max <= count) {
            maxrange = offset + max
        } else {
            maxrange = offset + (count - offset)
        }
        files = totalFiles.subList(offset, maxrange)
        return [totalFiles: totalFiles, files: files]
    }
    
    def deleteDriveFile(def params) {
        GoogleDrive file = GoogleDrive.get(params.id)
        if (file) {
            file.delete(flush: true)
        }
    }
    
    def setNewFolder(User user, def params) {
        new Folder (
            fName: params.title,
            user: user).save(failOnError: true)
    }
    
    def getFolderById(def folderId) {
        return Folder.get(folderId)
    }
    
    def uploadDocument(CommonsMultipartFile document, def params, Partner partner, def folder) {
        if (!document?.empty && document.size < 1024 * 1024 * 3) {
            def docUrl = getDocumentUrl(document)
            def docName = document.getOriginalFilename()
            Document doc = new Document()
            doc.docName = docName
            doc.docUrl = docUrl
            def documentCount = 0
            if (params.folderId) {
                def docs = folder.documents
                docs.each {
                    documentCount = (it.docName.equalsIgnoreCase(docName)) ? documentCount + 1 : documentCount ;
                }
                doc.numberOfDocs = documentCount
            } else {
                def docs = partner.documents
                docs.each {
                    documentCount = (it.docName.equalsIgnoreCase(docName)) ? documentCount + 1 : documentCount ;
                }
                doc.numberOfDocs = documentCount
            }
            if (doc.save()) {
                if (params.folderId) {
                    folder.addToDocuments(doc)
                    folder.save(failOnError: true)
                } else {
                    partner.addToDocuments(doc)
                    partner.save(failOnError: true)
                }
            }
        }
    }
    
    def getFolderDocuments(Folder folder) {
        return folder.documents
    }
    
    def getPartnerDocuments(Partner partner) {
        return partner.documents
    }
    
    def getFolders(User user) {
        return Folder.findAllWhere(user: user)
    }
    
    def getDocumentUrl(CommonsMultipartFile document) {
        if (!document?.empty && document.size >0) {
            def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
            def awsSecretKey = "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"
            def bucketName = "crowdera"
            def folder = "documents"

            def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
            def s3Service = new RestS3Service(awsCredentials);
            def s3Bucket = new S3Bucket(bucketName)
            
            int index = document.getOriginalFilename().lastIndexOf(".")
            String extName = document.getOriginalFilename().substring(index);

            def fileName =  UUID.randomUUID().toString() + extName

            def file = new File("${fileName}")
            def key = "${folder}/${fileName}"
            key = key.toLowerCase()

            document.transferTo(file)
            def object = new S3Object(file)
            object.key = key
            def contenType = document.contentType
            object.setContentType(contenType);
            s3Service.putObject(s3Bucket, object)
            file.delete()
            def docUrl = "//s3.amazonaws.com/crowdera/${key}"

            return docUrl
        }
    }
    
    def sendReceipt(def params, CommonsMultipartFile document) {
        def docUrl = getDocumentUrl(document)
        mandrillService.sendReceipt(params, docUrl)
    }
    
    def deleteFolderFile(Folder folder, def params) {
        Document document = Document.get(params.id)
        if (document) {
            folder.removeFromDocuments(document)
            folder.save()
            document.delete(flush:true)
        }
    }
    
    def deleteDocFile(Partner partner, def params) {
        Document document = Document.get(params.id)
        if (document) {
            partner.removeFromDocuments(document)
            partner.save()
            document.delete(flush:true)
        }
    }
    
    def trashFolders(def params) {
        Folder folder = Folder.get(params.int('folderId'))
        if (folder) {
            List documents = folder.documents
        
            List tempDocuments = documents
        
            if (!documents.isEmpty()) {
                documents.removeAll(documents)
                tempDocuments.each {
                    it.delete(flush:true);
                }
            }
            folder.delete(flush:true)
        }
    }
    
    def deletePartner(def params, Partner partner) {
        User user = User.get(params.int('userId'))
        UserRole userRole = UserRole.findByUserAndRole(user, roleService.partnerRole())
        boolean isDeleted = false
        if (userRole) {
            userRole.delete(flush: true)
            partner.discarded = true
            partner.save()
            isDeleted = true
            mandrillService.sendEmailToPartner(partner.user)
        }
        return isDeleted
    }

    def isUserProjectHavingContribution(User user, def environment){
        Boolean doProjectHaveAnyContribution = false
        if (environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia'){
            List projects = Project.findAllWhere(user:user, validated:true, rejected:false, inactive:false, payuStatus:true, offeringTaxReciept:true)
            projects.each{
                if (it.contributions){
                    doProjectHaveAnyContribution = true
                }
            }
        } else {
            List projects = Project.findAllWhere(user:user, validated:true, rejected:false, inactive:false, payuStatus:false, offeringTaxReciept:true)
            projects.each{
                if (it.contributions){
                    doProjectHaveAnyContribution = true
                }
            }
        }
        return doProjectHaveAnyContribution
    }

    def userHasContributedToNonProfitOrNgo(User user){
        Boolean result = false
        def contributions = Contribution.findAllWhere(user:user)
        if (contributions){
            contributions.each{
                if (it.receiptSent){
                    result = true;
                }
            }
        }
        return result
    }

    def getContributionsForWhichTaxReceiptreceived(User user, def params){
        def contributions = Contribution.findAllWhere(user:user)
        List contributionList = []
        def contributionsOffset
        if (contributions){
            contributions.each{
                if (it.receiptSent){
                    contributionList.add(it);
                }
            }
        }
        
        if (contributionList && !contributionList.empty){
            def offset = params.offset ? params.int('offset') : 0
            def max = 10
            def count = contributionList.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            contributionsOffset = contributionList.reverse().subList(offset, maxrange)
        }
        
        return [totalTaxReceiptContributions:contributionList, taxReceiptList:contributionsOffset]

    }

    def getSortedContributorsForProject(def params, Project project){
        List contributions = []
        def contributionsOffset
        switch (params.sort){
            case 'Anonymous':
            contributions = Contribution.findAllWhere(project:project, isAnonymous:true)
            break;

            case 'Non-Anonymous':
            contributions = Contribution.findAllWhere(project:project, isAnonymous:false)
            break;

            case 'Receipt Sent':
            contributions = Contribution.findAllWhere(project:project, receiptSent:true)
            break;

            case 'Receipt Not Sent':
            contributions = Contribution.findAllWhere(project:project, receiptSent:false)
            break;

            case 'Perk Selected':
            def contributionList = Contribution.findAllWhere(project:project)
            contributionList.each{
                if (it.reward.id != 1){
                    contributions.add(it)
                }
            }
            break;

            case 'No Perk Selected':
            def contributionList = Contribution.findAllWhere(project:project)
            contributionList.each{
                if (it.reward.id == 1){
                    contributions.add(it)
                }
            }
            break;

            case 'Online':
            contributions = Contribution.findAllWhere(project:project, isContributionOffline:false)
            break;

            case 'Offline':
            contributions = Contribution.findAllWhere(project:project, isContributionOffline:true)
            break;

            default:
            contributions = Contribution.findAllWhere(project:project)
        }
        if (contributions && !contributions.empty){
            def offset = params.offset ? params.int('offset') : 0
            def max = 10
            def count = contributions.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            contributionsOffset = contributions.reverse().subList(offset, maxrange)
        }
        return ['totalContributions':contributions, 'contributions':contributionsOffset]
    }
    
    def getContributorsListSearchedByName(def params, Project project){
        List contributionList = Contribution.findAllWhere(project:project)
        List contributions = []
        def contributionsOffset
        if (params.query && params.query != " "){
            contributionList.each{
                if (it.contributorName.contains(params.query)){
                    contributions.add(it)
                }
            }
        } else {
            contributions = contributionList
        }
        if (contributions && !contributions.empty){
            def offset = params.offset ? params.int('offset') : 0
            def max = 10
            def count = contributions.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            contributionsOffset = contributions.reverse().subList(offset, maxrange)
        }
        return ['totalContributions':contributions, 'contributions':contributionsOffset]
    }

    def setPartner(User user) {
        Partner partner = new Partner()
        partner.user = user
        partner.confirmCode = UUID.randomUUID().toString()
        partner.enabled = true
        partner.created = new Date()
        if (partner.save(failOnError: true)) {
            return partner
        } else {
            return null
        }
    }
    
    def updatePartnerInfo(Partner partner, def params) {
        def varValue = params.varValue
        def isValueChanged = false;
        
        switch (params.variable) {
            case 'orgName':
                partner.orgName = varValue;
                isValueChanged = true;
                break;

            case 'customUrl':
                partner.customUrl = varValue;
                isValueChanged = true;
                break;
                
            case 'description':
                partner.description = varValue;
                isValueChanged = true;
                break;

            case 'youtubeUrl':
                partner.youTube = varValue;
                isValueChanged = true;
                break;
                
            case 'category':
                partner.category = varValue;
                isValueChanged = true;
                break;

            case 'twitterUrl':
                partner.twitter = varValue;
                isValueChanged = true;
                break;
                
            case 'linkedinUrl':
                partner.linkedin = varValue;
                isValueChanged = true;
                break;

            case 'facebookUrl':
                partner.facebook = varValue;
                isValueChanged = true;
                break;
            
            case 'website':
                partner.website = varValue;
                isValueChanged = true;
                break;

            case 'email':
                partner.email = varValue;
                isValueChanged = true;
                break;
                
            case 'country':
                partner.country = varValue;
                isValueChanged = true;
                break;

            case 'addressLine1':
                partner.addressLine1 = varValue;
                isValueChanged = true;
                break;
                
            case 'addressLine2':
                partner.addressLine2 = varValue;
                isValueChanged = true;
                break;

            case 'city':
                partner.city = varValue;
                isValueChanged = true;
                break;
                
            case 'telephone':
                partner.telePhone = varValue;
                isValueChanged = true;
                break;
                
            case 'state':
                partner.pstate = varValue;
                isValueChanged = true;
                break;
                
            case 'zipCode':
                partner.zipCode = varValue;
                isValueChanged = true;
                break;

            default :
                isValueChanged = false;
        }
        
        if (isValueChanged) {
            partner.save()
        }
    }
    
    def isCustomUrlUnique(def params, Partner partner) {
        def customUrl = params.customUrl
        boolean isUnique = true
        
        def partners = Partner.list()
        partners.each {
            if (it.customUrl == customUrl) {
                if (partner != it) {
                    isUnique = false
                }
            }
        }
        return isUnique
        
    }
    
    // Convert Number to Word
    
    private static String convertLessThanOneThousand(int number) {
        String[] tensNames = ['',' ten', ' twenty', ' thirty', ' forty', ' fifty', ' sixty', ' seventy', ' eighty', ' ninety']
        
        String[] numNames = ['',' one', ' two', ' three', ' four', ' five', ' six', ' seven', ' eight', ' nine', ' ten', ' eleven', ' twelve', ' thirteen', ' fourteen', ' fifteen', ' sixteen', ' seventeen', ' eighteen', ' nineteen']
        
        String soFar;
        if (number % 100 < 20){
            soFar = numNames[number % 100];
            number /= 100;
        }
        else {
            soFar = numNames[number % 10];
            number /= 10;
            soFar = tensNames[number % 10] + soFar;
            number /= 10;
        }
        if (number == 0) 
            return soFar;
            
        return numNames[number] + " hundred" + soFar;
    }
    
    public static String convert(long number) {
        // 0 to 999 999 999 999
        if (number == 0) { return "zero"; }

        String snumber = Long.toString(number);
  
        // pad with "0"
        String mask = "000000000000";
        DecimalFormat df = new DecimalFormat(mask);
        snumber = df.format(number);
  
        // XXXnnnnnnnnn
        int billions = Integer.parseInt(snumber.substring(0,3));
        // nnnXXXnnnnnn
        int millions  = Integer.parseInt(snumber.substring(3,6));
        // nnnnnnXXXnnn
        int hundredThousands = Integer.parseInt(snumber.substring(6,9));
        // nnnnnnnnnXXX
        int thousands = Integer.parseInt(snumber.substring(9,12));

        String tradBillions;
        switch (billions) {
            case 0:
                tradBillions = "";
                break;
            case 1 :
                tradBillions = convertLessThanOneThousand(billions) + " billion ";
                break;
            default :
                tradBillions = convertLessThanOneThousand(billions) + " billion ";
        }
        String result =  tradBillions;
  
        String tradMillions;
        switch (millions) {
            case 0:
                tradMillions = "";
                break;
            case 1 :
                tradMillions = convertLessThanOneThousand(millions) + " million ";
                break;
            default :
                tradMillions = convertLessThanOneThousand(millions) + " million ";
        }
        result =  result + tradMillions;

        String tradHundredThousands;
        switch (hundredThousands) {
            case 0:
                tradHundredThousands = "";
                break;
            case 1 :
                tradHundredThousands = "one thousand ";
                break;
            default :
                tradHundredThousands = convertLessThanOneThousand(hundredThousands) + " thousand ";
        }
        result =  result + tradHundredThousands;

        String tradThousand;
        tradThousand = convertLessThanOneThousand(thousands);
        result =  result + tradThousand;

        // remove extra spaces!
        return result.replaceAll("^\\s+", "").replaceAll("\\b\\s{2,}\\b", " ");
    }
    
    def getUserForContributors(def email, def userId) {
        User user
        if (userId == '3' || userId == 3) {
            if (getCurrentUser()) {
                user = getCurrentUser()
            } else {
                user = getUserByEmail(email)
            }
            
            if (!user) {
                user = getUserById(userId)
            }
        } else {
            user = getUserById(userId)
        }
        return user
    }
    
    def generateTaxreceiptPdf(Contribution contribution) {
        TaxReciept taxReciept = projectService.getTaxRecieptOfProject(contribution.project)
        Transaction transaction = contributionService.getTransactionByContribution(contribution)
        SimpleDateFormat dateFormat = new SimpleDateFormat("d/MM/YYYY");
        
        String orgLogo;
        if (contribution.project.organizationIconUrl) {
            if (contribution.project.organizationIconUrl.startsWith('http') || contribution.project.organizationIconUrl.startsWith('https')) {
                orgLogo = contribution.project.organizationIconUrl
            } else {
                orgLogo = "https:"+contribution.project.organizationIconUrl
            }
        }
        
        Map reportParams = [:]
        reportParams.put("orgName", contribution.project.organizationName);
        reportParams.put("orgLogo", orgLogo);
        
        reportParams.put("orgAddress", (taxReciept.addressLine1 ? taxReciept.addressLine1 : "") +" "+
                                       (taxReciept.addressLine2 ? taxReciept.addressLine2 : "") +" "+
                                       (taxReciept.city ? taxReciept.city : "") +" "+ 
                                       (taxReciept.zip ? taxReciept.zip : "")+" "+
                                       (taxReciept.taxRecieptHolderState ? taxReciept.taxRecieptHolderState : "") +", India")
        
        reportParams.put("contributiondate", dateFormat.format(contribution.date));
        
        reportParams.put("signatureUrl", (taxReciept.signatureUrl ? "https:"+taxReciept.signatureUrl
                                                                  : "https://s3.amazonaws.com/crowdera/project-icon/csr.jpg"));
                                  
        
        reportParams.put("authorizedPerson", taxReciept.name);
        
        reportParams.put("regDate", dateFormat.format(taxReciept.regDate).toString());
        reportParams.put("exemptionPer", taxReciept.deductibleStatus ? taxReciept.deductibleStatus : " ");
        
        def reportDef
        
        if (contribution.project.payuStatus) {
            reportParams.put("amountInNo", "INR "+contribution.amount.round().toString());
            reportParams.put("orgStatus", "INR "+taxReciept.taxRecieptHolderState);
            reportParams.put("panNumber", taxReciept.panCardNumber);
            reportParams.put("panOfContributor", "");
            reportParams.put("receiptNo", transaction.transactionId);
            
            reportDef = new JasperReportDef(name:'taxreceiptIndia.jasper',fileFormat:JasperExportFormat.PDF_FORMAT,
                parameters: reportParams)
        } else {
            reportParams.put("amountInNo", "USD "+ contribution.amount.round().toString());
            reportParams.put("amountInWord", "USD "+convert((long)contribution.amount));
            reportParams.put("contributorName", contribution.contributorName)
            reportParams.put("perk", contribution.reward.title)
            reportParams.put("email", contribution.contributorEmail)
            reportParams.put("federalId", taxReciept.ein)
            reportParams.put("phone", taxReciept.phone)
            reportDef = new JasperReportDef(name:'taxreceiptUSA.jasper',fileFormat:JasperExportFormat.PDF_FORMAT,
                parameters: reportParams)
        }
        
        return reportDef;
    }
    
    def getUserSettingList(){
        def settingList = [
            Profile:'Profile',
            Contribution:'Contribution'
        ]
        return settingList
    } 
    

    @Transactional
    def bootstrap() {
        def admin = User.findByUsername('superadmin@crowdera.co')
        if (!admin) {
            admin = new User(username: 'superadmin@crowdera.co', password: 'P@$$w0rd',firstName: 'adminFirstName', lastName:'adminLastName', email: 'superadmin@crowdera.co').save(failOnError: true)
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

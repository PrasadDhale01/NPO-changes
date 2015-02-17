package fedu

import grails.transaction.Transactional

import java.text.DateFormat
import java.text.SimpleDateFormat

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import org.jets3t.service.security.AWSCredentials
import org.jets3t.service.model.*

class ProjectService {
    def userService
    def contributionService
    def grailsLinkGenerator
    def imageFile
	def imageUrlService
    def mandrillService

    def getNumberOfProjects() {
        return Project.count()
    }
    
    def getcardtypes(){
        def cardtypes=[
            VI: 'Visa',
            MC: 'Mastercard',
            DI: 'Discover Card',
            AX: 'American Express'
        ]
        return cardtypes
    }
    
    def getTitle(){
        def title = [
           Dr:'Dr.',
           Esq:'Esq.',
           Er:'Er',
           Hon:'Hon.',
           Jr:'Jr.',
           Lect:'Lect.',
           Miss:'Miss',
           Mr:'Mr.',
           Mrs:'Mrs.',
           Ms:'Ms.',
           Messr:'Messrs.',
           Mmes:'Mmes.',
           Msgr:'Msgr.',
           Prof:'Prof.',
           Rev:'Rev.',
           RtHon:'Rt. Hon.',
           Sr:'Sr.',
           St:'St.'
        ]
        return title
    }
    
    def getCountry(){
        def country = [
           AF:'Afghanistan',
           AX:'Aland Islands',
           AL:'Albania',
           DZ:'Algeria',
           AS:'American Samoa',
           AD:'Andorra',
           AO:'Angola',
           AI:'Anguilla',
           AQ:'Antarctica',
           AG:'Antigua and Barbuda',
           AR:'Argentina',
           AM:'Armenia',
           AW:'Aruba',
           AU:'Australia',
           AT:'Austria',
           AZ:'Azerbaijan',
           BS:'Bahamas',
           BH:'Bahrain',
           BD:'Bangladesh',
           BB:'Barbados',
           BY:'Belarus',
           BE:'Belgium',
           BZ:'Belize',
           BJ:'Benin',
           BM:'Bermuda',
           BT:'Bhutan',
           BO:'Bolivia',
           BA:'Bosnia and Herzegovina',
           BW:'Botswana',
           BV:'Bouvet Island',
           BR:'Brazil',
           IO:'British Indian Ocean Territory',
           BN:'Brunei Darussalam',
           BG:'Bulgaria',
           BF:'Burkina Faso',
           BI:'Burundi',
           KH:'Cambodia',
           CM:'Cameroon',
           CA:'Canada',
           CV:'Cape Verde',
           KY:'Cayman Islands',
           CF:'Central African Republic',
           TD:'Chad',
           CL:'Chile',
           CN:'China',
           CX:'Christmas Island',
           CC:'Cocos (Keeling) Islands',
           CO:'Colombia',
           KM:'Comoros',
           CG:'Congo',
           CD:'Congo, The Democratic Republic of The',
           CK:'Cook Islands',
           CR:'Costa Rica',
           CI:'Cote D\'ivoire',
           HR:'Croatia',
           CU:'Cuba',
           CY:'Cyprus',
           CZ:'Czech Republic',
           DK:'Denmark',
           DJ:'Djibouti',
           DM:'Dominica',
           DO:'Dominican Republic',
           EC:'Ecuador',
           EG:'Egypt',
           SV:'El Salvador',
           GQ:'Equatorial Guinea',
           ER:'Eritrea',
           EE:'Estonia',
           ET:'Ethiopia',
           FK:'Falkland Islands (Malvinas)',
           FO:'Faroe Islands',
           FJ:'Fiji',
           FI:'Finland',
           FR:'France',
           GF:'French Guiana',
           PF:'French Polynesia',
           TF:'French Southern Territories',
           GA:'Gabon',
           GM:'Gambia',
           GE:'Georgia',
           DE:'Germany',
           GH:'Ghana',
           GI:'Gibraltar',
           GR:'Greece',
           GL:'Greenland',
           GD:'Grenada',
           GP:'Guadeloupe',
           GU:'Guam',
           GT:'Guatemala',
           GG:'Guernsey',
           GN:'Guinea',
           GW:'Guinea-bissau',
           GY:'Guyana',
           HT:'Haiti',
           HM:'Heard Island and Mcdonald Islands',
           VA:'Holy See (Vatican City State)',
           HN:'Honduras',
           HK:'Hong Kong',
           HU:'Hungary',
           IS:'Iceland',
           IN:'India',
           ID:'Indonesia',
           IR:'Iran, Islamic Republic of',
           IQ:'Iraq',
           IE:'Ireland',
           IM:'Isle of Man',
           IL:'Israel',
           IT:'Italy',
           JM:'Jamaica',
           JP:'Japan',
           JE:'Jersey',
           JO:'Jordan',
           KZ:'Kazakhstan',
           KE:'Kenya',
           KI:'Kiribati',
           KP:'Korea, Democratic People\'s Republic of',
           KR:'Korea, Republic of',
           KW:'Kuwait',
           KG:'Kyrgyzstan',
           LA:'Lao People\'s Democratic Republic',
           LV:'Latvia',
           LB:'Lebanon',
           LS:'Lesotho',
           LR:'Liberia',
           LY:'Libyan Arab Jamahiriya',
           LI:'Liechtenstein',
           LT:'Lithuania',
           LU:'Luxembourg',
           MO:'Macao',
           MK:'Macedonia, The Former Yugoslav Republic of',
           MG:'Madagascar',
           MW:'Malawi',
           MY:'Malaysia',
           MV:'Maldives',
           ML:'Mali',
           MT:'Malta',
           MH:'Marshall Islands',
           MQ:'Martinique',
           MR:'Mauritania',
           MU:'Mauritius',
           YT:'Mayotte',
           MX:'Mexico',
           FM:'Micronesia, Federated States of',
           MD:'Moldova, Republic of',
           MC:'Monaco',
           MN:'Mongolia',
           ME:'Montenegro',
           MS:'Montserrat',
           MA:'Morocco',
           MZ:'Mozambique',
           MM:'Myanmar',
           NA:'Namibia',
           NR:'Nauru',
           NP:'Nepal',
           NL:'Netherlands',
           AN:'Netherlands Antilles',
           NC:'New Caledonia',
           NZ:'New Zealand',
           NI:'Nicaragua',
           NE:'Niger',
           NG:'Nigeria',
           NU:'Niue',
           NF:'Norfolk Island',
           MP:'Northern Mariana Islands',
           NO:'Norway',
           OM:'Oman',
           PK:'Pakistan',
           PW:'Palau',
           PS:'Palestinian Territory, Occupied',
           PA:'Panama',
           PG:'Papua New Guinea',
           PY:'Paraguay',
           PE:'Peru',
           PH:'Philippines',
           PN:'Pitcairn',
           PL:'Poland',
           PT:'Portugal',
           PR:'Puerto Rico',
           QA:'Qatar',
           RE:'Reunion',
           RO:'Romania',
           RU:'Russian Federation',
           RW:'Rwanda',
           SH:'Saint Helena',
           KN:'Saint Kitts and Nevis',
           LC:'Saint Lucia',
           PM:'Saint Pierre and Miquelon',
           VC:'Saint Vincent and The Grenadines',
           WS:'Samoa',
           SM:'San Marino',
           ST:'Sao Tome and Principe',
           SA:'Saudi Arabia',
           SN:'Senegal',
           RS:'Serbia',
           SC:'Seychelles',
           SL:'Sierra Leone',
           SG:'Singapore',
           SK:'Slovakia',
           SI:'Slovenia',
           SB:'Solomon Islands',
           SO:'Somalia',
           ZA:'South Africa',
           GS:'South Georgia and The South Sandwich Islands',
           ES:'Spain',
           LK:'Sri Lanka',
           SD:'Sudan',
           SR:'Suriname',
           SJ:'Svalbard and Jan Mayen',
           SZ:'Swaziland',
           SE:'Sweden',
           CH:'Switzerland',
           SY:'Syrian Arab Republic',
           TW:'Taiwan, Province of China',
           TJ:'Tajikistan',
           TZ:'Tanzania, United Republic of',
           TH:'Thailand',
           TL:'Timor-leste',
           TG:'Togo',
           TK:'Tokelau',
           TO:'Tonga',
           TT:'Trinidad and Tobago',
           TN:'Tunisia',
           TR:'Turkey',
           TM:'Turkmenistan',
           TC:'Turks and Caicos Islands',
           TV:'Tuvalu',
           UG:'Uganda',
           UA:'Ukraine',
           AE:'United Arab Emirates',
           GB:'United Kingdom',
           US:'United States',
           UM:'United States Minor Outlying Islands',
           UY:'Uruguay',
           UZ:'Uzbekistan',
           VU:'Vanuatu',
           VE:'Venezuela',
           VN:'Viet Nam',
           VG:'Virgin Islands, British',
           VI:'Virgin Islands, U.S.',
           WF:'Wallis and Futuna',
           EH:'Western Sahara',
           YE:'Yemen',
           ZM:'Zambia',
           ZW:'Zimbabwe',
        ]
        return country
    }
    
    def getState() {
        def state = [
            AL  :   'Alabama',
            AK  :   'Alaska',
            AZ  :   'Arizona',
            AR  :   'Arkansas',
            CA  :   'California',
            CO  :   'Colorado',
            CT  :   'Connecticut',
            DC  :   'District of Columbia',
            DE  :   'Delaware',
            FL  :   'Florida',
            GA  :   'Georgia',
            HI  :   'Hawaii',
            ID  :   'Idaho',
            IL  :   'Illinois',
            IN  :   'Indiana',
            IA  :   'Iowa',
            KS  :   'Kansas',
            KY  :   'Kentucky',
            LA  :   'Louisiana',
            ME  :   'Maine',
            MD  :   'Maryland',
            MA  :   'Massachusetts',
            MI  :   'Michigan',
            MN  :   'Minnesota',
            MS  :   'Mississippi',
            MO  :   'Missouri',
            MT  :   'Montana',
            NE  :   'Nebraska',
            NV  :   'Nevada',
            NH  :   'New Hampshire',
            NJ  :   'New Jersey',
            NM  :   'New Mexico',
            NY  :   'New York',
            NC  :   'North Carolina',
            ND  :   'North Dakota',
            OH  :   'Ohio',
            OK  :   'Oklahoma',
            OR  :   'Oregon',
            PA  :   'Pennsylvania',
            RI  :   'Rhode Island',
            SC  :   'South Carolina',
            SD  :   'South Dakota',
            TN  :   'Tennessee',
            TX  :   'Texas',
            UT  :   'Utah',
            VT  :   'Vermont',
            VA  :   'Virginia',
            WA  :   'Washington',
            WV  :   'West Virginia',
            WI  :   'Wisconsin',
            WY  :   'Wyoming',
            GU  :   'Guam',
            VI  :   'Virgin Islands',
            PR  :   'Puerto Rico',
            AS  :   'American Samoa',
            other:  'Other'
        ]
        return state
    }
    
    def getdefaultAdmin(Project project, User user) {
        def defaultAdminEmail = "campaign-admin@crowdera.co"
        getAdminForProjects(defaultAdminEmail, project, user)
    }
    
    def getAdminForProjects(String adminEmail, Project project, User user) {
                
        def fullName = user.firstName + ' ' + user.lastName
        if (adminEmail) {
            mandrillService.inviteAdmin(adminEmail, fullName, project)
            ProjectAdmin projectAdmin = new ProjectAdmin()
            projectAdmin.email = adminEmail
            project.addToProjectAdmins(projectAdmin)
        }
    }

    def updateAdminsAndSendUpdateEmail(def email1, def email2, def email3, def project, def user) {
        
        def fullName = user.firstName + ' ' + user.lastName
        def projectadmins = project.projectAdmins
        
        def campaignCoCreator = projectadmins[0]
        def firstAdmin = projectadmins[1]
        def secondAdmin = projectadmins[2]
        def thirdAdmin = projectadmins[3]
        
        isAdminCreated (email1, project, firstAdmin, user)
        isAdminCreated (email2, project, secondAdmin, user)
        isAdminCreated (email3, project, thirdAdmin, user)
        
        def campaignCoCreatorEmail = campaignCoCreator.getEmail()
        mandrillService.sendUpdateEmailToAdmin(campaignCoCreatorEmail, fullName, project)
        
        def projectOwner = project.user
        def projectOwnerEmail = projectOwner.getEmail()
        mandrillService.sendUpdateEmailToAdmin(projectOwnerEmail, fullName, project)
    }
    
    private def isAdminCreated(def email, def project, def projectAdmin, User user ) {
        
        def fullName = user.firstName + ' ' + user.lastName
        def projectadmins = project.projectAdmins
        
        def adminAlreadyCreated = false
        projectadmins.each{
            if (email == it.getEmail()) {
                adminAlreadyCreated = true
            }
        }
        if (!adminAlreadyCreated && email) {
            if (projectAdmin != null) {
                projectAdmin.email = email
                mandrillService.inviteAdmin(email, fullName, project)
            } else {
                getAdminForProjects(email, project, user)
            }
        } else {
            if(projectAdmin != null) {
                def adminEmail= projectAdmin.getEmail()
                mandrillService.sendUpdateEmailToAdmin(adminEmail, fullName, project)
            }
        }
    }

    def getNumberofDays(def endingdate, Project project) {
        def endDate = Date.parse('MM/dd/yyyy', endingdate)
        def currentDate = new Date()
        def numberOfDays = endDate - currentDate
        project.days = numberOfDays
        project.created = currentDate
    }

    def getUpdatedNumberofDays(def endingdate, Project project){
        def endDate = Date.parse('MM/dd/yyyy', endingdate)
        def createdDate = project.created
        def numberOfDays = endDate - createdDate
        project.days = numberOfDays
    }
	
	def isTeamAdmin(Project project) {
		def user = userService.getCurrentUser()
		def result = false
		project.projectAdmins.each{
			if(it.email == user.email)
				 result = true
		}
		return result
	}
    
    /*def sendEmailToAdminForProjectUpdate(def project, def user) {
        def projectadmins = project.projectAdmins
        def fullName = user.firstName + ' ' + user.lastName
        
        projectadmins.each{
            def projectadmin = it
            if (projectadmin) {
                def email = projectadmin.getEmail()
                mandrillService.sendUpdateEmailToAdmin(email, fullName, project)
            }
        }
        def projectOwner = project.user 
        
        if (projectOwner) {
            def projectOwnerEmail = projectOwner.getEmail()
            mandrillService.sendUpdateEmailToAdmin(projectOwnerEmail, fullName, project)
        }
    }*/
    
    def getCategoryList() {
        def categoryOptions = [
            (Project.Category.ANIMALS): "Animals",
            (Project.Category.ARTS): "Arts",
            (Project.Category.CHILDREN): "Children",
            (Project.Category.COMMUNITY): "Community",
            (Project.Category.EDUCATION): "Education",
            (Project.Category.ELDERLY): "Elderly",
            (Project.Category.ENVIRONMENT): "Environment",
            (Project.Category.HEALTH): "Health",
            (Project.Category.SOCIAL_INNOVATION): "Social Innovation",
            (Project.Category.RELIGION): "Religion",
            (Project.Category.OTHER): "Other",
        ]
        return categoryOptions
    }
	
   def getCategory(){
	   def categoryOptions = [
		   ALL: "All Categories",
		   ANIMALS: "Animals",
		   ARTS: "Arts",
		   CHILDREN: "Children",
		   COMMUNITY: "Community",
		   EDUCATION: "Education",
		   ELDERLY: "Elderly",
		   ENVIRONMENT: "Environment",
		   HEALTH: "Health",
		   SOCIAL_INNOVATION: "Social Innovation",
		   RELIGION: "Religion",
		   OTHER: "Other",
	   ]
	   return categoryOptions
	   }
    
    def getValidatedProjects() {
		def criteria = Project.createCriteria()
		def results = criteria.list {
			eq("validated", true)
			eq("inactive", false)
            eq("rejected", false)
			order("id", "desc")
		}
		def popularProjectsList = getPopularProjects()
		def finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
    List endedProjects = []
    List openProjects = []
    finalList.each { project ->
        boolean ended = isProjectDeadlineCrossed(project)
        if(ended) {
            endedProjects.add(project)
        } else {
            openProjects.add(project)
        }
    }
    finalList =  openProjects.reverse() + endedProjects.reverse()
//        return Project.findAllWhere(validated: true,inactive: false)
		return finalList
    }
	
	def getPopularProjects(){
		def results = PopularProject.getAll()
		def popularProjectsList = []
		results.each {
			popularProjectsList.add(it.getProject())
		}
		return popularProjectsList
	}
	
	def showProjects(){
		/* Logic to fetch the latest comes first out of the validated projects.*/
		//TO DO
		/* Later on the criteria will be modified in order to display the admin selected projects as the popular projects*/
		def criteria = Project.createCriteria()
		def results = criteria.list {
			eq("validated", true)
			eq("inactive", false)
            eq("rejected", false)
			order("id", "desc")
		}
		def popularProjectsList = getPopularProjects()
		def finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
		return finalList
	}
	
	def projectOnHomePage() {
		def projects = Project.getAll('6512bd43d9caa6e02c990b0a82652dca', '93db85ed909c13838ff95ccfa94cebd8', '17e62166fc8586dfa4d1bc0e1742c08b')
	    return projects
	}

    def getBeneficiaryId(Project project) {
        return( project.beneficiaryId )
    }
    
    def getProjects(def projects, def projectAdmins, def fundRaisers) {
        def list = []
        projects.each {
            if(it.inactive == false) {
                list.add(it)           
            }
        }
        
        projectAdmins.each {
            def project = Project.findById(it.projectId)
            if(project.inactive == false) {
                list.add(project)
            }
        }
        
        fundRaisers.each { fundRaiser ->
            def project = fundRaiser.project
            def isProjectexist = false
            list.each {
                if (project == it) {
                    isProjectexist = true
                }
            }
            if(!isProjectexist) {
                if(project.inactive == false) {
                    list.add(project)
                }
            }
        }
        return list
    }
    
    def getDataType(Double amount){
        def price
        if(((int)amount) == amount){
            price = (int)amount.round()
        } else {
            price = amount.round()
        }
        return price
    }

    def getNonValidatedProjects() {
        return Project.findAllWhere(validated: false, inactive: false, draft: false, rejected: false)
    }

    def search(String query) {
        List result = []
        def project = getValidatedProjects()
        project.each { 
            if( it.title.toLowerCase().contains(query.toLowerCase()) || it.story.toLowerCase().contains(query.toLowerCase()) ){
                result.add(it)
            }
        }
        return result
    }

    def getBeneficiaryName(Project project) {
        def name
        if (project.beneficiary.firstName && project.beneficiary.lastName) {
            name = project.beneficiary.firstName + ' ' + project.beneficiary.lastName
        } else {
            name = project.beneficiary.firstName
            if (!name) {
                name = project.beneficiary.email
            }
        }
        return name
    }

    def getProjectImageLink(Project project) {
        if (project.imageUrl) {
            if (project.imageUrl[0].getUrl().startsWith('http')) {
                return project.imageUrl[0].getUrl()
            } else {
                return grailsLinkGenerator.resource(file: project.imageUrl[0].getUrl())
            }
        } else if (project.image) {
            return grailsLinkGenerator.link(controller: 'project', action: 'thumbnail', id: project.id)
        } else {
            return 'http://lorempixel.com/400/400/abstract'
        }
    }

    def getProjectImageLinks(Project project) {
        def imageUrls = []
        for (imgUrl in project.imageUrl) {
            if (imgUrl) {
                if (imgUrl.getUrl().startsWith('http')) {
                    imageUrls.add(imgUrl.getUrl())
                } else {
                    imageUrls.add(grailsLinkGenerator.resource(file: imgUrl.getUrl()))
                }
            } else if (project.image) {
                return grailsLinkGenerator.link(controller: 'project', action: 'thumbnail', id: project.id)
            }
        }
        // if no project image, set the default project url
        if(imageUrls == []){
            imageUrls.add('http://lorempixel.com/400/400/abstract')
        }
        return imageUrls
    }

    def getProjectUpdatedImageLink(def projectUpdate) {
        def imageUrls = []
        def imagelinks = projectUpdate.imageUrls
        imagelinks.each {
            def link = it.url
            imageUrls.add(link)
        }
        return imageUrls
    }
    
    def getMultipleImageUrls(List<MultipartFile> files, Project project){
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)

        def Folder = "project-images"

        def tempImageUrl
        files.each {
            def imageUrl = new ImageUrl()
            def imageFile= it
            if (!imageFile?.empty && imageFile.size < 1024*1024) {
                try{
                    def file= new File("${imageFile.getOriginalFilename()}")
                    def key = "${Folder}/${it.getOriginalFilename()}"
                    imageFile.transferTo(file)
                    def object=new S3Object(file)
                    object.key=key

                    tempImageUrl = "https://s3.amazonaws.com/crowdera/${key}"
                    s3Service.putObject(s3Bucket, object)
                    imageUrl.url = tempImageUrl
                    project.addToImageUrl(imageUrl)
                    file.delete()
                }catch(IllegalStateException e){
                    e.printStackTrace()
                }
            }
        }
    }
	
    def getContributedAmount (Transaction transaction){
	def contribution = Contribution.findWhere(user: transaction.user,project: transaction.project)
	return contribution.amount.round()
    }
    
    def getUpdatedImageUrls(List<MultipartFile> files, ProjectUpdate projectUpdate){
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)

        def Folder = "project-images"
 
        def tempImageUrl
        files.each {
            def imageUrl = new ImageUrl()
            def imageFile= it
             if (!imageFile?.empty && imageFile.size < 1024*1024) {
                def file= new File("${imageFile.getOriginalFilename()}")
                def key = "${Folder}/${it.getOriginalFilename()}"
                imageFile.transferTo(file)
                def object=new S3Object(file)
                object.key=key

                imageUrl.url = "https://s3.amazonaws.com/crowdera/${key}"
                s3Service.putObject(s3Bucket, object)
                imageUrl.save()
                projectUpdate.addToImageUrls(imageUrl)
                file.delete()
            }
        }
    }
    
    def isImageFileEmpty(List<MultipartFile> files) {
        def isImageFileEmpty = true
        files.each {file ->
            if (!file?.empty) {
                isImageFileEmpty = false
            }
        }
        return isImageFileEmpty
    }

    def isFundingOpen(Project project) {
        if (isProjectDeadlineCrossed(project) || contributionService.isFundingAchievedForProject(project)) {
            return false
        } else {
            return true
        }
    }

    /*def getImageUrl(CommonsMultipartFile imageFile) {
        this.imageFile = imageFile
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"
        def bucketName = "crowdera"
        def folder = "project-images"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);
        def myBuckets = s3Service.listAllBuckets();
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
    }*/

    def getorganizationIconUrl(CommonsMultipartFile iconFile) {
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"
        def bucketName = "crowdera"
        def folder = "project-icon"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);
        def myBucket = s3Service.listAllBuckets();
        def s3Bucket = new S3Bucket(bucketName)
        
        def tempFile = new File("${iconFile.getOriginalFilename()}")
        def key = "${folder}/${iconFile.getOriginalFilename()}"
        iconFile.transferTo(tempFile)
        def object = new S3Object(tempFile)
        object.key = key

        s3Service.putObject(s3Bucket, object)
        tempFile.delete()
        
        def organizationIconUrl = "https://s3.amazonaws.com/crowdera/${key}"

        return organizationIconUrl
    }
	
    def VALID_IMG_TYPES = ['image/png', 'image/jpeg']

    def getImageUrls(Project project){
		def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
		def awsSecretKey = "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"

		def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
		def s3Service = new RestS3Service(awsCredentials);

		def bucketName = "crowdera"
		def s3Bucket = new S3Bucket(bucketName)
		
		def Folder = "project-images"
		
		def tempImageUrl
		files.each {
            def imageUrl = new ImageUrl()
            def imageFile= it
            
            if (!imageFile?.empty && imageFile.size < 1024*1024) {
                
                if (VALID_IMG_TYPES.contains(imageFile.getContentType())) {
                    try{
                        def file= new File("${imageFile.getOriginalFilename()}")
                        def key = "${Folder}/${it.getOriginalFilename()}"
                        imageFile.transferTo(file)
                        def object=new S3Object(file)
                        object.key=key
                    
                        tempImageUrl = "https://s3.amazonaws.com/crowdera/${key}"
                        s3Service.putObject(s3Bucket, object)
                        imageUrl.url = tempImageUrl
                        project.addToImageUrl(imageUrl)
                        file.delete()
                    }catch(IllegalStateException e){
                        e.printStackTrace()
                    }
                }
                
            }
        }
    }

    def isProjectDeadlineCrossed(Project project) {
        if (!project) {
            return null
        }

        def startDate = getProjectStartDate(project)
        def endDate = getProjectEndDate(project)

        def today = Calendar.instance
        boolean ended = endDate.compareTo(today) < 0 ? true : false

        return ended
    }
    def getRemainingDay(Project project) {
       if (!project) {
            return null
       }
        def day
        if ((getProjectEndDate(project))>(Calendar.instance)) {
            day =(getProjectEndDate(project)-Calendar.instance)
        }
        else {
            day =(Calendar.instance-getProjectEndDate(project))
        }
        return day
    }

    def getProjectStartDate(Project project) {
        if (!project) {
            return null
        }

        def startDate = Calendar.instance
        startDate.setTime(project.created)

        return startDate
    }

    def getProjectEndDate(Project project) {
        if (!project) {
            return null
        }

        def endDate = Calendar.instance
        endDate.setTime(project.created)
        endDate.add Calendar.DAY_OF_YEAR, project.days

        return endDate
    }
    
    def filterByCategory(def categories){
        def projects = getValidatedProjects()
        List list =[]
        if (categories == "All"){
            return projects
        } else {
            projects.each{
                String str = it.category
                if (str.equalsIgnoreCase(categories)){
                   list.add(it)
                }
            }
            return list
           
        }
    }
    
    def getFundRaisersForTeam(Project project, User user) {
        def teams = project.teams
		def amount = project.amount
        def isTeamExist = false
        String message
        teams.each {
            if(user.id == it.user.id) {
                isTeamExist = true
            }
        }
        if(!isTeamExist) {
            Team team = new Team(
                amount: amount,
                user: user,
				joiningDate: new Date()
            )

            project.addToTeams(team).save(failOnError: true)
            if (project.teams.size()==1) {
                message= "You have Successfully Created the Team"
            } else {
                message= "You have Successfully Joined the Team"
            }
        } else {
            message = "You Already have a Team"
        }
        return message
    }
    
    def getWebUrl(def project) {
        if (project.webAddress) {
            if (project.webAddress.startsWith('http')) {
                return project.webAddress
            } else {
                return "http://"+project.webAddress
            }
        }
    }
    
    def getCustomerRequest(def params) {
        CustomerService service = new CustomerService()
        service.category = params.customerType
        service.customername = params.firstAndLastName
        service.description = params.helpDescription
        service.email = params.emailAddress
        service.subject = params.subject

        service.save(failOnError: true)
        
        mandrillService.sendEmailToCustomer(service);
    }

    @Transactional
    def bootstrap() {
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy")

        User deepshikha = userService.bootstrapDeepshikha()
        User sampleUser = User.findByUsername('user@example.com')

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 600,
                days: 600,
                //fundRaisingReason: Project.FundRaisingReason.TUITION_FEE,
                //fundRaisingFor: Project.FundRaisingFor.MYSELF,
                category: Project.Category.ENVIRONMENT,
                title: 'Machine Learning',
                description: 'Machine learning is going to change the world for ever.',
                videoUrl: 'www.youtube.com/watch?v=UzxYlbK2c7E',
                charitableId: 'd207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl: 'https://s3.amazonaws.com/crowdera/project-icon/organization-icon.jpg',
                organizationName: 'Stanford',
                webAddress: 'https://www.coursera.org/course/ml',
                story: 'Machine learning is a scientific discipline that deals with the construction and study of algorithms that can learn from data',
                validated: true,
                user: sampleUser,
                beneficiary: new Beneficiary()
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                date: dateFormat.parse("01/16/2014"),
                user: sampleUser,
                reward: Reward.findById(3)
        ).addToContributions(
                date: dateFormat.parse("01/20/2014"),
                user: sampleUser,
                reward: Reward.findById(2)
		).addToImageUrl(
				url: 'https://1.bp.blogspot.com/-tn9GwuoC45w/TvtQvP6_UFI/AAAAAAAAAHI/ECpLGjyH6AI/s1600/machine_learning_course.png'
		).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-1.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.crowdera.co',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Anasuya',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/16/2014"),
                user: sampleUser
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/17/2014"),
                user: sampleUser
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/20/2014"),
                user: sampleUser
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/22/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Anusuya.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-2.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.crowdera.co',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Roshanbai',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(7)
        ).addToRewards(
                Reward.findById(9)
        ).addToRewards(
                Reward.findById(4)
        ).addToContributions(
                reward: Reward.findById(7),
                date: dateFormat.parse("01/23/2014"),
                user: sampleUser
		).addToImageUrl(
			url: 'https://s3.amazonaws.com/crowdera/project-images/Roshanbai.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.crowdera.co',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Vandana',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(7)
        ).addToRewards(
                Reward.findById(9)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(10),
                date: dateFormat.parse("01/21/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Vandana.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-1.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.crowdera.co',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Pushpa',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToRewards(
                Reward.findById(9)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(9),
                date: dateFormat.parse("01/26/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Pushpa.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-2.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.crowdera.co',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Sangita',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToRewards(
                Reward.findById(7)
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/18/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Sangita.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-2.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.crowdera.co',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Sunanda',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(8)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(4),
                date: dateFormat.parse("01/24/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Sunanda.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-3.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.crowdera.co',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Tarabai',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(8)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(8),
                date: dateFormat.parse("01/29/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Tarabai.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-1.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.crowdera.co',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Asha',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(4),
                date: dateFormat.parse("01/27/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Asha.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-3.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.crowdera.co',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Sunita',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/22/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Sunita.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-1.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.crowdera.co',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Yeshula',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(6),
                date: dateFormat.parse("01/20/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Yeshula.png'
        ).save(failOnError: true)
    }
}

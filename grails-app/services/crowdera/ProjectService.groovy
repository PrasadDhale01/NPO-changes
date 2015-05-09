package crowdera

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
	
	def getProjectById(def projectId){
		return Project.get(projectId)
	}
	
	def getImageUrlById(def imageId){
		return ImageUrl.get(imageId)
	}
	
	def getTeamById(def teamId){
		return Team.get(teamId)
	}
	
	def getTeamCommentById(def teamCommentId){
		return TeamComment.get(teamCommentId)
	}
	
	def getTeamByUserAndProject(def project, def user){
		def team = Team.findByUserAndProject(user, project)
		return team
	}
	
	def getProjectAdminByEmail(def email){
		return ProjectAdmin.findByEmail(email)
	} 
	
	def getProjectCommentById(def commentId){
		return ProjectComment.get(commentId)
	}
	
	def getProjectByParams(def projectParams){
		Project project = new Project(projectParams)
		return project
	}
	
	def getProjectUpdateDetails(def params, def request, def project){
		def iconFile = request.getFile('iconfile')
		if(!iconFile.isEmpty()) {
			def uploadedFileUrl = getorganizationIconUrl(iconFile)
			if (uploadedFileUrl) {
				project.organizationIconUrl = uploadedFileUrl
			}
		}
		
		def imageFiles = request.getFiles('thumbnail[]')
		if(!imageFiles.isEmpty()) {
			getMultipleImageUrls(imageFiles, project)
		}
		
		project.description = params.description
		project.story = params.story
		project.amount = Double.parseDouble(params.amount)
		project.title = params.title
		project.category = params.category
		project.webAddress = params.webAddress
		project.videoUrl = params.videoUrl

		def days = params.days
		getUpdatedNumberofDays(days, project)
	}
	
	def getCSVDetails(def params, def response){
		List contributions=[]
		SimpleDateFormat dateFormat = new SimpleDateFormat("d MMM YYYY");
		SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss");

		def projectId= params.projectId
		def project = Project.get(projectId)

		def teamId = params.teamId
		def team = Team.get(teamId)

		if(team!=null){
			if(project.user==team.user){
				contributions = project.contributions.reverse()
			} else {
				contributions = team.contributions.reverse()
			}
		} else {
			contributions = project.contributions.reverse()
		}

		response.setHeader("Content-disposition", "attachment; filename= Crowdera_report-"+project.title.replaceAll(' ','_')+".csv")
		def results=[]
		def  contributorName
		def payMode
		def shippingDetails=""
		def contributorEmail
		contributions.each{

			if(it.isContributionOffline){
				payMode="offline"
				contributorName= it.contributorName
				contributorEmail= "-"
				shippingDetails="No Perk Selected"
			}else{
				payMode="Online"
				contributorName= it.contributorName
				contributorEmail=it.contributorEmail
				shippingDetails=getShippingDetails(it)
			}
			def fundRaiserName = contributionService.getFundRaiserName(it, project)
			 if(project.rewards.size()>1){
				def rows = [it.project.title, fundRaiserName, it.date.format('YYYY-MM-DD HH:mm:ss'), contributorName, contributorEmail, it.reward.title, shippingDetails, it.amount, payMode]
				results << rows
				shippingDetails=""
			}else{
				def rows = [it.project.title, fundRaiserName, it.date.format('YYYY-MM-DD HH:mm:ss'), contributorName, contributorEmail, it.amount, payMode]
				results << rows
				shippingDetails=""
			}
		}
		def result
		if(project.rewards.size()>1){
			result='CAMPAIGN, FUNDRAISER, DATE AND TIME, CONTRIBUTOR NAME,CONTRIBUTOR EMAIL, PERK , SHIPPING DETAILS, AMOUNT, MODE, \n'
			results.each{ row->
				row.each{
				col -> result+=col +','
				}
				result = result[0..-2]
				result+="\n"
			}
		}else{
			result='CAMPAIGN, FUNDRAISER, DATE AND TIME, CONTRIBUTOR NAME,CONTRIBUTOR EMAIL, AMOUNT, MODE, \n'
			results.each{ row->
				row.each{
				col -> result+=col +','
				}
				result = result[0..-2]
				result+="\n"
			}
		}
		return result
	}
	
	def getUpdateValidationDetails(def params){
		def project = Project.get(params.id)
		project.created = new Date()
		project.validated = true
	}
	
		
	def getCommentsDetails(params){
		def project = Project.get(params.id)
		if (project && params.comment) {
			new ProjectComment(
				comment: params.comment,
				user: userService.getCurrentUser(),
				project: project,
				date: new Date()).save(failOnError: true)
	    }
	} 
	
	def getUpdateCommentDetails(def request){
		def checkid= request.getParrmeter('checkID')
		def proComment = ProjectComment.get(checkid)
		def status = request.getParameter('status')
		if(status=='false'){
			proComment.status=false
		}else{
			proComment.status=true
		}
	}
	
	def getEditedFundraiserDetails(def params, def team, def request){
		def user = userService.getCurrentUser()
		def project = Project.get(params.project)
		def amount = Double.parseDouble(params.amount)
		if(amount <= project.amount){
			team.amount = amount
		}
		def imageFiles = request.getFiles('imagethumbnail')
		if(!imageFiles.isEmpty()) {
			getMultipleImageUrlsForTeam(imageFiles, team)
		}
		
		team.videoUrl = params.videoUrl
		team.story = params.story
		team.description = params.description
		def message = "Team Updated Successfully"
		
		if (user == project.user) {
			mandrillService.sendTeamUpdationEmail(project, team)
		}
		
		return message
	}
	
	def getTeamCommentsDetails(def params){
		def fundRaiser = params.fr
		def message
		User user = User.findByUsername(fundRaiser)
		Project project = Project.get(params.id)
		Team team = getTeamByUserAndProject(project, user)
		if (team) {
			TeamComment teamComment = new TeamComment(
				comment: params.comment,
				user: userService.getCurrentUser(),
				team: team,
				date: new Date())
	        team.addToComments(teamComment).save(failOnError: true)
		} else {
			message = "Something went wrong saving comment. Please try again later."
		}
		return message
	}
	
	def getContributionDeleteDetails(def params){
		def contribution = contributionService.getContributionById(params.id)
		def project = Project.get(params.projectId)
		def fundraiser = params.fr
		def fundRaiser = User.findByUsername(fundraiser)
		Team team = getTeamByUserAndProject(project, fundRaiser)
		if (team) {
			List teamContributions = team.contributions
			teamContributions.remove(contribution)
		}
		
		List contributions = project.contributions
		contributions.remove(contribution)
		
		contribution.delete();
	}
	
	def getCommentDeletedDetails(def params){
		def project = Project.get(params.projectId)
		def fundraiser = params.fr
		def fundRaiser = userService.getUserByUsername(fundraiser)
		Team team = getTeamByUserAndProject(project, fundRaiser)
		if(team){
			def teamcomment = TeamComment.get(params.id)
			if (teamcomment) {
				List teamComments = team.comments
				teamComments.remove(teamcomment)
			    teamcomment.delete()
			}
		}else{
			def projectcomment= ProjectComment.get(params.id)
			if (projectcomment) {
				List projectComments = project.comments
				projectComments.remove(projectcomment)
			    projectcomment.delete()
			}
		}
	}
	
	def getContributionEditedDetails(def params){
		def contribution = Contribution.get(params.id)
		def project = Project.get(params.projectId)
		def fundraiser = params.fr
		def fundRaiser = userService.getUserByUsername(fundraiser)
		contribution.contributorName = params.contributorName
		contribution.amount = Double.parseDouble(params.amount)
	}

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
	
	def getSorts(){
		def sortsOptions = [
			All_Campaigns: "All Campaigns",
			More_than_ninety: "More than 90",
			Less_than_ten: "Less than 10",
			Ten_days_remaining: "10 days remaining"
		]
		return sortsOptions
	}
	
	def isCampaignsorts(def sorts){
		List projects = getValidatedProjects()
		List p = []
		if(sorts == 'All Campaigns'){
			return projects
		}
		if(sorts == 'More than 90'){
			projects.each {
				def percentage = contributionService.getPercentageContributionForProject(it)
				if(percentage > 90){
					p.add(it)
				}
			}
		}
		if(sorts == 'Less than 10'){
			projects.each {
				def percentage = contributionService.getPercentageContributionForProject(it)
				if(percentage < 10){
					p.add(it)
				}
			}
		}
		if(sorts == '10 days remaining'){
			projects.each {
				def day = getRemainingDay(it)
				if(day <= 10){
					p.add(it)
				}
			}
		}
		return p
	}
    
    def getdefaultAdmin(Project project, User user) {
        def defaultAdminEmail = "campaignadmin@crowdera.co"
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
	
	def getDaysFromStartDate(Project project) {
		def startDate = project.created
		def currentDate = new Date()
		def numberOfDays = currentDate - startDate
		return numberOfDays
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
		def popularProjectsList = getPopularProjects()
		def finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
		List endedProjects = []
		List openProjects = []
		List sortedProjects
		finalList.each { project ->
            boolean ended = isProjectDeadlineCrossed(project)
            if(ended) {
                endedProjects.add(project)
            }else {
                openProjects.add(project)
            }
        }
        sortedProjects = openProjects.sort {contributionService.getPercentageContributionForProject(it)}
        finalList =  sortedProjects.reverse() + endedProjects.reverse()
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
		def popularProjectsList = getPopularProjects()
		def finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
		return finalList
	}
	
	def projectOnHomePage() {
		def projects = Project.getAll('6512bd43d9caa6e02c990b0a82652dca', '93db85ed909c13838ff95ccfa94cebd8', '2c9f84884ba9312b014bb3f7bb0c0000')
	    return projects
	}

    def getBeneficiaryId(Project project) {
        return( project.beneficiaryId )
    }
	
    def getCurrentTeam(Project project,User user){
	return Team.findByProjectAndUser(project, user)
    }
	
    def getCurrentTeamAmount(Project project,User user){
	def team = Team.findByProjectAndUser(project, user)
	def amount = team.amount
	return amount.round()
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
        if (amount) {
            return amount.round()
        } else {
            return 0
        }
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
		    def category = project.category.toString()
			return getCategoryImage(category)
		}
    }
    
	def getCategoryImage(String category) {
		if(category.equalsIgnoreCase('ANIMALS')) {
			return '//s3.amazonaws.com/crowdera/assets/animals.jpg'
		} else if (category.equalsIgnoreCase('ARTS')) {
			return '//s3.amazonaws.com/crowdera/assets/arts.jpg'
		} else if (category.equalsIgnoreCase('CHILDREN')) {
		    return '//s3.amazonaws.com/crowdera/assets/children.jpg'
		} else if (category.equalsIgnoreCase('COMMUNITY')){
		    return '//s3.amazonaws.com/crowdera/assets/community.jpg'
		} else if (category.equalsIgnoreCase('EDUCATION')) {
		    return '//s3.amazonaws.com/crowdera/assets/education.jpg'
		} else if (category.equalsIgnoreCase('ELDERLY')) {
		    return '//s3.amazonaws.com/crowdera/assets/elderly.jpg'
		} else if (category.equalsIgnoreCase('ENVIRONMENT')) {
		    return '//s3.amazonaws.com/crowdera/assets/environment.jpg'
		} else if (category.equalsIgnoreCase('HEALTH')){
		    return '//s3.amazonaws.com/crowdera/assets/health.jpg'
		} else if (category.equalsIgnoreCase('SOCIAL_INNOVATION')){
		    return '//s3.amazonaws.com/crowdera/assets/social-Innovation.jpg'
		} else if (category.equalsIgnoreCase('RELIGION')) {
		    return '//s3.amazonaws.com/crowdera/assets/religion.jpg'
		} else if (category.equalsIgnoreCase('OTHER')) {
		    return '//s3.amazonaws.com/crowdera/assets/other.jpg'
		}
	}
	
    def getProjectImageLinks(Project project) {
        def imageUrls = []
        if(project.videoUrl){
            def regex =/^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
            def vidUrl=project.getVideoUrl()
            def match = vidUrl.matches(regex);
            if(match){
                def vurl=vidUrl.replace("watch?v=", "embed/");
                imageUrls.add(vurl)     
            }
        }
        for (imgUrl in project.imageUrl) {
            if (imgUrl) {
                if (imgUrl.getUrl().startsWith('http')) {
                    imageUrls.add(imgUrl.getUrl())
                } else {
                    imageUrls.add(grailsLinkGenerator.resource(file: imgUrl.getUrl()))
                }
            }else if (project.image) {
                return grailsLinkGenerator.link(controller: 'project', action: 'thumbnail', id: project.id)
            }
        }
        // if no project image, set the default project url
		def category = project.category.toString()
        if(imageUrls == []){
            imageUrls.add(getCategoryImage(category))
        }
            return imageUrls
    }
	
	def getTeamImageLinks(Team team, Project project) {
		def imageUrls = []

    		if(team.videoUrl){
      			def regex =/^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
      			def teamVideoUrl=team.getVideoUrl()
      			def match = teamVideoUrl.matches(regex);
      			if(match){
        			def tvurl=teamVideoUrl.replace("watch?v=", "embed/");
        			imageUrls.add(tvurl)
      			}
		}
		for (imgUrl in team.imageUrl) {
			if (imgUrl) {
				if (imgUrl.getUrl().startsWith('http')) {
					imageUrls.add(imgUrl.getUrl())
				} else {
					imageUrls.add(grailsLinkGenerator.resource(file: imgUrl.getUrl()))
				}
			} 
		}
		// if no project image, set the default project url
		
		if(imageUrls == []){
			def category = project.category.toString()
			imageUrls.add(getCategoryImage(category))
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
            if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
                try{
                    def file= new File("${imageFile.getOriginalFilename()}")
                    def key = "${Folder}/${it.getOriginalFilename()}"
                    imageFile.transferTo(file)
                    def object=new S3Object(file)
                    object.key=key

                    tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
                    s3Service.putObject(s3Bucket, object)
                    imageUrl.url = tempImageUrl
                    project.addToImageUrl(imageUrl)
                    file.delete()
                }catch(Exception e){
                    e.printStackTrace()
                }
            }
        }
    }
	
	def getMultipleImageUrlsForTeam(List<MultipartFile> files, Team team){
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
			if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
				try{
					def file= new File("${imageFile.getOriginalFilename()}")
					def key = "${Folder}/${it.getOriginalFilename()}"
					imageFile.transferTo(file)
					def object=new S3Object(file)
					object.key=key

					tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
					s3Service.putObject(s3Bucket, object)
					imageUrl.url = tempImageUrl
					team.addToImageUrl(imageUrl)
					file.delete()
				}catch(IllegalStateException e){
					e.printStackTrace()
				}
			}
		}
	}
	
    def getContributedAmount (Transaction transaction){
	    def contribution = transaction.contribution
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
 
        files.each {
            def imageUrl = new ImageUrl()
            def imageFile= it
             if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
                def file= new File("${imageFile.getOriginalFilename()}")
                def key = "${Folder}/${it.getOriginalFilename()}"
                imageFile.transferTo(file)
                def object=new S3Object(file)
                object.key=key

                imageUrl.url = "//s3.amazonaws.com/crowdera/${key}"
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
            if (!file?.empty && file.size < 1024 * 1024 * 3) {
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
        def imageUrl = "//s3.amazonaws.com/crowdera/${key}"

        return imageUrl
    }*/

    def getorganizationIconUrl(CommonsMultipartFile iconFile) {
        if (!iconFile?.empty && iconFile.size < 1024 * 1024 * 3) {
            def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
            def awsSecretKey = "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"
            def bucketName = "crowdera"
            def folder = "project-icon"

            def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
            def s3Service = new RestS3Service(awsCredentials);
            def s3Bucket = new S3Bucket(bucketName)
        
            def tempFile = new File("${iconFile.getOriginalFilename()}")
            def key = "${folder}/${iconFile.getOriginalFilename()}"
            iconFile.transferTo(tempFile)
            def object = new S3Object(tempFile)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            tempFile.delete()
        
            def organizationIconUrl = "//s3.amazonaws.com/crowdera/${key}"
            return organizationIconUrl
        }
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
            
            if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
                
                if (VALID_IMG_TYPES.contains(imageFile.getContentType())) {
                    try{
                        def file= new File("${imageFile.getOriginalFilename()}")
                        def key = "${Folder}/${it.getOriginalFilename()}"
                        imageFile.transferTo(file)
                        def object=new S3Object(file)
                        object.key=key
                    
                        tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
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
	    def description = project.description
	    def story = project.story
	    def videoUrl = project.videoUrl
	    def imageUrls = project.imageUrl
        def isTeamExist = false
        def isCampaignBeneficiaryOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
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
				description:description,
	            videoUrl:videoUrl,
	            joiningDate: new Date()
            )
            if (isCampaignBeneficiaryOrAdmin) {
                team.validated = true
            } else {
                imageUrls.each { imageUrl ->
                    ImageUrl imgUrl = new ImageUrl()
                    imgUrl.url = imageUrl.url
                    imgUrl.save(failOnError: true)
                    team.addToImageUrl(imgUrl)
                }
            }
            project.addToTeams(team).save(failOnError: true)
            if (isCampaignBeneficiaryOrAdmin) {
                message= "You have successfully joined the team."
            } else {
                mandrillService.sendTeamInvitation(project, user)
                message= "Your request has been submitted for review and we'll get back to you within 24 hours."
            }
        } else {
            def isValidatedTeamExist = userService.isValidatedTeamExist(project, user)
            if (isValidatedTeamExist) {
                
                message = "You already have a team."
            } else {
                message = "Your request is yet to be validated."
            }
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
        service.date = new Date()

        service.save(failOnError: true)
        mandrillService.sendEmailToCustomer(service);
        return service
    }
    
    def setAttachments(CustomerService service, List<MultipartFile> files){
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)
        
        def Folder = "Attachments"
        
        def tempImageUrl
        files.each {
            def fileUrl = new ImageUrl()
            def attachedFile= it
            
            if (!attachedFile?.empty && attachedFile.size < 1024 * 1024 * 3) {
                try{
                    def file= new File("${attachedFile.getOriginalFilename()}")
                    def key = "${Folder}/${it.getOriginalFilename()}"
                    attachedFile.transferTo(file)
                    def object=new S3Object(file)
                    object.key=key
                
                    tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
                    s3Service.putObject(s3Bucket, object)
                    fileUrl.url = tempImageUrl
                    service.addToAttachments(fileUrl)
                    file.delete()
                } catch(IllegalStateException e){
                    e.printStackTrace()
                }
            }
        }
    }
    
    def getEnabledAndValidatedTeamsForCampaign(Project project) {
        def teams = Team.findAllWhere(project : project,enable:true, validated: true);
        return teams
    }
    
    def getTeamToBeValidated(def project) {
        def teams = Team.findAllWhere(project: project,validated: false)
        return teams
    }
    
    def getValidatedTeam(def project) {
        def teams = Team.findAllWhere(project: project,validated: true)
        return teams
    }
    
    def getDiscardedTeams(project) {
        def teams = Team.findAllWhere(project: project,validated: true, enable: false)
        return teams
    }
    
    def discardTeam(def params) {
        def project = Project.get(params.id);
        def team = Team.get(params.teamId)
        List imageUrls = team.imageUrl
        def i = imageUrls.size()
        for (int j=0; j< i; j++) {
            imageUrls[j] = null;
        }
        List teams = project.teams
        teams.remove(team)
        team.delete()
        return project
    }

    def getAllProjectByUser(User user){
      def projects= Project.findAllByUser(user)
	  List activeProjects=[]
	  List draftProjects=[]
	  List pendingProjects=[]
	  List endedProjects=[]
	  List sortedProjects
	  def finalList
	  projects.each{ project->
		  boolean ended = isProjectDeadlineCrossed(project)
		  if(ended) {
			  endedProjects.add(project)
		  }else{
		  	  if(project.validated==true && project.inactive==false){
			      activeProjects.add(project)
			  }
		  }
		  
		  if(project.draft==true){
			  draftProjects.add(project)
		  }
		  
		  if(project.inactive==false && project.validated==false && project.draft==false){
			  pendingProjects.add(project)
		  }
	  }
      sortedProjects =activeProjects.sort{contributionService.getPercentageContributionForProject(it)}
	  finalList = draftProjects.reverse()+ pendingProjects.reverse() + sortedProjects.reverse() + endedProjects.reverse()
	  
      return finalList
    }

    def getProjectAdminEmail(User user){
      def projectAdminEmail= ProjectAdmin.findAllByEmail(user.email)
      return projectAdminEmail
    }

    def getTeamByUserAndEnable(User user, def enable){
      def teams=Team.findAllWhere(user:user, enable: enable)
      return teams
    }
    
    def getAddress(def params){
        def address 
        def state
        def country
        if (params.addressLine1 !=null){
            if (params.state == "other") {
                state = params.otherstate
            } else {
                Map states = getState()
                state = states.getAt(params.state)
            }
            Map countries = getCountry()
            country = countries.getAt(params.country)
            if (params.addressLine2 == null || params.addressLine2.isAllWhitespace()){
                address = params.addressLine1 +" "+ params.city +"-"+ params.zip +" "+ state +" "+ country
            } else {
                address = params.addressLine1 +" "+params.addressLine2 +" "+ params.city +"-"+ params.zip +" "+ state +" "+ country
            }
        } else {
            address = null
        }
        
        return address
    }

    def getContibutionByUser(User user){
      def contributions = Contribution.findAllByUser(user)
      return contributions
    }

    def shareCampaignOrTeamByEmail(def params, def fundRaiser) {
        def project = Project.get(params.id)
        String emails = params.emails
        String name = params.name
        String message = params.message
        if(emails) {
            def emailList = emails.split(',')
            emailList = emailList.collect { it.trim() }
            mandrillService.shareProject(emailList, name, message, project, fundRaiser)
        }
        
        return project
    }

    def getShippingDetails(def contibutions){
      def shippingDetails=" "
      if(contibutions.email==null && contibutions.physicalAddress==null && contibutions.twitterHandle==null && contibutions.custom==null){         
          shippingDetails="No Perk Selected"
      }else{
        if(contibutions.email!=null){
          shippingDetails="Email: " +contibutions.email
          if(contibutions.physicalAddress!=null){
            shippingDetails+=" - Physical Address: " + contibutions.physicalAddress
          }
          if(contibutions.twitterHandle!=null){
            shippingDetails+=" - Twitter Handle: " + contibutions.twitterHandle
          }
          if(contibutions.custom!=null) {
            shippingDetails+=" - Custom: " + contibutions.custom
          }
        }
        if(contibutions.physicalAddress!=null){
          shippingDetails="Physical Address: " + contibutions.physicalAddress
          if(contibutions.twitterHandle!=null){
            shippingDetails+=" - Twitter Handle: " + contibutions.twitterHandle
          }
          if(contibutions.custom!=null) {
            shippingDetails+=" - Custom: " + contibutions.custom
          }
          if(contibutions.email!=null){
            shippingDetails+=" - Email: " +contibutions.email
          }
        }
        if(contibutions.twitterHandle!=null){
          shippingDetails ="Twitter Handle: " + contibutions.twitterHandle
          if(contibutions.physicalAddress!=null){
            shippingDetails+=" - Physical Address: " + contibutions.physicalAddress
          }
          if(contibutions.custom!=null) {
            shippingDetails+=" - Custom: " + contibutions.custom
          }
          if(contibutions.email!=null){
            shippingDetails+=" - Email: " +contibutions.email
          }
        }
        if(contibutions.custom!=null) {
          shippingDetails="Custom: " + contibutions.custom
          if(contibutions.physicalAddress!=null){
            shippingDetails+=" - Physical Address: " + contibutions.physicalAddress
          }
          if(contibutions.twitterHandle!=null) {
            shippingDetails+=" - Twitter Handle: " + contibutions.twitterHandle
          }
          if(contibutions.email!=null){
            shippingDetails+=" - Email: " +contibutions.email
          }     
        }
      }
      return shippingDetails      
    }
	
	def checkShippingDetail(def emailId, def twitter, def address, def custom){
		def emailid
		def tweet
		def add
		def cstm
		if(emailId=='null'){
			emailid=null
		}else{
		 	emailid=emailId
		}
		if(twitter =='null'){
			tweet=null
		}else{
			tweet=twitter
		}
		if(address=='null'){
			add=null
		}else{
			add=address
		}
		if(custom=='null'){
			cstm=null
		}else{
			cstm=custom
		}
		
		return ['emailid':emailid, 'twitter':tweet,'address':add,'custom':cstm]
		
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

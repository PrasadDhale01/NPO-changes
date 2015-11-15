package crowdera

import grails.transaction.Transactional
import java.security.MessageDigest
import java.text.DateFormat
import java.text.SimpleDateFormat

import javax.servlet.http.Cookie

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import org.jets3t.service.security.AWSCredentials
import org.jets3t.service.model.*
import grails.util.Environment

class ProjectService {
    def userService
    def contributionService
    def grailsLinkGenerator
    def imageFile
    def imageUrlService
    def mandrillService
    def rewardService
    def grailsApplication
    
    def getProjectById(def projectId){
        if (projectId) {
            return Project.get(projectId)
        }
    }

    def getImageUrlById(def imageId){
        if (imageId) {
            return ImageUrl.get(imageId)
        }
    }

    def getTeamById(def teamId){
        if (teamId) {
            return Team.get(teamId)
        }
    }

    def getTeamCommentById(def teamCommentId){
        if (teamCommentId) {
            return TeamComment.get(teamCommentId)
        }
    }

    def getTeamByUserAndProject(def project, def user){
        def team = Team.findByUserAndProject(user, project)
        return team
    }

    def getProjectAdminByEmail(def email){
        return ProjectAdmin.findByEmail(email)
    } 

    def getProjectCommentById(def commentId){
        if (commentId) {
            return ProjectComment.get(commentId)
        }
    }
    
    def getCurrentEnvironment() {
        return Environment.current.getName()
    }
    
    def getBankInfoByProject(Project project) {
        return BankInfo.findByProject(project)
    }

    def getProjectByParams(def projectParams){
         Project project = new Project(projectParams)
		 Beneficiary beneficiary = new Beneficiary();
         project.beneficiary = beneficiary
         project.category = "OTHER"
         project.created = new Date()
         User user = userService.getCurrentUser()
         project.user = user
         return project
    }

    def getListOfValidatedProjects() {
        List projects = Project.findAllWhere(validated: true)
        return projects
    }
    
    def getNumberOfEndedAndLiveCampaigns(List projects) {
        def totalProjects = projects.size();
        def LiveProjects = 0
        def endedProjects = 0
        projects.each { project->
            if (isProjectDeadlineCrossed(project)) {
                LiveProjects = LiveProjects + 1
            } else {
                endedProjects = endedProjects + 1
            }
        }
        return [LiveProjects : LiveProjects , endedProjects: endedProjects, totalProjects: totalProjects]
    }
    
    def getNumberOfMostSelectedCategoryAndCount(List projects) {
        int animals = 0, arts = 0, children = 0, community = 0, education = 0, elderly = 0, environment = 0, health = 0, social_innovation = 0, religion = 0, other= 0
        projects.each{ project->
            def category = project.category
            
            switch (category) {
                case 'ANIMALS':
                    animals = animals + 1
                    break;
                case 'ARTS':
                    arts = arts + 1
                    break;
                case 'CHILDREN':
                    children = children + 1
                    break;
                case 'COMMUNITY':
                    community = community + 1
                    break;
                case 'EDUCATION':
                    education = education + 1
                    break;
                case 'ELDERLY':
                    elderly = elderly + 1
                    break;
                case 'ENVIRONMENT':
                    environment = environment + 1
                    break;
                case 'HEALTH':
                    health = health + 1
                    break;
                case 'SOCIAL_INNOVATION':
                    social_innovation = social_innovation + 1
                    break;
                case 'RELIGION':
                    religion = religion + 1
                    break;
                case 'OTHER':
                    other = other + 1
                    break;
                default :
                    other = other + 1
            }
        }
        
        Map categories = ['Animals' : animals, 'Arts': arts, 'Children' : children, 'Community': community, 'Education' : education,'Elderly': elderly, 'Environment': environment,'Health': health, 'Social_innovation': social_innovation, 'Religion': religion,'Other': other]
        def mostSelectedCategory = categories.max { it.value }.key
        def mostSelectedCategoryCount = categories.max { it.value }.value
        return [mostSelectedCategory: mostSelectedCategory, mostSelectedCategoryCount: mostSelectedCategoryCount]
    }

    def getProjectUpdateDetails(def params, def project){
		def vanitytitle
        User currentUser = userService.getCurrentUser()
        def fullName = currentUser.firstName + ' ' + currentUser.lastName
        def currentEnv = Environment.current.getName()
        project.story = params.story
        if (project.draft) {
            project.paypalEmail = params.paypalEmail
            project.charitableId = params.charitableId
            project.organizationName = params.organizationName
        }
        
        if (!project.beneficiary.country) {
            if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
                project.beneficiary.country = 'IN'
            } else {
                project.beneficiary.country = 'US'
            }
        }
        
        def projectAdmins = project.projectAdmins
        
        projectAdmins.each { projectAdmin ->
            def email = projectAdmin.email
            if (currentUser.email != email) {
                mandrillService.sendUpdateEmailToAdmin(email, fullName, project)
            }
        }
        
        def projectOwner = project.user
        if (projectOwner != currentUser) {
            def projectOwnerEmail = projectOwner.getEmail()
            mandrillService.sendUpdateEmailToAdmin(projectOwnerEmail, fullName, project)
        }

        if (project.customVanityUrl && project.customVanityUrl != ''){
            vanitytitle = getCustomVanityUrl(project);
        } else {
            vanitytitle = vanityTitleOriginal(project)
            vanitytitle = (vanitytitle) ? vanitytitle : getProjectVanityTitle(project)
        }
        project.save();
        return vanitytitle
    }

    def vanityTitleOriginal (Project project){
        String vanitytitle
        def title = project.title.trim().replaceAll("[^a-zA-Z0-9]", "-")
        def vanityTitleList = VanityTitle.findAllWhere(title:title)
        if (vanityTitleList){
            vanityTitleList.each{
                if (it.project == project)
                    vanitytitle = it.vanityTitle
            }
        }
        return vanitytitle
    }

    def getCSVDetails(def params, def response){
        List contributions=[]

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

        response.setHeader("Content-disposition", "attachment; filename= Crowdera_report-"+project.title.replaceAll("[,;\\s]",'_')+".csv")
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
                def rows = [it.project.title.replaceAll("[,;]",' '), fundRaiserName, it.date.format('YYYY:MM:dd HH:mm:ss'), contributorName, contributorEmail, it.reward.title.replaceAll("[,;]",' '), shippingDetails.replaceAll("[,]",' '), it.amount, payMode]
                results << rows
                shippingDetails=""
            } else {
                def rows = [it.project.title.replaceAll("[,;]",' '), fundRaiserName, it.date.format('YYYY:MM:dd HH:mm:ss'), contributorName, contributorEmail, it.amount, payMode]
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
        if(!project.validated){
            project.validated = true
            mandrillService.sendValidationEmailToOWnerAndAdmins(project)
        }
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

     def getEditedFundraiserDetails(def params, def team){
         def user = userService.getCurrentUser()
         def project = Project.get(params.project)
         def amount = Double.parseDouble(params.amount)
         if(amount <= project.amount){
             team.amount = amount
         }
         
         def video
         if (params.videoUrl) {
            def youtube = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
            def vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
            def match = params.videoUrl.matches(youtube);
            def vimeomatch = params.videoUrl.matches(vimeo);
            if (match && !params.videoUrl.contains('embed')) {
                String videoUrl = params.videoUrl.replace("watch?v=","embed/")
                videoUrl = videoUrl + "?rel=0"
                video = videoUrl
            } else if (vimeomatch){
                video = params.videoUrl
            }
         }
         team.videoUrl = video
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
         def contribution = contributionService.getContributionById(params.long('id'))
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
	 
	 def getEmailDetails(def params){
		 def project = Project.get(params.id)
		 def fundraiser = User.get(params.long('fr'))
		 String emails = params.emails
		 String name = params.name
		 String message = params.message

		 def emailList = emails.split(',')
		 emailList = emailList.collect { it.trim() }

		 mandrillService.shareContribution(emailList, name, message,project,fundraiser)
	 }

	def getTwitterShareUrlForCampaign(Project project, def fundraiser, def base_url){
		def vanityTitle = getVanityTitleFromId(project.id)
		def vanityUserName = userService.getVanityNameFromUsername(fundraiser.username, project.id)
		def url = base_url+'/campaigns/'+vanityTitle+'/'+vanityUserName
		return url
	}

    def getUserContributionDetails(Project project,Reward reward, def amount,String transactionId,User users,User fundraiser,def params, def address, def request){
        def emailId, twitter,custom, userId,anonymous 
        def currency
        if (project.payuEmail) {
            currency = 'INR'
            emailId = request.getParameter('shippingEmail')
            twitter =request.getParameter('shippingTwitter')
            custom =  request.getParameter('shippingCustom')
            userId = request.getParameter('tempValue')
            anonymous = request.getParameter('anonymous')
        } else {
            currency = 'USD'
            emailId = request.getParameter('shippingEmail')
            twitter = request.getParameter('twitterHandle')
            custom = request.getParameter('shippingCustom')
            userId = request.getParameter('tempValue')
            anonymous = request.getParameter('anonymous')
        }
        def shippingDetail=checkShippingDetail(emailId,twitter,address, custom)
        def name
        def username
 
        if (userId == null || userId == 'null' || userId.isAllWhitespace()) {
            if (project.paypalEmail){
                name = request.getParameter('name')      
                username = request.getParameter('email')
            } else if (project.payuEmail){
                name = request.getParameter('name')
                username = request.getParameter('email')
            } else {
                name = params.billToFirstName + " " +params.billToLastName
                username = params.billToEmail
            }
        } else {
            def orgUser = User.get(userId)
            name = orgUser.firstName + " " + orgUser.lastName
            username = orgUser.email
        }
 
        Contribution contribution = new Contribution(
            date: new Date(),
            user: users,
            reward: reward,
            amount: amount,
            email: shippingDetail.emailid,
            twitterHandle: shippingDetail.twitter,
            custom: shippingDetail.custom,
            contributorName: name,
            contributorEmail:username,
            physicalAddress: shippingDetail.address,
            currency : currency
        )
        project.addToContributions(contribution).save(failOnError: true)
		 
        Team team = Team.findByUserAndProject(fundraiser,project)
        if (team) {
            contribution.fundRaiser = fundraiser.username
            team.addToContributions(contribution).save(failOnError: true)
        }
		 
        contribution.isAnonymous = anonymous.toBoolean()
        
        if (project.payuStatus && project.contributions.size() == 1) {
            mandrillService.sendEmailToCampaignOwner(project, contribution) //Send Email to Campaign Owner when first contribution is done for INR
        }
		 
        userService.contributionEmailToOwnerOrTeam(fundraiser, project, contribution)
        
        def totalContribution = contributionService.getTotalContributionForProject(project)
        if(totalContribution >= project.amount){
            if(project.send_mail == false){
                def contributor = contributionService.getTotalContributors(project)
                contributor.each {
                    def user = User.get(it)
                    if (user.email != 'anonymous@example.com'){
                        mandrillService.sendContributorEmail(user, project)
                    }
                }
                def beneficiaryId = getBeneficiaryId(project)
                def beneficiary = Beneficiary.get(beneficiaryId)
                def user = User.list()
                user.each{
                   if(it.email == beneficiary.email){
                       mandrillService.sendBeneficiaryEmail(it)
                   }
                }
                project.send_mail = true
             }
         }
		 
         Transaction transaction = new Transaction(
             transactionId:transactionId,
             user:users,
             project:project,
             contribution:contribution,
             currency : currency
         )
         transaction.save(failOnError: true)
         return contribution.id
     }
     
     def getpayKeytempObject(def timestamp){
         PaykeyTemp paykeytemp = PaykeyTemp.findByTimestamp(timestamp)
         return paykeytemp
     }
	 
	 def generateCSV(def response, def params){
             SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY:MM:dd hh:mm:ss");
			 def userIdentity
			 def mode
             def contributions
             if (params.currency == 'INR'){
                 contributions = contributionService.getINRContributions()
             } else {
                 contributions = contributionService.getUSDContributions()
             }
             List results=[]
	     
		 response.setHeader("Content-disposition", "attachment; filename=Crowdera_Transaction_Report.csv")
		 contributions.each{
			if (it.isAnonymous) {
				userIdentity = "Anonymous"
			} else {
				userIdentity = "Non Anonymous"
			}

            if(it.isContributionOffline){
                mode = 'Offline'
            } else {
                mode = 'Online'
            }

			def rows = [dateFormat.format(it.date), it.project.title.replaceAll('[,;] ',' '), it.contributorName, userIdentity, it.amount, it.contributorEmail, mode]
			results << rows
		 }
		 
		 def result='Contribution Date & Time, Campaign, Contributor Name, Identity, Contributed Amount, Contributor Email, Mode \n'
		 results.each{ row->
			row.each{
			col -> result+=col +','
			}
			result = result[0..-2]
			result+="\n"
		 }
		 
		 return result
	 }
	 
	 def getOfflineDetails(def params){
		 def project = Project.get(params.id)
		 def user = User.findByUsername('anonymous@example.com')
		 def reward = rewardService.getNoReward()
		 def fundRaiser = userService.getCurrentUser()
		 def username = fundRaiser.username
		 def amount = params.amount1
		 def contributorName = params.contributorName1
                 def currency
                 if (project.payuEmail) {
                     currency = 'INR'
                 } else {
                     currency = 'USD'
                 }
		 if (amount && contributorName) {
			 Contribution contribution = new Contribution(
				 date: new Date(),
				 user: user,
				 reward: reward,
				 amount: amount,
				 contributorName: contributorName,
				 isContributionOffline: true,
				 fundRaiser: username,
                                 currency:currency
			 )
			 project.addToContributions(contribution).save(failOnError: true)
 
			 if(project.teams) {
				 Team team = Team.findByUserAndProject(fundRaiser,project)
				 if (team) {
					 team.addToContributions(contribution).save(failOnError: true)
				 }
			 }
		 }
	 }

     def getCommentDeletedDetails(def params){
         def project = Project.get(params.projectId)
         def fundraiser = params.fr
         def fundRaiser = userService.getUserByUsername(fundraiser)
         Team team = getTeamByUserAndProject(project, fundRaiser)
         if (team && params.teamCommentId) {
             def teamcomment = TeamComment.get(params.long('teamCommentId'))
             if (teamcomment) {
                 List teamComments = team.comments
                 teamComments.remove(teamcomment)
                 teamcomment.delete()
             }
         }
         if (project && params.commentId){
             def projectcomment= ProjectComment.get(params.long('commentId'))
             if (projectcomment) {
                 List projectComments = project.comments
                 projectComments.remove(projectcomment)
                 projectcomment.delete()
             }
         }
    }
	
	def getContributionEditedDetails(def params){
		def contribution = Contribution.get(params.long('id'))
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
    
    def getProjectUpdateById(def projectUpdateId) {
        def projectUpdate = ProjectUpdate.get(projectUpdateId)
        return projectUpdate
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
	
	def getRecipientOfFunds() {
	    def recipientOfFunds = [
            'PERSON':'Person',
			'NON-PROFIT':'Non-Profit',
			'NGO':'NGO',
			'OTHER':'Other'   	    
		]
		return recipientOfFunds
	}
	
	def getRecipientOfFundsIndo(){
		def RecipientOfIndia = [
			'INDIVIDUAL': 'Individual',
			'NGO': 'Indian NGO',
			'OTHER': 'Other'
		]
		return RecipientOfIndia
	}
	
	def getInDays() {
		def inDays = [
			    THI:'30',
				SIX:'60',
				NIN:'90'  
			]
		return inDays
	}
	
    def getPayment(){
        def payment = [
            PAY:'Paypal',
            FIR:'FirstGiving',
        ]
        return payment
    }
	
	def getIndiaPaymentGateway() {
		def payment = [
			PAYU:'PayUMoney',
		]
		return payment
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
	
	def getIndianState() {
		def state = [
			AP  :   'Andhra Pradesh',
			AR  :   'Arunachal Pradesh',
			AS  :   'Assam',
			BR  :   'Bihar',
			CG  :   'Chattisgarh',
			CH  :	'Chandigarh',
			DL	:	'Delhi',
			GA  :   'Goa',
			GJ  :   'Gujarat',
			HR  :   'Haryana',
			HP  :   'Himachal Pradesh',
			JK  :   'Jammu and Kashmir',
			JH  :   'Jharkhand',
			KA  :   'Karnataka',
			KL  :   'Kerala',
			MP  :   'Madhya Pradesh',
			MH  :   'Maharashtra',
			MN  :   'Manipur',
			ML  :   'Meghalaya',
			MZ  :   'Mizoram',
			NL  :   'Nagaland',
			OR  :   'Orissa',
			PB  :   'Punjab',
			RJ  :   'Rajasthan',
			SK  :   'Sikkim',
			TN  :   'Tamil Nadu',
			TL  :   'Telangana',
			TR  :   'Tripura',
			UK  :   'Uttarakhand',
			UP  :   'Uttar Pradesh',
			WB  :   'West Bengal',
			other:  'Other'
		]
		return state
	}
	
	def getSorts(){
		def sortsOptions = [
			Live_Campaigns: "Latest",
			Ending_Soon: "Ending Soon",
			Successful_Campaigns:"Most Funded",
			Ended_Campaign:"Ended",
			OFFERING_PERKS:"Offering Perks"
		]
		return sortsOptions
	}
	
    def isCampaignsorts(def sorts ,def currentEnv) {
        List projects = getValidatedProjects(currentEnv)
        List p = []
        if(sorts == 'Most-Funded') {
            projects.each {
                def percentage = contributionService.getPercentageContributionForProject(it)
                if(percentage >= 100){
                    p.add(it)
                }
            }
        }
        if(sorts == 'Latest') {
            projects.each {project ->
                boolean ended = isProjectDeadlineCrossed(project)
                if(project.validated && ended ==false){
                    p.add(project)
                }
            }
        }
        if(sorts == 'Ending-Soon') {
            projects.each {
                def day = getRemainingDay(it)
                if(day > 0 && day <10){
                    p.add(it)
                }
            }
        }
        if(sorts=='Ended'){
            projects.each{
                boolean ended_campaigns = isProjectDeadlineCrossed(it)
                if(ended_campaigns){
                    p.add(it)
                }
            }
        }
        if(sorts=='Offering-Perks'){
            projects.each{
                def  perkSize = it.rewards.size()
                if(perkSize > 1){
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
        def firstAdmin = projectadmins[0]
        def secondAdmin = projectadmins[1]
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
			(Project.Category.CIVIC_NEEDS): "Civic Needs",
            (Project.Category.EDUCATION): "Education",
            (Project.Category.ELDERLY): "Elderly",
            (Project.Category.ENVIRONMENT): "Environment",
			(Project.Category.FILM): "Film",
            (Project.Category.HEALTH): "Health",
			(Project.Category.NON_PROFITS):"Non Profits",
            (Project.Category.SOCIAL_INNOVATION): "Social Innovation",
            (Project.Category.RELIGION): "Religion",
            (Project.Category.OTHER): "Other"
        ]
        return categoryOptions
    }
	
	def getIndiaCategoryList() {
		def categoryOptions = [
			(Project.Category.ANIMALS): "Animals",
			(Project.Category.ARTS): "Arts",
			(Project.Category.CHILDREN): "Children",
			(Project.Category.COMMUNITY): "Community",
			(Project.Category.CIVIC_NEEDS): "Civic Needs",
			(Project.Category.EDUCATION): "Education",
			(Project.Category.ELDERLY): "Elderly",
			(Project.Category.ENVIRONMENT): "Environment",
			(Project.Category.FILM): "Film",
			(Project.Category.HEALTH): "Health",
			(Project.Category.SOCIAL_INNOVATION): "Social Innovation",
			(Project.Category.RELIGION): "Religion",
			(Project.Category.OTHER): "Other"
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
		   CIVIC_NEEDS: "Civic Needs",
		   EDUCATION: "Education",
		   ELDERLY: "Elderly",
		   ENVIRONMENT: "Environment",
		   FILM: "Film",
		   HEALTH: "Health",
		   NON_PROFITS:"Non Profits",
		   SOCIAL_INNOVATION: "Social Innovation",
		   RELIGION: "Religion",
		   OTHER: "Other"
	   ]
	   return categoryOptions
   }
   def getIndiaCategory(){
	   def categoryOptions = [
		   ALL: "All Categories",
		   ANIMALS: "Animals",
		   ARTS: "Arts",
		   CHILDREN: "Children",
		   COMMUNITY: "Community",
		   CIVIC_NEEDS: "Civic Needs",
		   EDUCATION: "Education",
		   ELDERLY: "Elderly",
		   ENVIRONMENT: "Environment",
		   FILM: "Film",
		   HEALTH: "Health",
		   SOCIAL_INNOVATION: "Social Innovation",
		   RELIGION: "Religion",
		   OTHER: "Other"
	   ]
	   return categoryOptions
	}
   
	def getDiscoverTopCategory(){
		def categoryOptions = [
			PASSION: "PASSION",
			IMPACT: "IMPACT",
			SOCIAL_GOODS: "Social_Good",
			PERSONAL_NEEDS: "Personal_Needs"
		]
		return categoryOptions
	}
    
    def getValidatedProjects() {
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
	
    def getValidatedProjects(def currentEnv) {
        def popularProjectsList = getPopularProjects()
        def finalList
        List endedProjects = []
        List openProjects = []
        List sortedProjects = []
		List indiaOpenCampaign = []
		List usOpenCampaign = []
		List indiaEndedCampaign = []
		List usEndedCampaign = []
		List sortIndiaCampaign = []
		List sortUsCampaign = []
        if (currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
            finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
            finalList.each { project ->
                boolean ended = isProjectDeadlineCrossed(project)
                if(ended) {
					(project.payuStatus) ? indiaEndedCampaign.add(project) : usEndedCampaign.add(project)
                } else {
                    (project.payuStatus) ? indiaOpenCampaign.add(project) : usOpenCampaign.add(project)
                }
            }
			sortIndiaCampaign = indiaOpenCampaign.sort {contributionService.getPercentageContributionForProject(it)}
			sortUsCampaign = usOpenCampaign.sort {contributionService.getPercentageContributionForProject(it)}
			finalList = sortIndiaCampaign.reverse() + sortUsCampaign.reverse() + indiaEndedCampaign.reverse() + usEndedCampaign.reverse()
        } else {
            finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false, payuStatus: false) - popularProjectsList)
            finalList.each { project ->
                boolean ended = isProjectDeadlineCrossed(project)
                if(ended) {
                    endedProjects.add(project)
                } else {
                    openProjects.add(project)
                }
            }
        sortedProjects = openProjects.sort {contributionService.getPercentageContributionForProject(it)}
        finalList =  sortedProjects.reverse() + endedProjects.reverse()
        }
        return finalList
    }

    def isPayuProject(Project project){
		if(project.payuStatus==true){
			return true
		}else{
		   return false
		}
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
		def popularProjectsList = getPopularProjects()
		def finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
		return finalList
	}
	
    def showProjects(def currentEnv){
        /* Logic to fetch the latest comes first out of the validated projects.*/
        //TO DO
        /* Later on the criteria will be modified in order to display the admin selected projects as the popular projects*/
        List finalList = []
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
            def popularProjectsList = getPopularProjects()
            finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
        } else {
            def popularProjectsList = getPopularProjects()
            finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false, payuStatus:false) - popularProjectsList)
        }
        List subFinalList = []
        if (finalList.size() > 3) {
            subFinalList = finalList.subList(0, 3)
        } else {
            subFinalList = finalList
        }
        return subFinalList
    }

	def projectOnHomePage() {
		def currentEnv = Environment.current.getName()
		def projects
		if (currentEnv == 'staging' || currentEnv == 'production')
		   projects = Project.getAll('2c9f84884d094bf3014dbc5347da000d', '2c9f84884e76f7ff014e83e539d50001', '2c9f84884fc22f8b014fe7788be40003')
		else
		   projects = Project.getAll('2c9f84884d094bf3014dbc5347da000d', '2c9f84884e76f7ff014e83e539d50001', '2c9f8f3b4feeeee0014fefed7fae0001')
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
	
    def getProjects(def projects, def projectAdmins, def fundRaisers, def environment) {
        def list = []
        List listIndAdmins = []
        List listUsAdmins = []
        List listIndTeams = []
        List listUsTeams = []
        if(environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia'){
            projects.each {
                if(it.inactive == false) {
                    list.add(it)
                }
            }
            projectAdmins.each {
                def project = Project.findById(it.projectId)
                if(project.inactive == false) {
                    (project.payuStatus) ? listIndAdmins.add(project) : listUsAdmins.add(project)
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
                if (!isProjectexist) {
                    if (project.inactive == false) {
                        (project.payuStatus) ? listIndTeams.add(project) : listUsTeams.add(project)
                    }
                }
            }
			list = list + listIndAdmins + listUsAdmins + listIndTeams + listUsTeams
        } else{
            projects.each {
                if(it.inactive == false && it.payuStatus==false) {
                   list.add(it)
                }
            }

            projectAdmins.each {
                def project = Project.findById(it.projectId)
                if(project.inactive == false && project.payuStatus==false) {
                    list.add(project)
                }
            }

            fundRaisers.each { fundRaiser ->
                def project = fundRaiser.project
                def isProjectexist = false
                list.each {
                    if (project == it && project.payuStatus==false) {
                        isProjectexist = true
                    }
                }
                if(!isProjectexist) {
                    if(project.inactive == false && project.payuStatus==false) {
                       list.add(project)
                    }
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
	
    def getNonValidatedProjects(currentEnv) {
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
            return Project.findAllWhere(validated: false, inactive: false, draft: false, rejected: false, payuStatus:true)
        } else {
            return Project.findAllWhere(validated: false, inactive: false, draft: false, rejected: false, payuStatus:false)
        }
    }

    def search(String query, def currentEnv) {
        List result = []
        List project = getValidatedProjects(currentEnv)
        project.each { 
            if( it.title.toLowerCase().contains(query.toLowerCase()) || it.description.toLowerCase().contains(query.toLowerCase()) ){
                result.add(it)
            } else if (it.story){
                if (it.story.toLowerCase().contains(query.toLowerCase()))
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
		}else if (category.equalsIgnoreCase('CIVIC_NEEDS')){
		    return '//s3.amazonaws.com/crowdera/assets/civic-category-img.jpg'
		}  else if (category.equalsIgnoreCase('EDUCATION')) {
		    return '//s3.amazonaws.com/crowdera/assets/education.jpg'
		} else if (category.equalsIgnoreCase('ELDERLY')) {
		    return '//s3.amazonaws.com/crowdera/assets/elderly.jpg'
		} else if (category.equalsIgnoreCase('ENVIRONMENT')) {
		    return '//s3.amazonaws.com/crowdera/assets/environment.jpg'
		} else if (category.equalsIgnoreCase('FILM')) {
		    return '//s3.amazonaws.com/crowdera/assets/film-category-img.jpg'
		}else if (category.equalsIgnoreCase('HEALTH')){
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
            def vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
            def vimeomatch = vidUrl.matches(vimeo);
            def vurl
            if(match){
                vurl=vidUrl.replace("watch?v=", "embed/");
                imageUrls.add(vurl)     
            } else if (vimeomatch){
                vurl = vidUrl.replace("https://vimeo.com/", "https://player.vimeo.com/video/");
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
            } else if (project.image) {
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
            def vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
            def vimeomatch = teamVideoUrl.matches(vimeo);
            def vurl
            if(match){
               vurl=teamVideoUrl.replace("watch?v=", "embed/");
               imageUrls.add(vurl)     
            } else if (vimeomatch){
               vurl = teamVideoUrl.replace("https://vimeo.com/", "https://player.vimeo.com/video/");
               imageUrls.add(vurl)     
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
    
    def getMultipleImageUrls(CommonsMultipartFile imageFile, Project project){
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)

        def Folder = "project-images"

        def tempImageUrl
        def imageUrl = new ImageUrl()
        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            try{
                def file= new File("${imageFile.getOriginalFilename()}")
                def key = "${Folder}/${imageFile.getOriginalFilename()}"
                key = key.toLowerCase()
                imageFile.transferTo(file)
                def object=new S3Object(file)
                object.key=key

                tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
                s3Service.putObject(s3Bucket, object)
                imageUrl.url = tempImageUrl
                imageUrl.save()
                project.addToImageUrl(imageUrl)
                file.delete()
            }catch(Exception e) {
                log.error("Error: " + e);
            }
        }
        return ['filelink':tempImageUrl, 'imageId':imageUrl.id]
    }
	
    def getMultipleImageUrlsForTeam(CommonsMultipartFile imageFile, Team team){
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)

        def Folder = "project-images"

        def tempImageUrl
        def imageUrl = new ImageUrl()
        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            try{
                def file= new File("${imageFile.getOriginalFilename()}")
                def key = "${Folder}/${imageFile.getOriginalFilename()}"
                key = key.toLowerCase()
                imageFile.transferTo(file)
                def object=new S3Object(file)
                object.key=key

                tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
                s3Service.putObject(s3Bucket, object)
                imageUrl.url = tempImageUrl
                imageUrl.save()

                team.addToImageUrl(imageUrl)
                file.delete()
            } catch(IllegalStateException e){
                 log.error("Error: " + e) 
            }
        }
        return ['filelink':tempImageUrl, 'imageId':imageUrl.id]
    }
    
    def getContributedAmount (Transaction transaction){
	    def contribution = transaction.contribution
	    return contribution.amount.round()
    }
    
    def getUpdatedImageUrls(def imageUrls, ProjectUpdate projectUpdate){
        def imageUrlList = imageUrls.split(',')
        imageUrlList = imageUrlList.collect { it.trim() }
        imageUrlList.each {
            if (!it.isAllWhitespace()){
                def imageUrl = new ImageUrl()
                imageUrl.url = it
                imageUrl.save()
                projectUpdate.addToImageUrls(imageUrl)
            }
        }
    }
    
    def getSavedImageUrl(CommonsMultipartFile imageFile) {
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)
        def Folder = "project-images"

        def tempImageUrl

        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            def file= new File("${imageFile.getOriginalFilename()}")
            def key = "${Folder}/${imageFile.getOriginalFilename()}"
            key = key.toLowerCase()
            imageFile.transferTo(file)
            def object=new S3Object(file)
            object.key=key

            tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
            s3Service.putObject(s3Bucket, object)
            file.delete()
        }

        return tempImageUrl
    }
    
    def getUpdatEditImageUrls(CommonsMultipartFile imageFile, ProjectUpdate projectUpdate){
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)
        def Folder = "project-images"

        def tempImageUrl
        def imageUrl = new ImageUrl()

        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            def file= new File("${imageFile.getOriginalFilename()}")
            def key = "${Folder}/${imageFile.getOriginalFilename()}"
            key = key.toLowerCase()
            imageFile.transferTo(file)
            def object=new S3Object(file)
            object.key=key

            tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
            imageUrl.url = tempImageUrl
            s3Service.putObject(s3Bucket, object)
            imageUrl.save()
            projectUpdate.addToImageUrls(imageUrl).save()
            file.delete()
        }

        return ['filelink':tempImageUrl, 'imageId':imageUrl.id]
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

    def getorganizationIconUrl(CommonsMultipartFile iconFile, Project project) {
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
            key = key.toLowerCase()
            iconFile.transferTo(tempFile)
            def object = new S3Object(tempFile)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            tempFile.delete()
        
            def organizationIconUrl = "//s3.amazonaws.com/crowdera/${key}"
            project.organizationIconUrl = organizationIconUrl
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
                        key = key.toLowerCase()
                        imageFile.transferTo(file)
                        def object=new S3Object(file)
                        object.key=key
                    
                        tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
                        s3Service.putObject(s3Bucket, object)
                        imageUrl.url = tempImageUrl
                        project.addToImageUrl(imageUrl)
                        file.delete()
                    }catch(IllegalStateException e){
                        log.error("Error: " + e) 
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
        if ((getProjectEndDate(project)) > (Calendar.instance)) {
            day =(getProjectEndDate(project) - Calendar.instance)
        }
        else {
            day = 0
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
    
    def filterByCategory(def categories, def currentEnv){
        def projects = getValidatedProjects(currentEnv)
        List list =[]
        if (categories == "All" || categories=="Country"){
            return projects
        } else {
			projects.each{
				String str = it.category
				String strSocialCategory = it.usedFor
				String strNonProfit = "NON_PROFITS"
				String strSocialGood = "Social_Innovation"
				Map countries = getCountry()
				String strCountryCategory = countries.getAt(it.beneficiary.country)
				
				if (str.equalsIgnoreCase(categories)){
					if(strSocialGood.equalsIgnoreCase(categories.replace("Innovation","Needs")) && strSocialCategory !=null){
						String strSocialNeeds = strSocialGood.replace("Innovation","Needs")
						if(strSocialCategory.equalsIgnoreCase(strSocialNeeds.replace('-','_'))){
							list.add(it)
						}
				 	}
					list.add(it)
				}else if(strNonProfit.equalsIgnoreCase(categories)){
					String strNonProfitCat = it.fundsRecievedBy
					if(strNonProfitCat !=null && strNonProfitCat.equalsIgnoreCase(categories.replace('_','-'))){
						list.add(it)
					}
				}else if(strCountryCategory !=null && strCountryCategory.equalsIgnoreCase(categories.replace('-',' '))){
					list.add(it)
				}else if(strSocialCategory !=null){
				 	if(strSocialGood.equalsIgnoreCase(categories) && strSocialCategory !=null){
						 String strSocialNeeds = strSocialGood.replace("Innovation","Needs")
						 if(strSocialCategory.equalsIgnoreCase(strSocialNeeds.replace('-','_'))){
							 list.add(it)
						 }
				 	}else if(strSocialCategory !=null && strSocialCategory.equalsIgnoreCase(categories.replace('-', '_'))){
					 	list.add(it)
				 	}
				}else{
					return null
				}
			}
			return list
        }
    }
    
    def getFundRaisersForTeam(Project project, User user) {
        def teams = project.teams
	    def amount = project.amount
	    def description = project.description
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
                message= "You're simply awesome! Now lets wait for the Campaign Owner to validate your Team Request."
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
	
	def getCrewRequest(def params, def resumeUrl){
		CrewReg crewrequest = new CrewReg()
		crewrequest.firstName = params.firstName
		crewrequest.lastName = params.lastName
		crewrequest.email = params.email
		crewrequest.phone = params.phone
		crewrequest.letterDescription = params.letterDescriptions
		crewrequest.crewDescription = params.crewDescriptions
		crewrequest.linkedIn = params.linkedIn
		crewrequest.faceBook = params.faceBook
		crewrequest.resumeUrl = resumeUrl
		crewrequest.requestDate = new Date()
		crewrequest.adminDate = new Date()
		
		crewrequest.save(failOnError: true)
		mandrillService.sendEmailToCrew(crewrequest)
	}
	
    def setResume(CommonsMultipartFile resume, def params) {
        if (!resume?.empty && resume.size < 1024 * 1024 * 3) {
            def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
            def awsSecretKey = "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"
            def bucketName = "crowdera"
            def folder = "Attachments"

            def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
            def s3Service = new RestS3Service(awsCredentials);
            def s3Bucket = new S3Bucket(bucketName)

            def tempFile = new File("${resume.getOriginalFilename()}")
            def key = "${folder}/${resume.getOriginalFilename()}"
            key = key.toLowerCase()
            resume.transferTo(tempFile)
            def object = new S3Object(tempFile)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            tempFile.delete()

            def resumeUrl = "//s3.amazonaws.com/crowdera/${key}"
            getCrewRequest(params, resumeUrl)
        }
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
                    key = key.toLowerCase()
                    attachedFile.transferTo(file)
                    def object=new S3Object(file)
                    object.key=key
                
                    tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
                    s3Service.putObject(s3Bucket, object)
                    fileUrl.url = tempImageUrl
                    service.addToAttachments(fileUrl)
                    file.delete()
                } catch(IllegalStateException e){
                     log.error("Error: " + e)
                }
            }
        }
    }
    
    def getEnabledAndValidatedTeamsForCampaign(Project project, def params) {
        List teams = Team.findAllWhere(project : project,enable:true, validated: true);
        List teamList = []
        def max = Math.min(params.int('max') ?: 6, 100)
        def offset = params.int('teamOffset') ? params.int('teamOffset') : 0
        def count = teams.size()
        def maxrange

        if(offset + max <= count) {
            maxrange = offset + max
        } else {
            maxrange = offset + (count - offset)
        }
        teamList = teams.subList(offset, maxrange)
        return [teamList: teamList, maxrange: maxrange, teams: teams]
    }
    
    def getTeamToBeValidated(def project) {
        def teams = Team.findAllWhere(project: project,validated: false)
        return teams
    }
    
    def getValidatedTeam(def project, def params) {
        List teams = Team.findAllWhere(project: project,validated: true)
        List teamList = []
        def max = Math.min(params.int('max') ?: 8, 100)
        def offset = params.int('teamOffset') ? params.int('teamOffset') : 0
        def count = teams.size()
        def maxrange

        if(offset + max <= count) {
            maxrange = offset + max
        } else {
            maxrange = offset + (count - offset)
        }
        teamList = teams.subList(offset, maxrange)
        return [teamList: teamList, maxrange: maxrange, teams: teams]
    }
    
    def getValidatedTeamForCampaign(Project project) {
        List teams = []
        teams = Team.findAllWhere(project: project , validated: true)
        return teams
    }
    
    def getDiscardedTeams(project) {
        def teams = Team.findAllWhere(project: project,validated: true, enable: false)
        return teams
    }
    
    def getEnabledTeam(project) {
        def teams = Team.findAllWhere(project: project,validated: true, enable: true)
        return teams
    }
    
    def discardTeam(def params) {
        def project = Project.get(params.id);
        def team = Team.get(params.long('teamId'))
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
		  } else if(project.draft==true){
			  draftProjects.add(project)
		  } else if(project.inactive==false && project.validated==false && project.draft==false){
			  pendingProjects.add(project)
		  } else{
		  	  if(project.validated==true && project.inactive==false){
			      activeProjects.add(project)
			  }
		  }
	  }
      sortedProjects =activeProjects.sort{contributionService.getPercentageContributionForProject(it)}
	  finalList = draftProjects.reverse()+ pendingProjects.reverse() + sortedProjects.reverse() + endedProjects.reverse()
	  
      return finalList
    }
	
    def getAllProjectByUser(User user, def environment){
        List activeProjects=[]
        List draftProjects=[]
        List pendingProjects=[]
        List endedProjects=[]
        List sortedProjects = []
        List draftIndiaProjects = [] 
        List draftUsProjects = []
        List pendingIndiaProjects = []
        List pendingUsProjects = []
        List endedIndiaProjects = []
        List endedUsProjects = []
        List sortedIndiaProjects = []
        List sortedUsProjects = []
        List activeIndiaProjects = []
        List activeUsProjects = []
        def finalList
        
        if(environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia'){
            def projects= Project.findAllWhere(user:user)
            projects.each { project->
                boolean ended = isProjectDeadlineCrossed(project)
                if(project.draft==true){
                    (project.payuStatus) ? draftIndiaProjects.add(project) : draftUsProjects.add(project)
                } else if(project.inactive==false && project.validated==false && project.draft==false){
                    (project.payuStatus) ? pendingIndiaProjects.add(project) : pendingUsProjects.add(project)
                } else if (ended) {
                    (project.payuStatus) ? endedIndiaProjects.add(project) : endedUsProjects.add(project)
                } else if(project.validated==true && project.inactive==false){
                    (project.payuStatus) ? activeIndiaProjects.add(project) : activeUsProjects.add(project)
                }
            }

            sortedIndiaProjects = activeIndiaProjects.sort{contributionService.getPercentageContributionForProject(it)}
            sortedUsProjects = activeUsProjects.sort{contributionService.getPercentageContributionForProject(it)}
            finalList = draftIndiaProjects.reverse() + draftUsProjects.reverse() + pendingIndiaProjects.reverse() + pendingUsProjects.reverse() + sortedIndiaProjects.reverse() + sortedUsProjects.reverse() + endedIndiaProjects.reverse() + endedUsProjects.reverse()
        } else{
            def projects= Project.findAllWhere(user:user,payuStatus: false)
            projects.each { project->
                boolean ended = isProjectDeadlineCrossed(project)
                if(project.draft==true) {
                    draftProjects.add(project)
                } else if(project.inactive==false && project.validated==false && project.draft==false){
                    pendingProjects.add(project)
                } else if(ended){
                    endedProjects.add(project)
                } else if(project.payuEmail==null && project.validated==true){
                    activeProjects.add(project)
                }
            }
            sortedProjects =activeProjects.sort{contributionService.getPercentageContributionForProject(it)}
            finalList = draftProjects.reverse()+ pendingProjects.reverse() + sortedProjects.reverse() + endedProjects.reverse() 
        }
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
	
	def getAddress(def params, def currentEnv ){
		def address
		def state
		def country
		if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
			if (params.addressLine1 !=null){
				if (params.state == "other") {
					state = params.otherstate
				} else {
					Map states = getIndianState()
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
		} else{
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
			}
		}
		
		return address
	}

    def getContibutionByUser(User user){
        def contributions = Contribution.findAllByUser(user)
        return contributions
    }
	
    def getContibutionByUser(User user,def environment){
        def contributions = Contribution.findAllByUser(user)
        List payuContributions=[]
        List otherContributions=[]
        contributions.each{
            if(it.project.payuStatus==true && it.project.payuEmail!=null){
                payuContributions.add(it)
            } else if(it.project.payuStatus==false){
                otherContributions.add(it)
            }
        }
        if(environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia'){
            return payuContributions
        } else {
            return otherContributions
        }
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
        project.gmailShareCount = project.gmailShareCount + 1
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
    
    def editCampaignUpdates(def params, def project) {
        ProjectUpdate projectUpdate = getProjectUpdateById(params.long('id'))
        def story = params.story
        
        boolean isCampaignUpdated = false
        if(projectUpdate) {
            
            if (!story.isAllWhitespace()) {
                if (projectUpdate.story != story) {
                    projectUpdate.story = story
                    isCampaignUpdated = true
                }
            } else {
                if (!projectUpdate.imageUrls.isEmpty()) {
                    projectUpdate.story = params.story
                    isCampaignUpdated = true
                }
            }
            
            if (projectUpdate.title != params.title) {
                projectUpdate.title = params.title
                isCampaignUpdated = true
            }
            
            if (isCampaignUpdated) {
                projectUpdate.save();
                
            } else if (projectUpdate.imageUrls.isEmpty() && story.isAllWhitespace()) {
                if (projectUpdate.story == null || projectUpdate.story.isAllWhitespace()) {
                    List projectUpdates = project.projectUpdates
                    projectUpdates.remove(projectUpdate)
                    projectUpdate.delete()
                }
            }
        }
    }
	
    def getProjectVanityTitle(Project project) {
        def projectTitle = project.title.trim()
        def title = projectTitle.replaceAll("[^a-zA-Z0-9]", "-")
        def list = VanityTitle.list()
        List result = []
        def vanitytitle
        list.each{
            if (it.title.equalsIgnoreCase(title)) {
                result.add(it)
            }
        }

        if (result.isEmpty()){
			vanitytitle = title
        }else{
            vanitytitle = title+"-"+result.size()
        }

        new VanityTitle(
            project:project,
            projectTitle:title,
            vanityTitle:vanitytitle,
            title:title
        ).save(failOnError: true)

        return vanitytitle
    }
	
    def getCustomVanityUrl(Project project){
        def projectCustomVanity = project.customVanityUrl.trim()
        def title = projectCustomVanity.replaceAll("[^a-zA-Z0-9]", "-")
        def result = VanityTitle.findByVanityTitle(title)

        if (!result){
            new VanityTitle(
               project:project,
               projectTitle:title,
               vanityTitle:title,
               title:title
            ).save(failOnError: true)
        }

        return title
    }

    def getVanityTitleFromId(def projectId){
        def vanity_title
        def project = Project.get(projectId)
		def title
        if(project){
            def status = false
            if (project.customVanityUrl){
                VanityTitle vanitytitle = VanityTitle.findByVanityTitle(project.customVanityUrl.trim())
                title = (vanitytitle) ? project.customVanityUrl.trim() : project.title.trim()
            } else {
                title = project.title.trim()
            }
            vanity_title= title.replaceAll("[^a-zA-Z0-9]", "-")
            def vanity = VanityTitle.findAllWhere(project:project)
            vanity.each{
                if (it.title.equals(vanity_title)){
                    status = true
                    vanity_title = it.vanityTitle
                }
            }
            if (!status)
                vanity_title = getProjectVanityTitle(project)
        }
        return vanity_title
    }

    def getProjectIdFromVanityTitle(def title){
        def projectId
        def vanitytitle = VanityTitle.findByVanityTitle(title)
        if (vanitytitle)
            projectId = vanitytitle.project.id

        return projectId
    }

    def getProjectFromVanityTitle(def title){
        def projectId
        def vanitytitle = VanityTitle.findByVanityTitle(title)
        if (vanitytitle)
            projectId = vanitytitle.project.id

        def project = Project.get(projectId)
        return project
    }
    
    def getCampaignShareUrl(Project project) {
        def base_url = grailsApplication.config.crowdera.BASE_URL
        List vanityTitles = VanityTitle.findAllWhere(project:project)
        def url
        def vanityTitle
        if (vanityTitles.isEmpty()) {
            vanityTitle = getVanityTitleFromId(project.id)
        } else {
            def vanity = vanityTitles.last() 
            vanityTitle = vanity.vanityTitle
        }
        def vanityUserName
        List vanityUserNames = VanityUsername.findAllWhere(user : project.user)
        if (vanityUserNames.isEmpty()) {
            vanityUserName = userService.getProjectVanityUsername(project.user)
        } else {
            def vanity = vanityUserNames.last()
            vanityUserName = vanity.vanityUsername
        }
        url = base_url+'/campaigns/'+ vanityTitle +'/'+ vanityUserName
        return url
    }
	
    def getYoutubeUrlChanged(String video, Project project){
       def youtube = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
       def vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
       def match = video.matches(youtube);
       def vimeomatch = video.matches(vimeo)
        if (match && !video.contains('embed')) {
            String videoUrl = video.replace("watch?v=","embed/")
            videoUrl = videoUrl + "?rel=0"
			project.videoUrl = videoUrl
        } else if (vimeomatch){
		    project.videoUrl = video
		}
    }
    
    def setContributorsComment(Project project,def comment,User fundRaiser,Contribution contribution) {
        User user = contribution.user
        def contributorName = contribution.contributorName
        TeamComment teamComment
        ProjectComment projectComment
        if (project.user == fundRaiser) {
            projectComment = new ProjectComment(
                comment: comment,
                userName: contributorName,
                user: user,
                project: project,
                date: new Date()).save(failOnError: true)
        } else {
            Team team = Team.findByUserAndProject(fundRaiser,project)
            if (team) {
                teamComment = new TeamComment(
                    comment: comment,
                    userName: contributorName,
                    user: user,
                    team: team,
                    date: new Date()).save(failOnError: true)
            }
        }
        return [projectComment: projectComment, teamComment:teamComment]
    }
	
    def getRedactorImageUrl(CommonsMultipartFile imageFile) {
        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
            def awsSecretKey = "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"
            def bucketName = "crowdera"
            def folder = "textEditor-Image"

            def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
            def s3Service = new RestS3Service(awsCredentials);
            def s3Bucket = new S3Bucket(bucketName)

            def tempFile = new File("${imageFile.getOriginalFilename()}")
            def key = "${folder}/${imageFile.getOriginalFilename()}"
            key = key.toLowerCase()
            imageFile.transferTo(tempFile)
            def object = new S3Object(tempFile)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            tempFile.delete()

            def redactorImageUrl = "//s3.amazonaws.com/crowdera/${key}"
            return redactorImageUrl
        }
    }

    def deleteContributorsComment(def projectComment,def teamComment,def project, def team) {
        if (project && projectComment) {
            List projectComments = project.comments
            projectComments.remove(projectComment)
            projectComment.delete()
        }
        if (team && teamComment) {
            List teamComments = team.comments
            teamComments.remove(teamComment)
            teamComment.delete()
        }
    }
    
    def getProjectComments(Project project) {
        List comments = ProjectComment.findAllWhere(project: project, status: false)
        return comments.reverse()
    }
    
    def getTeamComments(Team team) {
        List comments = TeamComment.findAllWhere(team: team)
        return comments.reverse()
    }
	def getProjectAdminEmailList(Project project) {
		List emailList = []
		project.projectAdmins.each { projectAdmin ->
			emailList.add(projectAdmin.email)
		}
		emailList.add(project.user.email)
		return emailList
	}

	
	/*******************Generate HASH for payu*********************/
	String generateHash(String type, String hashstring){
		byte[] hashseq=hashstring.getBytes();
		StringBuffer hexString = new StringBuffer();
		try{
			MessageDigest algorithm = MessageDigest.getInstance(type);
			algorithm.reset();
			algorithm.update(hashseq);
			byte[] messageDigest = algorithm.digest();
			for (int i=0;i<messageDigest.length;i++) {
				String hex=Integer.toHexString(0xFF & messageDigest[i]);
				if(hex.length()==1) hexString.append("0");
				hexString.append(hex);
			}
		}catch(Exception nsae){
		    log.errorEnabled = "Unable to generate Hash String : "+nsae
		}
		return hexString.toString();
	}
	
	/****************Generate unique transaction Id for payu*********************/
	def generateTransId(){
		Random rand = new Random();
		String rndm = Integer.toString(rand.nextInt())+(System.currentTimeMillis() / 1000L);
		def txnid=generateHash("SHA-256",rndm).substring(0,20);
		return txnid
	}
	
	def getProjectContributions(def params, Project project) {
		List totalContributions = []
		List contributions = []
		def max = Math.min(params.int('max') ?: 12, 100)
		def offset = params.int('offset') ?: 0
		totalContributions = project.contributions.reverse();
		def count = totalContributions.size()
		def maxrange
		
		if(offset+max <= count) {
			maxrange = offset+max
		} else {
			maxrange = offset + (count - offset)
		}
		
		contributions = totalContributions.subList(offset, maxrange)
		return [totalContributions: totalContributions,contributions: contributions]
	}
	
	def getTeamContributions(def params, Team currentTeam) {
		List totalContributions = []
		List contributions = []
		if (currentTeam) {
		    def max = Math.min(params.int('max') ?: 12, 100)
		    def offset = params.int('offset') ?: 0
		    totalContributions = currentTeam.contributions.reverse();
		    def count = totalContributions.size()
		    def maxrange
		
		    if(offset+max <= count) {
			    maxrange = offset+max
		    } else {
			    maxrange = offset + (count - offset)
		    }
		
	     	contributions = totalContributions.subList(offset, maxrange)
		    return [totalContributions: totalContributions,contributions: contributions]
		}
	}
	
    def autoSaveProjectDetails(def variable, def varValue, def projectId){
        Project project = Project.get(projectId);
        User user = userService.getCurrentUser()
        Beneficiary beneficiary = project.beneficiary;
        def isValueChanged = false; 
        switch (variable) {
            case 'category':
                project.category = varValue;
                isValueChanged = true;
                break;

            case 'country':
                beneficiary.country = varValue;
                isValueChanged = true;
                break;

            case 'videoUrl':
                project.videoUrl = (varValue.isAllWhitespace()) ? null : varValue;
                if (project.videoUrl){
                    if (project.videoUrl.contains('embed')) {
                        isValueChanged = true;
                        break;
                    } else {
                        getYoutubeUrlChanged(project.videoUrl, project)
                        isValueChanged = true;
                        break;
                    }
                }

            case 'email1':
                getFirstAdminForProjects(varValue, project, user)
                isValueChanged = true;
                break;
	
            case 'email2':
                getSecondAdminForProjects(varValue, project, user)
                isValueChanged = true;
                break;
	
            case 'email3':
                getThirdAdminForProjects(varValue, project, user)
                isValueChanged = true;
                break;

            case 'days':
                project.days = varValue;
                isValueChanged = true;
                break;
				
            case 'organizationname':
                project.organizationName = varValue;
                isValueChanged = true;
                break;
	
            case 'webAddress':
                project.webAddress = varValue;
                isValueChanged = true;
                break;
	
            case 'telephone':
                beneficiary.telephone = varValue;
                isValueChanged = true;
                break;
	
            case 'paypalEmailId':
                project.paypalEmail = varValue;
                project.charitableId = null;
                isValueChanged = true;
                break;
			
            case 'payuEmail':
                project.payuEmail = varValue;
                isValueChanged = true;
                break;

            case 'charitableId':
                project.charitableId = varValue;
                isValueChanged = true;
                project.paypalEmail = null;
                break;
	
            case 'story':
                project.story = varValue;
                isValueChanged = true;
                break;
				
            case 'usedFor':
                project.usedFor = varValue;
                isValueChanged = true;
                break;
	
            case 'fundsRecievedBy':
                project.fundsRecievedBy = varValue;
                isValueChanged = true;
                break;

            case 'secretKey':
                project.secretKey = varValue;
                isValueChanged = true;
                break;
               
            case 'facebookUrl':
                beneficiary.facebookUrl = varValue;
                isValueChanged = true;
                break;
               
            case 'twitterUrl':
                beneficiary.twitterUrl = varValue;
                isValueChanged = true;
                break;
               
            case 'linkedinUrl':
                beneficiary.linkedinUrl = varValue;
                isValueChanged = true;
                break;
				
			case 'name':
				beneficiary.firstName = varValue;
				isValueChanged = true;
				break;
				
			case 'amount':
				project.amount = Double.parseDouble(varValue);
				isValueChanged = true;
				break;
	
			case 'campaignTitle':
				project.title = varValue;
				isValueChanged = true;
				break;

			case 'descarea':
				project.description = varValue;
				isValueChanged = true;
				break;

			case 'customVanityUrl':
			    project.customVanityUrl = (varValue == '') ? null : varValue;
				isValueChanged = true;
				break;

            case 'city':
                if (!varValue.isAllWhitespace()){
                    beneficiary.city = varValue;
                    isValueChanged = true;
                }
                break;

            default :
               isValueChanged = false;
 
        }

        if (isValueChanged){
            project.save();
        }
    }
	
    def getFirstAdminForProjects(String adminEmail, Project project, User user) {
        def fullName = user.firstName + ' ' + user.lastName
        List projectAdmins = project.projectAdmins
        ProjectAdmin projectAdmin = ProjectAdmin.findByProjectAndAdminCount(project, 1)
        if (adminEmail) {
            mandrillService.inviteAdmin(adminEmail, fullName, project)
            if (projectAdmin){
                projectAdmin.email = adminEmail
                projectAdmin.save()
            } else {
                projectAdmin = new ProjectAdmin()
                projectAdmin.email = adminEmail
                projectAdmin.adminCount = 1
                project.addToProjectAdmins(projectAdmin)
            }
        } else if ((adminEmail == '' || adminEmail == null) && projectAdmin) {
                projectAdmins.remove(projectAdmin);
                projectAdmin.delete()
         }
    }

    def getSecondAdminForProjects(String adminEmail, Project project, User user) {
        def fullName = user.firstName + ' ' + user.lastName
        List projectAdmins = project.projectAdmins
		ProjectAdmin projectAdmin = ProjectAdmin.findByProjectAndAdminCount(project, 2)
        if (adminEmail) {
            mandrillService.inviteAdmin(adminEmail, fullName, project)
            if (projectAdmin){
                projectAdmin.email = adminEmail
                projectAdmin.save()
            } else {
                projectAdmin = new ProjectAdmin()
                projectAdmin.email = adminEmail
                projectAdmin.adminCount = 2
                project.addToProjectAdmins(projectAdmin)
            } 
        } else if ((adminEmail == '' || adminEmail == null) && projectAdmin){
                projectAdmins.remove(projectAdmin);
                projectAdmin.delete()
        }
    }

    def getThirdAdminForProjects(String adminEmail, Project project, User user) {
        def fullName = user.firstName + ' ' + user.lastName
        List projectAdmins = project.projectAdmins
		ProjectAdmin projectAdmin = ProjectAdmin.findByProjectAndAdminCount(project, 3)
        if (adminEmail) {
            mandrillService.inviteAdmin(adminEmail, fullName, project)
            if (projectAdmin){
                projectAdmin.email = adminEmail
                projectAdmin.save()
           } else {
                projectAdmin = new ProjectAdmin()
                projectAdmin.email = adminEmail
                projectAdmin.adminCount = 3
                project.addToProjectAdmins(projectAdmin)
             }
         } else if ((adminEmail == '' || adminEmail == null) && projectAdmin) {
                projectAdmins.remove(projectAdmin);
                projectAdmin.delete()
         }
     }
	
	def getAdminEmail(Project project){
		List admins = project.projectAdmins
		def email1
		def email2
		def email3
		admins.each{
			if (it.adminCount == 1){
				email1 = it.email
			}
			if (it.adminCount == 2){
				email2 = it.email
			}
			if (it.adminCount == 3){
				email3 = it.email
			}
		}
		
		return ['email1':email1, 'email2':email2, 'email3':email3]
		
	}
    
    def getPayuInfo(def params, def base_url) {
        def currentEnv = Environment.current.getName()
        def project = Project.get(params.campaignId)
        def user = User.get(params.userId)
        def reward = Reward.get(params.rewardId)

        User fundraiser = User.findByUsername(params.fr)
        def address = getAddress(params, currentEnv)
        if (user == null){
            user = userService.getUserByUsername('anonymous@example.com')
        }
        
        def key = grailsApplication.config.crowdera.PAYU.KEY
        def salt = grailsApplication.config.crowdera.PAYU.SALT
        def amount = params.amount
        def firstname =  params.firstname
        def email = params.email
        def productinfo = params.productinfo
        def surl = base_url + "/fund/payureturn?projectId=${project.id}&rewardId=${reward.id}&amount=${params.amount}&result=true&userId=${user.id}&fundraiser=${fundraiser.id}&physicalAddress=${address}&shippingCustom=${params.shippingCustom}&shippingEmail=${params.shippingEmail}&shippingTwitter=${params.twitterHandle}&name=${params.firstname} ${params.lastname}&email=${params.email}&anonymous=${params.anonymous}&projectTitle=${params.projectTitle}"

        def furl = base_url + "/error"
        def txnid = generateTransId()
        String hashstring = key + "|" + txnid + "|" + amount + "|" + productinfo + "|" + firstname + "|" + email + "|||||||||||" + salt;
        def hash = generateHash("SHA-512",hashstring)

        return [txnid:txnid, hash:hash, furl:furl, surl:surl]
    }

    def setCookie(def requestUrl) {
        Cookie cookie = new Cookie("requestUrl", requestUrl)
        cookie.path = '/'
        cookie.maxAge= 0
        return cookie
    }
	
	def setRequestUrlCookie(def requestUrl){
		Cookie cookie = new Cookie("requestUrl", requestUrl)
		cookie.path = '/'
		cookie.maxAge= 3600
		return cookie
	}

    def setLoginSignUpCookie() {
        Cookie cookie = new Cookie("loginSignUpCookie", 'createCampaignloginSignUpActive')
        cookie.path = '/'
        cookie.maxAge= 3600
        return cookie
    }

	def setCampaignNameCookie(def title){
		Cookie cookie = new Cookie("campaignNameCookie", title)
		cookie.path = '/'
		cookie.maxAge= 3600
		return cookie
	}

	def setFundingAmountCookie(def amount){
		Cookie cookie = new Cookie("fundingAmountCookie", amount.round().toString())
		cookie.path = '/'
		cookie.maxAge= 3600
		return cookie
	}

    def setContributorName(def contributorName){
        Cookie cookie = new Cookie("contributorNameCookie", contributorName)
        cookie.path = '/'
        cookie.maxAge= 3600
        return cookie
    }
	
	def setContributorEmailCookie(def contributorEmail){
		Cookie cookie = new Cookie("contributorEmailCookie", contributorEmail)
		cookie.path = '/'
		cookie.maxAge= 3600
		return cookie
	}
	
	def deleteContributorEmailCookie(def contributorEmail){
		Cookie cookie = new Cookie("contributorEmailCookie", contributorEmail)
		cookie.path = '/'
		cookie.maxAge= 0
		return cookie
	}

	def deleteContributorName(def contributorName){
        Cookie cookie = new Cookie("contributorNameCookie", contributorName)
        cookie.path = '/'
        cookie.maxAge= 0
        return cookie
    }

	def deleteCampaignNameCookie(def campaignNameCookieValue){
		Cookie cookie = new Cookie("campaignNameCookie", campaignNameCookieValue)
		cookie.path = '/'
		cookie.maxAge= 0
		return cookie
	}

	def deleteFundingAmountCookie(def fundingAmountCookieValue){
		Cookie cookie = new Cookie("fundingAmountCookie", fundingAmountCookieValue)
		cookie.path = '/'
		cookie.maxAge= 0
		return cookie
	}

    def deleteLoginSignUpCookie() {
        Cookie cookie = new Cookie("loginSignUpCookie", 'createCampaignloginSignUpActive')
        cookie.path = '/'
        cookie.maxAge= 0
        return cookie
    }
    
    def getProjectList(def params) {
        List totalCampaigns = []
        List projects = []
        def max = Math.min(params.int('max') ?: 12, 100)
        def offset = params.int('offset') ?: 0
        totalCampaigns = Project.findAllWhere(validated: true)
        totalCampaigns = totalCampaigns?.sort{it.title}
        
        def count = totalCampaigns.size()
        def maxrange
        
        if(offset+max <= count) {
            maxrange = offset + max
        } else {
            maxrange = offset + (count - offset)
        }
        
        projects = totalCampaigns.subList(offset, maxrange)
        return [totalCampaigns: totalCampaigns, projects: projects]
    }
    
    def getCampaignBySearchQuery(def params) {
        List totalCampaigns = []
        List projects = []
        List result = []
        def query = params.searchValue
        def max = Math.min(params.int('max') ?: 12, 100)
        def offset = params.int('offset') ?: 0
        totalCampaigns = Project.findAllWhere(validated: true)
        totalCampaigns.each {
            if( it.title.toLowerCase().contains(query.toLowerCase()) ){
                result.add(it)
            }
        }
        
        result = result?.sort{it.title}
        def count = result.size()
        def maxrange
        if (count > 0 && params.searchValue) {
            if(offset+max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            projects = result.subList(offset, maxrange)
            return [totalCampaigns: result, projects: projects]
        } else {
            count = totalCampaigns.size()
            totalCampaigns = totalCampaigns?.sort{it.title}
            if(offset+max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            projects = totalCampaigns.subList(offset, maxrange)
            def message = 'No campaign found'
            return [totalCampaigns: totalCampaigns, projects: projects, message: message]
        }
        
    }
    
    def getCampaignSupporterCount(Project project) {
        return project.supporters.size()
    }
    
    def ContributorNameCookie(contributorEmail){
		Cookie cookie = new Cookie("contributorEmail", contributorEmail)
		cookie.path = '/'    // Save Cookie to local path to access it throughout the domain
		cookie.maxAge= 3600  //Cookie expire time in seconds
	}

    def isCustomUrUnique(def vanityUrl, def projectId){
        List title = VanityTitle.list()
        Project project = Project.get(projectId)
        def status = true
        title.each {
            if (it.vanityTitle.equalsIgnoreCase(vanityUrl)){
                if (it.project != project)
                    status = false
            }
        }
        return status
    }
	
	def getShippingInfo(def params){
		def shippingInfo
		def twitter, custom, address, email
		if (params.twitterField){
			twitter = params.twitterField
		} else {
			twitter = null
		}

		if(params.customField && params.customField != ''){
			custom = params.customField
		} else {
			custom = null
		}

		if(params.emailField){
			email = params.emailField
		} else {
			email = null
		}

		if(params.addr1){  
			address = params.addr1

		if (params.addr2 && params.addr2 != '' && params.addr2 != 'null'){
			address = address + " " + params.addr2
		}

		address = address + " " + params.cityField + "-" + params.zipField
		Map countries = getCountry()
		if (params.otherField && params.stateField == 'other'){
			address = address+ " " + params.otherField + " " + countries.getAt(params.countryField)
		} else {
			Map states = getState()
			address = address + " " + states.getAt(params.stateField) + " " + countries.getAt(params.countryField)
		}
	} else {
		address = null
	}
		
	shippingInfo = [twitter:twitter, custom:custom, address:address, email:email]
	return shippingInfo
	}

    def generateCSVReportForCampaign(def response, Project project, def ytViewCount, def linkedinCount, def twitterCount, def facebookCount){

        def numberOfContributions = project.contributions.size()
        def percentageContribution = contributionService.getPercentageContributionForProject(project)
        def numberOFPerks = (project.rewards.size() > 1) ? project.rewards.size() : 0
        def maxSelectedPerkAmount = rewardService.getMostSelectedPerkAmountForCampaign(project)
        def numberOfTeams = getValidatedTeamForCampaign(project)
        def disabledTeams = getDiscardedTeams(project)
        def highestContribution = contributionService.getHighestContributionDay(project)
        def campaignSupporterCount = getCampaignSupporterCount(project)
        def usedFor = (project.usedFor) ? project.usedFor : 'IMPACT'
        
        List results = []
        
        def rows = [project.title.replaceAll("[,;]",' '), project.amount.round(), usedFor, numberOfContributions, percentageContribution, numberOFPerks, maxSelectedPerkAmount , project.comments.size() , project.projectUpdates.size(), numberOfTeams.size(), disabledTeams.size(), ytViewCount, highestContribution.highestContributionDay, highestContribution.highestContributionHour,facebookCount, twitterCount ,linkedinCount, project.gmailShareCount, campaignSupporterCount]
        results << rows
        def result
        response.setHeader("Content-disposition", "attachment; filename= Crowdera_report-"+project.title.replaceAll("[,;\\s]",'_')+".csv")
        result = 'CAMPAIGN, CAMPAIGN GOAL, RAISED FUND FOR, TOTAL NUMBER OF CONTRIBUTIONS , PERCENTAGE GOAL RAISED, NUMBER OF PERKS OFFERED, MOST SELECTED PERK AMOUNT, Total NUMBER OF COMMENTS, TOTAL NUMBER OF UPDATES, TOTAL NUMBER OF ENABLED TEAMS, TOTAL NUMBER OF DISABLED TEAMS, NUMBER OF VIDEO VIEWERS, HIGHEST CONTRIBUTION DAY, HIGHEST CONTRIBUTION HOUR, FACEBOOK SHARE COUNT, TWITTER SHARE COUNT, LINKEDIN SHARE COUNT, EMAIL SHARE COUNT, TOTAL NUMBER OF SUPPORTERS, \n'
        results.each{ row->
            row.each{
                col -> result+=col +','
            }
            result = result[0..-2]
            result+="\n"
        }
        return result
    }

    def sendEmailTONonUserContributors() {
        def contributionList = Contribution.list()
        List nonUserContributors = []
        List contributorsEmail = []
        def user
        contributionList.each {
           if (!contributorsEmail.contains(it.contributorEmail)) {
               user = User.findByEmail(it.contributorEmail)
               if (!user){
                   contributorsEmail.add(it.contributorEmail)
                   nonUserContributors.add(it)
               }
           }
       }
       mandrillService.sendEmailToNonUserContributors(nonUserContributors)
    }
    
    def getUsersPaginatedCampaigns(List projects, def params, def max) {
        List totalCampaigns = []
        if (!projects.isEmpty()) {
            def offset = params.int('offset') ?: 0

            def count = projects.size()
            def maxrange

            if(offset+max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }

            totalCampaigns = projects.subList(offset, maxrange)
        }
        return totalCampaigns
    }

    def getPaginatedContibutionByUser(User user,def environment, def params, def max) {
        List contributions = getContibutionByUser(user, environment)
        List totalContributions = []
        if (!contributions.isEmpty()) {
            def offset = params.int('offset') ?: 0

            def count = contributions.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            totalContributions = contributions.reverse().subList(offset, maxrange)
        }
        return [totalContributions: totalContributions, contributions: contributions]
    }
	
    def getShortenUrl(def projectId, def user_name){
        def username
        def code
        if (projectId){
            if (user_name){
                username = userService.getUsernameFromVanityName(user_name)
                if (!username){
                    Project project = Project.get(projectId)
                    username = project.user.username
                }
            } else {
                Project project = Project.get(projectId)
                username = project.user.username
            }

            def urlShortener = UrlShortener.findByProjectIdAndUsername(projectId, username)
            if (urlShortener){
                code = urlShortener.shortenUrl
            } else {
                code = getAlphaNumbericRandomUrl()
                new UrlShortener(
                    shortenUrl: code,
                    projectId: projectId,
                    username : username
                ).save(failOnError:true)
            }
        }
        return code
    }

    def getAlphaNumbericRandomUrl() {
        String chars = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        int numberOfCodes = 0;//controls the length of alpha numberic string
        String code = "";
        while (numberOfCodes < 8) {
            char c = chars.charAt((int) (Math.random() * chars.length()));
            code += c;
            numberOfCodes++;
        }
        return code;
    }

    def getCampaignFromUrl(url){
        def projectId
        def vanityTitle
        def username
        def vanityName
        def details
        def urlShortener = UrlShortener.findByShortenUrl(url)
        if (urlShortener){
            projectId = urlShortener.projectId
            username = urlShortener.username
            if (projectId){
                vanityTitle = getVanityTitleFromId(projectId)
            }
            if (username){
                vanityName = userService.getVanityNameFromUsername(username, projectId)
            }
        }

        details = [projectTitle:vanityTitle, fr:vanityName]
        return details
    }
    
    def getCurrencyConverter() {
        Currency currency = userService.getCurrencyById();
        if (currency) {
            return currency.dollar.round();
        } else {
            return 65;
        }
    }
    
    def getContributedAmount(List contributions) {
        double amount = 0;
        contributions.each{ contribution ->
            amount = amount + contribution.amount
        }
        return amount
    }

    def getTotalFundRaisedByUser(List projects) {
        double amount = 0;
        def conversionMultiplier = getCurrencyConverter();
        def currentEnv = getCurrentEnvironment()
        projects.each { project ->
            def contributedAmount = contributionService.getTotalContributionForProject(project)
            if (currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
                if(project.payuStatus) {
                    amount = amount + contributedAmount 
                } else {
                    amount = amount + (contributedAmount * conversionMultiplier)
                }
            } else {
                amount = amount + contributedAmount
            }
        }
        return amount;
    }
	
    def getSpendMatrixSaved(def params){
		Project project = Project.get(params.projectId)
		def saveCount = Integer.parseInt(params.savingCount)
		def amount = Double.parseDouble(params.amount)
		SpendMatrix spendMatrix = SpendMatrix.findByNumberAvailableAndProject(saveCount, project)
		if (spendMatrix) {
            def isValueChanged = false

            if (amount && amount != ' '){
				spendMatrix.amount = amount
				isValueChanged = true
			}

			if (params.cause && params.cause != ' '){
				spendMatrix.cause = params.cause
				isValueChanged = true
			}

			if (isValueChanged){
				spendMatrix.save(failOnError: true);
			}

		} else {
            SpendMatrix spend = new SpendMatrix(
               project:project,
               amount : amount,
               cause : params.cause,
               numberAvailable : saveCount
            ).save(failOnError:true);
		}
	}
	
    def getSpendMatrixDeleted(def params){
        Project project = Project.get(params.projectId)
		def deleteCount = Integer.parseInt(params.deleteCount)
        SpendMatrix spendMatrix = SpendMatrix.findByNumberAvailableAndProject(deleteCount, project)
        if (spendMatrix){
			spendMatrix.delete();
        }
    }

    def getPieList(Project project) {
        List pieValueWithPer = [];
        def spendMatrixs = project.spend;
		def pieListCount = 0;
		List sublist1 = [];
		sublist1.add("'"+'Goal'+"'");
		sublist1.add(project.amount.round());
		pieValueWithPer.add(sublist1);
		def cause
        spendMatrixs.each{ spendMatrix ->
			pieListCount++;
			List sublist = [];
			cause = "'"+spendMatrix.cause+"'"
            sublist.add(cause);
            def percentage = (spendMatrix.amount / project.amount) * 100;
            sublist.add(percentage.round());
			if (pieListCount == 1){
				sublist.add("'"+'blue'+"'")
			}
            pieValueWithPer.add(sublist);
        }
		return pieValueWithPer;
    }
	
	def getFundsRecieveVal(def fundsRecievedBy, def currentEnv){
		Map reciever = (currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') ? getRecipientOfFundsIndo() : getRecipientOfFunds()
		return reciever.getAt(fundsRecievedBy)
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

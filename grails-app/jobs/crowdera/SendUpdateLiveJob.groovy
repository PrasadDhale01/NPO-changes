package crowdera

class SendUpdateLiveJob {
    def projectService
    def mandrillService
    
    static triggers = {
    }
    
    def execute(context) {
        def id = (long)context.mergedJobDataMap.get('id')
        
        ProjectUpdate projectUpdate = ProjectUpdate.get(id)
        
        boolean isIntimationRequired = context.mergedJobDataMap.get('isIntimationRequired')
        
        if (projectUpdate) {
            Project project = projectUpdate.project
            User user = project.user
			def country_code = project.country.countryCode
			
            if (isIntimationRequired == true || isIntimationRequired == 'true') {
                mandrillService.sendIntimationEmailToCampaignOwner(project, projectUpdate, user,country_code)
            } else {
                projectUpdate.islive = true
                projectUpdate.save()
                mandrillService.sendUpdateEmailsToContributors(project, projectUpdate, user, projectUpdate.title)
            }
            
        }
    }
}

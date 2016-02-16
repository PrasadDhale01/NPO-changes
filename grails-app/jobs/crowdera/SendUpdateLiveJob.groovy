package crowdera

class SendUpdateLiveJob {
    def projectService
    def mandrillService
    
    static triggers = {
    }
    
    def execute(context) {
        def id = (long)context.mergedJobDataMap.get('id')
        
        ProjectUpdate projectUpdate = ProjectUpdate.get(id)
        if (projectUpdate) {
            Project project = projectUpdate.project
            User user = project.user
            projectUpdate.islive = true
            projectUpdate.save()
            mandrillService.sendUpdateEmailsToContributors(project,projectUpdate,user, projectUpdate.title)
        }
    }
}

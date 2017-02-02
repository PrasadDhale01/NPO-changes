package crowdera

class UpdateTeamListJob {
	
	def projectService
	
    static triggers = {
      simple name = "UpdateTeamList", startDelay: 60000, repeatInterval: 3600000  // execute job once in 1 hour
    }

    def execute() {
		println "Exceutted every 1hr"
		ProjectService.allTeams.clear()
		
		def projects = projectService.getValidatedProjectsByPercentage("in")//projectService.getValidatedProjects(currentEnv)
		for(Project project : projects) {
			projectService.getTeamList(project, "allTeams");         // if static array list is empty then it first fetch from database
		}
    }
	
}

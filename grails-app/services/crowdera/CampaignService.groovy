package crowdera

import java.util.List;

import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.Session
import org.hibernate.SessionFactory
/*Merging Master branch changes*/
class CampaignService {
    
    def contributionService
    def projectService
    
    SessionFactory sessionFactory;
    
    public List<Project> getValidatedProjectsForCampaignAdmin(String condition, boolean payuStatus) {
        
        def raised = 0;
        def daysleft = 0;
        List<Project> projectList = new ArrayList<>();
        List<Project> activeProjectList = new ArrayList<>();
        List<Project> endedProjectList = new ArrayList<>();
        boolean isCampaignEnded = false;
        
        def criteria = Project.createCriteria();
        
        def result = criteria.list {
            resultTransformer(org.hibernate.transform.Transformers.ALIAS_TO_ENTITY_MAP)
            createAlias('user', 'user')
            projections {
                property('id', 'id')
                property('title', 'title')
                property('amount', 'amount')
                property('description', 'description')
                property('user.username', 'username')
                property('days', 'days')
                property('created', 'created')
            }
            switch (condition) {
                case 'Pending':
                    eq("validated", false)
                    eq("draft", false)
                    eq("rejected", false)
                    eq("inactive", false)
                    break;
                case 'Homepage' || 'Deadline' || 'Current' || 'Ended':
                    eq("validated", true)
                    eq("draft", false)
                    eq("rejected", false)
                    eq("inactive", false)
                    break;
                case 'Draft':
                    eq("draft", true)
                    eq("rejected", false)
                    eq("inactive", false)
                    break;
                case 'Rejected':
                    eq("rejected", false)
                    break;
                default :
                   break;
            }
            eq("payuStatus", payuStatus)
            
        }
        
        if (condition == 'Current' || condition == 'Ended' || condition=="Homepage" || condition=='Deadline') {
            
            result.each { project ->
                raised = Contribution.createCriteria().get {
                    createAlias('project', 'project')
                    projections {
                        sum "amount"
                    }
                    eq("project.id", project.id)
                }
                
                if (project.days > (Calendar.instance - project.created.toCalendar()) ) {
                    daysleft = project.days - (Calendar.instance - project.created.toCalendar());
                    activeProjectList.add(project);
                } else {
                    daysleft =  0;
                    isCampaignEnded = true;
                    endedProjectList.add(project);
                }
                project["daysleft"] = daysleft;
                project["raised"] = raised;
                project["isCampaignEnded"] = isCampaignEnded;
                projectList.add(project);
            }
            
            switch (condition) {
                case 'Current':
                    projectList = activeProjectList;
                    break;
                case 'Ended':
                    projectList = endedProjectList;
                    break;
                default :
                   projectList = projectList;
            }
            
        } else if (condition == 'Rejected' || condition == 'Pending' || condition == 'Draft') {
            result.each { project ->
                project["daysleft"] = 0;
                project["raised"] = 0;
                project["isCampaignEnded"] = false;
                projectList.add(project);
            }
        }
        return projectList;
        
    }
    
    public boolean isTaxReceiptExist(String projectId) {
        String currentEnv = projectService.getCurrentEnvironment();
        Long rowCount = (Long) TaxReciept.createCriteria().add(Restrictions.eq("project.id", projectId))
                        .createAlias("project", "project").setProjection(Projections.rowCount()).uniqueResult();
        return (rowCount.intValue() != 0) ? true : false;
    }
    
    def isUserProjectHavingContribution(User user, def projectAdmins, String environment){
        Boolean doProjectHaveAnyContribution = false
        
        List<Contribution> contributions = []
        
        if (environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia') {
            List projects = Project.findAllWhere(user:user, validated:true, rejected:false, inactive:false, payuStatus:true, offeringTaxReciept:true)
            projects.each { project ->
                project.contributions?.each { contribution ->
                    if (contribution.panNumber != null) {
                        doProjectHaveAnyContribution = true
                    }
                }
            }
            projectAdmins.each {
                def project = Project.findById(it.projectId)
                
                if (project.contributions && project.payuStatus) {
                    project.contributions?.each { contribution ->
                        if (contribution.panNumber != null) {
                            doProjectHaveAnyContribution = true
                        }
                    }
                }
            }
            
        } else {
            List projects = Project.findAllWhere(user:user, validated:true, rejected:false, inactive:false, payuStatus:false, offeringTaxReciept:true)
            projects.each { project ->
                if (project.contributions) {
                    doProjectHaveAnyContribution = true
                }
            }
            
            projectAdmins.each {
                def project = Project.findById(it.projectId)
                if (project.contributions && project.payuStatus == false) {
                    doProjectHaveAnyContribution = true
                }
            }
        }
        
        return doProjectHaveAnyContribution;
    }

    def getAllProjectByUserHavingContribution(User user , def projectAdmins, def environment, def params){
        List activeProjects=[]
        List endedProjects=[]
        List sortedProjects = []
        def finalList
        boolean ended
        
        boolean doProjectHaveAnyContribution;
        boolean isProjectHaveAnyContribution;

        if (environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia') {
            def projects = Project.findAllWhere(user:user, validated:true, rejected:false, inactive:false, payuStatus:true, offeringTaxReciept:true)
            projects.each { project->
                
                doProjectHaveAnyContribution = false;
                
                if (project.contributions && project.offeringTaxReciept) {
                    
                    project.contributions?.each { contribution ->
                        if (contribution.panNumber != null) {
                            doProjectHaveAnyContribution = true;
                        }
                    }
                    
                    if (doProjectHaveAnyContribution) {
                        isProjectHaveAnyContribution = true;
                        ended = projectService.isProjectDeadlineCrossed(project);
                        if (ended) {
                            endedProjects.add(project)
                        } else if(project.validated==true && project.inactive==false){
                            activeProjects.add(project)
                        }
                    }
                    
                }
                
            }
            
            projectAdmins?.each {
                Project project = Project.findById(it.projectId)
                
                if (project.contributions && project.payuStatus && project.offeringTaxReciept) {
                    project.contributions?.each { contribution ->
                        if (contribution.panNumber != null) {
                            doProjectHaveAnyContribution = true
                        }
                    }
                    
                    if (doProjectHaveAnyContribution) {
                        isProjectHaveAnyContribution = true;
                        ended = projectService.isProjectDeadlineCrossed(project);
                        if (ended) {
                            endedProjects.add(project)
                        } else if(project.validated==true && project.inactive==false){
                            activeProjects.add(project)
                        }
                    }
                }
            }
            
        } else {
            def projects= Project.findAllWhere(user:user, validated:true, rejected:false, inactive:false, payuStatus:false, offeringTaxReciept:true)
            projects.each { project->
                if (project.contributions && project.offeringTaxReciept){
                    
                    isProjectHaveAnyContribution = true;
                    
                    ended = projectService.isProjectDeadlineCrossed(project)
                    if (ended) {
                        endedProjects.add(project)
                    } else if(project.validated==true && project.inactive==false){
                        activeProjects.add(project)
                    }
                }
            }
            
            projectAdmins?.each {
                def project = Project.findById(it.projectId)
                if (project.contributions && project.payuStatus == false && project.offeringTaxReciept) {
                    doProjectHaveAnyContribution = true
                    isProjectHaveAnyContribution = true;
                    
                    ended = projectService.isProjectDeadlineCrossed(project)
                    if (ended) {
                        endedProjects.add(project)
                    } else if(project.validated && project.inactive == false){
                        activeProjects.add(project)
                    }
                }
            }
        }

        sortedProjects = activeProjects.sort{contributionService.getPercentageContributionForProject(it)}
        finalList = sortedProjects.reverse() + endedProjects.reverse()
        
        def projects = []
        if (!finalList.isEmpty()){
            def offset = params.offset ? params.int('offset') : 0
            def max = 6
            def count = finalList.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            projects = finalList.reverse().subList(offset, maxrange)
        }
        return ['totalProjects' : finalList, 'projects' : projects, 'isProjectHaveAnyContribution': isProjectHaveAnyContribution]
    }
    
}

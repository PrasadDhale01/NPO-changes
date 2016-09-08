package crowdera

import java.util.List;

import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

class CampaignService {
    
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
        Long rowCount = (Long) TaxReciept.createCriteria().add(Restrictions.eq("project.id", projectId))
                        .createAlias("project", "project").setProjection(Projections.rowCount()).uniqueResult();
        return (rowCount.intValue() != 0) ? true : false;
        
    }
    
}

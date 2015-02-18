package crowdera

class ProjectComment {

    static belongsTo = [project: Project, user: User]

    String comment
    Date date
    boolean status=false

    static mapping = {
        comment type: 'text'
    }

    static constraints = {
    }
}

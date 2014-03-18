package fedu

class ProjectComment {

    static belongsTo = [project: Project, user: User]

    String comment
    Date date

    static mapping = {
        comment type: 'text'
    }

    static constraints = {
    }
}

package fedu

class CommunityInvite {

    static belongsTo = [community: Community, user: User]
    String inviteCode
    Date dateCreated
    boolean accepted = false

    static constraints = {
        inviteCode unique: true
    }
}

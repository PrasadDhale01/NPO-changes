package fedu

import java.util.Date;

class TeamComment {

    static belongsTo = [team: Team, user: User]

    String comment
    Date date

    static mapping = {
        comment type: 'text'
    }

}

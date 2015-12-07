package crowdera

class GoogleDrive {

    String alternateLink
    String fileId
    String title 

    static constraints = {
        alternateLink nullable: true
        fileId nullable: true
        title nullable: true
    }
}

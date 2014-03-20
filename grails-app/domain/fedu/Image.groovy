package fedu

class Image {
    byte[] bytes
    String contentType

    // static belongsTo = [project: Project]

    static constraints = {
        // Limit upload file size to 2MB
        bytes (maxSize: 1024 * 1024 * 2)
    }
}

package fedu

class Transaction {
    
    String transactionId
    
    static belongsTo = [user: User,project:Project]

    static constraints = {
        transactionId unique:true,required:true
    }
}

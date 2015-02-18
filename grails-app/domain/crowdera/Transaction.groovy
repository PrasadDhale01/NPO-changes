package crowdera

class Transaction {
    
    String transactionId
    
    static belongsTo = [user: User,project:Project,contribution:Contribution]

    static constraints = {
        transactionId unique:true,required:true
    }
}

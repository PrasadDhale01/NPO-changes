package crowdera

class SpendMatrix {
	
	double amount
	String cause
	int numberAvailable

	static belongsTo = [project:Project]

    static constraints = {
		cause nullable:true
    }
}

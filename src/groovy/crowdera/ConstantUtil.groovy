package crowdera;

public class ConstantUtil {

    /*Here we can define constant and enums thats can be used within the entire project*/
    public final static String PARTNER_LIST = "PARTNER_LIST";
	
	public enum PaymentState {
		
		SPLIT_STATE(1),
		SETTLEMENT_STATE(2),
		RELEASED_STATE(3);
		
		int id;
		public PaymentState(int id) {
			this.id = id
		}
		
		public getId() {
			return id;
		} 
	}
    
}

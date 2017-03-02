package crowdera

class PaymentReleaseJob {
	
	CampaignService campaignService;
	
    static triggers = {
		/* cronExpression: "second min hour DayOfMonth Month DayOfWeak Year-optional" */
        cron name: 'DisbursementTrigger', cronExpression: "0 0 19 * * ?" // Execute every day at 7pm Ex. 0 */5 * * * ?   
    }

    def execute() {
        // execute job
		campaignService.getSettlementStatus();
		campaignService.releaseContributions();
    }
}

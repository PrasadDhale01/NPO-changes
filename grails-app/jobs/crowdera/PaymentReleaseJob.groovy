package crowdera

class PaymentReleaseJob {
	
	CampaignService campaignService;
	
    static triggers = {
		/* cronExpression: "second min hour DayOfMonth Month DayOfWeak Year-optional" */
    }

    def execute() {
        // execute job
		campaignService.getSettlementStatus();
		campaignService.releaseContributions();
    }
}

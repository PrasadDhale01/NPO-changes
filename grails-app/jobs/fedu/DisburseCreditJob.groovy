package fedu



class DisburseCreditJob {
    static triggers = {
        simple repeatInterval: 24 * 60 * 60 * 1000l // execute once a day
    }

    def execute() {
        log.info('Executed DisburseCreditJob at ' + new Date().getTimeString())
    }
}

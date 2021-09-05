public with sharing class SolutionService {

    public void processSolutionByType(List<Solution__c> solutions) {
        List<Solution__c> apiSolutions = new List<Solution__c>();
        List<Solution__c> softwareSolutions = new List<Solution__c>();
        List<Solution__c> serviceSolutions = new List<Solution__c>();

        for (Solution__c solution : solutions) {
            if (solution.Type__c == SolutionConstants.TYPE_API) {
                apiSolutions.add(solution);
            } else if (solution.Type__c == SolutionConstants.TYPE_SOFTWARE) {
                softwareSolutions.add(solution);
            } else if (solution.Type__c == SolutionConstants.TYPE_SERVICE) {
                serviceSolutions.add(solution);
            }
        }

        this.processAPI(apiSolutions);
        this.processSoftware(softwareSolutions);
        this.processService(serviceSolutions);
    }

    private void processAPI(List<Solution__c> solutions) {
        if (!solutions.isEmpty()) {
            //DO SOMETHING
        }
    }

    private void processSoftware(List<Solution__c> solutions) {
        if (!solutions.isEmpty()) {
            //DO SOMETHING
        }
    }

    private void processService(List<Solution__c> solutions) {
        if (!solutions.isEmpty()) {
            //DO SOMETHING
        }
    }
}
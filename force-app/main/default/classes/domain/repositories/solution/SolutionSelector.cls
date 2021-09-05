public with sharing class SolutionSelector {

    private SolutionRepository repository;
    private SolutionSpecificationBuilder builder;

    {
        this.repository = new SolutionRepository();
        this.builder = new SolutionSpecificationBuilder();
    }

    public List<Solution__c> getByUserId(Id userId) {

        return null;
    }

    public List<Solution__c> getByAccountId(Id accountId) {

        return null;
    }
}
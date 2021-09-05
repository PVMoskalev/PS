public with sharing class SolutionRepository extends BaseSObjectRepository {

    public Solution__c querySolution(BaseSObjectSpecification specification) {

        return (Solution__c) super.queryRecord(specification);
    }

    public List<Solution__c> querySolutions(BaseSObjectSpecification specification) {

        return (List<Solution__c>) super.queryRecords(specification);
    }
}
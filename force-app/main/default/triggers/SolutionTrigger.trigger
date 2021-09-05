trigger SolutionTrigger on Solution__c (after update) {

    TriggerFactory.execute(Solution__c.getSObjectType());
}
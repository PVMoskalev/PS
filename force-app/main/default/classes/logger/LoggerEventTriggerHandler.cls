public with sharing class LoggerEventTriggerHandler {

    private List<Logger_Event__e> loggerEvents = Trigger.new;

    public void logExceptions() {
        List<Log__c> logs = new List<Log__c>();
        for (Logger_Event__e loggerEvent : loggerEvents) {
            logs.add(new Log__c(
                    Exception_Data__c = loggerEvent.Exception_Data__c
            ));
        }
        insert logs;
    }
}
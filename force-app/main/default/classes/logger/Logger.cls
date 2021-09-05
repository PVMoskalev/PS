public without sharing class Logger {

    private LoggerContext context;

    public Logger(LoggerContext loggerContext) {
        this.context = loggerContext;
    }

    public void logAndThrowException(Exception e) {
        Logger_Event__e loggerEvent = new Logger_Event__e();
        loggerEvent.Exception_Data__c = e.getStackTraceString();
        EventBus.publish(loggerEvent);

        if (this.context == LoggerContext.AURA) {
            throw new AuraHandledException(e.getMessage());
        } else {
            throw e;
        }
    }
}
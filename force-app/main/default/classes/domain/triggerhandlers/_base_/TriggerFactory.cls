public with sharing class TriggerFactory {

    private static Logger logger = new Logger(LoggerContext.TRIGGER_HANDLER);

    private static final Map<sObjectType, Type> TRIGGER_HANDLER_TYPE_BY_SOBJECT_TYPE_MAP {
        get {
            if (TRIGGER_HANDLER_TYPE_BY_SOBJECT_TYPE_MAP == null) {
                TRIGGER_HANDLER_TYPE_BY_SOBJECT_TYPE_MAP = new Map<sObjectType, Type>{
                        Solution__c.getSObjectType() => SolutionTriggerHandler.class
                };
            }

            return TRIGGER_HANDLER_TYPE_BY_SOBJECT_TYPE_MAP;
        }
        private set;
    }

    public static void execute(sObjectType sObjectType) {
        try {
            Type triggerHandlerType = TRIGGER_HANDLER_TYPE_BY_SOBJECT_TYPE_MAP.get(sObjectType);
            TriggerHandlerBase triggerHandler = (TriggerHandlerBase) DependencyInjector.getInstance(triggerHandlerType);
            if (Trigger.isAfter && Trigger.isUpdate) {
                triggerHandler.onAfterUpdate();
            }
        } catch (Exception e) {
            logger.logAndThrowException(e);
        }
    }
}
trigger LoggerEventTrigger on Logger_Event__e (after insert) {

    new LoggerEventTriggerHandler().logExceptions();
}
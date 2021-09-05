public with sharing class MySolutionController {

    private static Logger logger;
    private static MySolutionService mySolutionService;

    // EAGER INITIALIZATION
    static {
        logger = new Logger(LoggerContext.AURA);
        mySolutionService = (MySolutionService) DependencyInjector.getInstance(MySolutionService.class);
    }

    @AuraEnabled
    public static MySolutionDTO getSolutionDTOs() {
        MySolutionDTO result;
        try {
            result = mySolutionService.getSolutionDTOs();
        } catch (Exception e) {
            logger.logAndThrowException(e);
        }

        return result;
    }
}
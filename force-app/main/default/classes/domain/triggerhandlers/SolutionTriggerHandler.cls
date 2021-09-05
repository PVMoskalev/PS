public with sharing class SolutionTriggerHandler extends TriggerHandlerBase {

    private SolutionService solutionServiceInst;

    {
        this.solutionServiceInst = (SolutionService) DependencyInjector.getInstance(SolutionService.class);
    }

    public override void onAfterUpdate() {
        this.solutionServiceInst.processSolutionByType(Trigger.new);

        //TEST
        throw new HandledException('test common trigger logger');
    }
}
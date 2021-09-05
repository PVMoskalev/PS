public class SolutionSpecificationBuilder extends BaseSObjectSpecificationBuilder {

    public static final Set<String> FIELD_SET_DEFAULT;

    static {
        FIELD_SET_DEFAULT = Solution__c.getSObjectType().getDescribe().fields.getMap().keySet();
    }

    public override Type getSObjectSpecificationType() {

        return SolutionSpecification.class;
    }
}
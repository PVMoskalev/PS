public abstract class BaseSObjectSpecification {

    protected String sObjectApiName;
    protected String baseQuery = 'SELECT {0} FROM {1} ';
    protected String conditions = 'WHERE {0} ';
    protected String order = 'ORDER BY {0} ';
    protected String limitations = 'LIMIT {0}';
    protected String offset = 'OFFSET {0}';

    public BaseSObjectSpecification() {
        this.sObjectApiName = this.getSObjectApiName();
    }

    public BaseSObjectSpecification(QuerySettings settings) {
        this(settings, null);
    }

    public BaseSObjectSpecification(QuerySettings settings, String sObjectName) {
        this.setQuerySettings(settings, sObjectName);
    }

    protected abstract String getSObjectApiName();

    public void setQuerySettings(QuerySettings settings){
        this.setQuerySettings(settings, null);
    }

    public void setQuerySettings(QuerySettings settings, String sObjectName) {
        this.sObjectApiName = String.isNotBlank(sObjectName) ? sObjectName : this.getSObjectApiName();

        String fields = String.join(new List<String>(settings.fields), ', ');
        for (String subquery : settings.subqueries) {
            fields += ', (' + subquery + ')';
        }

        this.baseQuery = String.format(this.baseQuery,
                new List<Object> {
                        fields,
                        sObjectApiName
                });

        String conditionsList = '';
        for (String condition : settings.conditionsList) {
            conditionsList += condition + ' AND ';
        }

        conditionsList = conditionsList.substringBeforeLast('AND');
        this.conditions = String.isNotEmpty(conditionsList) ? String.format(this.conditions,
                new List<Object> {
                        conditionsList
                }
        ) : '';
        if (String.isNotBlank(settings.orderBy)) {
            this.order = String.format(this.order, new List<Object> { settings.orderBy });
            this.order += !this.order.toLowerCase().trim().endsWith('desc')?' NULLS LAST ':' NULLS FIRST ';
        } else {
            this.order = '';
        }
        this.limitations = String.isNotEmpty(String.valueOf(settings.limits)) ?
                String.format(this.limitations, new List<Object> { settings.limits }) : '';

        this.offset = String.isNotEmpty(String.valueOf(settings.offset)) ?
                String.format(this.offset, new List<Object> { settings.offset }) : '';
    }

    public virtual String toQuery() {

        return this.baseQuery + this.conditions + this.order + this.limitations  + this.offset;
    }

    public virtual String toSubquery() {

        return this.baseQuery.replace(this.sObjectApiName, this.sObjectApiName.replace('__c', 's__r'))
                + this.conditions + this.order + this.limitations;
    }
}
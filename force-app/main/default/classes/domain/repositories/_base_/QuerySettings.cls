public with sharing class QuerySettings {

    public String baseQuery;
    public String searchStr;
    public Set<String> fields;
    public Map<String, List<String>> subquery;
    public List<String> subqueries;
    public List<String> conditionsList;
    public Integer limits;
    public Boolean isApplyDefaultLimits;
    public String orderBy;
    public Integer offset;

    {
        this.fields = new Set<String>();
        this.subqueries = new List<String>();
        this.conditionsList = new List<String>();
    }

    public QuerySettings() {
        this.isApplyDefaultLimits = false;
    }

    public QuerySettings(String searchStr) {
        this.searchStr = searchStr;
        this.isApplyDefaultLimits = true;
    }

    public static String inClausify(Set<String> params) {
        return QuerySettings.inClausify(new List<String>(params));
    }

    public static String inClausify(List<String> params) {
        List<String> escapedParams = new List<String>();
        for(String param: params){
            escapedParams.add(String.escapeSingleQuotes(param));
        }

        String inClause = String.format( '(\'\'{0}\'\')',
                new List<String> { String.join(escapedParams, '\',\'') });
        return inClause;
    }
}
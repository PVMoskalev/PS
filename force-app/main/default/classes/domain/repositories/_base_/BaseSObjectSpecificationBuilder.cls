public abstract class BaseSObjectSpecificationBuilder {

    private static final String QUERY_EMPTY_COLLECTION = '(\'\')';

    protected QuerySettings settings;

    {
        this.settings = new QuerySettings();
        this.settings.fields = new Set<String>();
    }

    public abstract Type getSObjectSpecificationType();

    public static Set<String> getFields(String relationshipName, Set<String> fieldSet) {
        Set<String> result = new Set<String>();
        for (String field : fieldSet) {
            result.add(relationshipName + '.' + field);
        }

        return result;
    }

    public BaseSObjectSpecificationBuilder setFields(Set<String> fields) {
        this.settings.fields = fields.clone();

        return this;
    }

    public BaseSObjectSpecificationBuilder addField(String field) {
        this.settings.fields.add(field);

        return this;
    }

    public BaseSObjectSpecificationBuilder addFields(Set<String> fields) {
        this.settings.fields.addAll(fields);

        return this;
    }

    public BaseSObjectSpecificationBuilder addSubQuery(BaseSObjectSpecification specification) {
        if (specification != null) {
            this.settings.subqueries.add(specification.toSubquery());
        }

        return this;
    }

    public BaseSObjectSpecificationBuilder addCondition(String condition) {
        this.settings.conditionsList.add(condition);

        return this;
    }

    public BaseSObjectSpecificationBuilder addConditionEqual(String fieldName, String fieldValue) {
        this.settings.conditionsList.add(fieldName + ' = ' + encloseIntoSingleQuotes(fieldValue));

        return this;
    }

    public BaseSObjectSpecificationBuilder addConditionIncludes(String fieldName, Set<String> picklistValues) {
        this.settings.conditionsList.add(fieldName + ' INCLUDES ' + QuerySettings.inClausify(picklistValues));

        return this;
    }

    public BaseSObjectSpecificationBuilder addConditionIn(String fieldName, Set<Id> fieldValues) {
        this.settings.conditionsList.add(fieldName + ' IN ' + this.convertSetToQueryable(fieldValues));

        return this;
    }

    public BaseSObjectSpecificationBuilder addConditionNotIn(String fieldName, Set<Id> fieldValues) {
        this.settings.conditionsList.add(fieldName + ' NOT IN ' + this.convertSetToQueryable(fieldValues));

        return this;
    }

    public BaseSObjectSpecificationBuilder addConditionNotIn(String fieldName, Set<String> fieldValues) {
        this.settings.conditionsList.add(fieldName + ' NOT IN ' + this.convertListToQueryable(new List<String>(fieldValues)));

        return this;
    }


    public BaseSObjectSpecificationBuilder addConditionNotEqual(String fieldName, String fieldValue) {
        this.settings.conditionsList.add(fieldName + ' != ' + encloseIntoSingleQuotes(fieldValue));

        return this;
    }

    public BaseSObjectSpecificationBuilder addConditionEqual(String fieldName, Boolean value) {
        this.settings.conditionsList.add(fieldName + ' = ' + value);

        return this;
    }

    public BaseSObjectSpecificationBuilder addConditionTrue(String fieldName) {
        this.settings.conditionsList.add(fieldName + ' = TRUE');

        return this;
    }

    public BaseSObjectSpecificationBuilder addConditionFalse(String fieldName) {
        this.settings.conditionsList.add(fieldName + ' = FALSE');

        return this;
    }

    public BaseSObjectSpecificationBuilder addConditionIn(String fieldName, List<String> fieldValues) {
        this.settings.conditionsList.add(fieldName + ' IN ' + this.convertListToQueryable(fieldValues));

        return this;
    }

    public BaseSObjectSpecificationBuilder addConditionIn(String fieldName, Set<String> fieldValues) {

        return this.addConditionIn(fieldName, new List<String>(fieldValues));
    }

    public BaseSObjectSpecificationBuilder addConditionLike(String fieldName, String fieldValue) {
        this.settings.conditionsList.add(fieldName + ' LIKE ' + encloseIntoSingleQuotes('%' + fieldValue + '%'));

        return this;
    }

    public BaseSObjectSpecificationBuilder addConditionLikeWithOr(List<String> fieldNames, String subString) {
        if (!fieldNames.isEmpty() && String.isNotEmpty(subString)) {
            List<String> subConditions = new List<String>();
            for (String fieldName : fieldNames) {
                subConditions.add(fieldName + ' LIKE ' + encloseIntoSingleQuotes('%' + subString + '%'));
            }
            this.settings.conditionsList.add('(' + String.join(subConditions, ' OR ') + ')');
        }

        return this;
    }

    public BaseSObjectSpecificationBuilder setOrderBy(String fieldName, String sortOrder) {
        if (String.isNotEmpty(fieldName)) {
            this.settings.orderBy = fieldName + ' ' + (String.isNotEmpty(sortOrder) ? sortOrder : 'ASC');
        }

        return this;
    }

    public BaseSObjectSpecificationBuilder setOrderBy(String firstFieldName, String firstSortOrder, String secondFieldName, String secondSortOrder) {
        if (String.isNotEmpty(firstFieldName)) {
            this.settings.orderBy = firstFieldName + ' ' + (String.isNotEmpty(firstSortOrder) ? firstSortOrder : 'ASC');
        }
        if (String.isNotEmpty(secondFieldName)) {
            this.settings.orderBy = ', ' + secondFieldName + ' '
                    + (String.isNotEmpty(secondSortOrder) ? secondSortOrder : 'ASC');
        }

        return this;
    }

    public BaseSObjectSpecificationBuilder setLimit(Integer recordLimit) {
        if (recordLimit != null) {
            this.settings.limits = recordLimit;
        }

        return this;
    }

    public BaseSObjectSpecificationBuilder setOffset(Integer offset) {
        if (offset != null) {
            this.settings.offset = offset;
        }

        return this;
    }

    public BaseSObjectSpecification build() {
        Type specificationType = Type.forName(String.valueOf(this.getSObjectSpecificationType()));
        BaseSObjectSpecification specification = (BaseSObjectSpecification) specificationType.newInstance();
        specification.setQuerySettings(settings);

        return specification;
    }

    public static String encloseIntoSingleQuotes(String value) {
        return '\'' + soqlEscape(value) + '\'';
    }

    protected String convertListToQueryable(List<String> values) {
        String result = QUERY_EMPTY_COLLECTION;
        if (!values.isEmpty()) {
            List<String> processedValues = new List<String>();
            for (String value : values) {
                if (value == null) {
                    continue;
                }
                processedValues.add('\'' + soqlEscape(value) + '\'');
            }
            result = '(' + String.join(processedValues, ',') + ')';
        }

        return result;
    }

    public String convertSetToQueryable(Set<Id> values) {
        String result = QUERY_EMPTY_COLLECTION;
        if (!values.isEmpty()) {
            List<String> processedValues = new List<String>();
            for (String value : values) {
                processedValues.add('\'' + soqlEscape(value) + '\'');
            }
            result = '(' + String.join(processedValues, ',') + ')';
        }

        return result;
    }

    public static String convertDateToQueryable(Date value) {
        Integer day = value.day();
        Integer month = value.month();
        Integer year = value.year();

        return DateTime.newInstance(year, month, day).format('yyyy-MM-dd');
    }

    public static string soqlEscape(string plain) {
        return plain.replace('\\', '\\\\').replace('\'', '\\\'').replace('\"', '\\\"');
    }
}
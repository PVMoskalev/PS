public inherited sharing abstract class BaseSObjectRepository {

    private static Boolean withoutSharing = false;

    public static void queryWithoutSharing() {
        BaseSObjectRepository.withoutSharing = true;
    }

    public void createRecord(SObject record) {
        this.createRecords(new List<SObject>{ record });
    }

    public void createRecords(List<SObject> records) {
        for (SObject record : records) {
            if (record.getSObjectType().getDescribe().isAccessible()
                    && record.getSObjectType().getDescribe().isCreateable()) {
                continue;
            } else {
                throw new NoAccessException();
            }
        }
        if (!records.isEmpty()) {
            insert records;
        }
    }

    protected SObject queryRecord(BaseSObjectSpecification specification) {
        List<SObject> result = this.queryRecords(specification);

        return !result.isEmpty() ? result.get(0) : null;
    }

    protected List<SObject> queryRecords(BaseSObjectSpecification specification) {
        List<SObject> result;
        String queryStr = specification.toQuery();
        if (BaseSObjectRepository.withoutSharing) {
            result = new WithoutSharing().queryRecords(queryStr);
        } else {
            result = Database.query(queryStr);
        }
        return result;
    }

    public void updateRecord(SObject record) {
        this.updateRecords(new List<SObject>{ record });
    }

    public void updateRecords(List<SObject> records) {
        for (SObject record : records) {
            if (record.getSObjectType().getDescribe().isAccessible()
                    && record.getSObjectType().getDescribe().isUpdateable()) {
                continue;
            } else {
                throw new NoAccessException();
            }
        }
        if (!records.isEmpty()) {
            update records;
        }
    }

    public void upsertRecord(SObject record) {
        this.upsertRecords(new List<SObject>{ record });
    }

    public void upsertRecords(List<SObject> records) {
        for (SObject record : records) {
            if (record.getSObjectType().getDescribe().isAccessible()
                    && record.getSObjectType().getDescribe().isCreateable()
                    && record.getSObjectType().getDescribe().isUpdateable()) {
                continue;
            } else {
                throw new NoAccessException();
            }
        }
        if (!records.isEmpty()) {
            upsert records;
        }
    }

    public void deleteRecord(SObject record) {
        this.deleteRecords(new List<SObject> { record });
    }

    public void deleteRecords(List<SObject> records) {
        for (SObject record : records) {
            if (record.getSObjectType().getDescribe().isAccessible()
                    && record.getSObjectType().getDescribe().isDeletable()) {
                continue;
            } else {
                throw new NoAccessException();
            }
        }
        if (BaseSObjectRepository.withoutSharing) {
            new WithoutSharing().deleteRecords(records);
        } else if (!records.isEmpty()) {
            delete records;
        }
    }

    private without sharing class WithoutSharing {

        public List<SObject> queryRecords(String query) {
            List<SObject> result = Database.query(query);
            BaseSObjectRepository.withoutSharing = false;

            return result;
        }

        public void deleteRecords(List<SObject> records) {
            if (!records.isEmpty()) {
                delete records;
            }
            BaseSObjectRepository.withoutSharing = false;
        }
    }
}
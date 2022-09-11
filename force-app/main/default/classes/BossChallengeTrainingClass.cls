/*
 * Created by Z02 on 7/17/2022.
 */

public with sharing class BossChallengeTrainingClass {

//        public static String getToken(String mobile) {
//            Blob value = Blob.valueOf(mobile);
//            Blob hash = Crypto.generateDigest('MD5', value);
//            return EncodingUtil.base64Encode(hash);
//        }

        public static List<Person__c> getRecentHealthChanges() {
            List<Person__c> firstHundredPerson = [
                    SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate,
                            LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, Health_Status__c,
                            Mobile__c, Status_Update_Date__c, Token__c
                    FROM Person__c
                    ORDER BY Status_Update_Date__c DESC NULLS LAST
                    LIMIT 100
            ];
            return firstHundredPerson;
        }

        public static List<Person__c> searchPeople(String searchTerm) {
            String likeTerm = searchTerm + '%';
            return [
                    SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate,
                            LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, Health_Status__c,
                            Mobile__c, Status_Update_Date__c, Token__c
                    FROM Person__c
                    WHERE Name LIKE :likeTerm
                    OR Mobile__c LIKE :likeTerm
                    OR Token__c LIKE :likeTerm
                    ORDER BY Status_Update_Date__c DESC NULLS LAST
            ];

        }

        public static Person__c getPersonById(String personId) {
            return [
                    SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate,
                            LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, Health_Status__c,
                            Mobile__c, Status_Update_Date__c, Token__c
                    FROM Person__c
                    WHERE Id = :personId
            ];
        }

        public static List<Location__c> getRecentStatusChanges() {
            return [
                    SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate,
                            LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate,
                            Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c
                    FROM location__c
                    ORDER BY Status_Update_Date__c DESC NULLS LAST
                    LIMIT 100
            ];
        }

        public static List<Location__c> searchLocations(String searchTerm) {
            String likeTerm = searchTerm + '%';
            return [
                    SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate,
                            LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate,
                            Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c
                    FROM Location__c
                    WHERE Name LIKE :likeTerm
                    OR Pincode__c LIKE :likeTerm
                    OR Address__c LIKE :likeTerm
                    ORDER BY Status_Update_Date__c DESC NULLS LAST
            ];
        }

        public static Location__c getLocationById(String locationId) {
            return [
                    SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate,
                            LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate,
                            Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c
                    FROM location__c
                    WHERE Id = :locationId
            ];
        }

        public static List<Location_Tracing__c> getVisitors(String locationId) {
            return [
                    SELECT Id, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate,
                            LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate,
                            Person__c, Location__c, Visit_Date__c
                    FROM Location_Tracing__c
                    WHERE Location__c = :locationId
            ];
        }

        public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds) {
            return [
                    SELECT Id, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate,
                            LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate,
                            Person__c, Location__c, Visit_Date__c
                    FROM Location_Tracing__c
                    WHERE Person__c IN :personIds
                    AND Visit_Date__c = LAST_N_DAYS:10
                    ORDER BY Visit_Date__c DESC
            ];
        }
        /**
         * checkDuplicates method
         * 1. Query existing records from Location Tracing object
         * 2. Find duplicate records by matching locationTraces list and existing records
         * 3. Return List of duplicate Location Tracing records back to caller
         *
         * Algorithm:
         * Step 1: Iterate over the new location tracing records to get all unique location ids and person ids.
         * Step 2: Query existing location tracing records using ids collected in step 1
         * Step 3: Create a Map<locationId, Set<personId>>. This will make our task easier to find duplicates
         * Step 4: Loop over new location tracing records and check for duplicates in Map (created in Step 3)
         * Step 5: Return the list of duplicates
         *
         */

        public List<Location_Tracing__c> checkDuplicatesMaciej(List<Location_Tracing__c> newLocationTraces) {


            List<Location_Tracing__c> dbLocationTracingRecords = [
                    SELECT Id, Person__c, Location__c
                    FROM Location_Tracing__c
            ];
            List<Location_tracing__c> locationTracingDuplicates = new List<Location_Tracing__c>();

            for (Location_Tracing__c dbLocationTracingRecord : dbLocationTracingRecords) {
                for (Location_Tracing__c newLocationTrace : newLocationTraces) {
                    if (dbLocationTracingRecord.Person__c == newLocationTrace.Person__c && dbLocationTracingRecord.Location__c == newLocationTrace.Location__c) {
                        locationTracingDuplicates.add(newLocationTrace);
                    }
                }
            }
            Return locationTracingDuplicates;
        }

//        public List<Location_Tracing__c> checkDuplicatesManish(List<Location_Tracing__c> newLocationTraces) {
//
//            Set <Id> locationIds = new Set<Id>();
//            Set <Id> personIds = new Set<Id>();
//
//            for (Location_Tracing__c newLocationTrace : newLocationTraces) {
//                personIds.add(newLocationTrace.Person__c);
//                locationIds.add(newLocationTrace.Location__c);
//            }
//
//            List<Location_Tracing__c> existingRecords = [
//                    SELECT Id, Person__c, Location__c
//                    FROM Location_Tracing__c
//                    WHERE Location__c IN :locationIds
//                    AND Person__c IN :personIds
//            ];
//            if (existingRecords != null && existingRecords.size() > 0) {
//
//            }
//        }

        public List<People_Tracing__c> getTraces(String recordId) {
            return [
                    SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById,
                            SystemModstamp, LastViewedDate, LastReferencedDate, Contact_Type__c, Person_1__c, Person_2__c
                    FROM People_Tracing__c
                    WHERE Person_1__c = :recordId
                    OR Person_2__c = :recordId
                    ORDER BY CreatedDate DESC
            ];
        }

        public List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> peopleTraces) {
            Set<Id> uniquePersonIds = new Set<Id>();
            for(People_Tracing__c peopleTrace:peopleTraces){
                uniquePersonIds.add(peopleTrace.Person_1__c);
                uniquePersonIds.add(peopleTrace.Person_2__c);
            }
            List<People_Tracing__c> duplicatePeopleTracingList = new List<People_Tracing__c>();

            Map<Id,Set<Id>> existingPeopleTracingCombinationMap = new Map<Id,Set<Id>>();

            List<People_Tracing__c> existingPeopleTracings = [SELECT Id, Person_2__c, Person_1__c
                                                                FROM People_Tracing__c
                                                                WHERE Person_1__c IN : uniquePersonIds
                                                                AND Person_2__c IN : uniquePersonIds];

            if(existingPeopleTracings!=null && existingPeopleTracings.size()>0){

                for(People_Tracing__c existingPeopleTracing:existingPeopleTracings){
                    if(!existingPeopleTracingCombinationMap.containsKey(existingPeopleTracing.Person_1__c)){
                        existingPeopleTracingCombinationMap.put(existingPeopleTracing.Person_1__c,new set<Id>());
                    }
                    existingPeopleTracingCombinationMap.get(existingPeopleTracing.Person_1__c).add(existingPeopleTracing.Person_2__c);

                    if(!existingPeopleTracingCombinationMap.containsKey(existingPeopleTracing.Person_2__c)){
                        existingPeopleTracingCombinationMap.put(existingPeopleTracing.Person_2__c,new set<Id>());
                    }
                    existingPeopleTracingCombinationMap.get(existingPeopleTracing.Person_2__c).add(existingPeopleTracing.Person_1__c);
                }

                for (People_Tracing__c peopleTrace:peopleTraces){
                    if(existingPeopleTracingCombinationMap.get(peopleTrace.Person_1__c).contains(peopleTrace.Person_2__c)||
                            existingPeopleTracingCombinationMap.get(peopleTrace.Person_2__c).contains(peopleTrace.Person_1__c)){
                        duplicatePeopleTracingList.add(peopleTrace);
                    }
                }
            }
        return duplicatePeopleTracingList;
        }

    /**
     * Query Person records to find Number of People in each Health Status
     * Build a Map<String, Integer> to map count of peole with each status
     * Return the Map back to caller
    */

    public Map<String, Integer> getHealthStatusCount(){
        AggregateResult[] personPerHealthStatus = [SELECT Health_Status__c, Count(Id) countId
                                                    FROM Person__c
                                                    GROUP BY Health_Status__c];
        Map<String,Integer> numberOfPeoplePerHealthStatus = new Map<String,Integer>();
        for(AggregateResult person:personPerHealthStatus){
            String stringHealthStatus = String.valueOf(person.get('Health_Status__c'));
            Integer integerCountId = Integer.valueOf(person.get('countId'));
            numberOfPeoplePerHealthStatus.put(stringHealthStatus,integerCountId);
        }
        return numberOfPeoplePerHealthStatus;
    }

}


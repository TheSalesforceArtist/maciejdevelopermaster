/**
 * Created by Z02 on 8/17/2022.
 */

public with sharing class PersonTriggerHandler {

    //BEFORE INSERT METHODS
    public static void checkHealthStatusGreen(List<Person__c> personList){
        for(Person__c currentPerson:personList){
            if(currentPerson.Health_Status__c!='Green'){
                currentPerson.addError('When creating a Person record the status needs to be green');
            }
        }

    }

    public static void checkPersonMobileEmpty(List<Person__c> personList){
        for(Person__c currentPerson:personList){
            if(String.IsEmpty(currentPerson.Mobile__c)){
                currentPerson.addError('Mobile cannot be empty !');
            }
        }
    }


    public static List<Person__c> updateTokenOnPersonList(List<Person__c> personList){
        for(Person__c currentPerson:personList){
            currentPerson.Token__c = PersonTriggerHandler.generateToken(currentPerson.Mobile__c);
        }
        return personList;
    }

    public static String generateToken(String mobile){
        //generate unique hash using md5 algorithm
        Blob value = Blob.valueOf(mobile);
        Blob hash = Crypto.generateDigest('MD5', value);
        //return encoded string
        return EncodingUtil.base64Encode(hash);
    }

    //BEFORE UPDATE METHODS

    public static void updateStatusUpdateDateFieldOnStatusChange(Map<Id,Person__c>oldPersonMap, Map<Id,Person__c>newPersonMap, List<Person__c> personList){
        List<Person__c> personListToUpdate = new List<Person__c>();
        for(Id currentId:oldPersonMap.keySet()){
            if(oldPersonMap.get(currentId).Health_Status__c!=newPersonMap.get(currentId).Health_Status__c){
                Person__c recordToUpdate = oldPersonMap.get(currentId);
                recordToUpdate.Status_Update_Date__c = Date.today();
                //personListToUpdate.add(recordToUpdate);
            }
            else{
                //personListToUpdate.add(oldPersonMap.get(currentId));
            }
        }
        system.debug(personListToUpdate);
        //return personListToUpdate;

    }

    public static void beforeUpdate(List<Person__c> newRecords, Map<Id, Person__c> oldRecordsMap){
        for(Person__c person : newRecords){
            // check if the status changed in this transaction
            // also update Status_Update_Date__c
            if( person.Health_Status__c != oldRecordsMap.get(person.id).Health_Status__c){
                person.Status_Update_Date__c = Date.today();
            }
        }
    }



}